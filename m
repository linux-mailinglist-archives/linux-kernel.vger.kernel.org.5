Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5075302B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjGNDvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGNDvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:51:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FE26B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689306696; x=1720842696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DlGyhd6xC93azFkqH03jmGrCk0fm6IZm7ok8hTdRH4s=;
  b=LsrdsH+fStN8saearOG2u30tRN/F+h+QB3kGtSq8YI8wBuIUGvzxIDmc
   4dIBB5iTvBvJcbNnNsI009/4C9tmwaOmfbydPE9QNoyb9KGMykoe9m7WD
   twQpFnX5ReJOzCTnwDQ5IMUx9qyIQnIs2zGwDdiQE63j1jy7vpV7ddvFt
   Id4NpiUjSMrcI5c5dckSMfOTaaZNmyLybh1U3C05gkAMuXVPU+76yZIQb
   o8O5MDq8iwZ7OcZLgctUGRQJbe4yfnLjGjyK6QtStsCt6J4eKujFkiZ4m
   o3W3bnEE7xpWvuYBkJR0SaiFonku0E2RPsptBmS9QvlwtbortxEyn8aNi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="451746699"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="451746699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 20:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757427601"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="757427601"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 20:51:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:51:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 20:51:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 20:51:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 20:51:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo/Wfi80L2weBK8xE8xwa68UEpMsC/w5ARGoBQVHk8JgNZnTkNR9QAwL/doUjhchqIAblt3I4Kcwgls8gvwtIiM2xTdJZYB/P0FwnEh7hbY9h83dPj/lgLrb8YamUYSgoTWkLvXEyK/my/BWZlxCCSXbsn9avMPefOyTe2loW1t0ktzmghONZUkJP/Pyh5AMszhz9QnxF/3LPLQORiTQY2JqJI/+Tu/VuoOVKmBXMasYeo7C4sDrpVXsvm2Brscb9bvYcgBgiyhUZMI4DO5mi+NpFmLQA0B1mXf4FJZGkCI9mbN0s9evvKYbToNEc/m7BflIDCSL7a0/Uz+HarF/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlGyhd6xC93azFkqH03jmGrCk0fm6IZm7ok8hTdRH4s=;
 b=cUVbVqd5M43MwSltthb57UIiDAvyXDEabjxacu8veWD1co8xkT6IuhSa/H9dzhmEbQEJ5WtBwvI6PM/BqzPTvla/4MOqlRPQKV7JQjtxZQuCI6F/EFPMRyOZsiPveu1ssUIaRnU/3gk0GxC09zGFU/jBUhwznlfDaEZDG9VuNe7NIYWZKMHYZQ2GaBL8mJbGYatLQVDa3r230kDyEfZZOUE9ROegBNKCVPpkxU9by1UvC5yS++tdPvVovj+Riiz8zjpx+vTdorUvTIrSV1BTNJzHO5jINJmCdux+DarHI60zcbPPdOxBQ899gfJcyMp37/w5hLRhs6VQp/ttAPduvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 03:51:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 03:51:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Thread-Topic: [PATCH v10 3/7] iommu/vt-d: Add domain_flush_pasid_iotlb()
Thread-Index: AQHZtN38FvvxAju+I0Wmp9YhFMGVA6+3U8rAgAFLTYCAAAPAYA==
Date:   Fri, 14 Jul 2023 03:51:16 +0000
Message-ID: <BN9PR11MB5276DBFD837A82AF61DF00D28C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-4-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276EC6A22D3A3C9DE1C46678C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d89755de-bb7a-ee23-f308-2500aad81120@linux.intel.com>
In-Reply-To: <d89755de-bb7a-ee23-f308-2500aad81120@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5829:EE_
x-ms-office365-filtering-correlation-id: fb8ea56f-bc86-4ebb-b95f-08db841d9354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwfECcfBk+cXJcvD/JdffBieAywyToFjhHc1q+oFwq0N1Ur/Ts+Od6C6MqSzYTGBvnN5caA8mhlHn6pkbABBAxup5teGjYQKjYUFDxTEk653brW3PjcF9uGTv2WPgJfW09ZSVl7U4Gd/++t4ijHqZTy0G+th7Oup1dgsbaK9GAisoK2Ao8BDIROvsYXAd6LvbztTOKhq7Ts5o6OeR49MMDU0MQGyiDdMER3PTBHALDCDyAC9hQmZ85QUr36ZNDdMx7xZ+yKxHMIgyPGA55ARLqFTbrSPNC5j4X3vMBWgNOLisX4U9dOsi/z3dpz1ZquuLniLWNgSxoz1aMWYlhbOFVSI4W4bBOIM/BOPdJd+lGJDaoa4cxLypNwOSmTk6+rxuPRqL97ioL6aKtxH5Hi63JNIbGpvjB3VRfXVJgxOphhhuEZuNWpI3/tkqJ3s3h3yiPazbhXtU2y2sfY14aI/dkzhuRKrd8lSj9EkQ7+AINaF8S9a8jY2Fh/1IyboCka5GwMf5jPTNKZHjUNea04LX3IE/3hHcjO2v8cYu2+0AjdyecdbRelD4IBnGD9uzgEaMmcYDWKMR4jruNr/oTDmBKmgXAG+rO5W8Mi34KOmJVISNv2a/n5caDk5jnrUmziF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(2906002)(55016003)(38100700002)(122000001)(9686003)(82960400001)(83380400001)(186003)(26005)(86362001)(53546011)(6506007)(33656002)(52536014)(5660300002)(38070700005)(8676002)(8936002)(478600001)(41300700001)(110136005)(54906003)(7696005)(71200400001)(66556008)(66946007)(76116006)(4326008)(66446008)(66476007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmNHWCsrS1Y2WHpvbG5xaWhMZG5UdWtiVDE4NXg5ejVEcnVpVHFxTGlJa2FE?=
 =?utf-8?B?b0orMkhtVzFEMlQ3cXhjYnplZldKWWdYZllIaUVOc05ZQnpQZy9vVXhVTkh2?=
 =?utf-8?B?QnhlU1JvNmJWeEJaYU83UFBoc2gzRGppbVBVL2xZak5uRzFCY1U5T1pPYTVn?=
 =?utf-8?B?L1JPakRKSTdTRlJlVjQxbUp1em9lVHVlbHVaM3VrVmw4Zng0OWlZTituc2FL?=
 =?utf-8?B?Vk96QzhOUE1Xb01SamhqTmg3UzBJOUYwZE9rVGNtNHFQUEJaMmEvZFh4cGNN?=
 =?utf-8?B?WW5Xb1J3T3FRR21iY09vT202aERtbXhneXVCYU1xd0s2NklPNlVGQkl1c1NR?=
 =?utf-8?B?SkZVN2ltdVFGZFJyVFZvMnVSOTZOSTI2MnBDdmxwWkpwM3lzT2hSVXJVM1VS?=
 =?utf-8?B?NkpRYTI4Y2k2MjdsWldrcjdtT2lIY1k2WjdNZWtCRkxySlJHZWR4aVN0WEVO?=
 =?utf-8?B?V1V2azFLMlBjY0czcTU0NzVodzdobHZTcTJRZ2pYejNKOExnTzNMZERWZXJ0?=
 =?utf-8?B?ZktPMXZ2ZDI5VWNyVXhCOFpnZDZnUUZXNlA3eHFRRGFiQ2tkTWFad3EwTmRC?=
 =?utf-8?B?ZnJkOXJQb0VPcFlmdDRZNis1a1FXblkzMVBGUXhXRlQyK3hOV21oa1I0Sytm?=
 =?utf-8?B?dFVHcVFxY1l4MFhHSE4ra0FRd3hMdnhQUGk1WVRaYXpWY3d6NElRd2xld2Vj?=
 =?utf-8?B?aUlhNmhCbEJjV25FRU5PNEkrcGJGcDUxdzZ1VWNuSUQ2V1B6dUpYV3hyYnM2?=
 =?utf-8?B?MzMyVW95b2V5OE8rdUVQWUQzVDJiUjZKWVVDYndLMzJNeTlwdm50cHRPZ3RB?=
 =?utf-8?B?TTNwQWcxd2E4QlRkN05DRExPYnd3MGUrbXFhc3VQdnFXUXljT09CaU01WG8x?=
 =?utf-8?B?WFdWeDh4enNEZTluMFBJOWhGbDJ3Z00wSlZPWXBXbzJNOXQxSHZUd1FmNklX?=
 =?utf-8?B?cTVVUk12VGloTjdobG5hb3o4b2o1aGwxM09sYTZjejBVZXJPYVZyQVVEbDV6?=
 =?utf-8?B?MjE2dnV4OVROLzR0bnFwT3dEbHFEQ0FDUlpyVW51cFZNVjIrTDh3VXJ0dDV6?=
 =?utf-8?B?aHlDblRwRVJZajF3UzhLQ3lhOXJHeFVBcmJ1T015Z3MwdHhOQUIrTmN1MW5y?=
 =?utf-8?B?cFNGK0ZYNWMrcGJiUjh6SWJIUktMd0g0ODloUUdmeEhLN2lrWEN5b1A4eUl5?=
 =?utf-8?B?aEFYSmJQL01uZDZXemY3MzcyU2NzQUdXRzJUNUpaM29FcDh0Zzk2Yjl2ZmVL?=
 =?utf-8?B?QjdKVUVNVUNFVTNhWTVDaW8vU2ZETGcyczhtc0p0M1JVRTFMcjlZWkltZ0l3?=
 =?utf-8?B?a1A1dGFQU1lUTkMvRk5HQUtCVm9pd2U2elUrUmVXdTFkMGtCWUlqVWd4cUF1?=
 =?utf-8?B?dGtTQmNHSzZia1dEdE56Ylh1MEM4N3B6ck8xUFV0dW1SQ3hDdVJxcW1RZ0w4?=
 =?utf-8?B?RGFWY2VMRFptbE9iSUVRcFNnZC9WNWFNWG5iM21NeDBQZDlLUDlUSTl0UjN6?=
 =?utf-8?B?OXFJakhZbFlxMFVCaTgxeG5HNVR0eTJ3MlQwN3d1MHZJQ1ZsSlgwL2VhOGlj?=
 =?utf-8?B?TThpS0Z5TXIrMDJwM3Z6UHo1S3JCWmI3YnJjOG5zMUc5MjVGYzBCTGRNRi9x?=
 =?utf-8?B?cStPT3ZKYmx4Smk4WFQ0d0swOStoWE5xdzljS3AycFhzbjVidm8vTEhLYUlS?=
 =?utf-8?B?WkZUUkdVY1JZVUNuRVdlOVFnU1VqUzZPRVRkOGcxZlZmNnhrL1BXaHFkdEdk?=
 =?utf-8?B?WG9jT0VYNUhBMXNGM0txL2JVNzd6eko4UmNVb0Qrc3c3VHdjdTZyU0RXWjRX?=
 =?utf-8?B?aG5UdVkyT1JjaTV1emY5MmJUdzE1Z09KbzJHV1RWTDIrT2lkZkJBa1EySmVH?=
 =?utf-8?B?UTh0ejNEdkJVUWVYTUtsNlplTlh1ajNNNjB1bklHODY2WHpIZExoVUN0eHh1?=
 =?utf-8?B?K3ovS0kvMC9YTHlndzRscW9idXU5QTFybkYvaU1FRkxJd0VOem0ybE9PWlph?=
 =?utf-8?B?R0R2d1FVcS9BQkdHMjB4VE44RDM5RkQ4ZlBWV2dsNzhJUUtQTzdabEMzSTQw?=
 =?utf-8?B?Wms1QzF0MTIwZU1KVmI4SnFjbjFzdUY5Z0xibmlYL1pXRkM2aW9hZVFGdU9M?=
 =?utf-8?Q?yTuCKZQG3LjGAx+hmtlnmySCK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ea56f-bc86-4ebb-b95f-08db841d9354
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 03:51:16.3580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Iq5fG66InkL57vwVnb9aR1BVmKl0ZtCpa4XnvtaQtVOhncHhpJLR4vZWbplCPaU0cvExBNO5GsCHsKbNkVJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTQsIDIwMjMgMTE6MzcgQU0NCj4gDQo+IE9uIDIwMjMvNy8xMyAxNTo1MiwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51
eC5pbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDEzLCAyMDIzIDEyOjM0IEFN
DQo+ID4+ICtzdGF0aWMgdm9pZCBkb21haW5fZmx1c2hfcGFzaWRfaW90bGIoc3RydWN0IGludGVs
X2lvbW11ICppb21tdSwNCj4gPj4gKwkJCQkgICAgIHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWlu
LCB1NjQgYWRkciwNCj4gPj4gKwkJCQkgICAgIHVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBib29sIGlo
KQ0KPiA+PiArew0KPiA+PiArCXUxNiBkaWQgPSBkb21haW5faWRfaW9tbXUoZG9tYWluLCBpb21t
dSk7DQo+ID4+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4gKw0KPiA+PiArCXNwaW5fbG9j
a19pcnFzYXZlKCZkb21haW4tPmxvY2ssIGZsYWdzKTsNCj4gPj4gKwlpZiAoIWxpc3RfZW1wdHko
JmRvbWFpbi0+ZGV2aWNlcykpDQo+ID4+ICsJCXFpX2ZsdXNoX3Bpb3RsYihpb21tdSwgZGlkLCBJ
T01NVV9OT19QQVNJRCwgYWRkciwNCj4gPj4gbnBhZ2VzLCBpaCk7DQo+ID4+ICsJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmZG9tYWluLT5sb2NrLCBmbGFncyk7DQo+ID4NCj4gPiBidHcgSSBnYXZl
IGEgY29tbWVudCBiZWZvcmUgdGhhdCB0aGUgY2hlY2sgb2YgbGlzdF9lbXB0eSgpIGNoYW5nZXMN
Cj4gPiB0aGUgc2VtYW50aWNzIGluc3RlYWQgb2YganVzdCBjcmVhdGluZyBhIGhlbHBlci4NCj4g
Pg0KPiA+IElmIGl0J3MgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIHBsZWFzZSBzcGxpdCBpdCBpbnRv
IGEgc2VwYXJhdGUgZml4IHBhdGNoLg0KPiANCj4gUGVyaGFwcyBtb3ZlIGl0IGludG8gcGF0Y2gg
Nj8NCj4gDQoNCkkgc3RpbGwgcHJlZmVyIHRvIHB1dHRpbmcgaXQgaW4gYSBzZXBhcmF0ZSBwYXRj
aCBzaW5jZSBpdCBjaGFuZ2VzIHRoZQ0KYmVoYXZpb3IgaW4gZXhpc3RpbmcgcGF0aC4gSXQncyBu
b3QgcmVhbGx5IGFib3V0IGRldl9wYXNpZCB3aGljaA0KcGF0Y2g2IGlzIHRyeWluZyB0byBzdXBw
b3J0Lg0K
