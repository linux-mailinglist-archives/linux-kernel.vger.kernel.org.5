Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26857AF49C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjIZUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjIZUDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:03:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94211D;
        Tue, 26 Sep 2023 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695758587; x=1727294587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=siOeXPN1MiDc0YvsGHSfUYy2dp+LVamoUB3RVJJuSqM=;
  b=gh5Vs76jM8uzMh5hT6yhyKeFL8t/UclxLtET+nE7Xs/uHi07ZnnbjucH
   XXlGIi9RE5zG3c7pPspzIXua+uKk8a1fmcqeCYtq/HTWiIn0jT+h5a2QO
   OFARapW54nmIuwU1Eax/zUgAl6Op90nNAPGzeUT1dtP7Pbo+MWHqm5dGE
   DmQhrDQ2LmDVIazW5DnjVGGd99isiHoUukwNjDrbzTtiI4uyEoHURcBO0
   yBVc1P8sC4HkGNJHBe4+mffe4ffjxmcULRV45DEnz3c0VwJtHwgWOaKrc
   wTygIgVY6TfX50aKQOpofe9yiutTJn5sE0LbZoEe8qkOT7iDY1CmK4ofV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384436913"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="384436913"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 13:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814596853"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814596853"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 13:02:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 13:02:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 13:02:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 13:02:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 13:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvVuwpFcBlAWmEp2ewkNz0hofaUXebcn4wkg5hm5IxFW4fftYRxzVvwvSnEMVixIsE5UsfcASrOSR9k9wjyKRN+NGmkFaA4KERIgQSrHBOyuPCV+ORkW2+YdYMKi+7RyaF0jh8xWFphpOEWQe6hpPTKh1ECDC5zg348+Un3hmFJ3RxozFfXdfnjVgyV9Y3S4JcDocuCUugLt3sCniilAo6tmF5ltHGYT98e7+jkPrpkuVzJtVIjOaUtnAKLj/dIw28z6mseAypR07vwWw1ljT4b2RINPNw1j9Fn+B6qqed+gPAWnW0VBTweNTBMtkxknOo3gjKXU6lhfgqbTx/bF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siOeXPN1MiDc0YvsGHSfUYy2dp+LVamoUB3RVJJuSqM=;
 b=Nn6jPAoE3a7qSKMGuszz43Lixo8mGrusaq8ZYb8htrmz6PlH2nUGN05D4Iw/fF4VgbEZJG4EqCXXSzYCNbZFnGTmjgJhHbXKumi/idvyl9sxP5+VPihIvq20f+o2hJhu9XUTNRA6u3BzTIf1hiHI0Yh4EvzuwQR7M0quxnmgRWLJ7bxHkMgaHqLZIkUvg32Lu8UqsnZtbLKwtyF701dhNT0VUjEQZoxMmOo+ycqFqN8EsbXQAdh4WGQa0bE0BhH8w/oAGO/ENHC/aAUlllgXo4xcS0gwbchcwMqE+gFQ8O1BcMHO/HxhIgP9Fwd+/kFqk5tC9SI3l7WRxn8tmARYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 20:02:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 20:02:35 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Thread-Topic: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Thread-Index: AQHZ2tLOJWAT87qOwU+0c8WAv0aGYrAtpjsAgAAEVzCAAASpgIAAAFXw
Date:   Tue, 26 Sep 2023 20:02:34 +0000
Message-ID: <SJ1PR11MB60836E94B5DC0A2D7B5ED2C3FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
 <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3d0b98e7-9aeb-3a97-9861-707ed7a1db69@amd.com>
In-Reply-To: <3d0b98e7-9aeb-3a97-9861-707ed7a1db69@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM3PR11MB8736:EE_
x-ms-office365-filtering-correlation-id: a60e9e6b-e6d7-497c-82e2-08dbbecb86a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXMKDwk9UHunibia9XfTqSqLCBnOyk9FZR+k1r9hTGVcxEQCraAAaNdKofIx5zpExJAzIq6cSeG6OoN9Cs9AVbnetyFxZh7tgs8QJRcA4dsvxMSVURn2ZrpA4Tu7HHEEmXczMy5jVqL21//VU/57cpOGxxZMYb7xyuSvABXjZEkZFqbxNp6SKGnWK7GSsIwy42ibYb9Jt67Uq7sTJ1jLmWRS76PSQMY1S+UqC0dHK9CGphIL+uqjbJYtE4fBCdGiZWRuMPfieylt2i2Rek4HEJj8jwxbYWNM0n2xLl8COchw8v14b0I4K3q4g2cjw2SXux7V99XJ+916Zulwn19FIVKkdTxBvZBNa6bfyxXw+WK0rXvsmPpdCE5ShPrUunfBKWOrm7LhZLsF5tOozuzdTfZKA6CaG4o8eCNrDC4fUbWRQeXsfGS6G/U/7hMUTMDgBrLxyExCVfvKWapB4vnHo51gjeE92SeZHqcHhCQJPWw5A5A0Hrwl93mngLqrRG8HAzYmP2aeTBcWNp0i2+BQuqetib365d9bEvgvJO95VVfxiMqEkFklNH4DhY4dTUYBfIz15r6IYYVeaEiG420UHzUtwajZ3KxLPBYf4Y7SeiSrEUK7xvNO4IWN805aqbzH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(55016003)(66446008)(76116006)(38100700002)(316002)(110136005)(66556008)(64756008)(54906003)(478600001)(38070700005)(66476007)(66946007)(2906002)(8936002)(71200400001)(4326008)(8676002)(122000001)(52536014)(5660300002)(6506007)(7696005)(7416002)(4744005)(82960400001)(9686003)(26005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFAxQzlLaDBoM3VWRTIwcXp0V0J0UGNrZ3pFa3p2MW9Td3d4STA3WkxjYUp3?=
 =?utf-8?B?b1VuMjdyM0JYY0ZMWnlkSk1lbVlpaWJuRVNZQlFqVFFZSENqRytDZStPUGRS?=
 =?utf-8?B?RHZMQjlucWxJMmVHOXlIZ3RZR1hYRTgvWnBLM1FDWU1VVHl0d29SWm15c3Zr?=
 =?utf-8?B?dFoyRW5EdjNXa0tNaWpVU0lIaHB1L2pvdmNYcTkrVElHbnIwUHYwQ1lLMkIz?=
 =?utf-8?B?R2JIaU91TGd4bEcyNFN1M0VCd1NSNEtldnNrV3dtODEwRXAxWTFqY1lUMFp5?=
 =?utf-8?B?a2M0TmZRU3lHSGNrYkQ2Mzc4Y2tPRXBNZS9XWklLeVFoRTd2Q011dWJuVjFV?=
 =?utf-8?B?bUFjT2FYY0ZOdHQ5QUJCOUtJOHgxbllYZ05oR0dqY2ZBTWJzNU8ySThENXV4?=
 =?utf-8?B?cENSY3AzTGc0ZlJjazl5WUNhN1R1ejVDNE9VdExBOUc1MzROZklkUXAwbXJ3?=
 =?utf-8?B?N05uRndndGNrSUlIUjRTeVBOZzQ3QnhwN08rL3l6NDZERjBHalFwazdqN1Mx?=
 =?utf-8?B?MTNhOWY3elRZSFl1bzRFNXBPRnV2UlhSMUtyUGRxekRMSkYxRDVETWNncnNz?=
 =?utf-8?B?NFRscExPdWFSbEVTRldYOXFxdEdlWGtrTHhOYUJQbnRKeWY2NCsvVFBhaFFY?=
 =?utf-8?B?QW5HdzhJc2JDMnM2ekI2dDJzQXdsWjFhSTJPL3FOb3pVY1lYYWRDazVSNlV5?=
 =?utf-8?B?M3hZdllDSWxnVHhLTitrUTdRenkzRTgxUmtIa1BKcW5FM1NOTzJ4bmR1bUdv?=
 =?utf-8?B?VXJlQlNWeGNhZ1ZPdlkrZHFNSWRQVHFaaXBwRGQ1RHpsTWRYK3A1VGdoOENO?=
 =?utf-8?B?TVQvanovNkpSR3FNcVpFZmJQaTAzWVJGNS96YVhXVGdjaitQUlBIK3cyTmdZ?=
 =?utf-8?B?VGFCNUhlYm5xbXlzT0NNMSszNm9UR29wY04rQlpXMlRPUVhFNkFHWmhqTG5T?=
 =?utf-8?B?c3NvNm9hQzlSRHBqT2NOUDJCQnFta3BLaXZrNjdVY1RLT3U5RjhTUVN3VStT?=
 =?utf-8?B?UGg3YmxhK3R3UjN3KzJQSlRxN2F3alhhTTNYZ0x4YXFXRGFuSXBEaURyeHRO?=
 =?utf-8?B?d3ArQThYbEJUUmhCSTJPNVpTTEZuYWFuUWppTjJOT3hRaFJsd1VsWjdudWha?=
 =?utf-8?B?d1VTUHk1S1hhaDJJMkE0dGg3UEh2UGlyYTlKdHdRaWtBUVh6UXVKKzR2Sjdu?=
 =?utf-8?B?dUZPTUprSjkxU1BhMWJUMUxmUEpyQ2V3YkZkRDdxeDFyakV3Z0E5WmVJdHpv?=
 =?utf-8?B?bVprOUJIRkpKLzR3ZW9sVDRleFhjcHRPK1JreE9MUGs2SksrTG9IQU4rRDlK?=
 =?utf-8?B?NDdaak9zN3NSNWRsMlU0a3NSVGhEUm5zZTNtano5a3F1d3p5eVVhT2xvMTBT?=
 =?utf-8?B?QkRadGZ5b25mWW1wWlEzbGY5RnZyT2IvTGJ6OTZlRnI3aTZOekdTT1dsOUtX?=
 =?utf-8?B?MjVIRkVsNHJKeHhxdjRDOFFwb3VaNWg2bjhLMnZZOXV6Z2VBNzZ5ZjRHbStl?=
 =?utf-8?B?RHRWNk5uSmQ1bERnT1ZQTkpwcEJGQmhuWEsyRjNCd3BjSEh5MjNsT2FiN1Nr?=
 =?utf-8?B?VXV6TFdJYjBNUHcyS3kwcmlJTW9PYnlBbDc1TDFEQlpXcHZMSzBRMTY5WVJp?=
 =?utf-8?B?R0kzVlRMaExHcW5CSFRpSktUTWVzcTUwR2tWRmRMZk5nMUFQejZXTVpNMVI1?=
 =?utf-8?B?UEdJNW9qWTdXS2tUc1NjVXZOUE0zeUkzWGUwZkVEZ05NZTZJcWdmenhZTWRo?=
 =?utf-8?B?ekg5cGIxSUtzcU83alp4YVZwenhGTm4vSFc5Y21EazZ1RGEySE5JUkVnbFJl?=
 =?utf-8?B?UjNiYlBETGRjaDF6U0RZWXdvWUdMZld3amwrTTV6WkZYTHUremV3d3ZZM2Vr?=
 =?utf-8?B?aTBLMlEzaVp0S0NXbVlnL3F5bnl0Z3dqYkdlb3dtWDhyOHlQYzZBL1ZqNHRz?=
 =?utf-8?B?eU1wMENzenZ2eEIzRUt5STMwUk16YVFKRXdOZ1VqZ0d4bUJJNks3QmRBVTBh?=
 =?utf-8?B?QVVXY3pNK1NsV3N1RFFNb1NOZGx4VW1Td0lhUDlKL1c0TjNjdDUvOUkzWjZF?=
 =?utf-8?B?MGNjRTRITGtMb0g2K01EZTVyTVM1RUhqV3VpQUNVcHA0bDI4UmMvL3dMTVQv?=
 =?utf-8?Q?gRQaxs5kIJoKB3xem61I6m5nf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60e9e6b-e6d7-497c-82e2-08dbbecb86a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 20:02:34.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6d/uZJA/VvTRuYU3zVbBLcg7qI0gfRHKww8iBosUS9N0Kx6MZOroPb8YjjiinM7CGcV5+s0F7qFjWAMhFhYufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+PiArI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPj4+DQo+Pj4gSSBkaWRu
J3Qgc2VlIHRoZSBuZWVkIGZvciB0aGlzIGluY2x1ZGUuDQo+PiANCj4+IHN0cnVjdCB4ODZfY3B1
X2lkIGlzIGRlZmluZWQgaW4gdGhpcyAjaW5jbHVkZSBmaWxlLg0KPg0KPiBBY3R1YWxseSwgdGhl
IGZpbGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+IGFscmVhZHkgaW5jbHVkZXMgdGhlIGFib3ZlIGZp
bGUuDQoNCkl0IGRvZXMgdG9kYXkuIFdpbGwgaXQgaW5jbHVkZSBpdCBuZXh0IHdlZWsgd2hlbiBz
b21lYm9keSBoYXMgdG8NCnJlLWFycmFuZ2UgdGhpbmdzIHRvIHJlc29sdmUgc29tZSAjaW5jbHVk
ZSBkZXBlbmRlbmN5Pw0KDQpJIHRob3VnaHQgdGhlcmUgd2FzIGEgZ3VpZGVsaW5lIHNvbWV3aGVy
ZSB0aGF0IHNheXMgdG8gI2luY2x1ZGUNCnRoZSBmaWxlcyB0aGF0IGRlZmluZSB0aGUgdGhpbmdz
IHlvdSB1c2UuIE5vdCBqdXN0IHJlbHkgb24gY2hhaW5zIG9mDQojaW5jbHVkZXMuIEJ1dCBzb21l
IHNpbXBsZSBncmVwJ3MgaGF2ZW4ndCBmb3VuZCB0aGF0IHdyaXR0ZW4gaW4NCkRvY3VtZW50YXRp
b24vKg0KDQotVG9ueQ0KDQo=
