Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5544E75BB73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGUASg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGUASe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:18:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979C2106
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689898713; x=1721434713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uJrN46K4b/3C6g6hMaQbsPQ+fs6Q+a0y6UH3e+BjWkg=;
  b=RCMW06p+r1HXFO7xNRGONqE+Jqp2fQOcMnR7UC2QdwhWhOpSX26+pJNi
   njLcnRG9MsgTETs2fo7NHgDSwdvhchw5pAi1AmoFRSR34fYTb2UJJ0FU9
   rT620H+OBqJZi+y/zvOmwGnJ4wnbpoN/PvUFEm4f0oOiivlPZTa8uEwal
   0d4Re9OlBSRdZR75G3m4FSmd3sp11MjiAv87dvf7e5/P3dHmc5HorH8RT
   TqGERwAw7XqGrwdNb3i7zbnoBJMZyYw02m7sLgVlORSaaBS81yNnHw+5p
   4IbZIvgsS5YJ7igfHsQa8mgozeU+2o/xUF3GilFo1Le21Tu9FPGN4xXCQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370498439"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370498439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 17:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814749205"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="814749205"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2023 17:18:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:18:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 17:18:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 17:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7Iu0hFLK1vWnba9uIK7aNM7rz665lbmRktGQ4rFO0AmkKK+EFwGnuaQeyRzkYqYeZQ4DIv/5CZpB1n7hdACZVU6ptXvvh6lua1PkTHSZppVBwzCj05KlxoKjhkDpUnIMbC9IQ4AJH6ZQy+S0q/MO4P6OOambfW5PWXQDuiwsxgbSDun8b7hzkJ++/mQ6uraYrI0htPEix+8nxLYWAGl5zxr8GDtTgF3pmMkI9WbE3hxGJxJgiCsGfsAqxNNVrUiR46mnDIqekCE+zg0qj9XRnRYxMYBDi57Zp9QxjVOJERe1PlIyP74N4k3iEoTF9uvXHP1Pm7puUfjnnxggkEGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJrN46K4b/3C6g6hMaQbsPQ+fs6Q+a0y6UH3e+BjWkg=;
 b=L8pY8odlW20717CD4pz83a5r0M4VkTJhwji/oa3m6uAbVvM0c6jJe63M+W/NUvWO2FrJfuRKpgJHyQKaKVEjUnMIypR5mhrp42Ub03DMG1eMzBxVVk4CvzheyfWf7+/Bt0i7Xs4+Zt14QN+PQuFrQJ5ARZxX8i3vBFVAPBqkmi7chNHcrw3U4eqOnij7DNb8iEC6K2Res94rIo0Y9J65ar+n71R1tRA4b1tOcWLPHgZcDt4IR/sgs7c0WHlyvd2LsBfclQxhuGOl1jUqA6acIk9fAv7tQV9dfpJlj67m3K/ldIrINJRHQRUefxU2KpgFmbbk5UFt3xT95luhTY7hwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 00:18:24 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 00:18:24 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Topic: [PATCH v2 00/11] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Thread-Index: AQHZuwSXJzY29NdU9UyvS7MM7BQC1a/CoqcAgAC5BYA=
Date:   Fri, 21 Jul 2023 00:18:23 +0000
Message-ID: <a23ce8fd289141cea3a1b4f3dace221dca847238.camel@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
         <20230720131608.GE3569127@hirez.programming.kicks-ass.net>
In-Reply-To: <20230720131608.GE3569127@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6613:EE_
x-ms-office365-filtering-correlation-id: 89227dc2-e690-45e3-ac95-08db897fff42
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuWA5NeWxXJAmYTJ4giLtMS2vFCIy8WT0ZnDpmFEQzpkqneF1ZIzr89j5hJZ4BhS5y5sGKoWqJkisT+m3/CFcBYWVdbp2TlMTa1pkxtM+JcY4V2ZSCd3Xn+/ssztYcxpbHgoUliISAb9HtkZ4KP/o1Qq6UTxzjt1TALCn2NVwluR/pLSjFexb7WLmMYFNetdoBnoMpUaU7nAO7tshTsuA9h8EenSx2kRfBZ2B+w+j68fVVkhuIuzGmgveZJN4IFTIUIBtMXWsLCkbi3H2eRfxskmw3AtB39sdZjWsFwFdf4hkYjhE/rhMgWyh+aqajSiKX+66gz4AICPKnLlB0C93WYqlBPwQn03avN7ZpJwCwfmtZ7eiPXRaDW3H2SNVr+SNym1O19CS13DwndRPnXElzaLoiWiKM7S9ZIsSSdIQybVDGrY3OV/VFxYrOtg6EYXq/TwXXCI8qI96QfbBUaUFNGTWwOmWJBbeqq9jBh7WTBsrKcBdV95kdb1jXRrxK4CROBK43l9+ixov537JjHJxZ9Y0nwiLZ+q9bHCo8MtP4j4f8IcE09094mQvdxf0nhIovsvkGHLa6Rq9m1kJkoZEFaK9B30DwelnThjSDqFN9NbsQF3iKLQHNoY/6g7jvKt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(8676002)(86362001)(36756003)(71200400001)(91956017)(54906003)(478600001)(66946007)(76116006)(66476007)(4326008)(6916009)(66446008)(64756008)(26005)(6486002)(66556008)(6506007)(6512007)(2906002)(5660300002)(41300700001)(7416002)(316002)(38100700002)(38070700005)(122000001)(82960400001)(83380400001)(186003)(2616005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnRlUzA1cVZVWEFOeTFVTUFkZDQ4c05CUzBsbkJ4WFZXSmV3RHdTdTMydnRs?=
 =?utf-8?B?elluOEhBRUQvME11YUExd1l2Sm82K05rQ3oxT1dDZFU3dmlaeklBSWRHYTRY?=
 =?utf-8?B?N0dZS2tqM2JkNEs0elg2VHRHTlhvOEY0dHhqNVZXY25jQTNrK0FVeXFUVFoy?=
 =?utf-8?B?L1podUt5QmdkZVpRU0d5WGFFTmNXbVhZaEtQQThqOVN2YTBHS0lpcS9kc3hF?=
 =?utf-8?B?K09nWHJ3aFA5THpYODZVSmozZmxvV1pJTlNuUkpaeVE5YWxsc09vSWdFdmhY?=
 =?utf-8?B?c25XcWV5WEFDcWNjemRNQVV6TGNaQWtTU3ZMVW9jTEF2dlZ4a2JIeGg0cVJC?=
 =?utf-8?B?UmFiSXI1OEpnRVBLZDVUc2NKeTdWK2ZFL1FrekJpMUdZT2k1UE05Ulhyem1j?=
 =?utf-8?B?NC8zcis1bUMxZHFKZU5NaXJaaGNDRXdJZ29SVFlya0JLU2tBNFFLVEFSdzlu?=
 =?utf-8?B?UVUyQW9EQ0hpVVc2d25jRG5mcTZpaGtmM0ExNnNWY2F0MXh3Yk93bGFJWDVh?=
 =?utf-8?B?b1g0eDVvWURUUWUvU0dXZTFJMHBEc2M5Q0gvRHZqeDR4a0hMOERQRmhuWEJ5?=
 =?utf-8?B?NCtpNmZ2Rk1VTXJZVDBtL21XVDBWUjJVL3F5c0tTeTlxK0Z5N0dIeHpWZEJO?=
 =?utf-8?B?dUpNaVFpSWtlYUdLcWtZT0RvcUNRUlRKRmxTQ0JBQ1E0cW90eDJWbzJCcE8y?=
 =?utf-8?B?L1F3QTJlbC9PcWxOU1QzejBnSEs5WEpNOEpyekcvQkJtWW1mV1FRdGpJbVkw?=
 =?utf-8?B?Nll2bXFVNnd2MEVEamNtYUdwaml2S2ViSXllenFmaFNiWVNCREVRRlY3UU4z?=
 =?utf-8?B?Q3pCaE5UTWRtT1owR3ducG5uWXFucDBQS3oveXpCd3cxcGx3bk9la1pKaStK?=
 =?utf-8?B?dXBKd1dkV2c0MXRua0ZqOUFia3o0WWs2am1RT1lkS2Z4d2F2T2dMVVdSa3JD?=
 =?utf-8?B?ZTM4NmQ1OWdoRnFtV1VCVDlpempLbmRjaVN2UmZGY3UrdkFaSi9lbm5ORzNB?=
 =?utf-8?B?MmdUTHc3aVFZTU40SlNzY1MzbkovaU8wWjlzR0Q5V25sWXVFYTYvQ3M5NEMx?=
 =?utf-8?B?SER5OExIWmFQekZzVHV6Q05DMGpWb0VBUXExcldHSTJyOUhYMnQ0N0RhTnNT?=
 =?utf-8?B?YmJXODRoQWtQa3NlZGp1WVRpTHJHd1YxV3ZuTXk0RnkyY29ldUtnNlVkM2tJ?=
 =?utf-8?B?SUdZSEx0MWM3ZGVvbU52Y0NHOXNRVmxmeGJCZVoxTVBnK2hlZnR2YWNVc09j?=
 =?utf-8?B?aUpUQTFHY2twREVCSE5xQ2M1aWxtdG5ZbWVjakZnOUZvdTRZRWEwRU9UWnZN?=
 =?utf-8?B?TWJ6dDk2VlBoMm03bUZoVjBuQncvMWQzamZ3dU1YMjFHQjM4STl1ME9ISjlF?=
 =?utf-8?B?cWJvbmFBdEw4T1hKWFJzTC9uOC9FRWg3VWc2YWRKdWExQWdXQ1dYNTVPUUdi?=
 =?utf-8?B?cjhoWUN6WWNTTGJWclB4bUNlZ3NIemFXL01vWHZKQ052VXNCOW81MW5qVlBo?=
 =?utf-8?B?T3JpMEcrcEsxUTVFU2F4OHl2K0N3NmZRc1lWU2x6cGY4OHNnOEx2Nms4a1VQ?=
 =?utf-8?B?MzBNd203TFdPWk5pc1FtWHNoa1FvZUlBM1A1dmZHeEp0Z0VURG4zS2trUnlq?=
 =?utf-8?B?VTJQc1NoVG9DSzhEdjM0NDkrNHpYaWZNOWsyU0N2Z0MvUEF6WktxNG5oajFp?=
 =?utf-8?B?L0thSmJJdlhqQWI1ekRBYS9ZSkYrY0VxSWFJTk1FWUFxMytKaTBKR3RQL1Rw?=
 =?utf-8?B?TjVTdGFSVUt4V1VPRjY1Z001M3BkWUZsSHZQeVdXdmMyTDVtMDlzVDJTdEsx?=
 =?utf-8?B?TWtpU1JsWlM0cFU1VE9RM1FQUndqdFhPR1Q2NlJZSFF4b0hJRTBSRnZqRlFI?=
 =?utf-8?B?SHdJUWF6cHpxaXNESkdpa2NXMFFmT1daZ2xZQkVBT2dqRXJ4aUVxc0QzMDRF?=
 =?utf-8?B?aHVEM3hRK1F5bFFWSFZnUnRoRExHNytXMFI2b1FoY3NZRFV3MUNsSE90Qkkr?=
 =?utf-8?B?M3pObWFrQThmeGdJamJxOWdYTDdIeTNMcVV1c0tNK1l3TlFVNU80UUFkMnp4?=
 =?utf-8?B?UDdJU0lNQThWTUZYbjJZMXc1WkJRQWs1Qng5N3BWY0NlOHZnS2ZmR3QraTYy?=
 =?utf-8?Q?f36aN6OuUIHMO0HZAfGLQuKZ3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F1D38AFA2DB1B4989734A0230F7274E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89227dc2-e690-45e3-ac95-08db897fff42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 00:18:23.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsfvOpiqy+iEtihEaEQpzUGr/DEG571sNQKoU75ilTHE63SpKuEu56kSAOVwbmTAVj0UuE7acQjplmQVLMUS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTIwIGF0IDE1OjE2ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMTI6Mjg6MDNBTSArMTIwMCwgS2FpIEh1YW5nIHdy
b3RlOg0KPiANCj4gPiBLYWkgSHVhbmcgKDExKToNCj4gPiAgIHg4Ni90ZHg6IFplcm8gb3V0IHRo
ZSBtaXNzaW5nIFJTSSBpbiBURFhfSFlQRVJDQUxMIG1hY3JvDQo+ID4gICB4ODYvdGR4OiBTa2lw
IHNhdmluZyBvdXRwdXQgcmVncyB3aGVuIFNFQU1DQUxMIGZhaWxzIHdpdGgNCj4gPiAgICAgVk1G
YWlsSW52YWxpZA0KPiA+ICAgeDg2L3RkeDogTWFrZSBtYWNyb3Mgb2YgVERDQUxMcyBjb25zaXN0
ZW50IHdpdGggdGhlIHNwZWMNCj4gPiAgIHg4Ni90ZHg6IFJlbmFtZSBfX3RkeF9tb2R1bGVfY2Fs
bCgpIHRvIF9fdGRjYWxsKCkNCj4gPiAgIHg4Ni90ZHg6IFBhc3MgVERDQUxML1NFQU1DQUxMIGlu
cHV0L291dHB1dCByZWdpc3RlcnMgdmlhIGEgc3RydWN0dXJlDQo+ID4gICB4ODYvdGR4OiBFeHRl
bmQgVERYX01PRFVMRV9DQUxMIHRvIHN1cHBvcnQgbW9yZSBURENBTEwvU0VBTUNBTEwgbGVhZnMN
Cj4gPiAgIHg4Ni90ZHg6IE1ha2UgVERYX0hZUEVSQ0FMTCBhc20gc2ltaWxhciB0byBURFhfTU9E
VUxFX0NBTEwNCj4gPiAgIHg4Ni90ZHg6IFJlaW1wbGVtZW50IF9fdGR4X2h5cGVyY2FsbCgpIHVz
aW5nIFREWF9NT0RVTEVfQ0FMTCBhc20NCj4gPiAgIHg4Ni90ZHg6IFJlbW92ZSAnc3RydWN0IHRk
eF9oeXBlcmNhbGxfYXJncycNCj4gPiAgIHg4Ni92aXJ0L3RkeDogV2lyZSB1cCBiYXNpYyBTRUFN
Q0FMTCBmdW5jdGlvbnMNCj4gPiAgIHg4Ni92aXJ0L3RkeDogQWxsb3cgU0VBTUNBTEwgdG8gaGFu
ZGxlICNVRCBhbmQgI0dQDQo+IA0KPiBUaGVzZSBsb29rIG9rIHRvIG1lLCB0aGFua3MhDQoNClRo
YW5rcyENCg0KPiANCj4gVGhpcyBkb2VzIG5vdCB5ZXQgcmUtb3JkZXIgdGhlIGFyZ3Mgc3RydWN0
dXJlIHRvIGNvbmZvcm0gdG8gdGhlIGhhcmR3YXJlDQo+IGluZGV4IG9yZGVyIGFzIHBlciBrdm0n
cyByZXF1aXJlbWVudCwgcmlnaHQ/IFRoYXQgd2lsbCBiZSBwYXJ0IG9mIHRoZQ0KPiBLVk0gc2Vy
aWVzPw0KDQpVbmZvcnR1bmF0ZWx5IEkgZG9uJ3QgdGhpbmsgaXQncyBmZWFzaWJsZS4gIFNlYW4g
cG9pbnRlZCBvdXQgdGhhdA0Ka3ZtX3ZjcHVfYXJjaDo6cmVnc1tdIGRvIGZvbGxvdyB0aGUgInJl
Z2lzdGVyIGluZGV4IiBoYXJkd2FyZSBsYXlvdXQgaW4geDg2IChmb3INCndoaWNoIEkgbWlzc2Vk
IHNvcnJ5KSwgc28gd2UgY2Fubm90IHJlLW9yZGVyIEtWTSBwYXJ0LiDCoA0KDQpBbmQgdW5mb3J0
dW5hdGVseSBSQlAgKDUpIGlzIGluIG1pZGRsZSBvZiB0aG9zZSByZWdpc3RlcnM6DQoNCgkwID0g
UkFYDQoJMSA9IFJDWA0KCTIgPSBSRFgNCgkzID0gUkJYDQoJNCA9IFJTUA0KCTUgPSBSQlANCgk2
ID0gUlNJDQoJNyA9IFJESQ0KCTjigJMxNSByZXByZXNlbnQgUjjigJNSMTUsIHJlc3BlY3RpdmVs
eS4uLg0KDQpUaHVzIHVubGVzcyB3ZSBhZGQgUkJQIHRvICdzdHJ1Y3QgdGR4X21vZHVsZV9hcmdz
JywgaXQncyBpbXBvc3NpYmxlIHRvIHJlLW9yZGVyDQp0aGUgc3RydWN0dXJlIHRvIG1hdGNoIEtW
TSdzIGxheW91dC4NCg==
