Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAC7CB7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjJQBZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:24:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B39B;
        Mon, 16 Oct 2023 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697505898; x=1729041898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3TEXvOQsA3VpAMhnZQUHLVAf5B0YTLXoU78ZGNVMd9w=;
  b=AAKMMy5DD4ig/A2nZeHXlqXLk87t4tW9Xs7i9f73asWcGZHFCgbD6r/t
   wgxZl4eHqyJhhxjEuSvDjHU11cR0j+pJv/voXCshGiUJxQqJ3RIlp/eN9
   bpYpVe6wTizm5cwpKdNt4Vss3XxAHV2ZBsEX9ZLAZxPUjmGErF1FdBAfO
   u19V5VNVXD2q9WUaDph+K/5pAayzybvGoXL3fDi0IG/HBNLQtGA1wFwj+
   x5gNFAlv26Llyen/dSVbjzUGujynZYLFWPPAwkuOtxHiQ4m99xqz5RTdo
   V/SiYqOrHJFHx/Jl3J3FXoJ+fCx1ZOhRiAFBk/9yqOkI0BPxEhRmYPld8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365937658"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="365937658"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="791032658"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="791032658"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 18:24:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 18:24:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 18:24:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 18:24:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 18:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO7EafciJnAYTXkgJJkEsxJswBhd4ZD9f+1W/6yDd3bE4Wbxwq2JDAdICTyS0EsRECxzaHvsUW8KDnF7wnTIyjeqZoYKUBLu74YRorUAb2ruUQhTupjK1PAy1CWbcNSkMvBiatCX6PuYOeFXdhoNoCvewhixF1wRfBLsKbArIXa4/udSi7KGIjWyJyQSSSttdua/DTqq8T06LqImfql+c15eULjsGSGerGX7N03ehhmmbFjcqGpSvJGBUUSZcpyJuwKunzb50Py6Xd17hr/cn02beNQkou6xMnDLIxMNa8LguHkY4ImcTGHFLeeDOb0ZdZ7Z8U3j0qS8RdIFiOvXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TEXvOQsA3VpAMhnZQUHLVAf5B0YTLXoU78ZGNVMd9w=;
 b=aRQnnkunTq14PMLHIbh0/7+YnAv8JTRi1IRZdLyiCfubPWxg5NujWKW7a+39BDqNSdZxoVgbhwLJ3vTKfLFgOHKOTbe5M7UWq/DT1tR7vPk19IX7PaFD+mwNe1ctQ/F3GaNF5LgfJ2PTbK0ejGDX7fYSueR51hm0l5/EEJcRCXM2/INurpZB7viuMbGh9RZZo5QGTZ1iOlytXGVT/wjISxPdl6PavQq8LaW+o96OB8pkZtvOWyf4UWdRUpFqegNyQZRbt0mhK4MK3LLJ83Y0asSSLlU4V/tdj7G2sB2tWOC8oayD4aVybFaBuBbUU7Ixbisda8pkv8yXGdBWvqDPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 01:24:54 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 01:24:53 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
Subject: RE: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Topic: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Thread-Index: AQHZ/lso9WGwaznFOkSBbySsExRE6LBIvACggABKdwCAAx5hgIABCoQAgAAEGNA=
Date:   Tue, 17 Oct 2023 01:24:53 +0000
Message-ID: <SJ1PR11MB60834039F485FEBC8031398AFCD6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
 <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
 <759ccb97-cf5a-4787-b699-27551d5d2865@intel.com>
In-Reply-To: <759ccb97-cf5a-4787-b699-27551d5d2865@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV2PR11MB5974:EE_
x-ms-office365-filtering-correlation-id: b2709a6c-85a9-4e61-c8ea-08dbceafdd8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4KWsJ3r5Vk12D/d2jBoaRAvCAVtc/TUaLa9L3SEAwoSZ0OPuku8hLqyXCueT/rIeDEiDs99NSsPH6Dm195g1Zj7UT8dNobdsETFyJRoy5WCmfunTkH6IA4+v0EuP/rTWKIejkYY36D8BY8qiPe/Y8+I5L9v8Pkwjz2m/t5+EeUZfavXnC17FmSpwdap0XO63wASCsWbSYsEQdNGi+aucv+ipLGOugqkRc0eVArakpU8jgpvrx3QPZ0Nj27QR+6GVGRb25NK56BRyNm/bymDwphJc6hO6Xw/lv/jGX/LL051xT1fp3Vf3phoSfCV20Cd7eacdARVLhdYqo3PXLUMeRf81kFt9Iu8CCHI+SXu02xIZrntCFa97RH0NC/aodpvPbxPld+Y0/ZGJqe6R+64oZijpUgIOKRofKQQU5RjCSUq9toex6TeT+791bPQ0o/f2sds9xcW7GX3uS/BPVvMDpBcwfMoTYzvDh7/2yPyWVsiMcZWlS3FfXp3zvbSiPy5bUU1fHr0qe9NUWfSkRF8GTN1Pz5Ru5hg+5gghpidqEVSEIF17f6CM6qqiLRM07w708BzMm/sn1Ur9WoZUbG5ojfEB/1cxd0TvJucBWAaRwSxJuN0fTS/KWgSMDFf47F/R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(76116006)(66446008)(66476007)(54906003)(316002)(110136005)(66556008)(66946007)(71200400001)(26005)(7696005)(64756008)(6506007)(2906002)(9686003)(5660300002)(8936002)(8676002)(4326008)(52536014)(4744005)(41300700001)(33656002)(86362001)(82960400001)(38070700005)(122000001)(38100700002)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVdqaTBDWFZSSlhnekl2NGNNemlEVkhNRmVaRnBteExRd1dyVkJyaUJONjNI?=
 =?utf-8?B?ZTBlL3ArSldrZDBVbEViSkFmRFJrc24yQmxKNm9xeG5La2JDUEF5d1RUcXpX?=
 =?utf-8?B?aW8wR3N3eS9rQ241UjBFSW1ETVYyWUkwQnBQbFAxS1QvZm16dG10L085ZjBj?=
 =?utf-8?B?bG40Mk1ISENQWk15ek85NlI3Y3h2b0xjZ2NOcU9qQU14dW52eGNlT3grMzhK?=
 =?utf-8?B?MzFtL1phdFZLWC9sWmlwby96a3hEUjluV21VUnR2ZE81eHJaSWlGMUdFNmd5?=
 =?utf-8?B?QlBFclAwblVTN1F6VWlkWS9lK1ZEMVJiZnQ3a2l0d1AveExMbEdrUGQ3ZnlO?=
 =?utf-8?B?NTRMaGt3QlNRUWhCVVAwOEZnbHBvaGM3QzNpMW9UZTVGd28vR3BqL0pNNHZx?=
 =?utf-8?B?bTNVS0FUYkltaGpOMGR5VUtWeHprOHZ3L3Fac2lQZm5sSWRhbzVVWmJTNU84?=
 =?utf-8?B?QWJWSjhsTDA4VUQ3bTl4Tk5yQWUyeCtvaHB2Q2RmVWh0bmVGRWFTRHdjTjJ6?=
 =?utf-8?B?UkJZb0czb2JWU1RVT1pPK1hjQkx5S00zeDVPTFFucGFZOTdEaGxDa0FFREFM?=
 =?utf-8?B?eUFjdVkwbjhwb1dmM1lGQUNUcXc4aFNCL25tU0tvNFlvQjU1dmx0RjQrM0lv?=
 =?utf-8?B?OVdkaUszUEZSVFFWSmZxTm5NQW0wVFFybmN3YkEra3hXeC95UWY1UTdFZC83?=
 =?utf-8?B?Uk1OZnQ2R2pybFdlWnhqR0U3d05sUHV5VTVtektOWGJOeElMWFlwNkM4dUUx?=
 =?utf-8?B?UUNZMmZUcjdiWGFtNHRsYzc1SEtiaHB6ekhwWCtiOC80N0U4bUFqWWRyeXRx?=
 =?utf-8?B?SWFSOFVrcVNHeVN0YTNFbmJMbGFGc2d3SlJET0l4WHROYzZuc2M3cFhtbTRD?=
 =?utf-8?B?ckwvSnNRdGNiVW9RWWIwZkh2aGVqUy9kVHNuM0s4U2o1NkpmYW5rQ2ZqTDJR?=
 =?utf-8?B?MlFXTnZKY0oyUDlKTmdXeFVVaFVjY0s4cDlWaUVVbG0zNmZWemYxaC9rWHkz?=
 =?utf-8?B?VkZvcDdoZkw3MXlzYURWUlZsclFITldwWENnblFHMXZTd292Mk9ja3M5MGtJ?=
 =?utf-8?B?azVhOU9JWlFqZ09FK0VvaFFzWkhMaUJpa1VrSERGQnlCazB4Tm14NDNqV0lx?=
 =?utf-8?B?VFVRN0tHRGZIU2xsTHFSb2lCVVgyN0RRbENHeTIyUHR4ZVhrOFFxN0JFTjla?=
 =?utf-8?B?MlpsdWtjdDZKZmlkSXRZQkszVmluTHFYdzZ0anVoc1Vud2xQZWZrcTIxSDhB?=
 =?utf-8?B?THlRUGZ2RHQ5M3ppamhweVpHamk5c0NMQm9DT0FGKzQvOVhzUTBOS3BNTTNa?=
 =?utf-8?B?anordXFEWEdIbXlqNlZmcXdGTk42Q2ROSXIxN3JXRDY2cFhkc3RQd2xzQ3Rt?=
 =?utf-8?B?VHdYRUNoc09yd2R4MXFXVWprY05XZ2daY2RlQ2xCSE51VTZVeXM4eFB2NURX?=
 =?utf-8?B?VkVQWUZEUGd0OTJ6bURKMUtEMEdYekhuUm1NVW5kTnBZMXd1Zm5SY0dNRDVK?=
 =?utf-8?B?QUlFNjFqSVg0RW0xUnVwdTBKQXJ1b3ppSEZMVmZ3cGRVaFRLRDJkMlVFSHdE?=
 =?utf-8?B?YXdzVStZOGN5UzRoSXdmVnBkb0xUd1NHenBCTUZGRTZxQ2J0ZHpMWXJOUWls?=
 =?utf-8?B?M3FzYmh1aFQ1Wjd6ZGpHekIyS2FOOE4zSVV6Qmx0WGxCVWtVT0YxZjZnaFQr?=
 =?utf-8?B?Q3g4WW1CeUVldXBmMS9MbW5HTmdRalVHWmFCdzdGUENaRWxxR29Da3lvclov?=
 =?utf-8?B?YjdPZDFGOXIxZHU0ZzlZbFBuMFFxUkdDZ3V5L3FESGs2UGxrWmJTRnF5OWEv?=
 =?utf-8?B?VllEUC9GdklzME9uSDZ1WXpPYTlDeWlOcm9UVlpKUjN6TmZsY1R3a0VsZllH?=
 =?utf-8?B?N2M1TG96dlRvOVZjakNqcVNZaDVmS3dnRG1GRjIxNFlEUFdJcEY5bkk4d1hQ?=
 =?utf-8?B?RkJWWTRFM0NFZTY1bVpwMkY1eXBoMzlXTTdDRStxSFduZGZORm9mRGozd3FB?=
 =?utf-8?B?QXN2Y3J1VlhXdlVUZTBWRW1CNndCdWk5VzV4dURvSFVTQ2R1QzRCMU0ybVRk?=
 =?utf-8?B?cVI5b0RWYkRFMEFjU0QyaGhHd0NpeVlDazNZdmVBckduVXdTSFMxbWVxNG1r?=
 =?utf-8?Q?CyoqzDZy2M1IQHhRG02izuR3v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2709a6c-85a9-4e61-c8ea-08dbceafdd8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 01:24:53.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iISUH6NW+s+HiO7EI9Bk1xghIq1//8FCxuIOWCYqDxZYAXUuuyzEncA3YWt6DaB5KjqN6ilTxUoyOAcHKwjF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi4gIExvb2tzIEkgZGlkbid0IGV4cHJlc3MgbXlz
ZWxmIHdlbGwgb24gdGhpcw0KPiBwb2ludCBhbmQgY2F1c2VkIGFtYmlndWl0eS4gIE1heWJlIHJl
bW92aW5nIHRoZSBhdHRyaWJ1dGl2ZSBjbGF1c2Ugd291bGQNCj4gbWFrZSBpdCBicmllZiBhbmQg
Y2xlYXI/IFN1Y2ggYXMsDQo+DQo+CUZvciBzb21lIE1DRSBmYXRhbCBlcnJvciBjYXNlcywgdGhl
IGtlcm5lbCBtaWdodCBjYWxsDQo+CW1jZV9wYW5pYygpIHRvIHRlcm1pbmF0ZSB0aGUgcHJvZHVj
dGlvbiBrZXJuZWwgZGlyZWN0bHksIHRoZXJlDQo+CWlzIG5vIG9wcG9ydHVuaXR5IHRvIHF1ZXVl
IGEgdGFzayBmb3IgY2FsbGluZyBtZW1vcnlfZmFpbHVyZSgpLg0KDQpIb3cgYWJvdXQ6DQoNCldo
ZW4gdGhlcmUgaXMgYSBmYXRhbCBtYWNoaW5lIGNoZWNrIExpbnV4IGNhbGxzIG1jZV9wYW5pYygp
DQp3aXRob3V0IGNoZWNraW5nIHRvIHNlZSBpZiBiYWQgZGF0YSBhdCBzb21lIG1lbW9yeSBhZGRy
ZXNzDQp3YXMgcmVwb3J0ZWQgaW4gdGhlIG1hY2hpbmUgY2hlY2sgYmFua3MuDQoNCklmIGtleGVj
IGlzIGVuYWJsZWQsIGNoZWNrIGZvciBtZW1vcnkgZXJyb3JzIGFuZCBtYXJrIHRoZQ0KcGFnZSBh
cyBwb2lzb25lZCBzbyB0aGF0IHRoZSBrZXhlYydkIGtlcm5lbCBjYW4gYXZvaWQgYWNjZXNzaW5n
DQp0aGUgcGFnZS4NCg0KLVRvbnkNCg==
