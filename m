Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851077AF7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjI0CKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjI0CIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:08:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021F286A2;
        Tue, 26 Sep 2023 17:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695772805; x=1727308805;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ciozfjmqWSfw0JbQQmYH7ZIvnnrA78YZu04qmict6ic=;
  b=lPgBXe258bZv8wodwRc9hKNDAWvpb9ArX/ULiMFVLvurGT9/fSHifqoY
   yQzYTVnWi4nAhMm9Jbu6ZyYGcwciHcxn7GXtxUrjP0RXeuFTDALkpPmpz
   x+UyTTnaXEtuSxuOnR97QSlSbjOIDKgbRRrPY/uR6DvxRsu5TzennXkTI
   Tvpxch/qpLtnOVaHvsQHICG+geAIL82pHMVApy8MpGNgxJ4GJARyy0KH3
   5o2vcalTHObv2rDuVVC9xPJg3BgteZJR3aZe23Nhat7vYjnRZ4G5FP7h4
   tuJVFF7i6WGnaGWlPNu3rYaFj2RXGgppYZWWh5piTprpH1rlbcfkAMpRe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448188905"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="448188905"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:00:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864584470"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="864584470"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 17:00:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 17:00:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 17:00:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 17:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km13E7h6XQsD1pZq4DJ8KJm58tCRq5+mV493u0xauL4OroTV7DDwB+QQVCeLcQEy073/RWD8vJTkezfl+oX/YxKEDytSfy29VhnEOzcaV3PgCZ3ud1CjCayHOBpaLIzQkg9bpz6fyLJno5jCTGE0tB9F7Ncis5G10wUZ6oP5RpCT0Nf4k27VL18+nTV0O1n7BawRZvPwklEj6MhE/AU+V8G0iRovrEBsHBDvj+60C+FnRMJtW6qDD8QSR266OpBRgqsq2I1yFYenV5K9UnpWLFzk+hScsxLPf4Ly0pkpAq9s/wxtC5saGDI9TZEayqtBAlQ6WmW2hfri0kJkbMhGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciozfjmqWSfw0JbQQmYH7ZIvnnrA78YZu04qmict6ic=;
 b=hyrcQXv3uiSw80OplcMKju2LE/HiVy8s3X+pxrfEjwB3nVNH3cfEwYn2Q+2DuAFVvYL2oO16NJ9/s1lrHmIWkI0M47H6EZyqfaaxo+YBkrFfpFuT6TcxBOLjsGRvqR5d0zW02qyMxG9+zfy4lBH7sTJc4tOr4afZBESqK23/r0rgWgX6mjqi317MWP7f12QKLCAEaHrR64boBJAU+nOqPUEggNiOKt/099kKGuuBZCNXqUgMuDanfjAiQ0PM3ZckMXzj4mXkyOohQZ6jqRv/XxqBjQLpb+W8S7QjFpJnrt0/8cj57LJo/6cVJmyZQpSogqnjrD/B0ORI0GpRf1navg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 00:00:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 00:00:00 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Thread-Topic: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Thread-Index: AQHZ2tLNO4lA/XIHxUC5FtYBBgm4WrAsWW2AgAF60aCAAAHJAIAAEHAAgAAN05A=
Date:   Wed, 27 Sep 2023 00:00:00 +0000
Message-ID: <SJ1PR11MB6083210E470189053CCD1F70FCC2A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
 <ZRMnCFWzcxa6Qa4E@agluck-desk3>
 <5b2fd31e-3cef-3c35-7d17-411cea27502a@intel.com>
 <SJ1PR11MB6083D9AA22033235210BD847FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <595d6062-fece-83c0-5d5d-2f9405f6b842@intel.com>
In-Reply-To: <595d6062-fece-83c0-5d5d-2f9405f6b842@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7062:EE_
x-ms-office365-filtering-correlation-id: fc33b7e9-b0b6-47e5-07f9-08dbbeecb198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmpr0vgb6A7NqO5MFjWBGVxZaCu3/+LMT39XpaGoj5r+P9TfWQOleAj60H++Qz0jK9dKRpm3MSpaLoC2UlHQtHPm9SyOyHYN1muvZlK/8tUcw4OjnFDK0PKXVZDMT3XN8+AfDLK4Vj+FsqSTCkkFUFSABQUYHN99hMJehJEFisPcI5JNxeMgj1pQKWVr/3yyiIshEe3nLhugQJAu2ee0lppmKFsOJMT4qdvm3Y+JZQhnrgDxQRTs/PgIThKHpAyunbgzw0Cl9MVUgnCHNdKHPVpVefa5w3q0JGlJbAVifroB1eb5vgeL7JBEmZNVamnaGIKUWqdm9zNPBiEH5rcxBQCprtxPq7hvQPZIf8REhVjpSEn++Yen7gS7KAnXAqxZbnlC4l9kxcOX0ppabpI47JpAta9PKABaKhJgKOYVGqjqEGC+/Mf1Zw2DGHVm67dRinxBRd+WKtTCOfZA1q1W/sBKRUZYFj6CuipzAOjbGpyYdXXZpqLZnGs3SclZJdxQ3nYG69p3Jubp4XuJAVFUzKIz/TMqB1hajKjA2sS3y0MLHQKZRIoW18HRQRRs0wZGHdDo+U36dw5E9TKqHypvHc+tERQ7bP59UEZqePU/Z8VArVBfuuz2B5ky9VHFY+Vm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799009)(6636002)(316002)(41300700001)(54906003)(76116006)(64756008)(66476007)(66946007)(66556008)(66446008)(7416002)(9686003)(8676002)(8936002)(6862004)(2906002)(4326008)(52536014)(478600001)(71200400001)(26005)(7696005)(38070700005)(33656002)(38100700002)(5660300002)(55016003)(6506007)(86362001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?allzUFNiK3lFV3NyMS9aSTg0SGprWkJrSmY3Qnlaa0UzK01JNXBtdFJlK0ty?=
 =?utf-8?B?SnRjK01ncG9KckZ3aUJyVEwwbGRaV0cwVHVXREdpcFZSSm1IQ3hWVEpXSkFI?=
 =?utf-8?B?UjZLSWJoN1IvTElwY2xZZjgzc1d3U1VRc3MzTDhqWkx0cnFmZUVCbDNoVDhL?=
 =?utf-8?B?bDkvaGRQVk1saVd3VkxjQVdPYjdONHU1dHlrZVI2MExyQ1h1L3RVenZuREwz?=
 =?utf-8?B?UngrSENINkRSZVY4YTlLY3VFUFhQQ2xnWHZmWTlxNit5Q1RpVEM4d1htVjZI?=
 =?utf-8?B?eHUvd2tCSU1aRkdZNGtqZHQ0NHJHdHJoQzVlTW14RkZuejVseDF5a2hhVW1E?=
 =?utf-8?B?RzJFeXR4aDVObXBkZ2hkbjhRZUkyUlB6eDF6UEJjRExUdEl5aHRmMnlPUTBo?=
 =?utf-8?B?V0ZOY3RGUkdPTHJIaG1VZ2NFcy81c0FQaTBIamVzd2Y2OGRuZ3Z2Um5uNis3?=
 =?utf-8?B?dG05Y0QzREhuc3htRWxmL0JlQWQ2QU5UNEVWLzkwOHQ4UzRFOUVlZ21HS21u?=
 =?utf-8?B?ZUV0a0pCSG93YVl1M0VsSjJHNGxXUXNDWU5TbEFUblVkMFFmemlkY0Z1WS9v?=
 =?utf-8?B?Y1VYRlJ1K0tqRUsrSEtIZFgybTYrd25UalEvQStSQUZEVkM0K3g5SGcvN0dU?=
 =?utf-8?B?aWltTmhueEZQU2tUK1dZS0EvY0lQNWpwMHNnYWtPRDN2Qzdaa0t6MHFrZUNU?=
 =?utf-8?B?WlhTb1hyeFJaZU1BWkJIS2JzbC91WHpUV3V3RG5vcGdybDB5eEdsTkVHaFM1?=
 =?utf-8?B?TFFncmFCbkN3RFJ6OGE5RGJGeUZKTFBXWWNWWTNHZHMxOU9rNTk4cjNLdXBD?=
 =?utf-8?B?dGw1OVpaak5FYXE2M1RiVFhWM1NUTldjMXBSQ21QR2x1QVNoWjgwK0lJdmlq?=
 =?utf-8?B?TUcrbW11S3lLNE5VbENPRnFDZGwrZDJYMVdFWDVGWTA3MzhiVUs1TmhYQlRj?=
 =?utf-8?B?NVc3K0JQVmU5RzRuU3ZiZ2NOZUgvaExaR2xRSEpBSDdtdDVCY0crZWd0UXpH?=
 =?utf-8?B?aEUxdUNyU1VjM2ZmZ1pUWjZ4YkdCZjl1alRnQ3g0UUlPTXlZa1dYMnovZnlj?=
 =?utf-8?B?aXJVNjZsT3hIdGppVXV2cjl5USt3NnlkWG9yRDQ1dDRHQTJucmM5V0pSWDhq?=
 =?utf-8?B?Tnc5WmhYa2N1YmVZOUNobmVoU0xpT0wwNmxWQ0ZGS1c2U1dKL0MyNUwvY2Zp?=
 =?utf-8?B?T1F2eW9VVnFjWE9IVGQzZ01XS3JGbjJrN1B3dzkwOGw1TW8xR29JNnRaaVpG?=
 =?utf-8?B?QU9GKzlGbm9ETGkrakFHcTJpTXpiRVBwYUtvbE9KU21SNkNvNmVuWjdES2VC?=
 =?utf-8?B?bEsrQ1AyK29JUnY5ZmJoNWVUY21IZlBNYmt6ZXVIYXExNloyWmgrZDl6RDRh?=
 =?utf-8?B?RU42Ung5WjJ6MXQ4eVI3MGJWOTB4ZUpZOTl0MTZZR0M2TDFURTB5T2hZWXJt?=
 =?utf-8?B?ditGMFRHaWxlanhzb0FwS2g0OTRSOWE0OGtlWWN6QVlyNjg5SWtrZDRCRFJJ?=
 =?utf-8?B?MFFuRXZNNEhaTEdoR0hrMjEvK2ptU0lnNVR2S1RXYTh6T0NhL2sxR0trOXNM?=
 =?utf-8?B?Ny9sUlU1YnRhVnpWRUdyRmp6SzFwQkUzamM0ck9DZVNwbmtnTE1pdE5aUXhn?=
 =?utf-8?B?aHJITzRYbEZLTWxjcHZ6cmN3cmtTQU1ETGgzSDR2bGZ5S1ZBc0RaU2ZYbHhV?=
 =?utf-8?B?RVYxd2ZaTEdGQkFoMjdmd0lZRUVqUm5oTjJkRlRZeGQyb2s4NWtVbWdLOTNJ?=
 =?utf-8?B?d3o1cGdha0lwTVRCc0xnT3l0Mjk0WU9yeHgrOHBBbnB3ZjlUQXMzbFdRU1Ns?=
 =?utf-8?B?QVhGdzl5K09hdmlyUlo5OWI3M3lqREk3akpKc21mY2Z3MC9jcEY5WmRXSjRN?=
 =?utf-8?B?RDRZYjJOaTBKZEdhUFNuU0RuTUhHUlpBdU9VdWJEMDBGZzlnNU1mdmc0MlAv?=
 =?utf-8?B?M0U3RjJGSUNlTndIdzQxNHZ1T3A5Mm43Z1h5bTJBM0ZOWGxQc2xMSGIxUG8y?=
 =?utf-8?B?NEJScVprTGdoSy9XY0s5K1krcmk4NDJ0eCtMSjdHRkZCdGJpeFZoejkvcU53?=
 =?utf-8?B?djFXUzhTeWp5UzNDd1QvUW0ydDNMZGlMekhMS0QxOHA1NmsxbkExOCtNaExB?=
 =?utf-8?Q?OiJumNMov+DdLlMscdK01Mc68?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33b7e9-b0b6-47e5-07f9-08dbbeecb198
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 00:00:00.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2iGGPsOsWTi0V4fIbBN1n42LhSU9gROtwG1309WbsAdi+PMmYn3F7LL1lhX2eViMAVYBZo8yX3ND/0aofnkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGV4cGVjdCB5b3UgYXJlIHJpZ2h0IGFuZCB5b3VyIHByb3Bvc2FsIG1ha2VzIHRoZSBjb2Rl
IGNsZWFuZXIuDQo+IENvdWxkIHRoZSBsaXN0X2VudHJ5KCkgY2FsbCB3aXRoaW4gcmR0X2ZpbmRf
ZG9tYWluKCkgaW5zdGVhZA0KPiBleHRyYWN0IGEgcG9pbnRlciB0byBhIHN0cnVjdCByZHRfZG9t
YWluX2hkcj8gVG8gbWUgdGhhdCB3b3VsZCBtYWtlDQo+IGl0IG1vc3QgZ2VuZXJpYyBhbmQgYXZv
aWQgdXNpbmcgd3JvbmcgdHlwZSBmb3IgYSBwb2ludGVyLiBJIGRvIHRoaW5rIHRoYXQNCj4gbWF5
IGhhdmUgYmVlbiB3aGF0IHlvdSBpbnRlbmRlZCBieSBtb3ZpbmcgaWQgaW4gdGhlcmUgdGhvdWdo
IC4uLg0KDQpSZWluZXR0ZSwNCg0KRXhhY3RseSBteSB0aG91Z2h0cyEgVGhlIGZ1bmN0aW9uIGN1
cnJlbnRseSBsb29rcyBsaWtlIHRoaXMNCih0aG91Z2ggSSBleHBlY3QgbXkgbWFpbCBjbGllbnQg
bWF5IG1lc3MgdXAgdGhlIGZvcm1hdHRpbmcpOg0KDQpzdHJ1Y3QgcmR0X2RvbWFpbl9oZHIgKnJk
dF9maW5kX2RvbWFpbihzdHJ1Y3QgbGlzdF9oZWFkICpoLCBpbnQgaWQsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICoqcG9zKQ0Kew0KICAg
ICAgICBzdHJ1Y3QgcmR0X2RvbWFpbl9oZHIgKmQ7DQogICAgICAgIHN0cnVjdCBsaXN0X2hlYWQg
Kmw7DQoNCiAgICAgICAgaWYgKGlkIDwgMCkNCiAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BU
UigtRU5PREVWKTsNCg0KICAgICAgICBsaXN0X2Zvcl9lYWNoKGwsIGgpIHsNCiAgICAgICAgICAg
ICAgICBkID0gbGlzdF9lbnRyeShsLCBzdHJ1Y3QgcmR0X2RvbWFpbl9oZHIsIGxpc3QpOw0KICAg
ICAgICAgICAgICAgIC8qIFdoZW4gaWQgaXMgZm91bmQsIHJldHVybiBpdHMgZG9tYWluLiAqLw0K
ICAgICAgICAgICAgICAgIGlmIChpZCA9PSBkLT5pZCkNCiAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBkOw0KICAgICAgICAgICAgICAgIC8qIFN0b3Agc2VhcmNoaW5nIHdoZW4gZmluZGlu
ZyBpZCdzIHBvc2l0aW9uIGluIHNvcnRlZCBsaXN0LiAqLw0KICAgICAgICAgICAgICAgIGlmIChp
ZCA8IGQtPmlkKQ0KICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgIH0NCg0K
ICAgICAgICBpZiAocG9zKQ0KICAgICAgICAgICAgICAgICpwb3MgPSBsOw0KDQogICAgICAgIHJl
dHVybiBOVUxMOw0KfQ0KDQphbmQgYSB0eXBpY2FsIGNhbGxlciBkb2VzIHRoaXM6DQoNCiAgICAg
ICAgc3RydWN0IHJkdF9kb21haW5faGRyICpoZHI7DQogICAgICAgIHN0cnVjdCByZHRfbW9uX2Rv
bWFpbiAqZDsNCg0KDQoNCg0KICAgICAgICBoZHIgPSByZHRfZmluZF9kb21haW4oJnItPm1vbl9k
b21haW5zLCBpZCwgJmFkZF9wb3MpOw0KICAgICAgICBpZiAoSVNfRVJSKGhkcikpIHsNCiAgICAg
ICAgICAgICAgICBwcl93YXJuKCJDb3VsZG4ndCBmaW5kIG1vbml0b3Igc2NvcGUgaWQ9JWQgZm9y
IENQVSAlZFxuIiwgaWQsIGNwdSk7DQogICAgICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICB9
DQogICAgICAgIGQgPSBjb250YWluZXJfb2YoaGRyLCBzdHJ1Y3QgcmR0X21vbl9kb21haW4sIGhk
cik7DQoNCi1Ub255DQo=
