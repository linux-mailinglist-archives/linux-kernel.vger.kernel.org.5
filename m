Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0218778F777
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbjIADgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:36:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694DE4C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693539408; x=1725075408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9+ovaTwU+XtUB2jeJ51SvY5PrBztaej6w3TAFHSmvA=;
  b=cyzySN87m3FnftvIZXcAgW9CItc+4azHp+DXLiK8sTmGnSncqu9n57hB
   LekoF9+uBK1m3g7azBGwj3/iaGDYf4mioT+xccN/ZMU1jRF/vZ/6nrTcA
   k3EE7pJL9RtxR+w1c9pHBt3hC3V2OOegbHdNXunlwp4Kd+l0TF1b3WetT
   QXbpdZ7n9sYxQY96Ven/Ls+cptylB5nVLtaVdDnQyhEq55EXkWnH8YkMk
   tS0fT+K9etdYbnUpsKB06Ljp0UKQx+9ftSCCKMxIW340yBz9wi9Pqa89F
   PCLLdnuwmMTsnFEgAqngo7gTLc1XCMP1dm4y/ofDqPoLo2is6nEcdU99h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="378856190"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="378856190"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733403377"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="733403377"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 20:36:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 20:36:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 20:36:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 20:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axyumBbMhvGsmMj9XVHWC4xo+MrVUdJDvVpjH2amcMNVoGy6PqSVyDQSU4h5OaQ18qaAqZYflWdGXqrLYsd2P0aad416tlmFZOsqFW7Hq6EqS9EmZhOOiVnAUhP1I4WVWTl3zAJCh11HdDSdIuj7yRQCzG8Sl5seG5Vek05lQId22wkDOBuqZDSHxPO+tfno7G4xCqJ03O+SB+ouckzK7Kbqm3wih4NCDhrgfSN8jLV4Edb77/0d6GWPZf6FbaKj9z3P1aFXclaZKthVEVmlWnTNYI02NbSeclBTHb0nELbKFBabR7HoMTmR6YQLWOXOmpZMMMQ1k4dGlKBKsFLsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9+ovaTwU+XtUB2jeJ51SvY5PrBztaej6w3TAFHSmvA=;
 b=OUHM5xwH2VpbqiPvJwvh3ku3OSNiMPe1t07LO5ZwgGy+pZ5cgePHA/jOMWjzosg7lAI6TCH2J29hCkHksoZqXpubjT9mdfi1bT7yQPPEF4w3uWfh5PAo6gmX8t2SGWD1ZGV43px0efyqXKMUjMa+apa5svuljUrtIGZrJzN59XNcRmNIy/gEUpqbZU83202BzWpVeoK6FUWdQjDLyBrNPEn5fvyrGV3MfCGzGh/ZGn7a5n7npDAugzplVISAhkQpFPhfYTH12GagmfaCEUMj/1zce6UkhqnR30JURFJe9CGn5rl2vLiCQfHC68KrTShmA3K5bm82AXnsPI+uUNJlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 03:36:45 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6699.035; Fri, 1 Sep 2023
 03:36:44 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] mm: Add structure to keep sva information
Thread-Topic: [PATCH v2 3/5] mm: Add structure to keep sva information
Thread-Index: AQHZ2MK1L4EDAFnAkkKcm9CNP8QwVrADuNSAgAGev6A=
Date:   Fri, 1 Sep 2023 03:36:44 +0000
Message-ID: <MW5PR11MB58812C6D52210A9A66A79C1689E4A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-4-tina.zhang@intel.com>
 <92bceb62-b33f-2380-9229-af9634b12c95@linux.intel.com>
In-Reply-To: <92bceb62-b33f-2380-9229-af9634b12c95@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|IA1PR11MB6098:EE_
x-ms-office365-filtering-correlation-id: 22792dfe-4962-417d-5e1b-08dbaa9caa10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBStImtIDKwxmRlismIDW0zKmLdHTNE6Pn6DvFn7WAMXhRpqB516BFmGeuWpYZ9+ZW6l2v+ugnqc3xHe2MbFQls8gjkk5rbF+acUltakWAbBodCFyJtqDgdCxOXTECIg581lYMb5z43yxLjNFeq6N/P8lcVlgr7xq0OZk0zolAknr+n+FuThHxChXvuXjmRyqZeS17+vp8GiEfyB9BJHsizY3iMsP+/NWjHkSgl67soD7Iz0R/I+iLgizTVvdlNQfodoB2x2vL5TIrKkwXk6utGWH6k7Xz5fIYt//0/5HSfDNPHY8SO89i+lKZjhPYEHugbWz60XSP08l5eYKMTT/mpr4Qtn3LUcwp8hnmE/sJomhK2T37Ztp6xTp9pvy813bYGQ1LBj5JssYo1jlhoUOUiM8Wsimso+EHEcHQEDRCb1OItQpJIFisNvOTpioRfBdu4b0U7iDSYb9mXkJjKMvvjxQqARfVBORKaYb2nexZggLpkPjoHoT/xyJvQjmwhXRpEueoVQ59NtICbQhZoySJ2/SztXDkIhlDOK6g434sOJWD1JM8zcYH/tA9TDhjic6RVUMTEtxgPEE3Dn5RfVFHbjsHWPQo5elYql69bzQM/8msS8qSFrniBFHyHpWWkR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(71200400001)(7696005)(6506007)(9686003)(53546011)(478600001)(83380400001)(26005)(2906002)(64756008)(66556008)(54906003)(66446008)(66476007)(316002)(41300700001)(66946007)(76116006)(110136005)(52536014)(5660300002)(8936002)(8676002)(4326008)(55016003)(33656002)(82960400001)(86362001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjlKUE55YW5ld0czdExBODk5V0x0bDNmd1h5MTBhbHZLdi9BUFlJSVFLSWFq?=
 =?utf-8?B?RVN4dURBU3czcXBmbkY4YWtMZ2d2am5sRHBJUzlMQmJlL2MxN2JDNzAwb2Zv?=
 =?utf-8?B?R3l6SnJsK09FNGpDcEl3Zlc2czMxVUsySXF5OXVjc0FXV004K1ZrNGpSancx?=
 =?utf-8?B?akJ0bEJXSDlIOVdVNjFkU1BzaFgrMk14K0tDUkZjU3lIWTl5UGhtcE1ac0VC?=
 =?utf-8?B?M1NyS1pMenBlRGwvLzRKcng1OVdCMHRibzAxcEZPdzFjK1B4YkZ6d3QwNmUy?=
 =?utf-8?B?T0c2UHN6WkNtaVlhYXA2Sk5ycWN0cjlUcGxKeU11dk8yOFJCYURoU1UwUXpt?=
 =?utf-8?B?MVpENTdxc0xabkVpMVJvR3BITHJheTUxOGdPaGFKYlQ1a3d0bjFCaXhVbDUr?=
 =?utf-8?B?c3plZjlnTlJHVXY2NEdhTlgyYkp1ZU9iNEEybVI3bFdUMTVETHdiU1IxeVds?=
 =?utf-8?B?YmptSXVMTVR6aUFCSlVPOHNtS0lGcWdCaFc2VThHMGJUZGlpUk9JNXY1MGZW?=
 =?utf-8?B?WnFyUlFLYzNxbGdKUWJ5bExZWHEwUDFNd1pvRG1pcEh4Y1lnOGtNSW4yT0NZ?=
 =?utf-8?B?M01QRXFQMnM4TnVqaGo5RWJsd25qcE9saVd2VkZ0TXUvdE0zRWxoYm9zdlhR?=
 =?utf-8?B?ZlNBL1ppbmM1a2U3TFIrSTFaRUs1NU4vUlNKWW9TM0s2NmhrOEVFZ3FVQk1L?=
 =?utf-8?B?a1FDOWZrZCs4WTJPUTRiMGphSnNWZEpyMzRqbzN0NkRMZ2tma3p6U0Z2eGlr?=
 =?utf-8?B?SVZkRVVsVXVpNjRjVEtPelUzU0Rvb2E0UjZWc2tEbHVxYW51ZlIyaUZ3QU5P?=
 =?utf-8?B?VnViYVFmY3F1ZEhobkpwOWloNWRpb3pSNWV2cXhNcmRHL1JheERxb00vL2hP?=
 =?utf-8?B?K1dmN01nRVBoQWRPcm1aSERnNGx0aGV1Ti9QTVlxTzk5M2NPTnAyQytLMWtC?=
 =?utf-8?B?Ty9qZzZsZDdTMUxQWFNBVW9EYUVIdHJ4UTVncHFWMUZQZ29CSTErbU1TdGpr?=
 =?utf-8?B?M083bDllK3F0dWRCcEkyL0VGRmJ5YXIxTGl6T0U2VTNRL1JvNDdNbFNjakxN?=
 =?utf-8?B?a0FWTkEwbjRGK2JqMEZxOGNZZHhvbDJLSytVaEJyRTFwaHlvSnVZQ1lDcjZ2?=
 =?utf-8?B?d3ZuUHJ2cEJGZzd2WGsrdEx5NFBsUE1UVldNQXlQU1VNOCtwcjR6bFhoUzdC?=
 =?utf-8?B?OXBJdlkyNXdNWDkrOWtBS2ZKblMvb1pSeXFRL1hWUkNaTFIvV0c2SWJKSTRu?=
 =?utf-8?B?eTlYdkdvOTcyd1pNT0V1LzNpbXhUU1FtUUltZ3VIb0VMZUlQTGxHQlJaMVIx?=
 =?utf-8?B?RUhZUmZWZUNkVEtaa3E4akZlNWJaWWpwN1JITjQ0Wkp1ZjB4UHZYWnQvZmJI?=
 =?utf-8?B?WjF6Q2wwL1FFdDkzNkdpOVRYa29KWGZlekEzQnlNTm1OK2RWUmdOZk5yeGVi?=
 =?utf-8?B?R05nWmZ0SHpZNURDVHVjRXdiTnlSSStWZUYxYmt6OXl4aG9BM0ZBSWtUL0Z2?=
 =?utf-8?B?ang5bU9adzhJdmVzVy96aWdQNnNHNzF5cE55MzFWNlVHTzY1NkdWby9YTlJq?=
 =?utf-8?B?ZlFSOU9lRGxqa0dXOFNwSFZNenBkTGFLYnV3V2ZlbTE2ZW1xNHhhYXBySXU0?=
 =?utf-8?B?VlhGZk5NSm1GT3cwOFA1RnFkeXVNd3d3cjJ2a3B2NVVuRXdKOG5UTkluSmJ6?=
 =?utf-8?B?bWQ0YllKQTJRQXZJS3VWOUk1Vkc2b3F6Smc0ak5qVGhPV2dJYitNT0ZQTmVv?=
 =?utf-8?B?M29ucXV4TjVnRDU1Y2srWnhQZGhGeHo4UExSMUM4VnNua1FockdnQUhNT0gy?=
 =?utf-8?B?WW01YTlJOXdDY1liRW52cWRiSW8zOEI0UHl4aERqSlQ5dEsrRDBwVEo0bG9E?=
 =?utf-8?B?eTZVVk4vaEMzdW0vMDJJeDgyekloNFpDU2IzS1pFQ3p6VUxKSG5sNFB3Qzhz?=
 =?utf-8?B?M05KOC9YaCt5cysrS1F1NkZZQ1pJenRjSS80VUFPZGxNbmFpbVFLT0JTWmJN?=
 =?utf-8?B?bFZCay9Cd29PeUVxZ0prd0RSdTlvSEhzSDZaWlltenVwUkh4UGRSLy9jK3Vh?=
 =?utf-8?B?SXdVdFYwcGdUbHM1SzJ0Q3pySkVPSFpscEdlOWlYdnRtVlFLYUxIajFySyt4?=
 =?utf-8?Q?2s3oZeCf9TZa5YleheU/KbY2a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22792dfe-4962-417d-5e1b-08dbaa9caa10
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 03:36:44.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B56XGArtOD4DGi5aXPOWhJfL17FqhdTWSra+smN+CcLRpdnTabEN6CCrrh+VwnIje36s8tRYjGctaNfd3S5JSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6098
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

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAz
MSwgMjAyMyAxMDo0NSBBTQ0KPiBUbzogWmhhbmcsIFRpbmEgPHRpbmEuemhhbmdAaW50ZWwuY29t
PjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+Ow0KPiBUaWFuLCBLZXZpbiA8a2V2aW4u
dGlhbkBpbnRlbC5jb20+OyBNaWNoYWVsIFNoYXZpdCA8bXNoYXZpdEBnb29nbGUuY29tPg0KPiBD
YzogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy81
XSBtbTogQWRkIHN0cnVjdHVyZSB0byBrZWVwIHN2YSBpbmZvcm1hdGlvbg0KPiANCj4gT24gMjAy
My84LzI3IDE2OjQzLCBUaW5hIFpoYW5nIHdyb3RlOg0KPiA+IEludHJvZHVjZSBpb21tdV9tbV9k
YXRhIHN0cnVjdHVyZSB0byBrZWVwIHN2YSBpbmZvcm1hdGlvbiAocGFzaWQgYW5kDQo+ID4gdGhl
IHJlbGF0ZWQgc3ZhIGRvbWFpbnMpLiBBZGQgaW9tbXVfbW0gcG9pbnRlciwgcG9pbnRpbmcgdG8g
YW4NCj4gPiBpbnN0YW5jZSBvZiBpb21tdV9tbV9kYXRhIHN0cnVjdHVyZSwgdG8gbW0uDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW5hIFpoYW5nPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9pb21tdS5oICAgIHwgNSArKysrKw0KPiA+ICAgaW5j
bHVkZS9saW51eC9tbV90eXBlcy5oIHwgMiArKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykNCj4gDQo+IE5pdDoNCj4gDQo+IGlvbW11IGFsc28gaGFzIGEgcGVyLWRldmlj
ZSBwcml2YXRlIHBvaW50ZXIsIGl0J3MgZGVmaW5lZCBhcyBzdHJ1Y3QgZGV2X2lvbW11DQo+IGFu
ZCBzdG9yZWQgYXQgZGV2LT5pb21tdS4gSXMgaXQgdmFsdWFibGUgdG8gYWxpZ24gYm90aD8NCkkn
bSBub3Qgc3VyZSBpZiBJIHVuZGVyc3RhbmQgdGhlIGlkZWEgY29ycmVjdGx5LiBUaGlzIHN0cnVj
dCBkZXZfaW9tbXUgaXMgdXNlZCB0byBkZXNjcmliZSBhIGNvbGxlY3Rpb24gcGVyLWRldmljZSBJ
T01NVSBkYXRhLiBJcyB0aGUgaWRlYSBhYm91dCBtaWdyYXRpbmcgc29tZSBiaXRzIGZyb20gdGhp
cyBzdHJ1Y3QgZGV2X2lvbW11IHRvIGlvbW11X21tX2RhdGEgc3RydWN0dXJlPw0KDQpUaGFua3Ms
DQotVGluYQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0K
