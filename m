Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38607A011F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbjINKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjINKDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624841BE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694685777; x=1726221777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1BZiTxdPizuyGQcEmbNokq4yL8KApGs8Zgn/iQvegEQ=;
  b=nkFHqOrEczfquy3IFd1fkRpIm8XUmvHBgK5Joxi+JoYYd0nqU74Ivc7j
   lmglzG01eDx5DS4nNmLBjF4RP69Fv6WWAhdVWGx3grorolFRaUPs3l7XG
   g3x/b7lk4n34/9XSUTDgUL6LcB3gYeMLYRH8Z+UtNz9DckEGvyCZ63MBA
   EnMipbuq+Dm5Qabl7laTcUmqgDcO32NSbRMnfp7P8PdrCf9JYP83h7+uy
   LsLFJjK3SfFTVEPS4xZM3Neg5n0I7THH/uprZBeZKreNJiylhEa3rbSP1
   KjcNy7rLAIHdw3GqeXmKaR6K/fk59bWmJGi+DpJFSpkeXbNLiq4BzlTs4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377815600"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="377815600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="991340850"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="991340850"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:02:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:02:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:02:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk21gULIi8ut99+d2YqcR+VAdlzbI7nMjE5NNB1m0/kDZ529dAe0H61z2ghv0LkxpiBu8TqnyxP6EP6f+osN3nK761htlfoVwBSG6nPWu0FumCpztJB+wCtoxjW3ksMd9okeI4DWrWNroKJJ1ZGXoLeFbG76iz7qpVxw7F6QDW1g/+/lYk7AV1miICi10E50GeFU0NHvHf31FTBg0rm9LBW37K7yvTsIbWn7McYoQ4qvH3juu7mOC1DPZHqB90Y5l3PkkJg7mXDGthdArcu76G0p+cyipsTjNuUbAG2yzEeRsB4pGClRR9NenjPIu4vS095jw2PnJuqnqkyf3G8bjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BZiTxdPizuyGQcEmbNokq4yL8KApGs8Zgn/iQvegEQ=;
 b=PJU2UKYjdcKMC+MuMEDXZEy7gOXCO2I22kdJT15e4beiZ9fX/kdbBP081f01ia1YdyjWnRtChaay3uLchHMyW/RvHmWGshUwACzjEcPgPCr/nffiVHpL83HShqL0HHDw/l+aAZm+5iI5lakOwwVtzOSnqvWkXHNZZZn4ih+iO6P2k5FDE9sFCiyJZFYgyG7WQnfU8njHP1uLWwRB3m+atmqAdi3nOo3Ov8h9hzEwR20bn9M5ujJWXwwEKHk9etETQu/Qk31E0FkHUAcgnyuXMlSKQKkfE/ied6MCIoAH1bfM52Po2s1Lq0orniB+wtR9wnVDPuF2FBiDO54sKxnscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 10:02:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6768.036; Thu, 14 Sep 2023
 10:02:40 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Topic: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Thread-Index: AQHZ5qem7IU2VPrp+E+UjIKvurp2uLAZhucAgAAgzICAAEWGgIAABr8AgAASL4CAABG3gA==
Date:   Thu, 14 Sep 2023 10:02:40 +0000
Message-ID: <560662b4dd5088164119e0d312f88ed97f6f94a7.camel@intel.com>
References: <202309140828.9RdmlH2Z-lkp@intel.com>
         <90f0a4d44704f9c296f3a4d8b72c57f2916aa09d.camel@intel.com>
         <377b1ce2ecd390f4b6f8cdf68d22c708f7cef6d1.camel@intel.com>
         <20230914072959.GC16631@noisy.programming.kicks-ass.net>
         <9eb77be3a64c25b3264d5011a93242d006b88627.camel@intel.com>
         <20230914085913.GD16631@noisy.programming.kicks-ass.net>
In-Reply-To: <20230914085913.GD16631@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8135:EE_
x-ms-office365-filtering-correlation-id: 8cd575f2-7519-4c75-e05f-08dbb509bb31
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cGJGbMX/4DELEZGH3BUAAdxW7aMGozfaD5s40nJlRvjO73HSvu7+lN6x/ELx/bwM2Zja58cyRqvcG0Ubq/JJ0oL206hMkH/bDt/zHeOyx3IkBME05uMIfLrrSnk42W7RIM5EqfnlppxN0PF1T9kI5IuzYkTg0c44ynIMWDdbO9PntweLSUNv4FhE9zQKWEM9UtCeiZ0pisuEC6CJzfyADYKItCFGpxjIpspr0l+VzYrVh5EqYDX3J22JmvdgyJHq9OjaSJcN8fNuqCNaLQd3FAkFivrf6YqVqOrp5ZASssIm6aR2Z3onVbCEFwgcYIyqxX/ZaEiRGfURvHeUWdkO1qVa0kMFpJjZ7feN3xlzN4Ra8Tm9yals/HABOHITwXLV3TKFzJeRFrh8n2o893OIxjPi/fjipnJnGheTHGi0vuqmsdtY77hLWxBjHSb4UHJv1WSzHlYVmgfqiEYiWL0+alCV75c4mbAcYBwZpX/JmJxyn1R7NVKlnQ9YoA+Mu5Bd9C8wlhcrIKNII4EkuxwWG4a03BsmJxAGW5ai2RFRNnhDfewMS8JyBGNdt8yHrFjBBFS9AegXJ+fGb+NLo5wu513I7xRBoNPnkApLIFDf8CnNFAMiKIBEMo6t2sbPK6E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199024)(1800799009)(186009)(2906002)(82960400001)(36756003)(86362001)(38070700005)(122000001)(38100700002)(41300700001)(316002)(6512007)(66946007)(6916009)(66556008)(64756008)(66476007)(76116006)(91956017)(54906003)(8676002)(4326008)(8936002)(2616005)(478600001)(66446008)(6486002)(71200400001)(26005)(6506007)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTc4YngwYVpOdXJwZERJTHUxL2VUd0J1d2hMNWsyMjJHOGVnczlCOHF4b1RJ?=
 =?utf-8?B?WnBBblNrbEsyQldON25UYkkzZTdLei9wNzB4UnZMOUJGOG93c0kybGZpYndu?=
 =?utf-8?B?Q2gvY1lQVERkTkswblRPa0tTY3JlYzlVWVFKVkI0YzFwTE1jOStycHhSRGlC?=
 =?utf-8?B?YnFLUFlpVkhLd2pCQWN3T0owQnJnS2pjNExWZVl1bWJKSllxRTB6QnN3NmVa?=
 =?utf-8?B?YkY0MXB0ZFBqNUFmMlNXbm14RTF4ODVBQ0FBVDRibFNnMDRBWDl4UWxQdnpJ?=
 =?utf-8?B?ZzRxMG9mcVdhajBzMWU5dGxCdmpYZUJ6d29PSUI4TWJhSDlHaHEwV1hQUklB?=
 =?utf-8?B?V0tIazB1L1djVVZCdGdLWnFGaEQraGdKT0hubjBPRGxaOHpFK1NoblVVSXl5?=
 =?utf-8?B?VGRlUHYvZnRtTnNEYXUxRWhUQ0ErbVdnbEFOUmpzaGdOMUlvcVVVWVpnMkFX?=
 =?utf-8?B?SkxmOUpkbUZwUDc5aWZwV1ZZM1RFSkZudVJGZjI1U2VFZkFlbEkrQ3JSVTk4?=
 =?utf-8?B?R1lab2hQMjJndGwzeHQwcTl0elpkUk5SK01uNzBXTEJ4T3VJbENzbXJXSGdy?=
 =?utf-8?B?ak8vZU1XOXlwcWxwS1gzc1RNLytiYTRNNVhQbGFXdS9HSjJRY0hUZHdaRmRv?=
 =?utf-8?B?NTUxQVRDdDNPbG5KSWh3WEpZNU83aXU1VmwwcE1Ma1JsSkx0ZWR0UTlXbGV5?=
 =?utf-8?B?NlkrSmZTeGVkMHkyTC9zbFRCOGFiamgxb2U3QTZ3ODdSejVQVXJ0ck5qbGly?=
 =?utf-8?B?YzF1ZFBMdlNUaVJ4U2tGd3Z2Q3RvK2ZYNWhPOUhXR1hqcXlqVjhoMXVOSjdR?=
 =?utf-8?B?WWVwSFJrMTE5bm9YTW5HVmM3anVTcy9LaU9rNkl1ZmlJanVBYU93M3IxMjgx?=
 =?utf-8?B?MTlISmpqczBsMEJ6T2dBTUdUbkExbGxKZjNnUG1iUC9rOWYrR085bkM5eTNI?=
 =?utf-8?B?VGJWUmlqY0hmSkoyYnoyT3JCbUlOcS80eW42cWlrNFJLZXFpSTJWaVh5SVht?=
 =?utf-8?B?VmdXWUcvYzRTaG4vN3lQQXNabHdlUWdvZlRzS2cwVzFCK2t2bkVYT2Z0ZE9H?=
 =?utf-8?B?RkxJajJ1UDF4NGxTL3BBZ0VMdnJZbE8vaFNENFdqMnF2SnZ3YkhuSTV4ekR4?=
 =?utf-8?B?b2VkZ2lhR1pMdzZZcDhybjN3Q2ZOeFdyMjFkWWF1MVBqYXZNdmdheHpBcWts?=
 =?utf-8?B?UUVTY3JuVmdmczVKbnB1SUUrV3M1VzVlQ1FCaWRFdndvMUFuWU51bjRzV0FI?=
 =?utf-8?B?a1I0dWZUakJyMlhlbzJ5ZVVoTnYrMFNOZVhtUG9Pd1hrWXpVWCtaNTI1OEls?=
 =?utf-8?B?TFRnZTlaVkJONGhPWVZIQmgzS215WkNjWXAwaFdHbFYreVVDMHBrRTFHUk5r?=
 =?utf-8?B?VGJPYXZxM082cnA0Mk8xZW9hcC95dW5KUDU3TVJRWHIxTy9OMStzQUtEZ1Jl?=
 =?utf-8?B?UHNYYnh1enV6Wk9neWxBOGhTQnhJRDR2QzlxWWFwNXpFMGJ6aHZlZUVleGgr?=
 =?utf-8?B?MXBINjl6Qmd0eVRaYUlpMHh4RVJVakdwNHZuYXdidVhaa0N4OTdpOEFMeUJQ?=
 =?utf-8?B?UXdtbGsxa0pGT1MzNDlYaWJEYTlwZ3o1UXkyMVJTZzlWL1djanZCai9BMmEv?=
 =?utf-8?B?OWlSTHc4WDd3Y3lVMWhvYWNCTStiTklwb2Fid0p4SEdkdW9KVVV0NHZOMUp4?=
 =?utf-8?B?SU9FL0ZLUnFlcU1BY1BOZUdFemR5b0UwbnBWM1pETUpVVUlNbHZtdkVxQWxq?=
 =?utf-8?B?c0VmTGhZYzFnVmVET0RqcVY0Ukg2NjhWTjNoNTdhUTZGWlcyanJqV2lYOVNz?=
 =?utf-8?B?aklJbUlkZnVpMUdodGE0eWIrdnhEMjdBNHM2Q2hYTzhUSGhqUGx5TWI2ZWVE?=
 =?utf-8?B?b1kzdWI2UTJjYUdkVXZoN21yZlprTEhXUE95L1BVZ1Z3RVhybVdzRDJFamND?=
 =?utf-8?B?TmVwQ2lnSzQrbkh6d0dqbmhHM2l6NGcrM0FFbGlpdmVKWEIwNFE1Q3NLL0Nk?=
 =?utf-8?B?TEwxdlJHR2FqZUl0RjFUaVpMczgrL0QzSnYyQWxLY1I5dVYrWCtacXVFQ1l0?=
 =?utf-8?B?bTAwRE5Iby9jNVprZXN6dzY3dEd3N091UUQxeVhWZTRHWEhQRS9ud3NWNlhI?=
 =?utf-8?B?NkhOeWsyc3hFUzdJZ1BCVFQyZksvNGNuVzJOTHlwd1BOSVRnejhZVEdrdVJJ?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF45923B1644C049A0ADA172DD33DEF9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd575f2-7519-4c75-e05f-08dbb509bb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 10:02:40.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQ2oojavPCpU08FFJOR6ov1KUlsrzgxLMhWK29kaHX53Jly0HIESxpyLJEILHbjb1yf4+JNSVc40YDiQr3HVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA5LTE0IGF0IDEwOjU5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMDc6NTQ6MTBBTSArMDAwMCwgSHVhbmcsIEthaSB3
cm90ZToNCj4gDQo+ID4gPiBUaGUgcG9pbnQgb2Ygbm9yZXR1cm4gaXMgdGhhdCB0aGUgY2FsbGVy
IHNob3VsZCBrbm93IHRvIHN0b3AgZ2VuZXJhdGluZw0KPiA+ID4gY29kZS4gRm9yIHRoYXQgdGhl
IGRlY2xhcmF0aW9uIG5lZWRzIHRoZSBhdHRyaWJ1dGUsIGJlY2F1c2UgY2FsbCBzaXRlcw0KPiA+
ID4gdHlwaWNhbGx5IGRvIG5vdCBoYXZlIGFjY2VzcyB0byB0aGUgZnVuY3Rpb24gZGVmaW5pdGlv
biBpbiBDLg0KPiA+IA0KPiA+IEFoIHRoYXQgbWFrZXMgcGVyZmVjdCBzZW5zZS4gIFRoYW5rcyEN
Cj4gPiANCj4gPiBUaGVuIEkgYXNzdW1lIHdlIGRvbid0IG5lZWQgdG8gYW5ub3RhdGUgX19ub3Jl
dHVybiBpbiB0aGUgZnVuY3Rpb24gYm9keSwgYnV0DQo+ID4gb25seSBpbiB0aGUgZGVjbGFyYXRp
b24/ICBCZWNhdXNlIHRoZSBjb21waWxlciBtdXN0IGFscmVhZHkgaGF2ZSBzZWVuIHRoZQ0KPiA+
IGRlY2xhcmF0aW9uIHdoZW4gaXQgZ2VuZXJhdGVzIHRoZSBjb2RlIGZvciB0aGUgZnVuY3Rpb24g
Ym9keS4NCj4gDQo+IEkgdGhpbmsgc28sIEknbSBzdXJlIGl0J2xsIHRlbGwgeW91IGlmIGl0IGRp
c2FncmVlcyA6LSkNCj4gDQo+ID4gQnR3LCBJIGhhcHBlbmVkIHRvIG5vdGljZSB0aGF0IHRoZSBv
Ymp0b29sIGRvY3VtZW50YXRpb24gc3VnZ2VzdHMgdGhhdCB3ZSBzaG91bGQNCj4gPiBhbHNvIGFk
ZCB0aGUgdGhlIGZ1bmN0aW9uIHRvIHRvb2xzL29ianRvb2wvbm9yZXR1cm5zLmg6DQo+ID4gDQo+
ID4gMy4gZmlsZS5vOiB3YXJuaW5nOiBvYmp0b29sOiBmb28rMHg0OGM6IGJhcigpIGlzIG1pc3Np
bmcgYSBfX25vcmV0dXJuIGFubm90YXRpb24NCj4gPiANCj4gPiAgICBUaGUgY2FsbCBmcm9tIGZv
bygpIHRvIGJhcigpIGRvZXNuJ3QgcmV0dXJuLCBidXQgYmFyKCkgaXMgbWlzc2luZyB0aGUNCj4g
PiAgICBfX25vcmV0dXJuIGFubm90YXRpb24uICBOT1RFOiBJbiBhZGRpdGlvbiB0byBhbm5vdGF0
aW5nIHRoZSBmdW5jdGlvbg0KPiA+ICAgIHdpdGggX19ub3JldHVybiwgcGxlYXNlIGFsc28gYWRk
IGl0IHRvIHRvb2xzL29ianRvb2wvbm9yZXR1cm5zLmguDQo+ID4gDQo+ID4gSXMgaXQgYSBiZWhh
dmlvdXIgdGhhdCB3ZSBzdGlsbCBuZWVkIHRvIGZvbGxvdz8NCj4gDQo+IFllcy4gb2JqdG9vbCBo
YXMgc29tZSBoZXVyaXN0aWNzIHRvIGRldGVjdCBub3JldHVybiwgYnV0IGlzIGlzIHZlcnkNCj4g
ZGlmZmljdWx0LiBTYWRseSBub3JldHVybiBpcyBub3Qgc29tZXRoaW5nIHRoYXQgaXMgcmVmbGVj
dGVkIGluIHRoZSBFTEYNCj4gb2JqZWN0IGZpbGUgc28gd2UgaGF2ZSB0byBndWVzcy4NCj4gDQo+
IEZvciBub3cgbWFudWFsbHkgYWRkaW5nIGl0IHRvIHRoZSBvYmp0b29sIGxpc3QgaXMgcmVxdWly
ZWQsIHdlJ3JlIHRyeWluZw0KPiB0byBnZXQgdG8gdGhlIHBvaW50IHdoZXJlIGl0IGlzIGdlbmVy
YXRlZC92YWxpZGF0ZWQgYnkgdGhlIGNvbXBpbGVyLA0KPiBwZXJoYXBzIHdpdGggYSBwbHVnaW4s
IGJ1dCB3ZSdyZSBub3QgdGhlcmUgeWV0Lg0KDQpTb3JyeSBvbmUgbW9yZSBxdWVzdGlvbiwgZG8g
eW91IGtub3cgd2hhdCBLY29uZmlnIG9wdGlvbiB0cmlnZ2VycyB0aGlzDQpfX25vcmV0dXJuIG9i
anRvb2wgY2hlY2s/ICBJIGNvdWxkbid0IHJlcHJvZHVjZSBpdCBvbiBteSBvd24gbWFjaGluZSBi
dXQgaGF2ZSB0bw0KZGVwZW5kIG9uIExLUCBmb3Igbm93Lg0K
