Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B907D3CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjJWQq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJWQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:46:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43891E6;
        Mon, 23 Oct 2023 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698079583; x=1729615583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4d5aub/285Peu9Tm4JB3YwsrFLC9o8qUDWhq+iWyTcc=;
  b=NBbWAoo0Tv61lPoffJw2etVWgimHnYWekUhZXd+ZcLZ6vUGDVa13z4we
   /Fmbfl5eayk/pBKNuFaYW0LvCh/iHUOSMWfL0jYPB6Os//aMMio++XPj5
   op8avsKGLbR6ucleZsGHbmNBOMZC62ynMnBdyxSLI5vjb2LmRm3atexrS
   /+iRSUu00YOzluiiKkXtqdmAzjCg/jof49h2BrP/IoP5ZmAn/tyt8Tcvy
   DOD89G/BB6OxDArrb5gpW58sZAMn2AetWeGB7UZTtIe0BVgmogG0JHE6p
   vab/821V94chxajdY85SOVIjvYCJABM/FAsyYMqf7ORuRVX9W+tcfIWBg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="418010946"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="418010946"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="6150974"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 09:46:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 09:46:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 09:46:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 09:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBEfp9ENHD3Isi5zQlLlV+OHy9JXVTtMTMgN8VWhl17Ed4Z+3/nTrV65qdXsj3eV2TNjAAEGtySLxIw6WuyG7dng7mGoY6odkftEk6sMk40n16Kg3BWd1pqSOQDZW8xjyIM7oOKgFFa5FJtxcjRci6KFgSZg8NDtypkNM3WM/UYrMXKfFbC4+HyIimHcv3rhEOpgB2VgNTM48XcSWZvgOQdhlT1bofFp6ZKQip7evSj3o8XDt78zxuKV4CbScSdMsMhfsRpS32JrtxLCNg6Iqb16ClgFx4aMFrWi2/uceBxODafjgPNn5XEbF8vSaX+q/TaPBTqWjtYV7JaLYJOt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d5aub/285Peu9Tm4JB3YwsrFLC9o8qUDWhq+iWyTcc=;
 b=IqFhA8akujh+trB+E3DwE871zAkUlyrDjeRDUVIF7W75gasTjdKCcQ88W/v3OTSWrRg4v/8gaIBn90i+tbXzjIzYV1DvpZ6ixKSzOzsljtiJ7vbfNBISrDsFY9kWrf03Q0aT8t9zrh1Q/1z83hNp37BgK+O39CpyoFXdL0mWeZrEO4rMTY2xRq/yw1d3iUnIoWDecj6y7hY3gaFFIeZNtex2TrTl/dPs3DBLx6GsjeO1kvdtf7WcgsywcHnwiQLxqIiTa3PXanpOQUnDp72ClyYCObkzvSH2i5J4ZD4d+0hTgjQJ4bmSsw57ZbiaeHbhdz4ho/tUzCtaHBQhfjdmcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB6466.namprd11.prod.outlook.com (2603:10b6:208:3a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 16:46:18 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 16:46:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Thread-Topic: [PATCH 06/10] dma: Use free_decrypted_pages()
Thread-Index: AQHaATgYbrh2vf9YMEisxdRJ1o7j3rBP0mkAgAfMBoA=
Date:   Mon, 23 Oct 2023 16:46:17 +0000
Message-ID: <ea8ad4e75303178ee907682797dea7de36441c95.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-7-rick.p.edgecombe@intel.com>
         <b4dc423b-a658-449f-9c6d-1502685a2f1b@arm.com>
In-Reply-To: <b4dc423b-a658-449f-9c6d-1502685a2f1b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB6466:EE_
x-ms-office365-filtering-correlation-id: de6e6274-71d5-4ade-ba6c-08dbd3e7942a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yrba8HDexMhVyb8XhHfh9USyvze3dU1v3ompDK0KZejmZsswAV31bfbCY1wKqcx7wtU/rI4nZG6pC3M2kWzBvsPtNeeFCJkh6lZqrumnDl2e9No63xL35gUeD7iEECRfkpKgckKABcr36L4K1WzkcMCf7d7FCpMQayxDB8Pmhf/+8lfvgQnc/4O8I4jtmnoVSBDJqCnejtjtnQ6eoVuFTbQJTZFeUlpfvxni8V7JS6WxANbA7165/hsUS1jNa58RIKqxIW+xbFW6mDW3bVVPDgisn3Trgw51BE+mPRwaHO84lF7yHyla5MDUUJURseN3ORSeb9NyfLLnijru/xvDUBtvWwVRicYwERWp5VxyTpRkbMOvmHPVs9HpPIpx+cLwgv5CqoOPvUntrRDCdB7is7ZtsQ4txc4xj9qSdHYoPY29KjzMpe+ad1lMIvSPNqG2qSVi4WjmKvs89QkJ2VzlJcXLUXhkgi4/zxJoDf/nkIHH4HC7n5W3NnWxcmtXghll9rHLj0QXfEe+2WyOALUHkL0jTwVI/dzkS2jGyGToovMKjuI4DZE6RkHsyO3i5HyjxlsHyUId4YvNvQJYdEq7007jHiHP1GJjjNWxup2t3ZTTXgu1p8GEZCeJ2u+Ig8Qth8vaiLGjzNjuzXPvnAavZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(71200400001)(86362001)(83380400001)(478600001)(5660300002)(66899024)(4001150100001)(7416002)(36756003)(82960400001)(2906002)(6506007)(53546011)(26005)(122000001)(6486002)(8936002)(316002)(91956017)(2616005)(76116006)(8676002)(6512007)(4326008)(66446008)(41300700001)(54906003)(64756008)(110136005)(38100700002)(38070700009)(66946007)(66476007)(66556008)(921008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVd4Qi9KQmpoUzQrR2pkQk84Sk0vU1dqRFJicE5rbVZPWlJUcCtPZ2pyeE04?=
 =?utf-8?B?NFpDZkExcmtXaHQxeGpSbU1obUlCVEJWbTU4YXg3d0tSNjVUSUppZTREdFRQ?=
 =?utf-8?B?YXFLRTZidlQvcHdiWkphaDZLYm5FblVic3poSHZ2M2graHB0VnlqenduVyt2?=
 =?utf-8?B?bWJyb0kwN1dyYUFzUUJXU20rYkNyYTBzNDExRlA4WkpRMzlvbnpuL29nWTZr?=
 =?utf-8?B?V0lNU0NYcGxmWW14ZEZmejEwM3JUcWp3ZDEyVTZqVHBONXQxZmkzak93NDRT?=
 =?utf-8?B?eFFMVDZSaTdoWXRHa0szS1lsTnkzUnZ4VHh4azgzZ0V1dzVwdC9ZZXJLQis4?=
 =?utf-8?B?T2hZNTRMcnhyUjZ3Y3h4T2hLN1pWQnVPaElIUXZtOWJ2WW9NbjVUbURid096?=
 =?utf-8?B?SHJuNm93MHQzaGlKYWlod3NSN3kwYW5WZ0JEQlh0SFZCUUZRTEoveC9oWk5o?=
 =?utf-8?B?Y3JjdDY2TFZDT2xFQXk4YXdvS005blBFeS9GZC91aVdXS1cvajVvWDAzdE5W?=
 =?utf-8?B?eXBLV0FiRHRjMlNjS1FhVFZLK2o4RlRMTE5VNWlGc3cyN0Y3ejBVaFJUTjg1?=
 =?utf-8?B?dUczL2lKYkRRVUdldDJaT3pxY0wwNmxQOFZPazdINWpyelZ1dXZqYkQ0L0Ew?=
 =?utf-8?B?Y0ZYdVc4ejE5dVNRNkNMbnNuREFtQ09TRGFpMTEyTytoUjJ4SXJvSzdCcTk4?=
 =?utf-8?B?S0lRZW5KK3ZTWjhVYjZXVStkeitwSWU1OE5lek5USEZmQVNLcjl5V1dhOUJC?=
 =?utf-8?B?SUtxa2pzaHNoS0FQMjZ6YjZnWHVBVjlJS0NvZ0JISldaaFBwQ2ZibXliY2lU?=
 =?utf-8?B?ajNGOXgyVE9CN21UZDRwQXNwOXJaelNvVDVuWWhyZlFOSVRyVE14eU16VDNx?=
 =?utf-8?B?Y0V0MDQwbXlqNXVlK3cvL2ErV0pTME5BOVgxZjByb1ZhUU5mVHUvaklIQk4z?=
 =?utf-8?B?NkYrek1ubXYrOFRkTjdEMU5FdEhNNkJEbkt1d0lTckNLb01KQUdHRHYwa1BB?=
 =?utf-8?B?UTVCODJHUGVHUi9xWklMRWNDYU9SRERETVBNdGtRRStHTFowYXRVMmpTTmky?=
 =?utf-8?B?VW41UlR5L1ViNDNIY3d4eGtKdDg1dzNtcGNpSFZvUHh3cG84dFVuZFB6TWhC?=
 =?utf-8?B?SVhlYnNyZkVXb2JHN2pvaWx0b3RHaW9laGJIbXI3RFVkM0g3RHZxQUdyc2Ns?=
 =?utf-8?B?KytQM0o0d0FhQStBMFlhbFBYVzROT29lUXo3OTdib0tDNHdFSGFmYzRhZGxp?=
 =?utf-8?B?RGQvRnQ0Uy9TbWV6Nkg3NGZjaVBZSDljbnZFWE1xNzZ2TG1qNkpKeUdTSGda?=
 =?utf-8?B?S0xFWm54UEk0SDRLbm9Pb3RyNEV4Y002OUc0MTltZGVSTHNUbnJ3YnpPaUho?=
 =?utf-8?B?YVNLMEh6TS8yWjFZdWJ2dVFrOFUwTHVrT29iZjVaYTB1bkF2MEZaL1VQWTdW?=
 =?utf-8?B?RTdmZG1CeW42MDZzempHQVFTdlBQYy9Td2VGSlZDWk1VRXRGMTFnR2REclQw?=
 =?utf-8?B?ZGV4Y1ZEb2loNlJ0UFZ3NnRhMW5jK1ZUZkxubUlSVlByR0t6ZW9yYVJlZ3hW?=
 =?utf-8?B?aENWaTNaV0tQYXJOMHM0K2N4QnppN2lPT3U2WlBITGt6YlJsUmVINWYvUjcy?=
 =?utf-8?B?UG95K2dnZ2RzVlYvUDBiVHd4YlpYZ08zbGFadmdhUnpYUDhmNjlRNjNuVW5Y?=
 =?utf-8?B?N1ROQ1pESGVSZzQvSEZwTTMvSk9La1VBa0FOV2dpMVpvb0JQOWdxZTlXZkZa?=
 =?utf-8?B?K2pJc095VVF2ek9JeVFLTFdTbmVFT0MxeGlRQ2Q0d2YrZEliZml2bVJ3ZkQ1?=
 =?utf-8?B?c1BXRXgyWm5NK1l3MGZ4bnRZZGxpUU5wTUhYUFA4KzlPR1QxTVZpeHBJV294?=
 =?utf-8?B?M1BCM2k0MmdtRDQyWmptSEJBdVZjckNrVkJjM1AvWWZVYUU3akxZcEJFWXVs?=
 =?utf-8?B?NkIzWSs4WFQ2L3g1ZGJjdGswVlJLTi9ERlZ5YUV4cyt0UVFkam5qRTROUU1m?=
 =?utf-8?B?RzhqS1E2MnBNK2Q1M0JMMU03NDNQZEt3OEFqVTBuaDRZZ0tSUXhiZWU5cit2?=
 =?utf-8?B?elRIeHNjT3VGQzRJY1BReXFGQW9KTzcyKzF2T0NkR1g0WHFtZ2xGZXFGMW9k?=
 =?utf-8?B?VzZYckVjNE02YUJUSkdzODlQZ3VNb1BXdCttZGJZSllnKzA5MzBWZkx3eFoz?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CAEF3F61EE143408C52CAFBBE1D2319@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6e6274-71d5-4ade-ba6c-08dbd3e7942a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 16:46:17.9546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxQvzVgxPRQ+332LHbkNQM7pSmhqNfJBdhgk7fyk2zc96FzEkNwHAthPtH/dqedXWB9m7xR4xoPbQ1yHmZSXpzQEfBerJRWDfA21BvdW0BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6466
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

T24gV2VkLCAyMDIzLTEwLTE4IGF0IDE4OjQyICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjMtMTAtMTcgMjE6MjUsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IE9uIFREWCBp
dCBpcyBwb3NzaWJsZSBmb3IgdGhlIHVudHJ1c3RlZCBob3N0IHRvIGNhdXNlDQo+ID4gc2V0X21l
bW9yeV9lbmNyeXB0ZWQoKSBvciBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHRvIGZhaWwgc3VjaCB0
aGF0DQo+ID4gYW4NCj4gPiBlcnJvciBpcyByZXR1cm5lZCBhbmQgdGhlIHJlc3VsdGluZyBtZW1v
cnkgaXMgc2hhcmVkLiBDYWxsZXJzIG5lZWQNCj4gPiB0byB0YWtlDQo+ID4gY2FyZSB0byBoYW5k
bGUgdGhlc2UgZXJyb3JzIHRvIGF2b2lkIHJldHVybmluZyBkZWNyeXB0ZWQgKHNoYXJlZCkNCj4g
PiBtZW1vcnkgdG8NCj4gPiB0aGUgcGFnZSBhbGxvY2F0b3IsIHdoaWNoIGNvdWxkIGxlYWQgdG8g
ZnVuY3Rpb25hbCBvciBzZWN1cml0eQ0KPiA+IGlzc3Vlcy4NCj4gPiANCj4gPiBETUEgY291bGQg
ZnJlZSBkZWNyeXB0ZWQvc2hhcmVkIHBhZ2VzIGlmIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkNCj4g
PiBmYWlscy4NCj4gPiBVc2UgdGhlIHJlY2VudGx5IGFkZGVkIGZyZWVfZGVjcnlwdGVkX3BhZ2Vz
KCkgdG8gYXZvaWQgdGhpcy4NCj4gPiANCj4gPiBTZXZlcmFsIHBhdGhzIGFsc28gcmVzdWx0IGlu
IHByb3BlciBlbmNyeXB0ZWQgcGFnZXMgYmVpbmcgZnJlZWQNCj4gPiB0aHJvdWdoDQo+ID4gdGhl
IHNhbWUgZnJlZWluZyBmdW5jdGlvbi4gUmVseSBvbiBmcmVlX2RlY3J5cHRlZF9wYWdlcygpIHRv
IG5vdA0KPiA+IGxlYWsgdGhlDQo+ID4gbWVtb3J5IGluIHRoZXNlIGNhc2VzLg0KPiANCj4gSWYg
c29tZXRoaW5nJ3MgbmVlZGVkIGluIHRoZSBmYWxsYmFjayBwYXRoIGhlcmUsIHdoYXQgYWJvdXQg
dGhlIA0KPiBjbWFfcmVsZWFzZSgpIHBhdGhzPw0KDQpZb3UgbWVhbiBpbnNpZGUgY21hX3JlbGVh
c2UoKS4gSWYgc28sIHVuZm9ydHVuYXRlbHkgSSB0aGluayBpdCB3b24ndA0KZml0IGdyZWF0IGJl
Y2F1c2UgdGhlcmUgYXJlIGNhbGxlcnMgdGhhdCBhcmUgbmV2ZXIgZGVhbGluZyB3aXRoIHNoYXJl
ZA0KbWVtb3J5IChodWdlIHRsYikuIFRoZSByZXNldC10by1wcml2YXRlIG9wZXJhdGlvbiBkb2Vz
IGV4dHJhIHdvcmsgdGhhdA0Kd291bGQgYmUgbmljZSB0byBhdm9pZCB3aGVuIHBvc3NpYmxlLg0K
DQpUaGUgY2FzZXMgSSB0aG91Z2h0IGV4aGliaXRlZCB0aGUgaXNzdWUgd2VyZSB0aGUgdHdvIGNh
bGxzIHNpdGVzIG9mDQpkbWFfc2V0X2RlY3J5cHRlZCgpLiBQbGF5aW5nIGFyb3VuZCB3aXRoIGl0
LCBJIHdhcyB0aGlua2luZyBpdCBtaWdodCBiZQ0KZWFzaWVyIHRvIGp1c3QgZml4IHRob3NlIHRv
IG9wZW4gY29kZSBsZWFraW5nIHRoZSBwYWdlcyBvbg0KZG1hX3NldF9kZWNyeXB0ZWQoKSBlcnJv
ci4gSW4gd2hpY2ggY2FzZSBpdCB3b24ndCBoYXZlIHRoZSByZS1lbmNyeXB0DQpwcm9ibGVtLg0K
DQpJdCBtYWtlJ3MgaXQgbGVzcyBmb29sIHByb29mLCBidXQgbW9yZSBlZmZpY2llbnQuIEFuZA0K
ZnJlZV9kZWNyeXB0ZWRfcGFnZXMoKSBkb2Vzbid0IGZpdCBncmVhdCBhbnl3YXksIGFzIHBvaW50
ZWQgb3V0IGJ5DQpDaHJpc3RvcGguDQo=
