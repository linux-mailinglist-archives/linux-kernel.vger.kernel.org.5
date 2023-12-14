Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1775A8133C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573614AbjLNPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573669AbjLNPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:00:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E0111B;
        Thu, 14 Dec 2023 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702566055; x=1734102055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+2kWTf0kf8dOJM0HElhnMeXq/iVFKg0CeaWatpjvnC4=;
  b=VcZAwRMD9/JmGVAStzMXE38UfwU0eS6Got7RmsvKN6Iz26zi6b9vSqPE
   dYTrva8kw3E09IYBpxlMhWhazvuyC5SUeNs7ZTfzCpos1eN1w/DdS9HQZ
   nooAMVxWpDd1fICC0n75BwZB4+Zaw1tyUpKuyYSbiY5MGPpLrSQ2bM45O
   QZHoL2D8TkJrqSlAkXJ3KteYGF0+li913kjD4I4vFN+eVYxi/WcB6CFk/
   TS9zopc9hF73ibo3ad7EyFdRadxjDfIH0/wzNJnMSFUwQc6l9SEQuhBlM
   a/3Jhj8IeKERuQJPZ/93vjbPhYaVLICb3MlB+e85eupbzLh7o28R1mAXL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2215342"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="2215342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:00:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918085250"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="918085250"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 07:00:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 07:00:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 07:00:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 07:00:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy9ViNK3qDCRTvi5AjrxOoEWacnY1soI+p+upnfZLhUS9oC1U2B8J/xWzwOsi9WxSiyMMAMSzXvtSuFgtkhFZLTJFEMG3wbi9kf8rRo0k/GZZDJNQJ0t1rCLkNPRws2hJ2H0/knvAAbcqQPImNsvRoyMwhTLaNp43ZGjSGfTFnvUPmfSFTTBzzLeelwKytN/9NwbGjN/AUf/n/ZiC5AL3KyxDH7A3HkVDO9N0duNkOj/9HlPwMN4NuAIbphRfWU12dnH+2vnfxL9xZprL51SFsgH7uRWbRCI8NGl1glgSWcOjnRxm7rQPBSWeJei6CuEZi/353jUDLMmSGdGf9xhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2kWTf0kf8dOJM0HElhnMeXq/iVFKg0CeaWatpjvnC4=;
 b=FCkXElefzkpqYtUgp3GTCdhXO86H8TOtcwGy8FXIee8523qKus38l7A0xnRA6eKhZTFkpahOzjxTs9UTfJOTpPA+zzlzzrxaH1vC/y2+ZxjJCvIK+L5Csj3AlVoxtQ8coRu7RfJE2OFph5s/f+rGqcPXV/FmHuoY4yPolkuuWd24WT83Juyng6zXNb0mB4BbAHohfiLveC4yvHWCyK2r82cps22e9WqGyJLQ2/L6TR67nQIb96gkfuugQYoGBVJfBNFr/WIp8dvv2iCHiYintoSzN5VPw+zwGCPWbBqpw2hlEtGGXPrPTPG45BdOxl99U++8sws2+0Jo1naUC8E3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH3PR11MB7324.namprd11.prod.outlook.com (2603:10b6:610:14f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:00:50 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:00:50 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Topic: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
Thread-Index: AQHaExJ8HYCIhq0C9kqRsYucn9Sz1LCG/duAgADzWYCAHiuoAIAA69wAgAB4tQCAAZUSAA==
Date:   Thu, 14 Dec 2023 15:00:50 +0000
Message-ID: <378afe31b40b94fbb9096832bf47055c27fa8638.camel@intel.com>
References: <87ttonpbnr.ffs@tglx>
         <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
         <878r5yp357.ffs@tglx>
In-Reply-To: <878r5yp357.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH3PR11MB7324:EE_
x-ms-office365-filtering-correlation-id: 0ddd1bad-92d5-4bcd-f8a1-08dbfcb5762c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVe+y3e33Ft1hq0R/9y2FwGs3Knmxplr8jNZ9YYKEUkiZGnQ6/cT7LuI43hOnx0DSFs3QJ3V/1ATvrmPZPTfQCRJdYqJumzbWkiyUxSOistABdzHohbTtmPZMExHShd5u5c7DgCeL/fStishM4N/FfUqrhaAm6Cb8RikFgNsaoE0P0I4nW5JxXErZg0eQV7d21Q8BNJp6Tek3iNoPPD8fchNOutr4zZVkEgFzLfif9gEeQ6tmfwqpcfwdMWhLpf9T6u0XaCWXtFfnAqSSimoZ9PdiL//WVS6mQuwFn5QLdMahr2mZ/hXv/c4ZN8wazUi7CBhe1lE3azF5W89+esWir4qIc4GfGHNN5Xj5QrTt9mGGhlQIcnYQVDgtpis4ky+EN1To4JqWdwIZ2I64E+aot98kygbnO2RaD+To/6P9xwEKKTlY/HMpmzokWDmrZ70zd0Z9KX5j2h9N7EKni0wlkifwzD1JO1czqS82hvHPx4ZZtLb/3LcQG6nyqoEYoZlbWZx8TcOpxmyxO58YGlKGUf6qtEyQz4UVLlnEJ6t1FYYAwCv+cnyn4yM+e03HXufeUDXwEhxiVeMBQWpfVXZxXzYGuSNmfoErZy6oAz+bdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(478600001)(6512007)(36756003)(6486002)(966005)(26005)(122000001)(66476007)(54906003)(66446008)(64756008)(66556008)(66946007)(110136005)(38100700002)(76116006)(91956017)(82960400001)(71200400001)(2616005)(83380400001)(6506007)(316002)(86362001)(4326008)(8936002)(8676002)(2906002)(4001150100001)(41300700001)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGxTMDRjT2xESVJhMVYxejhaRUZKMVVReFVEdWIrcFVaNk1mb0VNRWI5MDA3?=
 =?utf-8?B?OW9uSnZERmtuSUFieVVUd21iVnRrTlBVTDhCdUh4UFJZWVU4TzV3a1BHZTZ4?=
 =?utf-8?B?SmVudWRHTzd1VmRvMDFKM3NCeElIbEVmbTQzYmtYOXRGWXdzck9tWDFWZHdi?=
 =?utf-8?B?ejVFSTl0NTZzM1FSTW5tZjZwM0NDOTRTUDRBQXdyczFtMHpSSnpRK21Jc3Rh?=
 =?utf-8?B?SmFaWW1RK2N3U3IveVpiRGw5MVFZMVIydmEySHYvbkQyaGhuK1YwRU5BaGVa?=
 =?utf-8?B?MlQyQkRyR0MzRTF5QUhwQWdhanFvL0FMOWFGUHV4SU5sRXIvQVFoeDdZSWI3?=
 =?utf-8?B?SHI3RGp3SVZUMThxRjRMdFlwWHdyUkcxMU8vTG5GbXBhRVJFS1ZwUDNOdUdC?=
 =?utf-8?B?RkNFOWl5WWsxZXRFM1RCMlVaZERJcWhKZWYyd3Mxc0NNakRmUjNoVWI3VkxX?=
 =?utf-8?B?alRHcUI1Q2lBd1BoT2hodlhqVXoyVWgzVjlDdmlaZTJPcWFyRE8wY2M3eGFW?=
 =?utf-8?B?akVSa0E0TzNNVFNCYVVnWU1UYVU1Ymt3Qm1rU0V6NE5UUXYwVVZpRjBYYVV4?=
 =?utf-8?B?V0V6R2NxelBtM0t2OVlXS1hBRXNzTXc1ZjdaRHBjUUx5RzZQMGJRQUgydVBi?=
 =?utf-8?B?N2xac1JobDJVVWNJNjc4Z3MvMWpSZ3ZOdDlDTnY5L1lwT003UmQ4bnNiTVNa?=
 =?utf-8?B?c3hONmo2SnRpRlFZVVFyUVR5bHdqUWxUSmlaZzMxU0JQb0JXdjFoWTBiUVpP?=
 =?utf-8?B?K1g0S2pubjk4OFhOaHBFUy9jL3A2T0RML2loMnozV05FLysyY3dYaXUrempy?=
 =?utf-8?B?VkE3bTJOL2pHQWNFcnZ1c210V28xMkhadTRScU4zN1plUDcwdU1iQ1dqdEFS?=
 =?utf-8?B?WmhhVEVUQXdia08vL3FCSGh4ZUZlQWROT0xVakpJcjZPSXlKZUc2U3hHcTZo?=
 =?utf-8?B?dkVGWHh1cXBjNnZ5MlU0eVdCb3g3M2Zjc3pWemE4NkNrY0FCZzZlOEFmMytp?=
 =?utf-8?B?Mko5WE1WSWJITVNvY1BYNGZlc1JEd1M4MnZ5SmtpWnpQTkZ1VzArck5Kd3Yy?=
 =?utf-8?B?NEp4N3AyVVUzKzliUjAxdEpYRTU3dWlKdll3Z0MrS1UxcVZsa2lLMTBTSHFF?=
 =?utf-8?B?dDdBZU95U3h5WDBvNmdDcHJub3A2NHl4QkhrMTZyRS9tVjE5SVRQQklScVpZ?=
 =?utf-8?B?V2tOZWljVk5HNlZ2ZkJ1TUJwckUzVGNncDBQYXRCeGhZYk4yK0FMNlNhNTlZ?=
 =?utf-8?B?U3JrNnVQandPTzhHVDNPUm9Od1JvTE8vamh0NWNhMTFSNHNxZE5NdGI4SWov?=
 =?utf-8?B?SU81NXhSSEtnV2YyL09yeHB1SHJsQVZzVEFVcXVid2JEQS9xNmlRcXRKRm9L?=
 =?utf-8?B?RjdJMzdvdm1aMUQ1T256Tk5nRWpIL3ZWYW1uQnpHVEYreXdTeUJtVmY4V21m?=
 =?utf-8?B?YzZiaEo5N0pIaElaK2Y1THhpZ1k5V0ExZUw5VTBxVlRXMkEySEJIbTZhYkxG?=
 =?utf-8?B?SDlMV0J0amZ0c2s1WTkxdkxIK2t0U1ZBS2hneE5ITUZGcTNTd2wwcTZRM2NZ?=
 =?utf-8?B?UTlyL213cWl3YTVhYm5GcFE3ZGRtY0lwTEhWekQwZVBFTWZFL0lob28rc0Ft?=
 =?utf-8?B?QnBubjcxNnRReTZXcGwvSGxSbERUMjRTbXQ1YUU5YmFJRWxDQlhuaUNLbTBY?=
 =?utf-8?B?V3FQMVpVNDFpMm5RQmVjY0ZzZ2ZqOWdhdE5WeVdCTGoyNFV6L1B5dXBtYUtZ?=
 =?utf-8?B?WVRsMXpDOGRaZ3VVVWdFaWEwWWxyVXFEdEZSeUYrUUFnK2RsMXlFMlQ5Z3Qr?=
 =?utf-8?B?d0pVTTYxaTZ5Z2dydXpzeVAwS3RPaWlpYWpPRmRZdzBUUTJnUHgvRW1MeFlY?=
 =?utf-8?B?RjM0MjdqcVhjeXhlbzV1S0MyL2trL3NIM2dKNXhaYTAvdnI3TEZRL3BqVWFm?=
 =?utf-8?B?RDBHQXNWc0tDSnQ4Z3JjYmM3QjNOMjJJZGZMZC94N3JHUnZEdnJJekM0V0cr?=
 =?utf-8?B?dmo4anFQdXpISDJ3UU5Ud0gyUVVkVFRnRnhHMnQ3QnlCSlNObVpPL3ArQkVh?=
 =?utf-8?B?K0VPUWNlTGJ0bDlWWFBFSllqSlc0WjFzSW9HYXFETE5keVN6eWl2NHMvak5M?=
 =?utf-8?Q?i+u9MLnlX3VN6KIyybKaQYLjW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FF574FE3D9F0442B7F2934A4CC1446E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddd1bad-92d5-4bcd-f8a1-08dbfcb5762c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 15:00:50.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nUeMWQOtaMpsrKshhDvpED0q3qGL3G1XdkWisaoL6wS2EglCiCRnpPVgE824DvHnenngg+XehgHXVbDvaAD+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDE1OjUxICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFdlZCwgRGVjIDEzIDIwMjMgYXQgMDc6MzksIFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4g
WWVhaCwgSSBhZ3JlZS4NCj4gPiANCj4gPiBJIGhhdmUgcG9zdGVkIGEgcGF0Y2ggdG8gZG8gbW9y
ZSBzdHJpY3QgY2hlY2sNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEyMTAx
NDM5MjUuMzg3MjItMS1ydWkuemhhbmdAaW50ZWwuY29tLw0KPiA+IGluIGNhc2UgdGhlcmUgYXJl
IHNvbWUgd2VpcmQgY2FzZXMgdGhhdCBMQVBJQyBmYWlscyB0byBwcm9iZSBhbnkNCj4gPiBlbmFi
bGVkIENQVSBhbmQgd2UgYWxzbyBsb3NlIHRoZSBYMkFQSUMgY3B1cy4NCj4gDQo+IFRoZSByZXR1
cm4gdmFsdWUgb2YgYWNwaV9yZWdpc3Rlcl9sYXBpYygpIGlzIG5vdCByZWFsbHkgdXNlZnVsLg0K
PiANCj4gSXQgcmV0dXJucyBhbiBlcnJvciBpZg0KPiANCj4gwqAgMSkgdGhlIG51bWJlciBvZiBy
ZWdpc3RlcmVkIENQVXMgcmVhY2hlZCB0aGUgbGltaXQuDQo+IMKgIDIpIHRoZSBBUElDIGVudHJ5
IGlzIG5vdCBlbmFibGVkDQo+IA0KPiAjMTogYW55IGZ1cnRoZXIgWDJBUElDIENQVSB3aWxsIGJl
IGlnbm9yZWQNCj4gDQo+ICMyOiB0aGUgcmV0dXJuIHZhbHVlIGlzIGJvZ3VzIGFzIHRoZSBDUFUg
aXMgYWNjb3VudGVkIGZvciBhcyBkaXNhYmxlZA0KPiDCoMKgwqAgYW5kIHdpbGwgZXZlbnR1YWxs
eSBsZWFkIHRvICMxDQo+IA0KPiDCoMKgwqAgSW4gZmFjdCBldmVuICdkaXNhYmxlZCcgZW50cmll
cyBhcmUgdmFsaWQgYXMgdGhleSBjYW4gYmUgYnJvdWdodA0KPiDCoMKgwqAgaW4gbGF0ZXIgKHRo
YXQncyB3aGF0ICJwaHlzaWNhbCIgaG90cGx1ZyB1c2VzKQ0KDQpBZ3JlZWQuDQoNCj4gDQo+IFRo
ZSB0b3BvbG9neSBldmFsdWF0aW9uIHJld29yayBnZXRzIHJpZCBvZiB0aGlzIHJldHVybiB2YWx1
ZQ0KPiBjb21wbGV0ZWx5LA0KPiBzbyBJIHJlYWxseSBkb24ndCB3YW50IHRvIGFkZCBhbiBkZXBl
bmRlbmN5IG9uIGl0Lg0KDQpHcmVhdCB0byBrbm93IHRoYXQgdGhlIHRvcG9sb2d5IGV2YWx1YXRp
b24gcmV3b3JrIGlzIHN0aWxsIGluIHlvdXINCnBsYW4uIFdlIGhhdmUgdGVzdGVkIHRoZSBsYXRl
c3QgdmVyc2lvbiBhbmQgaXQgaW5kZWVkIHNvbHZlcyBzb21lIHJlYWwNCmlzc3VlcyB3ZSBvYnNl
cnZlZCwgYW5kIEknbSB3aWxsaW5nIHRvIHRlc3QgaWYgd2UgaGF2ZSBhIG5ldyB2ZXJzaW9uDQpw
b3N0ZWQuDQoNCnRoYW5rcywNCnJ1aQ0K
