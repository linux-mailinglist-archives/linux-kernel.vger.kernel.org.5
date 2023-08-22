Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613FC78370C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjHVA0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHVA0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:26:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02312C;
        Mon, 21 Aug 2023 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692663983; x=1724199983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c7dhP2CznHBsi/FykvehEI5lfbzLLY3TTeBTRlSf4vo=;
  b=IprB0b0p4oWXNS7yzOcCIxaunLNrbyuvSq6Or+LSXg/1yFS00bX5i804
   JFNDKnom1jqtVGOMZQ2DLkxS+0YKZA6hbd49KoiYUlr7tSasPCgu57bsZ
   JzmPFjzOyexJcUdF0kn07fkIp7mKS6HUEoftlJ69TyEkHzI/gXaZUnYsp
   EkCRKwCxocZUw6Jrb0ztfHeYCdSl8xmvrtbPqZ02FTso7tg79VXnWsMBO
   E3Rq4rsmiggQYkbeacWgTmpkoZC4Dmkn1VaffSGQVgO3qwD5UUamR6naS
   BCM1avB5Ni3NhZ6ryDMrOUxqTOphK5vm/zxokPB9RG6T8G8Pf4fBLKxQj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404739048"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="404739048"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 17:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879718056"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2023 17:26:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 17:26:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 17:26:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 17:26:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 17:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPn08fDWsL7cGAytYFnD7SNYFCXFnhim0oxNFb7cgkS/Avoi0CAsfO3/a3NV3YSOs7hmGw4T9l/37OcoBkyA1oYpnO6IMZLYK2MIoMAD+ibEqk21oi/tMPXvpFzJp2JdpkAyPX1xxsmXwbpRIJyPBGsT6NJT1cU4KjQUdf8IPznU2AnMej9xDk49KiNZgMKvqb442v5c2JEEqppSVm9/JlOuBSjSBFDQ/Yba7YCogjKebdEXRbGn0RekBfI5sUuCJ5FhqVkyysAIFteiSHAzN5p2LrglmNoLfMX1gGs9jHX16/xz3JhY0Hx1iEXG5+1z48lDVw384oZjX8fuiciUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7dhP2CznHBsi/FykvehEI5lfbzLLY3TTeBTRlSf4vo=;
 b=TYkrTmrb5ZcV8cRtrOWrPi2+ApAhJ/OYWNefKK44ye2nTkEs94UrQvM1pXDtaKSHtsXlivbS3QHt72j516qaGT7/XFVhECiwNnGbtduw4Y0n9XzbQVcTMpwmq1N7x8MVFRHFYu7IfK500UA8B2xNfviE3CeI/vvgoMDMtaJXjcJe/5lArch/dhS5Oc3qqfwwq1Uf9MS7ZhpWeAJBXmDndglm5TtRVkrXU5VU/nGNpy+FPboNBgLQC/Gb3l09un8yN0oSPr0AH1weUPgInpBQXLCTM/inFKUmRWkWlCwi5kJpIYNJtCbNNXC/8lKRar+FOAdXI7tDfE+ENuQhypLKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 00:26:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 00:26:13 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 2/9] selftests/sgx: Produce static-pie executable for
 test enclave
Thread-Topic: [PATCH v3 2/9] selftests/sgx: Produce static-pie executable for
 test enclave
Thread-Index: AQHZ0oHDQUm+9DQ5NEuEMksSj0fi7K/1eXwA
Date:   Tue, 22 Aug 2023 00:26:13 +0000
Message-ID: <71ad6389da7db8541dada0276db33f98e2a4fdcf.camel@intel.com>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
         <20230819094332.8535-3-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-3-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: d31ce50e-5a04-42a8-2213-08dba2a66422
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GwYT2Fqx4398RwXQFnV5JQAasKry5famvdZJn7QieB7sEPzw6B0fEXkfU8+FKmbRxwyqk0M4UpLB6uZF5A85aBOqA/xRJjLzXdBzySjAQPr9BzG4yDMkA/8kNta/6aY939vz1pS5QL4nUnycfDFwEP3nV5Djk54iCTMXfn8+nYJa2uPHV8odRw2KfTMj9WJssagLCUWD7FZMj2Jge2R0cb1tThE5I8BmGnABCfgn7OcMVBxXueGkNzyATNtH51G25whmpGFzTdAOuVVtxW4OXNpHLaN9Jr9I9onS/549v8nXZTkw3frjL1A5DOArmZNvSQq8KKVtnB68/E2rgDrcRFaREExdViWQLSs761qhfTq7ji9dGGolBB41bPFVU8w+55rp8GxWMt4gQWDf1vt67fBeDPhq5Cf/fAvhJ8AkG2C+WPPUvs6ZHVMVXYcoAVSckB2+ifp0l4sb0i4SQuZWa8qyHAiH8/a9+HseSB5CaaCxO4IjP0s8+6SK5dLQlRQV3JgzqfgWIPxbqDkn5Y6K50RtfBYF+9dVF/cC1ub6vgDq4C+IgI6MIZI9K7JOpn1ZjtUMZGRfY3cKJiAGaLq3c+Ibk+/F0wElVJVlgoRx1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(6512007)(66946007)(82960400001)(110136005)(91956017)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(122000001)(966005)(478600001)(71200400001)(38100700002)(38070700005)(6506007)(6486002)(83380400001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1JiVUpUUVNkZXRET3JNTHk5RXZ3QUFQSG9GZjdkdzF1L0t5SUlDYmowR1Y0?=
 =?utf-8?B?c0QxS2QxdUdVV0Mzd2luM2huNHkrNHFWTjJPbjdzTnVWdExNc21Oa05mU3Uw?=
 =?utf-8?B?Mzc4NUcvdll1amp3enRvTHQvYWljOENubmZoUXFjWURocGxRdlNOWHgzd1Br?=
 =?utf-8?B?RUsrMXBMVzJrT0tFY1RQWGpmU0xSZkJwVmc0eDQyOThaTy9VNGY0T0tOMUUz?=
 =?utf-8?B?MWYwVjg3NWVFS3NvOHQvZHlmYlFXMTFZcGQzZFpvdHIxNXZ1Vm5yNFZmR2FJ?=
 =?utf-8?B?K3lOMkwrNVl1K3dCeFhaNVhFY0N6YjlWeU1QVTNHcUdUamZXZGxBMHZxYnpS?=
 =?utf-8?B?bUlBY2JhUzBUMVVFNkVOWE9EM0V1Qm9ZNC9YeVdmanpRK3JmUUs4Q3dVTE9l?=
 =?utf-8?B?U0c0b2N4RXlVbU1kcko0eWhnUkFEMXh0RlNENG95a3F2L2lweGs1Nzg4V1lm?=
 =?utf-8?B?cDJ5aTN4ZnVvT2FUbkNBcDUyMUthNjQ5ak1TczdUaVo0U3luMGhqQnJwbjV4?=
 =?utf-8?B?NXBaaHhRUllJeDZnRGxZd2dRZnBZMUxRakNSWFdJVDlyZllJa3pVeWljR2U4?=
 =?utf-8?B?TDJQOXNXZFRLckg4YS9xdEtVTmthMGtLcHZtT1dETTdOVUZzd0tDSmF0cjhQ?=
 =?utf-8?B?VmRZRVQwNW4wMG1GOW1wTDBMUER4WlJPdU4xZzNDcDJ4czF4eHo3QkJSNkJF?=
 =?utf-8?B?NkpGMkIvQ25xSml6Y29nd1crbGxxVDNRUlh2RXA3ckhMc2thci9GZXdRWVYv?=
 =?utf-8?B?UnFPQVBDZGtuNVFicXdZR1VzdjQ3VHI5R1AycjBQdmtiZGZMRmE2aWtmeVNP?=
 =?utf-8?B?VGJYeXF4bWxJVE9HdmUybi9kTEpBUU9Na2JXV1VobjBHVlhDc1pJZjBlVWN3?=
 =?utf-8?B?cElyMTdnSEE4enlPM3U4QUdDellENlJrWFRscHNsSG1KUWNOMHg3MG5kbmZU?=
 =?utf-8?B?SXVOWlJFV2dYNFJZdE9aTDRCMFJpR2diZXJqL053bXppL3hKS3pmSThaOXFw?=
 =?utf-8?B?VFFLTi9zK0Y0cjYzeUViREE3TVJSbS94MnZmcTBURDZvOWdMbmtZN3FXMHdi?=
 =?utf-8?B?K25WRC9TeUtNVjFmU3Nxa0lPcGd4K1JzakwxZUxpaDJPZW1LY0ZNcjhNOTBh?=
 =?utf-8?B?QVIrOHh1UTBwNzFrelEvOTVnT1FFTlFPQllPQ0NBeXhYNnc3SXd1ZHBsdE9O?=
 =?utf-8?B?bDcwYys3V3dKamNnd1lXMlM4QVB6TTNzaFJwUGtVVTBJbGVOZDZ0SVp3cjhO?=
 =?utf-8?B?SEFZc0dUbVNvNEhaek91anptZGN1RS9DY0NOaUFlVldScTYyRmRnRkRlZHRD?=
 =?utf-8?B?Z1JtZzlKWmFieTF3LzA4aUttYk5sNE1XeENpbVFIY3JDckZQT2ZQQmYxRnlI?=
 =?utf-8?B?OW1mSU1pU1F4TXVqelhpdHgxUUhCLzlIMlUxMy9UbXVuS3VkYUlWS0orMm1q?=
 =?utf-8?B?RENQMTd4Qm5lVEhyUUVVVEFiY1pGVVg1bXgzWVM1Um50bUtGc1F3T0hIS2la?=
 =?utf-8?B?WUlYcG93WmNwNURBNFZITnBBblpZVWpSZGxabzdCSU5KeEorU1NGVDk1S0JH?=
 =?utf-8?B?ZDRhaEFnb2RTNFBNZ3lMUXJBZUZ4eFBsYnNGbEVseFdsbm0zODVtNEhSYk9N?=
 =?utf-8?B?ejlPY3FQQk5VZVdHMFhkaHBUTkx0TWhGQUpuUWU4OWZmdTIyTlM0YWVFNUZj?=
 =?utf-8?B?NEdCNHpLZVdlUW5MaTRxVVh6OWM2SkZmWmh5MGRYZFZrbVh6dUk4RnBQRFFq?=
 =?utf-8?B?cXJxMGsvWkxaa09iRzJWOU45L284RXlIUEI5dWhLeFZZdThGejhwT0Rwd0dB?=
 =?utf-8?B?R09Ld0sxcUNIZmh5S0x2dFV6WkNtZERUWU85VmVSVUpMM2FNUjVlOUlPZVlU?=
 =?utf-8?B?WTZMekdxUG9ON3dYdUJqY1F1WXQvdFBnV0NQbHJIeDY0UmlsMXlkdUZNTHhS?=
 =?utf-8?B?dW54aitIbVJHdGx0bnMzOWo1SzluZUFaMWRhUW5zR1pKbUpkUXJMNEFrYlJX?=
 =?utf-8?B?VFVkWUVEOERmQW4wRGJGeWZhV3NaRHZwSjV1aEFkemtVbFJtWHFSUi8wZ0lv?=
 =?utf-8?B?ekFIazUyT0l5NGwzNTlDNGlFU2ZJSmVmV0FKUXNYVWxZL2hYNFArYitFa3pX?=
 =?utf-8?Q?AROWX/eH/cM84veaakdp5H3rT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABDDB209FA9BDF41A00990EDBB7809FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31ce50e-5a04-42a8-2213-08dba2a66422
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 00:26:13.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHcshYt53gbyiK9qNd3hUrTmHFKRn0QHYQoEXuunWoofBv7cKa6V5C7XJv9LRETSpeWvD2d8ag5/PwzUocxOyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTE5IGF0IDExOjQzICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFRoZSBjdXJyZW50IGNvbWJpbmF0aW9uIG9mIC1zdGF0aWMgYW5kIC1mUElDIGNyZWF0ZXMgYSBz
dGF0aWMgZXhlY3V0YWJsZQ0KPiB3aXRoIHBvc2l0aW9uLWRlcGVuZGVudCBhZGRyZXNzZXMgZm9y
IGdsb2JhbCB2YXJpYWJsZXMuIFVzZSAtc3RhdGljLXBpZQ0KPiBhbmQgLWZQSUUgdG8gY3JlYXRl
IGEgcHJvcGVyIHN0YXRpYyBwb3NpdGlvbiBpbmRlcGVuZGVudCBleGVjdXRhYmxlIHRoYXQNCj4g
Y2FuIGJlIGxvYWRlZCBhdCBhbnkgYWRkcmVzcyB3aXRob3V0IGEgZHluYW1pYyBsaW5rZXIuDQoN
CklNSE8sIHRoaXMgcGF0Y2ggaXMgYWxzbyBtaXhpbmcgZGlmZmVyZW50IHRoaW5ncyB0b2dldGhl
ci4NCg0KU3BlY2lmaWNhbGx5LCAuLi4NCj4gDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9mOWMyNGQ4OS1lZDcyLTdkOWUtYzY1MC0wNTBkNzIyYzZiMDRAY3Mua3VsZXV2ZW4u
YmUvDQo+IFNpZ25lZC1vZmYtYnk6IEpvIFZhbiBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2
ZW4uYmU+DQo+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3Jn
Pg0KPiAtLS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtlZmlsZSAgICAgICAg
ICAgICAgfCAgMiArLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5s
ZHMgICAgICAgICB8ICAxICsNCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2Vu
Y2xfYm9vdHN0cmFwLlMgfCAxMiArKysrKystLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Nn
eC9NYWtlZmlsZQ0KPiBpbmRleCA1MGFhYjZiNTcuLjFkNjMxNWEyZSAxMDA2NDQNCj4gLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L01ha2VmaWxlDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3NneC9NYWtlZmlsZQ0KPiBAQCAtMTMsNyArMTMsNyBAQCBlbmRpZg0KPiAg
DQo+ICBJTkNMVURFUyA6PSAtSSQodG9wX3NyY2RpcikvdG9vbHMvaW5jbHVkZQ0KPiAgSE9TVF9D
RkxBR1MgOj0gLVdhbGwgLVdlcnJvciAtZyAkKElOQ0xVREVTKSAtZlBJQyAteiBub2V4ZWNzdGFj
aw0KPiAtRU5DTF9DRkxBR1MgOj0gLVdhbGwgLVdlcnJvciAtc3RhdGljIC1ub3N0ZGxpYiAtbm9z
dGFydGZpbGVzIC1mUElDIFwNCj4gK0VOQ0xfQ0ZMQUdTIDo9IC1XYWxsIC1XZXJyb3IgLXN0YXRp
Yy1waWUgLW5vc3RkbGliIC1ub3N0YXJ0ZmlsZXMgLWZQSUUgXA0KPiAgCSAgICAgICAtZm5vLXN0
YWNrLXByb3RlY3RvciAtbXJkcm5kICQoSU5DTFVERVMpDQoNCi4uLiBJIHRoaW5rIG9ubHkgdGhp
cyBidWlsZCBmbGFnIGNoYW5nZSBzaG91bGQgYmUgZG9uZSBpbiAgdGhpcyBwYXRjaCwgYXMNCmRl
c2NyaWJlZCBpbiB0aGUgY2hhbmdlbG9nLg0KDQpCZWNhdXNlIC4uLg0KPiAgDQo+ICBURVNUX0NV
U1RPTV9QUk9HUyA6PSAkKE9VVFBVVCkvdGVzdF9zZ3gNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvc2d4L3Rlc3RfZW5jbC5sZHMNCj4gaW5kZXggYTFlYzY0ZjdkLi42MmQzNzE2MGYgMTAwNjQ0
DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+ICsr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+IEBAIC0xMCw2
ICsxMCw3IEBAIFBIRFJTDQo+ICBTRUNUSU9OUw0KPiAgew0KPiAgCS4gPSAwOw0KPiArICAgICAg
ICBfX2VuY2xfYmFzZSA9IC47DQo+ICAJLnRjcyA6IHsNCj4gIAkJKigudGNzKikNCj4gIAl9IDog
dGNzDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNs
X2Jvb3RzdHJhcC5TIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbF9ib290
c3RyYXAuUw0KPiBpbmRleCAwM2FlMGY1N2UuLjI4ZmU1ZDJhYyAxMDA2NDQNCj4gLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbF9ib290c3RyYXAuUw0KPiArKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsX2Jvb3RzdHJhcC5TDQo+IEBAIC00
Miw5ICs0MiwxMiBAQA0KPiAgZW5jbF9lbnRyeToNCj4gIAkjIFJCWCBjb250YWlucyB0aGUgYmFz
ZSBhZGRyZXNzIGZvciBUQ1MsIHdoaWNoIGlzIHRoZSBmaXJzdCBhZGRyZXNzDQo+ICAJIyBpbnNp
ZGUgdGhlIGVuY2xhdmUgZm9yIFRDUyAjMSBhbmQgb25lIHBhZ2UgaW50byB0aGUgZW5jbGF2ZSBm
b3INCj4gLQkjIFRDUyAjMi4gQnkgYWRkaW5nIHRoZSB2YWx1ZSBvZiBlbmNsX3N0YWNrIHRvIGl0
LCB3ZSBnZXQNCj4gLQkjIHRoZSBhYnNvbHV0ZSBhZGRyZXNzIGZvciB0aGUgc3RhY2suDQo+IC0J
bGVhCShlbmNsX3N0YWNrKSglcmJ4KSwgJXJheA0KPiArCSMgVENTICMyLiBGaXJzdCBtYWtlIGl0
IHJlbGF0aXZlIGJ5IHN1YnN0cmFjdGluZyBfX2VuY2xfYmFzZSBhbmQNCj4gKwkjIHRoZW4gYWRk
IHRoZSBhZGRyZXNzIG9mIGVuY2xfc3RhY2sgdG8gZ2V0IHRoZSBhZGRyZXNzIGZvciB0aGUgc3Rh
Y2suDQo+ICsJbGVhIF9fZW5jbF9iYXNlKCVyaXApLCAlcmF4DQo+ICsJc3ViICVyYXgsICVyYngN
Cj4gKwlsZWEgZW5jbF9zdGFjayglcmlwKSwgJXJheA0KPiArCWFkZCAlcmJ4LCAlcmF4DQoNCi4u
LiBpZiBJIGFtIG5vdCBtaXNzaW5nIGFueXRoaW5nLCB0aGlzIGNodW5rIGlzbid0IG5lZWRlZCBm
b3IgX3RoaXNfIHBhdGNoLiDCoFRoZQ0Kb2xkIGNvZGUgY2FuIHN0aWxsIHByb2R1Y2UgdGhlIGNv
cnJlY3Qgc3RhY2sgYWRkcmVzcy4gX19lbmNsX2Jhc2UgaXMgb25seSBuZWVkZWQNCmZvciB0aGUg
bmV4dCBwYXRjaCwgdGh1cyB0aGUgcmVsZXZhbnQgY2hhbmdlIHNob3VsZCBiZSBtb3ZlZCB0byB0
aGUgbmV4dCBwYXRjaC4NCg0KPiAgCWptcCBlbmNsX2VudHJ5X2NvcmUNCj4gIGVuY2xfZHluX2Vu
dHJ5Og0KPiAgCSMgRW50cnkgcG9pbnQgZm9yIGR5bmFtaWNhbGx5IGNyZWF0ZWQgVENTIHBhZ2Ug
ZXhwZWN0ZWQgdG8gZm9sbG93DQo+IEBAIC01NSwxMiArNTgsOSBAQCBlbmNsX2VudHJ5X2NvcmU6
DQo+ICAJcHVzaAklcmF4DQo+ICANCj4gIAlwdXNoCSVyY3ggIyBwdXNoIHRoZSBhZGRyZXNzIGFm
dGVyIEVFTlRFUg0KPiAtCXB1c2gJJXJieCAjIHB1c2ggdGhlIGVuY2xhdmUgYmFzZSBhZGRyZXNz
DQo+ICANCj4gIAljYWxsCWVuY2xfYm9keQ0KPiAgDQo+IC0JcG9wCSVyYnggIyBwb3AgdGhlIGVu
Y2xhdmUgYmFzZSBhZGRyZXNzDQo+IC0NCj4gIAkvKiBDbGVhciB2b2xhdGlsZSBHUFJzLCBleGNl
cHQgUkFYIChFRVhJVCBmdW5jdGlvbikuICovDQo+ICAJeG9yICAgICAlcmN4LCAlcmN4DQo+ICAJ
eG9yICAgICAlcmR4LCAlcmR4DQoNCkkgaG9uZXN0bHkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0J3Mg
dGhlIHB1cnBvc2Ugb2YgdGhpcyBjb2RlIGNoYW5nZS4gIEkgYmVsaWV2ZQ0KdGhpcyBjaGFuZ2Ug
Y2FuIGJlIGRvbmUgKGJlY2F1c2UgaXQgbG9va3MgdGhlcmUncyBubyBuZWVkIHB1c2gvcG9wICVy
YnggaW4gdGhlDQpmaXJzdCBwbGFjZSksIGJ1dCBhZ2FpbiBpdCBzaG91bGQgYmUgaW4gdGhlIG5l
eHQgcGF0Y2ggSSBzdXBwb3NlLg0K
