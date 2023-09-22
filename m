Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9307ABB96
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjIVWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:03:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B483;
        Fri, 22 Sep 2023 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695420210; x=1726956210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uajK/guU7CxNSsF84PY9+0WqvVWdEZ+t0xcmY0/rB4w=;
  b=aJk9JaPd20tLUJyYStODmpvzH6vtoCBAPUUCfO+i7w08awNBaovxlYwV
   eFC5Qc1hr8c8gui+Xa11GWEEkAJT9vQZGDJn/cLrHNcTgPbkg8YOFpc8U
   agAcqEOukhgILaRu5NPGz40+WVnue+rXks96Kphyk5QhgLxpk+1yP8EM4
   eH15m0EzNgsdXEAY0/9FxF2ZZ7eRpNxFHbNpODcrcIcifazLLAnR9EWiA
   gl9ant//1IF39yXvde17mUttEDlh79SqrlEZCQNcjEEYyTnI7+yXvG8Ol
   jMymhG6vI4iHVMTkbZ6wPXYiV84RW1a8JR/VCxeew2bsJYUYPGhjVdocF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="361204681"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="361204681"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 15:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="837912565"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="837912565"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 15:03:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 15:03:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 15:03:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 15:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOTRq1Otz2ZG6+plFLClvHdvMFL6/nJ2BLpXag9B0hjTxNvbmi++AoqLhYdLN3SQC1RyYmh2R7SjoDXbDqASYFaqEgB7Jui5Apq0LEnB4SAUe3S1O/kdyBLDCyzLt7rzi5BNG1Qn/zvqM0kbJ4hPgJUDodVA/MwfFtyPshIiCe767Urgg2xgBXSv3NXj/qbLmfHT8fh5Yn8nGGa00WeGF1KSQGh0vQtMvbVXQBSjYrnkJBHSqNUZPE6dGx5CJmVP9FJykgQjtZlnCXpHUURYjC7oaNiTdRyMCkyfNcRjhz1q+N9MYCvQ5anx3UW5U0EMidUhl77UrlMcVXbKZE157A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uajK/guU7CxNSsF84PY9+0WqvVWdEZ+t0xcmY0/rB4w=;
 b=P3fiiIZcXV+PwnbEBN8N1+jpTjk5c/ySSl8B/X6b9ALxaH2FGXkhE+zC2rpTvfaeTRZXqzpkePMek7qqWzQZP1a26MBx7fSjLzh4s3/svMc8AyR2iNcfeEyVxyysXv/kUdVk+rb+JJlp4e7GGVYFdigWrQZ/b24pehs/u+U1k3hma8janJGel6J8gFuBoALgaQxl2QyhVX3BnzyDZulK7/9Up0UDkGwTAYPinMu6KsMg46Gr3dUH1cfeDgOSEBf7tkJK93I4CCVHVpGQseUzqBGAEujAvKWGwR0SD0aVGl401rzYgZa52EWX0CNL/fnILGzARNaOP4pXQibt36nUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Fri, 22 Sep
 2023 22:03:12 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 22:03:12 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: Annotate struct nd_region with __counted_by
Thread-Topic: [PATCH] libnvdimm: Annotate struct nd_region with __counted_by
Thread-Index: AQHZ7X2aBeC3+BDVdEaBrGQ3J9Q33bAnZiuA
Date:   Fri, 22 Sep 2023 22:03:12 +0000
Message-ID: <67de23d7b2cda95fbba2260cd5b680cbc72f2575.camel@intel.com>
References: <20230922175238.work.116-kees@kernel.org>
In-Reply-To: <20230922175238.work.116-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA0PR11MB7159:EE_
x-ms-office365-filtering-correlation-id: f72ce34a-770a-427b-c81d-08dbbbb7b6f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8a0SbxW6/Q35DW1wSNRtsZdBmQW1cpTRIMhqaKjADFi1voAX3Sm0x4IJ5vqPbP03yBSTLE52jtLD6baUDBa3qMGVlPmqrqb7IX6LuD6cbf5Pz9vu33KGStqvCVKgNONS+snv8UFEhSYyp9gBCPAu737xgNNgsolpNI5FUGIYzXew3+7HOx+4uHK57a3DXz7D0jMD8FVMbSnGKmMMDwW0FCW16Hb+Gl+ti7q2lRv0BTdkkMdDlA7pwnRIYJ4hj89fU29dhd4MuEHIcYPoxY+wDW6Aee6DvTcNzosqeYO4vrur0+Ca1QsY5J1dmf6/5aygT3oaCi0pGWZLhIWpXXTMI7v82Prqr1Kh43vd20V3p1hPnSfd4qpRg96Vzfu+2+DxpA/Z3+cwLrd6dELIdDNiB7HillQP7LAXHyzpXHCLUrDNVVKpmcLrlUA2Elgex9+vajjjtcP6YvhDlCgS6lQFiZDqViXQWFmzZOhjAhBt//u47XLp78rjcydvMf3+C6zpowdBouSYTiZUnsuR5uVZOuv8dkasCEPeos8bIlO2GRq03eh5Aa4M1DlkDnVVGwTSxr2byE6lrrkhqVqpDzasrpw35Suny+oYb2HkE4e574=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(1800799009)(186009)(451199024)(8676002)(36756003)(83380400001)(8936002)(71200400001)(4326008)(122000001)(966005)(38070700005)(478600001)(54906003)(66446008)(38100700002)(66476007)(66946007)(82960400001)(76116006)(66556008)(41300700001)(6636002)(64756008)(110136005)(316002)(6486002)(6506007)(5660300002)(6512007)(2906002)(86362001)(2616005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUZBQnN4dkgyUmZ0RU11VEZtTUtzVTJweDZlSC9QOU02YUFRQ2EwTDZWemJi?=
 =?utf-8?B?RUUyaWI2QjcvZUp6Y0ZNdGV6WStIT2s5M2hvSE1oTDVqRjgyeFl5WlRSeVVm?=
 =?utf-8?B?QmttanlFTlRRaGVlUURlRVlXTXdHWHViSktsZHRIYzJiRjNlOVFrbXBoSndw?=
 =?utf-8?B?NDdJTHlORzR2WG5wa1NLU3EvakFoZmswRkExY1RiOWhoRnA3aEMxMWRjUU93?=
 =?utf-8?B?VkR5VkhFZ0wxRGkxZjYxOG93d2ZzTXp5cEQ2RHVuWStQSnk0bWJRWEV1SDRx?=
 =?utf-8?B?eTZWOXV4WjgzazA3VHhGRTV1VW9nTWRhaGUrTnl0TTI3TnhKRXFhdFRybmlG?=
 =?utf-8?B?b2hHK1FCa29pUEI2aUlLdm8zVllwV3hod3VQUURmNkR0VUIwQThmVk45Znlp?=
 =?utf-8?B?c3B2RE5BQTJtUFJkeGlIRWdWalBVUE1iajB1d1NWdlVHelFiL1JEYUVmSFRI?=
 =?utf-8?B?TFVyZzlUUnVJZmVMYzZJTTlpV3ozWG9sV01pVTgwQXlNN1Y4NEtHWHd6WGJQ?=
 =?utf-8?B?YkRxN3RDdGNXV0UwcmMzZGE5WFNyRzQ5ZGZLVVdRQWI4cjk3YkdKeHlUcGk4?=
 =?utf-8?B?a2lhRzZwQ2lBRnAzWjcrOWhkdlRDRXluVmV5clJNUHF0S2pURDVDRWZJU1p5?=
 =?utf-8?B?M0lyMFJSQW56eG1zZTE2T0FRWDkzT2oyRTd4VG9xd2R2K3BQVkpaUUtvQjdp?=
 =?utf-8?B?N2IxWU5VcmR5UUh5MFNYcEtadXZWd2h6RkZBUDVmNUM5eldIaTZKVmFjNXA1?=
 =?utf-8?B?TXdxQVBrRjljOEl6M255NkNGb05BdnhvMC9qV2ZXcTF2QkFkZjhHTzNJUVNM?=
 =?utf-8?B?V0ZsMHhRV3ZDYVpxdmpScS9FTWljaDNJeUE5MDcvWTVoZHBySmprYnB0WXZ6?=
 =?utf-8?B?ZjIwVWtnTlpjQkNPM3BlWjh2R3k5RzEzUXdlMDVRVzhhdUpESHlySXJVZS92?=
 =?utf-8?B?WXRMeVhucnY2NVBXdHhqSWhjbU9rcjR5OEVZK0p1Yk4vTUxTdUEveXhPZFBB?=
 =?utf-8?B?eFgrV0xheFRXcGN6Ym9sRWxnTlRiUXNpTEw5VGFwckt5WkVKYXRkQS90d2xh?=
 =?utf-8?B?NEtGZG1XaG1uVGQ2Tnp1d0xtTnptK2FUclF5OHk1U045cEkxWHZWaVY5OFZs?=
 =?utf-8?B?K2NuMlZRNHVETEMvQXVRYjVyZmNKd1NCb2FVaW1CNTkwWXdzdDRqSkQxV1RP?=
 =?utf-8?B?WGlJc0UzQzNjTTJIdzczZ1EwQXVpdjh5aHpNVG02ZGM5a2IrU3BLdHFGZTg5?=
 =?utf-8?B?UDkwa0FqNTVnejJKOEJIMExndzFSemlnZzZ3WHp0eWc1b0wyWVh1Ry9MVFJq?=
 =?utf-8?B?czhkYUJaRXViV0ZLM2tpaXZ4aDdvdWQxbHFQNloyTHdQUk0vUW05d0V4NmNo?=
 =?utf-8?B?ektTM1JxN0ErT0NyZVpYYkMrZ2FZczV5U01LdTAzYzlzTHlWY2NHdW9pa0ZI?=
 =?utf-8?B?YnhqYWlnRnBwdmZOVWlrUEh6S0p5NWM0di81emFOL2U2ckR0K2JPRmZVTDB4?=
 =?utf-8?B?TnJtY1JZNTI4K3Z4UFVYbEpGNVZrQjYyVkdIWTU4cGlGYjRKdnB3KzlZM1Bz?=
 =?utf-8?B?UlNiZXk1OEszNE1ZVGRkenZ2NDc1Rk8vdmxVdFhaTmUyNktteDk1UkRlZTNF?=
 =?utf-8?B?YzRMVXBERkxFN0k1SkRzeE13Qlk2WU1vNUZRWUZGZlR6b2RkLzA5ZjdFS3Jz?=
 =?utf-8?B?cXRvU1RQYlErWDJFbUozUDAvTWwybTBmZEtsWW5OSzVDOW9GOENhSzhLM3lt?=
 =?utf-8?B?TUlTSGY1ZkQzSjQ1bTd6d1dQS2lyUHBmcW96SVVLckJSOG43OTF0dEpqZm1j?=
 =?utf-8?B?REZ4THdoYktaRlJsUkE4V2xoTUIrQ0NmMmdpV1dOWlRQRytTTXRmWXBiNnZr?=
 =?utf-8?B?dE1VSUk0aC80aCtTUnRZNG9iaVJEampuVHgyb2lQNnRhbVdKU0ZIalY3b0I1?=
 =?utf-8?B?NmVWMkZpZzlFbi9ta2wwUEhzZXhDL2dSdTlzQlErU3k3SEMwNnAxVnNlOU13?=
 =?utf-8?B?MjRVUW5CNTJmR3hZbUh5SlNMSFpxVVBRNTN0Y0t6ZkRqY1pGNlRRV2Jlb2FP?=
 =?utf-8?B?WlBBeklOaXBpellBaFJKVXJlZ0ZMVGZwV2xwN2R3VTNxUEk5Q1ZabXRjbUZ6?=
 =?utf-8?B?ampQWVhHcEtVaEQ5eVZDUkJyWndydW5WckNJTjRWVlBoZ3lHTjZFN0hIVGFq?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A4B9C3DBC9AC44AA9142C875C1C05D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72ce34a-770a-427b-c81d-08dbbbb7b6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 22:03:12.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI9zI7AxP22sI496X69NexOf02vgtZb94ODHtLHSaABBt0lre0bbRMcFbyI/0D7iL9pJTU/K41G51vKEhMU+Y1p42KeYq0djYlQFImZeGBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDEwOjUyIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IFBy
ZXBhcmUgZm9yIHRoZSBjb21pbmcgaW1wbGVtZW50YXRpb24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0
aGUNCj4gX19jb3VudGVkX2J5DQo+IGF0dHJpYnV0ZS4gRmxleGlibGUgYXJyYXkgbWVtYmVycyBh
bm5vdGF0ZWQgd2l0aCBfX2NvdW50ZWRfYnkgY2FuDQo+IGhhdmUNCj4gdGhlaXIgYWNjZXNzZXMg
Ym91bmRzLWNoZWNrZWQgYXQgcnVuLXRpbWUgY2hlY2tpbmcgdmlhDQo+IENPTkZJR19VQlNBTl9C
T1VORFMNCj4gKGZvciBhcnJheSBpbmRleGluZykgYW5kIENPTkZJR19GT1JUSUZZX1NPVVJDRSAo
Zm9yIHN0cmNweS9tZW1jcHktDQo+IGZhbWlseQ0KPiBmdW5jdGlvbnMpLg0KPiANCj4gQXMgZm91
bmQgd2l0aCBDb2NjaW5lbGxlWzFdLCBhZGQgX19jb3VudGVkX2J5IGZvciBzdHJ1Y3QgbmRfcmVn
aW9uLg0KPiBBZGRpdGlvbmFsbHksIHNpbmNlIHRoZSBlbGVtZW50IGNvdW50IG1lbWJlciBtdXN0
IGJlIHNldCBiZWZvcmUNCj4gYWNjZXNzaW5nDQo+IHRoZSBhbm5vdGF0ZWQgZmxleGlibGUgYXJy
YXkgbWVtYmVyLCBtb3ZlIGl0cyBpbml0aWFsaXphdGlvbiBlYXJsaWVyLg0KPiANCj4gWzFdDQo+
IGh0dHBzOi8vZ2l0aHViLmNvbS9rZWVzL2tlcm5lbC10b29scy9ibG9iL3RydW5rL2NvY2NpbmVs
bGUvZXhhbXBsZXMvY291bnRlZF9ieS5jb2NjaQ0KPiANCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJt
YUBpbnRlbC5jb20+DQo+IENjOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4g
Q2M6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gQ2M6IG52ZGltbUBsaXN0cy5s
aW51eC5kZXYNCj4gU2lnbmVkLW9mZi1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5v
cmc+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvbnZkaW1tL25kLmjCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
ICstDQo+IMKgZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYyB8IDIgKy0NCj4gwqAyIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KUmV2aWV3ZWQtYnk6
IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udmRpbW0vbmQuaCBiL2RyaXZlcnMvbnZkaW1tL25kLmgNCj4gaW5kZXgg
ZThiOWQyN2RiYjNjLi5hZTIwNzhlYjZhNjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZkaW1t
L25kLmgNCj4gKysrIGIvZHJpdmVycy9udmRpbW0vbmQuaA0KPiBAQCAtNDIyLDcgKzQyMiw3IEBA
IHN0cnVjdCBuZF9yZWdpb24gew0KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5kX2ludGVybGVh
dmVfc2V0ICpuZF9zZXQ7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmRfcGVyY3B1X2xhbmUg
X19wZXJjcHUgKmxhbmU7DQo+IMKgwqDCoMKgwqDCoMKgwqBpbnQgKCpmbHVzaCkoc3RydWN0IG5k
X3JlZ2lvbiAqbmRfcmVnaW9uLCBzdHJ1Y3QgYmlvICpiaW8pOw0KPiAtwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgbmRfbWFwcGluZyBtYXBwaW5nW107DQo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZF9t
YXBwaW5nIG1hcHBpbmdbXSBfX2NvdW50ZWRfYnkobmRyX21hcHBpbmdzKTsNCj4gwqB9Ow0KPiDC
oA0KPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBuc2xfdmFsaWRhdGVfbmxhYmVsKHN0cnVjdCBuZF9y
ZWdpb24gKm5kX3JlZ2lvbiwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9k
ZXZzLmMNCj4gYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQo+IGluZGV4IDBhODFmODdm
NmY2Yy4uNWJlNjVmY2U4NWNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252ZGltbS9yZWdpb25f
ZGV2cy5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMNCj4gQEAgLTEwMjgs
NiArMTAyOCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbmRfcmVnaW9uDQo+ICpuZF9yZWdpb25fY3JlYXRl
KHN0cnVjdCBudmRpbW1fYnVzICpudmRpbW1fYnVzLA0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFuZF9yZWdpb24pDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IE5VTEw7DQo+ICvCoMKgwqDCoMKgwqDCoG5kX3JlZ2lvbi0+bmRyX21hcHBpbmdzID0gbmRyX2Rl
c2MtPm51bV9tYXBwaW5nczsNCj4gwqDCoMKgwqDCoMKgwqDCoC8qIENYTCBwcmUtYXNzaWducyBt
ZW1yZWdpb24gaWRzIGJlZm9yZSBjcmVhdGluZyBudmRpbW0NCj4gcmVnaW9ucyAqLw0KPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHRlc3RfYml0KE5EX1JFR0lPTl9DWEwsICZuZHJfZGVzYy0+ZmxhZ3Mp
KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmRfcmVnaW9uLT5pZCA9IG5k
cl9kZXNjLT5tZW1yZWdpb247DQo+IEBAIC0xMDYyLDcgKzEwNjMsNiBAQCBzdGF0aWMgc3RydWN0
IG5kX3JlZ2lvbg0KPiAqbmRfcmVnaW9uX2NyZWF0ZShzdHJ1Y3QgbnZkaW1tX2J1cyAqbnZkaW1t
X2J1cywNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnZXRfZGV2aWNl
KCZudmRpbW0tPmRldik7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IC3CoMKgwqDCoMKgwqDCoG5k
X3JlZ2lvbi0+bmRyX21hcHBpbmdzID0gbmRyX2Rlc2MtPm51bV9tYXBwaW5nczsNCj4gwqDCoMKg
wqDCoMKgwqDCoG5kX3JlZ2lvbi0+cHJvdmlkZXJfZGF0YSA9IG5kcl9kZXNjLT5wcm92aWRlcl9k
YXRhOw0KPiDCoMKgwqDCoMKgwqDCoMKgbmRfcmVnaW9uLT5uZF9zZXQgPSBuZHJfZGVzYy0+bmRf
c2V0Ow0KPiDCoMKgwqDCoMKgwqDCoMKgbmRfcmVnaW9uLT5udW1fbGFuZXMgPSBuZHJfZGVzYy0+
bnVtX2xhbmVzOw0KDQoNCg==
