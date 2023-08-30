Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D078E23E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjH3WVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343713AbjH3WVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:21:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC898F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693434041; x=1724970041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uVu/i52k1eCJzITJJp0KuiP0q/QUjzUze24gz/op6iI=;
  b=KgluW3JBVVp8JevYWF2+MNs6mZ2VEmsmAarP7LWxEyGzVrmISWLcI4Jx
   9xB3EJkNvJekmAqfrvKs0vKAMu/9Xct1k/GHLUfAv8cNZUjDtxsdISWH3
   m+PuOJGciQEnLTVu3VnhcUHfyfYWzuGX4CMbs/jzqerQN8SWJuD2jw+EF
   XSdx8linY26TVLEf2bzs/FKVwSbLR4+kREEl2ET4+h9skOcbzks03rcxC
   CKshtYtau0uF6yBP42FQJAYerPkbyr8oZc/Yw5BYOYvMW6n11UB9gFzya
   gkJwHP8yrg0lCjMIffPthRny0LXEhyVsyFAmXxaX+oY7CdjW3nO87J4Y2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374673644"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374673644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774256139"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774256139"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:20:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 15:20:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 15:20:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 15:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUoq/N1kwZ/YuOTO/a3IYJvj2cH/RR9FoypOtA9jAaFp8DjmKu3PCKrYInoydgCB6KzR4+ZIxlPLktw38X7dAfQJu+TT0IQtnUklmltcS9xTz0e/ta1kGfIedTapu8mwCveG1G6OTxVYqDysaZSkdPUjY5+PQZ1aefDI41vBQyS9LpJtxDlZ1LdLmVybD3xOMyUATLXFhvGa0BDfmfjAmOuIouE5y0Tb9BzqIPSq0SuLtBREbnyyAYnZGukGsxKB6ZkUlrW3vD8Aa1/j1l9EkJFsKUTXsjl8wZ7TfT8XkR0NhI1YgCQ/cJ5ql3ei2Pir2e7giN0bWHy9zlN6oFPTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVu/i52k1eCJzITJJp0KuiP0q/QUjzUze24gz/op6iI=;
 b=Xmv7JgG9/0ez8CRxCBAldvjMTvq2hKE5JnEnD2JvkEpLZdBktErIIthaBJJQop7sznXjgT9ti9wY8Lj99Ti/eOXBmPWB5YSFj2+iDCEB5j1ZYbvHYfTDNVnTpJMxdRh+onh2ePRYcqeNcWrbivuWQeFif2HdnlVGeZXxMDG/Jch+DOJ/RWtE5FlbQZ6X9iRCx/dCf/2J+M8h9nkixvmbyqPQffswDdeyfYM8kkfjiAJo6idpsNreh48oOXZ8Ga58ZDTLiA12LHLEQ9vI9rAEzTkqyUg0QOZvtBbLBYjQs1/7CW3lfINWN7JUdR9SymUQ5bRAvByCoX2Qi8TeSd3orQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 22:20:01 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 22:20:01 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Topic: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Thread-Index: AQHZz2d7UQsEDFsUOEaymlW0GXBdza/7uv0AgAAUuQCABxgsAIAAmYiA
Date:   Wed, 30 Aug 2023 22:20:01 +0000
Message-ID: <f35d73eb9fa9496267eee589ccaf97e42970e081.camel@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
         <0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang@intel.com>
         <20230825233558.xzqukr3vbccii7f4@box>
         <1a40b4dc8d155618723671685e7ad53e3fce0aa4.camel@intel.com>
         <20230830131028.lbtwtefap7khvt44@box.shutemov.name>
In-Reply-To: <20230830131028.lbtwtefap7khvt44@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL3PR11MB6388:EE_
x-ms-office365-filtering-correlation-id: 6bd8286f-fd93-4d3a-0b69-08dba9a740f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9d/AE/GpE+mwXaa/Lpj+azlHtZikoQny/++SGIx77Ae02zKcX/Q2q9jnolcu83nAX4ZbGDmXnI5wDEfrz/znx9BuDBBnH/CXG8tYhNnfEoUB6s97F5w1sSUew2zzGWtUnf1wwAJryVgF+oayc+cVFU8/FlhFbVhZXzMKvAqEujkA3szcgheZwk9eGDyBXl19fvGHhyS2Y60lTnTJWlDRFI3RGx22vvlyI2e593UV/S0AQxXstN8rkdbvXzdvJ//CVkFmMX3sxdEOQ1lGdsOrW8yiNWOSLXDbLsjbfEMJ51yOUsJ1tAahLVTwkcnw7QXJ4iP8jc1EQXFT7a5FZV38MXTgxf2VmTYFgqtAh0lao5kAuOEbyq+HyzioiBxjSbBkQt+UQ07+8wJSAQU9a2p+ZxuYRXlKuWKm0+lZ6br5CboDqS+IL+7KoIz0uelt/KCf5C18ut2/Kldnyt2OwIkMSMOHB5gPfNV1XypNEq/PQyQFf1QqqMS+H1L48wy3LXZoNu20o2c3OOvpORrLPNpbyYBMyN7PRTNvLd3AK8uhlyuxvvbxJhf9EQYGBd+HrAqfSNH1ftzt7aI2+J1AGFqnKQjttfho1zSqspG6p1PqP/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199024)(1800799009)(186009)(6512007)(316002)(38070700005)(38100700002)(41300700001)(82960400001)(5660300002)(4326008)(7416002)(2906002)(6916009)(83380400001)(2616005)(26005)(8676002)(86362001)(36756003)(8936002)(66556008)(6506007)(71200400001)(64756008)(966005)(6486002)(66446008)(66476007)(54906003)(91956017)(76116006)(122000001)(478600001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUtUbUg0bHhuSHNGeDh1amkzK3FmWjJBbUs1blVqR2Y0aVVUU0NVbGtNSm9W?=
 =?utf-8?B?MGJRcHMydHdLVkpaRXY3RDVCUVZGMVRtVGNvOVM0NThvQ0NvaUk2Q0xqbXVi?=
 =?utf-8?B?UTV5YzBGR3dVR2ZaR3kwcnMraWRGRDZuVWlRazhQWXVVZXgxa3l4UUFjaC94?=
 =?utf-8?B?dWFOS2g3Y3Zxa1h4YUg3U0orQXBXMGF3aGYzYVVvTGZwYys5bkU1Nk1UTUls?=
 =?utf-8?B?ZjNORUk4NkxLc2tBZUFMZHlIQWVqeExPVndvQ2NhT2Y1Y2hCNjBxM0FYakNt?=
 =?utf-8?B?bmtpRHBHaEN4eGFXUVVoQnV1WGV1ancyZTFkbzJwZytQTzdGTzhDUU1HMk11?=
 =?utf-8?B?TUlTaWNjU0FZT0V1YUZ4cnIxRk9DTXV3TWVZSjRyMmpUVjdMWlFETWdKblpk?=
 =?utf-8?B?THRUNUZmTHlZeHdsWmNvZlVxajJsZDRXQnNudXBBR1QwVGc2L1J3ZnBwL3Nr?=
 =?utf-8?B?UVlvQXA4VUJCNG5oNEcxYWF1VWg5aEZRcHRtcU5SeG4vMDVMVGZaRU1LcU5Z?=
 =?utf-8?B?YXZVZG9DTlZYSmNVMmFBVGs3K0NFN2NpemhzemtYUThGSXlMNndHcmtYTHFq?=
 =?utf-8?B?NzRsRmFVUHhzWUg1ZS81TkdVYTMxR0JITUVLckJJU3lFU0RKWHZHNFBCSEFz?=
 =?utf-8?B?SnVrZytjSnRXREoyTWRsSlc0NXZiWXAyRjFhZ29sYk52NTVlOVFpZm0yOVF5?=
 =?utf-8?B?RWxDUGlCbEtoeWIwS2R6T0NvT295eXFkSUZUUXI1Z3RVb2FwK1FWOHdQVVpk?=
 =?utf-8?B?ZDRoQjdnVG4rd0RXUVRMWGFPNEdsZktsZk0vT0xEdEZobm9zTmRmSFdjVzFM?=
 =?utf-8?B?R3JzK3lpRWphVUQ1MkpGRTcrai85THprSEN2MXE4OFFxeXBHNnV4a0NSVWlp?=
 =?utf-8?B?ejQxd0hxL3MzK1F3NTVpT0xIK0NaUkxaMFpqbit0bmdBN0VOUlQzdFRzaTBh?=
 =?utf-8?B?bVp2UFRyeTU4TFRZZG8yN0RsajVIc1ZUaktPdjBvWlhGcCtRZjdjYWFoaTlE?=
 =?utf-8?B?Ykx0aTYva2FSQzFmZWh1U2pDcVVoSUQ0ZElYTDBGeVFSS0cvQ2pIMlhzOUU0?=
 =?utf-8?B?L3h3MEN2Y3M0TVFFMmx6WlhGSFgwZVEwa1V3ejRQdjlRUGJXY2hUelozU0Y4?=
 =?utf-8?B?b3FUMHZJZkdENXF2QmtWbmRjc3paSFphMHdRa2lQa2FDOStvalZ3cTl3NkVT?=
 =?utf-8?B?TG90OXh1YjJnQVByY1A4blVBUnZCTEd1ajhRb1M2cUM5bGhhaUVmUkUyOEsw?=
 =?utf-8?B?ZnlZVTJpdUszQkR1aUtBdUlmTTVieElodm4zMVlvRDdOcnpaSVFtaVY4Y1pK?=
 =?utf-8?B?Vmo2RTh3MVRoWmpoU3Rza3NmOEhEZnFzdGVPOFdkVUt1d1BpUFd4QUxYUHpo?=
 =?utf-8?B?SHNKbHY2TjlPcUU3dlFQUmNOODNzSHNlSlpqcUtubTRZOHZtUk5BclRSdkJw?=
 =?utf-8?B?WFZkSE1pVHJNQm9sb2Z0RHBKQTQ1VTlGTFcvNWsyZU52Z3JBVTErNnpDSHp1?=
 =?utf-8?B?NmJvWmFrTjV2K3gxSG9QRlcvZFpUY2hBVnAybXVlVUVaUWpEQUhLTWFpVW5T?=
 =?utf-8?B?aWtTdjlnYWY3L0F6MS9UYW9aN3ZUdlVSZytzZ3VOdSttY21PTEtlR29iTjJR?=
 =?utf-8?B?emFYWTh2K2NDNmRIdkEzc2liVUtaKzVKZ2V4VjZsNkJ3ak9iOFFIWU1ncnE2?=
 =?utf-8?B?b0dTbkZrU092MTI0TWVDMDhMTjluNmtJSExvUGptdFNkR1Y2bzczSmxXSGVz?=
 =?utf-8?B?WFZxckRCNTNxYklWaXR1WmRQQUZkL0hwMDFrbVhLUCtvTExLLzkwWGtWOFlP?=
 =?utf-8?B?YkF6ZVBqcVlBWDQ1Z1BET1hjdW9CZVU3ckgxVWlLblpXYVlvSE8zeG41NGdh?=
 =?utf-8?B?VUU2K2hMc2oxQ3QxalBsWkEyWVFBVVU1dVhPWndBTy9DYkhscnFyWSsvbklj?=
 =?utf-8?B?VmN3UW5LYzBXR21sZFRGWVpnM3RJUWRjOEdvVXl2OG1GeG5ja0hOSG1XQkRG?=
 =?utf-8?B?djRVZmFReGhNd0MvZDNVRHVPd3ByWEJlSTdSam14bHdmRDlaQU96SHM2SHov?=
 =?utf-8?B?a3JLbjRESkNKODljeEU3WFZkS2NBbDlzMkdLVlpFY296NTNrZFk0cHhGdjV1?=
 =?utf-8?Q?8R4zdLOWbwnBmqWM5yJEs1czZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C55C85759881B4CA2C4FB33B54D1361@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd8286f-fd93-4d3a-0b69-08dba9a740f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 22:20:01.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZNUlAPDOCmLINWIrcISd8VvdV8IXTMam04IVRsMFdxdAlCQj8qSPwk6g33/vuUHnNlHteF8Oy2LI+qI+fyT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE2OjEwICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBTYXQsIEF1ZyAyNiwgMjAyMyBhdCAxMjo1MDoxMUFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyMy0wOC0yNiBhdCAwMjozNSAr
MDMwMCwga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4gPiA+IE9uIFR1
ZSwgQXVnIDE1LCAyMDIzIGF0IDExOjAyOjAxUE0gKzEyMDAsIEthaSBIdWFuZyB3cm90ZToNCj4g
PiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIEZhaWx1cmUgb2YgX190ZGNhbGxfaHlwZXJjYWxsKCkg
aW5kaWNhdGVzIGEgZmFpbHVyZSBvZiB0aGUgVERWTUNBTEwNCj4gPiA+ID4gKwkgKiBtZWNoYW5p
c20gaXRzZWxmIGFuZCB0aGF0IHNvbWV0aGluZyBoYXMgZ29uZSBob3JyaWJseSB3cm9uZyB3aXRo
DQo+ID4gPiA+ICsJICogdGhlIFREWCBtb2R1bGUuICBfX3RkeF9oeXBlcmNhbGxfZmFpbGVkKCkg
bmV2ZXIgcmV0dXJucy4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwlpZiAoX190ZGNhbGxfaHlw
ZXJjYWxsKFRER19WUF9WTUNBTEwsICZtYXJncykpDQo+ID4gPiA+ICsJCV9fdGR4X2h5cGVyY2Fs
bF9mYWlsZWQoKTsNCj4gPiA+IA0KPiA+ID4gRG8gd2UgZXZlbiBuZWVkIF9fdGR4X2h5cGVyY2Fs
bF9mYWlsZWQoKSBhbnltb3JlPyBKdXN0IGNhbGwgcGFuaWMoKQ0KPiA+ID4gZGlyZWN0bHksIG5v
Pw0KPiA+ID4gDQo+ID4gDQo+ID4gX190ZHhfaHlwZXJjYWxsKCkgaXMgY3VycmVudGx5IGFubm90
YXRlZCB3aXRoICdub2luc3RyJyAod2hpY2ggaXMgYWxzbyB0aGUNCj4gPiBiZWhhdmlvdXIgb2Yg
dGhlIG9sZCBjb2RlKS4gIFdlIG5lZWQgaXQgb3RoZXJ3aXNlIHdlIHdpbGwgZ2V0IGJ1aWxkIHdh
cm5pbmcgbGlrZQ0KPiA+IGJlbG93Og0KPiA+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvYTIzY2U4ZmQyODkxNDFjZWEzYTFiNGYzZGFjZTIyMWRjYTg0NzIzOC5jYW1lbEBpbnRl
bC5jb20vVC8jbTIwNWIyOWNlM2UzMzk4M2VjNmJlNzMzYzJhZmZmYmZkNWNiNjUzZmYNCj4gDQo+
IE9rYXksIGZhaXIgZW5vdWdoLiBXZSBjYW4gcmV0dXJuIGJhY2sgdG8gaXQgbGF0ZXIuDQo+IA0K
PiBSZXZpZXdlZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tPg0KPiANCg0KWWVhaC4gIFRoYW5rcy4NCg==
