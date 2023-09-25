Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FF27AE210
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjIYXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjIYXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:07:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED3101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695683221; x=1727219221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5dd3jlorPE0f2nDKyNI53/o5oCG02r3/1Jp0DefeRMo=;
  b=c34Spzg53is20+Y9ONb8GORF+vETe/ET8sq5WGUqbDAjwIyCpokKJE6H
   IdfciJI/hqau/iWzy9ju+rKtW06zzFOoT/bLdNPwqgd23v6UtnEq37rVX
   E+MDzbQX6Kj1JIX74Aw50VE43192NC38WC2Mhg2CVO1GFcOaI1F8CEkdV
   5nLH5VB3iWKKnrNCn2QUzpQDK/E0BwQIn7Q1N7Vi5uFW/gKIxvRXl4naq
   ajKUtH3RHZQ00SomD7+sFpRtsOvMUBTBEOBgeOlgpreqEtSC8ljesizNA
   6xNW8IzfatvyhvIrqOywP1NL56caUtv2DrulQN1k8XooUnNBf+1MoDZnw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412349901"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412349901"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079460837"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="1079460837"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:06:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:06:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:06:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:06:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9I6nWulfRmf0WgY2GPVYoGlkjdKOHerBLL73j09//vII8DFf5sSH2FVxrUSmR/joX1T2iDZTFnaLwlv5xM0w8yppo6dF5oOJSIKrnPhDymM8G1ChDzVc5XkoNbRB5yG7UIBkiXJd4Nmfyp6jNJtIO3JKsxxrmF4rh3Q/FFqAPo/m0tkjK4LMFo/K+gSPCEzJou4OXA2gbuA2OqWwnE3eRk/xP/+iAefxRlzCwU0R5/Mg2lOaKfKS7YXiI/4Qz6PoZ3kI3Fd9z2D83NzgtqKNNSgaki8J4NLCKTQ/cFZpwrX9I9cI65PWDNaK0z8wYOnOrMTnVtgx19QcLJFu3iQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dd3jlorPE0f2nDKyNI53/o5oCG02r3/1Jp0DefeRMo=;
 b=XXpq6C7RUAbGgD6qeB08/+/CZTO1iswMBgZ7wpGLRkmtba/1+WFM/mx+gsnLe2Mo59yd+qCcL7tzhG9Xwbth4owVCs23HRtICqoSz74VdokdPIaA2n2Umy3Sv56SyI0fzxxS0tth83hCr4LEoTXCvyFnfnGDEAOfJ2X0w700W5d+NBGb7ZKLLw0BSDP2edEsla4cZZ0GaGh8ZoHkcS1fnpM8jj7HSLymRvGJpmtXJ37PFd8MPthDCYD/kckm7H9sRY//s9KmNqonPIlMUvG1Nb/PTn49JKanIrUrGvJ5qUKjna+O/y+mA3YMfxU5SqsYrb7WIKsdrsft9Q1nnSj9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5382.namprd11.prod.outlook.com (2603:10b6:208:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 23:06:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:06:55 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/cpu/intel: Fix MTRR verification for TME enabled
 platforms
Thread-Topic: [PATCH] x86/cpu/intel: Fix MTRR verification for TME enabled
 platforms
Thread-Index: AQHZ7aKWilSlnKBI1UuS+9tfcRziwLAoBkIAgAQoaQA=
Date:   Mon, 25 Sep 2023 23:06:55 +0000
Message-ID: <7ed6d9d8d267ec10a74366456415e191afd7f9d2.camel@intel.com>
References: <87v8c1ua39.fsf@jcompost-mobl.amr.corp.intel.com>
         <SA1PR11MB67344EB62BF798C9FA991552A8FEA@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67344EB62BF798C9FA991552A8FEA@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5382:EE_
x-ms-office365-filtering-correlation-id: 57043c5f-08d0-48ee-ab83-08dbbe1c1d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULQvr0vrpb4NL4p4XNktbM6azl+X/dhNl1X7xq9/opUoTVkIU/u1xgVYehcgsXi1YLGsWr+W1UAyuSK8WUEQs99fn9YWXp78/Y/nRhbQ14U/mtqqsOknKwrKl/cTIsjOtJ4JAIulT9RI77i3XW+OR34D/orwtLRXnRO+UpdvtYc0ZfH43myeoJvtDi8J7VBsPq0a95GbkEYAnvS5GWM0q8gwXYKyzx2A0KDHvMqjGmmFLE5mhpY6vFk6J7Vy3BY3PfH/B4jECxif2rHakhUSOxzFwIEjemKAQtnyq5kdsGvtzBA184Zc/LzsVXP0JzNDiZDlA4fF4a3+e4XOrAsjz1t9SqJ62BJowOjr0/49NVImc1fB2JLJcjqPmfMmpCTP5OqONMruyoL8a8OoTo6UC4kSmEyPqy0ttyQppwXMpGsM4f7QsNbM+wSRYuODLuiI2i0t7wQ3yjx+Mn8d5PyuvkDpxjQjQJEmZPzev49G9LsamXFagcEv6TfrKGhRENq6zcCYnpJ7t5pPgFzoAr/EjPF9S8e06NYOcuhTyhW9m3T/0BCq6k7bAx2Usa3wWetQP8w7r+kVIDqiv6cmYZHvAC+MVwy+7YwaQeBBGkjgBdKbiSTRPbgrbSUFeYUjGYg8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(83380400001)(6486002)(6506007)(38100700002)(36756003)(86362001)(82960400001)(122000001)(38070700005)(2906002)(26005)(15650500001)(66476007)(4326008)(5660300002)(8676002)(2616005)(71200400001)(6512007)(478600001)(8936002)(91956017)(76116006)(110136005)(41300700001)(66446008)(66946007)(66556008)(316002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M05nTktrVkRsNXNnMlJCYkhqT0FGYXE5NFNycVNFcllzOWVNQlBRTXZ3MjRE?=
 =?utf-8?B?QitFSmU5a0VkWGU2eWlrRm1DMHNnY3JhR21LWmNSaXhaNVRZTUVrY3FVaXlD?=
 =?utf-8?B?bHRjZ1lNV2pVSkVUbWMya2J1a2pFdGp5Z29tc21Da29EZTBDNWtYVUIvQ0dC?=
 =?utf-8?B?V3hYeWxOblZtVi9hM0xML2RabkVoTWNlcUFrZ1pFSTFCU1dnRDU4ZDdmSDZR?=
 =?utf-8?B?WFRhU3BYWTF4a0UyYzBJd2RDeXI5bldnL0ZMekRLZ2dWVFp2YVhhS253WmRi?=
 =?utf-8?B?NHpMRXJCdHpnTHRROWI0VmExSElJengrQ2g3MzVtNlJLSGJhV1N3dXkrNXh1?=
 =?utf-8?B?SWNrUjV5SkpqYUl6VUQzSXY2QWhUTkI4MHhCZlo3Z2tISDE2OGV6UENOTWxi?=
 =?utf-8?B?b3NTVmI2WWlUQldtTDRCL1N5M2pUVWFlNTcxNC8wcUwwVVMvSlF1NXZiN2hr?=
 =?utf-8?B?WlR5bFRXSVVhYTA3YjROYmFFZlpraitVbUJ5Z0RXcW4zQVlZc2liZkVYb3RQ?=
 =?utf-8?B?cWtxRWY4TXF4elBwbVFHdGtSL3QvK09QVUkzaXNPTXRncUVNWVBPTE9aeEJt?=
 =?utf-8?B?TG9VYm9ZQnQ3TUpnVkdOY3J1UDBLSGpjaEtxZGlkSkl3MlpnbkdGMUhzUmRC?=
 =?utf-8?B?d284Wk9LTmRKVUVyVDdMMU94ZElQVGVVSVpxK25zSUV6TlFZaFBSdTFQeW5M?=
 =?utf-8?B?dm5IVG52RXVyTkFmMlZ1WVRKL0FXYUM3K3ZQNUNXU2ZQaUMvUXZvL0hjOGxp?=
 =?utf-8?B?TU1YSFkvbE9MTFNiN01lWlpYaEs5TDU2YXJpak9TdlNQSUJOclRSVjBBalRn?=
 =?utf-8?B?dEZJYU9FdExUMVM5Qnk0NUxHd0MrUUN1Wmh2NU12QVpRMkRVRnVlSHNZMGRU?=
 =?utf-8?B?YisvNFM2MVl5ZVFNcjBqNTBWWE1aQ2YySWRWODdKcnhiLzNBQXhBVDdVMC9B?=
 =?utf-8?B?Qi83TkNvUWZPQkk2YVdjcStLVjZQMGMzNVdQVlZwclo1N2FaaldvRkROQkZs?=
 =?utf-8?B?b2JJYjc1UC9veWw3VDd4UFNFWmVZSnNpMWVhRUd1U3pPUGFGYVNSc1E1cEZp?=
 =?utf-8?B?S2w0QjNEUW9hU25PcDh5OEpicmY1OGUzbHdlNnNPclp1bDZ3d0wrSnM5NHI5?=
 =?utf-8?B?SzRHWnAvVnFNbU96d3FBV0cxWHVtYlEzVWx4ZUVsUFczTVZGdUcrNE1LeEx1?=
 =?utf-8?B?RDZxOEJlaTcrdkFUNm0rWnpIbkVEdXJKdW43RVdXY1VvaTdBZGhuQ0VFUXBr?=
 =?utf-8?B?ampIQUk5d0JOVUMwbE5yOHN5c1RvUTdBVnVqcEVLeUhjWUpjMzRyWDhLa0xo?=
 =?utf-8?B?NThQdHptK2JBQmtBRzQ4dTlzVWZBb0NvcVBFdXlsQ3NlWDNsNEFsZHk2VWpV?=
 =?utf-8?B?MGRtS1lJcjdPSGlBNlV3c3FkN1J5SHVacDk5b1J3aWlTVXNEOUNKelhUU2hh?=
 =?utf-8?B?YzhRdE5YZDAyYU40eFVrK3NVZEduVm9RUTZ3Q2JTeXZxdFdNL0I4bG02dllt?=
 =?utf-8?B?ekFCNTNGSi9xWFllSUwrUzFQbkNmeXhLYVhTejZtQkdwNDE4akNwUWpsVmxD?=
 =?utf-8?B?cEcyb0FaUWNKVWMyMm5qNzFRWWhiL2Ztcy9pUVVxY0lwdmhnNnZCSFpzdjZD?=
 =?utf-8?B?SEtoTE9VRHpnTmlwbXhibXIwQXIxME1md0lBcXdBQ1RHcHU5Z1VhMG1uUjVX?=
 =?utf-8?B?bHJIcUxyR0MvUWpabElQSVU2ME1VRWVpMldZeUNqRFpUbjR2SCtLRTFobFBt?=
 =?utf-8?B?T29tdUFBdGh6UFZmUzd4SEszakVWaG9FTGlDTk5aMUFJN3FkWnBIMW5kOG5q?=
 =?utf-8?B?RE5YYThLajlHTU81NWI4cVlRczFCcTdaQ2ZDV24yck1sanRZRWEvOHBUSXZm?=
 =?utf-8?B?ejJkSTVzcGh5RTFLcHlyMWZoeEhvZGJDWW1GZFVBWWw4bzFEUGtSOGtqMFV4?=
 =?utf-8?B?ckR2RVAwa2ZxKzdqTDNRQXNXUEt3cVJ2SGZVb3VONDRsUDlCTlpReVk2N2RG?=
 =?utf-8?B?Sy80dlQ4ZVFGMm9STzJHUjE1RVZ0ekhCcGxNdXpINDc2dUR2YXBkM0dCUXhH?=
 =?utf-8?B?VzgwbU9DT2s2RzNhN2Z4bVdLay9LRUNZeVl3cTlkallNTkhvUlRCcXl4Wm9V?=
 =?utf-8?B?ZG95SVM0RzZoY2hSYW4wNEJpdWNzSHk5RXBpYkM3SmdGbkUxck9NVGtBRmFK?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C895E3955CFFBE40918C808566658AE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57043c5f-08d0-48ee-ab83-08dbbe1c1d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 23:06:55.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIpaPr3gXsOsieTBxRoxouVZxOX+wpGQUOBV/G75bCgyLFw/sFEq5+90n6AA1tr0f6LFaVRj3NkU8p2ZsKPNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5382
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA5LTIzIGF0IDA3OjM3ICswMDAwLCBMaSwgWGluMyB3cm90ZToNCj4gSGkg
SmVyZW15LA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5j
IGIvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5jDQo+ID4gaW5kZXggYmU0MDQ1NjI4ZmQzLi4z
NGM1NDQzMmJmMDAgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5j
DQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5jDQo+ID4gQEAgLTE4NCw2ICsx
ODQsOTAgQEAgc3RhdGljIGJvb2wgYmFkX3NwZWN0cmVfbWljcm9jb2RlKHN0cnVjdCBjcHVpbmZv
X3g4NiAqYykNCj4gPiAgCXJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+IA0KPiA+ICsjZGVmaW5l
IE1TUl9JQTMyX1RNRV9BQ1RJVkFURQkJMHg5ODINCj4gDQo+IEkga25vdyB5b3UncmUganVzdCBt
b3ZpbmcgdGhlIGRlZmluaXRpb25zLCBob3dldmVyIHdlIHVzdWFsbHkgZGVmaW5lIE1TUnMNCj4g
YW5kIHRoZWlyIGJpdHMgaW4gYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmguDQo+IA0K
PiA+ICsNCj4gPiArLyogSGVscGVycyB0byBhY2Nlc3MgVE1FX0FDVElWQVRFIE1TUiAqLw0KPiA+
ICsjZGVmaW5lIFRNRV9BQ1RJVkFURV9MT0NLRUQoeCkJCSh4ICYgMHgxKQ0KPiA+ICsjZGVmaW5l
IFRNRV9BQ1RJVkFURV9FTkFCTEVEKHgpCQkoeCAmIDB4MikNCj4gDQo+IFdoYXQgYWJvdXQ6DQo+
IA0KPiAjZGVmaW5lIFRNRV9BQ1RJVkFURV9MT0NLRUQoeCkJCSh4ICYgQklUKDApKQ0KPiAjZGVm
aW5lIFRNRV9BQ1RJVkFURV9FTkFCTEVEKHgpCQkoeCAmIEJJVCgxKSkNCg0KKEFsc28gKyBLaXJp
bGwgd2hvIGlzIHRoZSBhdXRob3Igb2YgZGV0ZWN0X3RtZSgpKQ0KDQpCeSBtb3ZpbmcgdGhlc2Ug
Yml0IGRlZmluaXRpb24gdG8gbXNyLWluZGV4LmgsIElNSE8gd2Ugc2hvdWxkIGp1c3QgZGVmaW5l
IHRoZQ0KbWFjcm9zIGZvciB0aGUgYml0IHBvc2l0aW9ucywgYnV0IHJlbW92ZSB0aGUgKHgpIHBh
cnQuICBUaGlzIGlzIGNvbnNpc3RlbnQgd2l0aA0KYWxsIG90aGVyIGV4aXN0aW5nIGRlZmluaXRp
b25zLg0KDQpTb21ldGhpbmcgbGlrZToNCg0KI2RlZmluZSBUTUVfQUNUSVZBVEVfTE9DS0VECQlC
SVQoMCkNCi4uLg0KDQogDQo+IA0KPiA+ICsNCj4gPiArI2RlZmluZSBUTUVfQUNUSVZBVEVfUE9M
SUNZKHgpCQkoKHggPj4gNCkgJiAweGYpCS8qIEJpdHMgNzo0ICovDQo+IA0KPiBBbmQ6DQo+IA0K
PiAvKiBCaXRzIDc6NCBhcmUgVE1FIGFjdGl2YXRlIHBvbGljeSBiaXRzICovDQo+ICNkZWZpbmUg
VE1FX0FDVElWQVRFX1BPTElDWV9PRkZTRVQJCTQNCj4gI2RlZmluZSBUTUVfQUNUSVZBVEVfUE9M
SUNZX01BU0sJCTB4Zg0KPiAjZGVmaW5lIFRNRV9BQ1RJVkFURV9QT0xJQ1koeCkJCQkJCQlcDQo+
IAkoKHggPj4gVE1FX0FDVElWQVRFX1BPTElDWV9PRkZTRVQpICYgVE1FX0FDVElWQVRFX1BPTElD
WV9NQVNLKQ0KPiANCj4gPiArI2RlZmluZSBUTUVfQUNUSVZBVEVfS0VZSURfQklUUyh4KQkoKHgg
Pj4gMzIpICYgMHhmKQkvKiBCaXRzIDM1OjMyICovDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFRNRV9B
Q1RJVkFURV9DUllQVE9fQUxHUyh4KQkoKHggPj4gNDgpICYgMHhmZmZmKQkvKiBCaXRzDQo+ID4g
NjM6NDggKi8NCj4gDQo+IGRpdHRvDQo+IA0KPiA+IEBAIC0zMzUsNiArNDE5LDkgQEAgc3RhdGlj
IHZvaWQgZWFybHlfaW5pdF9pbnRlbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ID4gIAkgKi8N
Cj4gPiAgCWlmIChkZXRlY3RfZXh0ZW5kZWRfdG9wb2xvZ3lfZWFybHkoYykgPCAwKQ0KPiA+ICAJ
CWRldGVjdF9odF9lYXJseShjKTsNCj4gPiArDQo+IA0KPiBQbGVhc2UgYWRkIGEgY29tbWVudCBo
ZXJlIGV4cGxhaW5pbmcgd2h5IGRldGVjdF90bWUoKSBuZWVkcyB0byBiZSBjYWxsZWQNCj4gaW4g
ZWFybHlfaW5pdF9pbnRlbCgpLg0KDQpBbHNvIHRoaXMgd29ya3MgYmVjYXVzZSBpbml0X2ludGVs
KCkgYWxzbyBjYWxscyBlYXJseV9pbml0X2ludGVsKCkuICBJIG5vdGljZWQNCmJlZm9yZSB0aGF0
IHBlb3BsZSBkb24ndCBsaWtlIHRoaXMuICBTbyBtYXliZSBpdCdzIHdvcnRoIGFkZGluZyBzb21l
IGV4dHJhIHdvcmRzDQpzYXlpbmcgdGhpcywgaW4gY2FzZSBwZW9wbGUgbWF5IHdhbnQgdG8gc3Rv
cCBjYWxsaW5nIGVhcmx5X2luaXRfaW50ZWwoKSBmcm9tDQppbml0X2ludGVsKCkgaW4gdGhlIGZ1
dHVyZSwgYnV0IEkgYW0gbm90IHN1cmUgd2hldGhlciB0aGlzIGlzIHdvcnRoIHBvaW50aW5nDQpv
dXQuDQoNCk9yLCBzaG91bGQgd2UgY2hhbmdlIHRvIGNhbGwgZGV0ZWN0X3RtZSgpIGZyb20gYnNw
X2luaXRfaW50ZWwoKSBpbnN0ZWFkIG9mDQplYXJseV9pbml0X2ludGVsKCksIGFuZCBzdGlsbCBr
ZWVwIGNhbGxpbmcgZGV0ZWN0X3RtZSgpIGZyb20gaW5pdF9pbnRlbCgpPw0KDQpUaGlzIGFsc28g
YXZvaWRzIGNhbGxpbmcgZGV0ZWN0X3RtZSgpIHR3aWNlIGZvciBCU1AgSUlVQywgYmVjYXVzZSBB
RkFJQ1QNCmVhcmx5X2luaXRfaW50ZWwoKSBpcyBjYWxsZWQgdHdpY2UgZm9yIEJTUC4NCiAgDQo+
IA0KPiA+ICsJaWYgKGNwdV9oYXMoYywgWDg2X0ZFQVRVUkVfVE1FKSkNCj4gPiArCQlkZXRlY3Rf
dG1lKGMpOw0KPiA+ICB9DQo+ID4gDQo+ID4gIHN0YXRpYyB2b2lkIGJzcF9pbml0X2ludGVsKHN0
cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4gDQo+IFRoYW5rcyENCj4gICAgIFhpbg0KDQo=
