Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186F177A686
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHMNaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:30:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE271713
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691933414; x=1723469414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VkyoCWpqi228D0MCCSMzpddJlSXZr40NvLXgq9GK9/k=;
  b=UQi+nVaQ4kMOyid0SvnmdJfdWR2Dg4i8B4P+IyoBOfeBPHU+MMyZBvmt
   Z9NfQW0dxLAth0u3jCzsmqgT/OTmfQt6nN65FdEuKz73Z1Hz+ruz6feaq
   uRlqVQtzU7r6B4n+gyF/Xi+bFMz1tREeOj2CxhA0DypVD0ysuNJiUsgLX
   EmUWErQFqGxxTY2TIg6UN491y0sSp/DE8Hi3cCfHaeaS0VdiARnkNujFB
   6NJS4DR5y2jOeq+7kmKmQRN62PwfVquSZ30SxLLWRy/lQ8V17yb387vi2
   4Y1J9Hwk60nikp0xowMpRQDCVapfUzTbVVmpnEg6C4KX83vwTocn3523e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="356856534"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="356856534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 06:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="823162373"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="823162373"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2023 06:30:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 06:30:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 13 Aug 2023 06:30:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 13 Aug 2023 06:30:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 13 Aug 2023 06:30:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo2CWpXNuayZXmcpDF0CCbuD2eQkUynDN1+BuhP3sc12cX8So128FZmU9/IxjJgSfSux/iILXHJclwdeRbu2HNjP5sU0p8UMB65+sfeopxnYexhYCmU/RS80GRf3xtp1gdA8QM9MfIR3fx6brCpzd3+3EyGUzMIMmXcHd/BYfreqzb1E6NUjiYyMPLkWrpYGcys3oLU6N/nVHPKpvup5+GDuxZxOeJsRwbv6ft5SJCYbwjVVI3WD4TLMaNLmPpo+9e+wdUgFsDcp9M9U+L6gxafbd4o62WJtKx1BUBQcYwtqwZ5kxGiMQSAA9EThtfOQBWGtpuF5/XZKAmCx24Fy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkyoCWpqi228D0MCCSMzpddJlSXZr40NvLXgq9GK9/k=;
 b=mSEv7juDe6Uc3pcX700LkO1VN0b/3kIXXeqIyCM9iBHPXT4F2OflY17RjdGAADsEvgCsVRIUiz/2ukKjBUg13XNLTtC9tv/Ri0FhPZFQZJd2Epd/Y4NUia59tvS+5PLbjuZ+tnFLPfQFZmR26g5NzEFF37KVnyZ57EMIBj/z16oNCp+ytQWm4QhlBI9xt8uNW9Z0JfUoAJEOtKKp/90ygab0kUsrwJzphCAuoBZzPlOdVJr5W/kTjob/iiY1EJ/h1JTF2Txcs2CnCNBkRpni5UEL5nDC2aO4kieqMZYBcr9tnYb0DN1Z21k6GWG7rZ4gDoy7LIyBPOhY1SMEEuVftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 13:30:11 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 13:30:11 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZxStsBtGoY60ZQkekYudRfTtGjK/mROWAgAIFU4A=
Date:   Sun, 13 Aug 2023 13:30:11 +0000
Message-ID: <33b628a02f190481c42a2dfd31b5ed1b2b50b37f.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.026097251@linutronix.de>
         <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
In-Reply-To: <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: e34aec45-85ee-4d7a-37f2-08db9c016b3b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CSEK2pxyiY+23+y4xY1tNOgI1FWKtHM5S4O54EaGeNvOTKz9EM0HlR4wcHPqA/FN8hRlAp2yt4eCdz2Da92xDo14zwTINhfGYnn/HNxwTD3zWoASLX9Q3FGkDhlHG0OUNJAsmhPrFfPBzOhoL7UXIb5uDRHUGbfGOkh8gK5TO8e+xCWJpfbpg3gp0T7Z0luxEHpcmogsu8xw0ictFIqMnOu2zXnqud1qwJDG1p5FktbLzTfx8QNKpHy4a3yx4jP9HCbcMX+ppX7JHQfFTO0bR3OQbpUdn5IK79XKm0+XsK5D9s83qDUreonwkpxvAiW/tmgzbXB3eQizUMdVgiYt4XbeS2gKb+QQP1ZH6Qek055SNv/2kh0ZGjGZuYeGoTK43gEvrbOfyzNWFdY3rkEVlCAFSqELOpzrf5S+9j0GZWs/OJsx3liYs10rUh6miutKgGikiMcfoSX3a8Z575UD71q3uDrJ/ld5pj9xYoWVJbe+cnlv0IAb2VHh33QQ3s3p1/rNScVjDotZhWstWoCTOjMaNl8vY+PhKyjZ3Hy+TzvLz1yAbvV6Wz2pStifxnNyyLqHtQbWrwec+RNevhwweyQXiOR6H/OdlKUA1bqhDwwtLvEj0rEt+hq3cUMBrSR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(1800799006)(186006)(38100700002)(54906003)(110136005)(6486002)(71200400001)(478600001)(122000001)(82960400001)(7416002)(38070700005)(5660300002)(2906002)(36756003)(86362001)(4326008)(91956017)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8676002)(316002)(26005)(6506007)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2RCSE9sNWVvNW95RWgxN3ZTRjY3RkVsMzc3Wno0d2FIQko5VkFiTUlhY05u?=
 =?utf-8?B?QkozZlNHOTFKYWhiTDNONXB1Y2h5YXY0ancwT0NzR2RuWjRSQm9ETVpYb2hX?=
 =?utf-8?B?dWtjbXJ2N2tpdU1mZm1OWEx6Q0FrdjByV0NDSFF4Qng2QzFnZERlTlpHMmVW?=
 =?utf-8?B?NWJHVEN4Zkkya2p6UDlFMmpYNXk1ZDhJa3pRZWdPdUdtK0l6NHNCWHk1WnRk?=
 =?utf-8?B?ZXRxbmh5YzY5aURtK0IwTkRyRlFoeHRXenNHYXZTWE4yemhNT0Fuc2RVT3dX?=
 =?utf-8?B?U1pjRytHb2FkMDlZaml6MWF3OSszK05zdXJnUDhvV0tDTmFUdWltY25JdFhw?=
 =?utf-8?B?c3JKb3VwbEYycUlzSGdiektSRlhpd0FBdnB0cWhSQ1RQTzI4Z1YvaXd2VE0v?=
 =?utf-8?B?QW5CRTQ1RUpYRHB4b3JrSFdhV0pGZi9aa01CNGIyanZTS2VjL1V3bjVvbDUw?=
 =?utf-8?B?YUV2SjV5NXlubk9VMm9GWitXWk1oZmlPN1I3bk90cXo5MXRYcEFzNXJpaGty?=
 =?utf-8?B?dzluSWR4dWVORE5BWnZQbEhPU0ZEVGZmaFh4aUZmOW5IVk9BeG1yWXo5ei9o?=
 =?utf-8?B?S0ZwZGptbm5Ya1pMNER4S0U0c2RmSDJPZHg2YkRab1pNZ2pUVDhlVVhBbWRP?=
 =?utf-8?B?bmZVSFRqallOWlRMYUg0VU5zUzBJbEhITVc5VjJweHMxT1Q3ckZMc3JmMDhq?=
 =?utf-8?B?Q2pHQXczUFJ2czZaYkd2a3lLeElIVi92Zm1Mb2liT0JIT2JUcWk0N2hlQlJr?=
 =?utf-8?B?Y2RaQTByalE2WjZsK2xrMjR4Vm50MThJQmF1RGFZbmt6Tysxc0xyd0VMT3hI?=
 =?utf-8?B?YXpQUjkrQXJDc3RjbjNsNjZUN2s2eFdUUThWOFZQaTdEdE55d0dYeGhzWTVo?=
 =?utf-8?B?MGVxcVhSOU8yTFp4TW82ZTMycUUwT0llVnUwYWtpbzdPMU1iSk9KTC9DNk9F?=
 =?utf-8?B?M3lJVEhXOHNzQ1JjdmZXK1ROaHR4a3BsSjlZVkhlUFJXRmlIaCtWOSt2cHB4?=
 =?utf-8?B?d2llY3VYZEhRZ3cyMVhFdmhSYVFaejNMM2lmN0ZKVWxZRm9xdU42cGVRWUFm?=
 =?utf-8?B?T2lOMzd4Uk9hSWJiRjg2dERuQnlLb21lMjNYZU5SeVJubE1yRFVCN3J2M0lG?=
 =?utf-8?B?OUhKYVRBd0RpZVJRVlphU2lnYXk3N0VLemJiM0RjcHpkQzMreFUvTDlZM0Qw?=
 =?utf-8?B?cGlCaldjNFNsT2JiVVYrYW42TW5UelRWcTFmMGwyV0JjQSthN2dpdSt6RmRo?=
 =?utf-8?B?bm1FbkJWbEhtTHRkdnRwSmdOWCtuQklNTXlZYlpUZWllcTVjWDJwV1lVZENx?=
 =?utf-8?B?ZHJvZHJ4VTdGMmxmNmg2ZGp3aVhGdDdDTE83OWZNek85ZG5BUEhxM1lXZHp3?=
 =?utf-8?B?Zkhhc0NnMlpTVFBhMHZ3UTNnZjhlcjQwd1dpYzkrdTlHUyszYUdtNUdvQ1gz?=
 =?utf-8?B?UkEvcDNYZlRlWFNINmNkQkZJWkFmWmFwMk5ZNDBFejF0azdaazJXaGR6b2xp?=
 =?utf-8?B?UTlGRTlLTWFmSUpsVTNxTVhiRFRIUFBUcU1QTVpLc2VDcXdoMml1VHRNcHpB?=
 =?utf-8?B?eUlieTBnVmZIYzBxRHorMFBxVGRENDArSGkyMkZ5eVRkVHVJSkZrYnRXQjZr?=
 =?utf-8?B?bGFkZzhVOWNGdnV4Q0NLM2hqd1dQc29wNlUrMXY4ejRCUFhZbVd5bXk1VDI0?=
 =?utf-8?B?RTR6Y0xoejhEN0xpVWRsaE9RVlZLR2F6QlpkWUhmV2V0QWlwZUhGa1dyRkJD?=
 =?utf-8?B?cUxPWEsxN1Z0YkpvR0k3OEFOa1RZSXFiZ0xHYm9obWlFM2JQZUd2NHdmVkZD?=
 =?utf-8?B?UElWdFNTM2doTHVQNmxMTGlGU3V3QXMyMGpCZ3BHQ25VVis3Tmg3a2l0em5h?=
 =?utf-8?B?eWlVK09VbkFVUTRyZHhhWlBxd0dJdUhmSkp1c3VkN2dNL09DeS92UlVZTWRN?=
 =?utf-8?B?K0lJL2RjeUpacHNLb3dVUXQzTEg4eHpZNlZXdlA0UXVDOUZ2WTdhNXo5OXFx?=
 =?utf-8?B?UFFzNitwcW5XZ3U5V3VwSEhlOWF0UVVQTXBTUHlpdkgyd3RZZCttb2g2QURU?=
 =?utf-8?B?bnRRdDZJc2NrUHNadTZ3bHlNaEVsbTFteWpHbUt3SlMrK2kxdXdTcSt3L0Vx?=
 =?utf-8?B?R2x2TjhSOE9sb3crL2lJRlk2ZFZLY3JkdklxVitPNndGbTNia1pzMktMWUhC?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BF1D6C627E844F8F3FDA171E77986B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34aec45-85ee-4d7a-37f2-08db9c016b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 13:30:11.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qq/v8WaSQ/yzWCcTX3UV4jK1MFNpp+v/n2s8Z7vbZUyDzVxKEQyk5h/JpsaFidXZ0XefuFP5IcGcmO2svCHJug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
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

T24gU2F0LCAyMDIzLTA4LTEyIGF0IDA2OjQxICswMDAwLCBaaGFuZywgUnVpIHdyb3RlOg0KPiA+
ICsNCj4gPiArc3RhdGljIGlubGluZSB1MzIgdG9wb19yZWxhdGl2ZV9kb21haW5faWQodTMyIGFw
aWNpZCwgZW51bQ0KPiA+IHg4Nl90b3BvbG9neV9kb21haW5zIGRvbSkNCj4gPiArew0KPiA+ICvC
oMKgwqDCoMKgwqDCoGlmIChkb20gIT0gVE9QT19TTVRfRE9NQUlOKQ0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhcGljaWQgPj49IHg4Nl90b3BvX3N5c3RlbS5kb21fc2hpZnRz
W2RvbSAtIDFdOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBhcGljaWQgJiAoeDg2X3RvcG9f
c3lzdGVtLmRvbV9zaXplW2RvbV0gLSAxKTsNCj4gPiArfQ0KPiANCj4gcmVsYXRpdmVfZG9tYWlu
X2lkKCkgaXMgdXNlZCB0byBnZXQgYSB1bmlxdWUgaWQgdmFsdWUgd2l0aGluIGl0cyBuZXh0DQo+
IGhpZ2hlciBsZXZlbC4NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHRvcG9fc2V0X2lkcyhzdHJ1Y3Qg
dG9wb19zY2FuICp0c2NhbikNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBjcHVp
bmZvX3g4NiAqYyA9IHRzY2FuLT5jOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHUzMiBhcGljaWQgPSBj
LT50b3BvLmFwaWNpZDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgYy0+dG9wby5wa2dfaWQg
PSB0b3BvX3NoaWZ0X2FwaWNpZChhcGljaWQsDQo+ID4gVE9QT19QS0dfRE9NQUlOKTsNCj4gPiAr
wqDCoMKgwqDCoMKgwqBjLT50b3BvLmRpZV9pZCA9IHRvcG9fc2hpZnRfYXBpY2lkKGFwaWNpZCwN
Cj4gPiBUT1BPX0RJRV9ET01BSU4pOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqAvKiBSZWxh
dGl2ZSBjb3JlIElEICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgYy0+dG9wby5jb3JlX2lkID0gdG9w
b19yZWxhdGl2ZV9kb21haW5faWQoYXBpY2lkLA0KPiA+IFRPUE9fQ09SRV9ET01BSU4pOw0KPiAN
Cj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0LCB0byBlbnN1cmUgYSBwYWNrYWdlIHNjb3BlIHVu
aXF1ZSBjb3JlX2lkLA0KPiByYXRoZXIgdGhhbiBNb2R1bGUvVGlsZSBzY29wZSB1bmlxdWUsIHdo
YXQgaXMgcmVhbGx5IG5lZWRlZCBoZXJlIGlzDQo+IHNvbWV0aGluZyBsaWtlLA0KPiDCoMKgwqDC
oMKgwqDCoMKgYXBpY2lkID4+PSB4ODZfdG9wb19zeXN0ZW0uZG9tX3NoaWZ0c1tTTVRdOw0KPiDC
oMKgwqDCoMKgwqDCoMKgYy0+dG9wby5jb3JlX2lkID0gYXBpY2lkICYgKHg4Nl90b3BvX3N5c3Rl
bS5kb21fc2l6ZVtQQUNLQUdFXQ0KPiAtIDEpOw0KPiANCj4gSSBkb24ndCBoYXZlIGNoYW5jZSB0
byBjb25maXJtIHRoaXMgb24gYSBwbGF0Zm9ybSB3aXRoIE1vZHVsZSBsZXZlbA0KPiB5ZXQsIGJ1
dCB3aWxsIGRvIHNvb24uDQo+IA0KVGVzdGVkIG9uIGFuIEFkbGVyTGFrZS1OIHBsYXRmb3JtLCB3
aGljaCBoYXMgMiBFY29yZSBNb2R1bGVzIG9ubHkuDQoNClsgICAgMC4yMTI1MjZdIENQVSB0b3Bv
OiBNYXguIGxvZ2ljYWwgcGFja2FnZXM6ICAgMQ0KWyAgICAwLjIxMjUyN10gQ1BVIHRvcG86IE1h
eC4gbG9naWNhbCBkaWVzOiAgICAgICAxDQpbICAgIDAuMjEyNTI4XSBDUFUgdG9wbzogTWF4LiBk
aWVzIHBlciBwYWNrYWdlOiAgIDENClsgICAgMC4yMTI1MzFdIENQVSB0b3BvOiBNYXguIHRocmVh
ZHMgcGVyIGNvcmU6ICAgMQ0KWyAgICAwLjIxMjUzMl0gQ1BVIHRvcG86IE51bS4gY29yZXMgcGVy
IHBhY2thZ2U6ICAgICA4DQpbICAgIDAuMjEyNTMyXSBDUFUgdG9wbzogTnVtLiB0aHJlYWRzIHBl
ciBwYWNrYWdlOiAgIDgNClsgICAgMC4yMTI1MzJdIENQVSB0b3BvOiBBbGxvd2luZyA4IHByZXNl
bnQgQ1BVcyBwbHVzIDAgaG90cGx1ZyBDUFVzDQpbICAgIDAuMjEyNTM1XSBDUFUgdG9wbzogVGhy
ZWFkICAgIDogICAgIDgNClsgICAgMC4yMTI1MzddIENQVSB0b3BvOiBDb3JlICAgICAgOiAgICAg
OA0KWyAgICAwLjIxMjUzOV0gQ1BVIHRvcG86IE1vZHVsZSAgICA6ICAgICAyDQpbICAgIDAuMjEy
NTQxXSBDUFUgdG9wbzogVGlsZSAgICAgIDogICAgIDENClsgICAgMC4yMTI1NDNdIENQVSB0b3Bv
OiBEaWUgICAgICAgOiAgICAgMQ0KWyAgICAwLjIxMjU0NV0gQ1BVIHRvcG86IFBhY2thZ2UgICA6
ICAgICAxDQoNClRoaXMgaXMgYWxsIGdvb2QsIGhvd2V2ZXIsDQoNCiMgZ3JlcCAuIC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2NwdSovdG9wb2xvZ3kvYypfaWQNCi9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdTAvdG9wb2xvZ3kvY2x1c3Rlcl9pZDowDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9j
cHUwL3RvcG9sb2d5L2NvcmVfaWQ6MA0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MS90b3Bv
bG9neS9jbHVzdGVyX2lkOjANCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTEvdG9wb2xvZ3kv
Y29yZV9pZDoxDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUyL3RvcG9sb2d5L2NsdXN0ZXJf
aWQ6MA0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1Mi90b3BvbG9neS9jb3JlX2lkOjINCi9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTMvdG9wb2xvZ3kvY2x1c3Rlcl9pZDowDQovc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHUzL3RvcG9sb2d5L2NvcmVfaWQ6Mw0KL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvY3B1NC90b3BvbG9neS9jbHVzdGVyX2lkOjgNCi9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdTQvdG9wb2xvZ3kvY29yZV9pZDowDQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHU1
L3RvcG9sb2d5L2NsdXN0ZXJfaWQ6OA0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1NS90b3Bv
bG9neS9jb3JlX2lkOjENCi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTYvdG9wb2xvZ3kvY2x1
c3Rlcl9pZDo4DQovc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHU2L3RvcG9sb2d5L2NvcmVfaWQ6
Mg0KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1Ny90b3BvbG9neS9jbHVzdGVyX2lkOjgNCi9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTcvdG9wb2xvZ3kvY29yZV9pZDozDQoNClRoZSBjb3Jl
X2lkIGlzIGJyb2tlbiBhcyBpdCBpcyBNb2R1bGUgc2NvcGUgdW5pcXVlIG9ubHkuIFRvIGdldCBw
YWNrYWdlDQpzY29wZSB1bmlxdWUgY29yZSBpZCwgaXQgc2hvdWxkIGNvbnRhaW4gYWxsIGJpdHMg
dXAgdG8gcGFja2FnZSBpZCBiaXRzLg0KDQp0aGFua3MsDQpydWkNCg0K
