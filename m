Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A3758D44
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGSFkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGSFkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:40:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E61BF5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689745205; x=1721281205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UyNK47nkcM2t21KsVDuYdBg69/A2XzhsELdWWaNz1nc=;
  b=K2BhCBhA0MihPGvz/8trreNeR9T0usFue9uQFL4HlB9xVmKbtNhw25ih
   +km+/ug7jtJbSxMubPBsqQwh/FOwYs7IGvLxVbb0UO2FBaOGEYwDnIGaX
   K+umg2D269caTPTjsCgrslXBPZLUh/h3X5khB+/AjdnkdNVDf4BR4zOan
   loI8fCBG0T2XwmNNbM2Nem7mgfaUr4gteTOl9KA8+iJy8y0D+pqJ3YNT8
   OYiRH7c6Agjq/QpyN7rNa9rgqw2IqMHpWC/7Ijyy9kayVPt2KjjSRd2C5
   ZX3jqOTnXXyPUKuWknjM44SKD7osdK9flHJNwrnsmHSIav+Hy0coP6gEM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432559198"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432559198"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="759026734"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="759026734"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 22:40:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 22:40:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 22:40:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 22:40:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 22:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq9pmmmPF5kIQurneVQ9arN99q+SXvbUH1WXbgzbSjSY2wK2m0f/K4BqtkBTyzEHMt5cVrUZbMu+XLs68ECJi3Gn6LpkFaQ/UPqoLmddhwdPhPD0toquHjQDTJq7tqkaBMb2YTfQbjH2mzJBABpl03ww0kEROlMpxh9vj61t5DX0k9W0KmSMKVOjbBWPmdX4UjT6Ylbc6ACJho/lMqryTVRMbuMugO76T7kz/rWJOKnvDdGx9ED4tT6e1UZZod0C/26bxGCmOHH0WPf6Tlks4gF32POLyny7vaRiizP8k7syP/pybsD4fCZrltrelY89iitEAerc7U49BR0hP0HSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyNK47nkcM2t21KsVDuYdBg69/A2XzhsELdWWaNz1nc=;
 b=f7rPPF4SHpjBCIGa1TcNblCJcqdepil2W/bax5tQvjMtWKwfZEazl0q/pL9cMjheGcznBowi22l44eHP/Ug88XjQSY/xwYumUCfXGMHuFRkhsyhhgOyKktmo4/CPVk9HHmwA/YUPSRtYhyNHqRGgxn+wJcw5gRCcGDZckk59s8jD1EzA1+eIvUxtBgCLPVg6F6uU9ZTB1Tak/6jemtjJ6apr5EQdPD/DcvrG6fUIqXzRXvcu1Ri37tAVBawZrtZeaecBJPvRdJq7mcomCAezElW9FNTZ8hVQ1y3V4iGpK6cg8BkLRbrlZ56pZX/7zGVr8Qhx+aL0rBSKMuRp1FGrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7106.namprd11.prod.outlook.com (2603:10b6:930:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 05:39:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 05:39:57 +0000
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
Subject: RE: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Topic: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Thread-Index: AQHZtN38PCDm3MU1mUGnhonJfEjVea+3VKSQgAFJrgCAAAQ0oIAAJJ+AgAfV9bA=
Date:   Wed, 19 Jul 2023 05:39:57 +0000
Message-ID: <BN9PR11MB52765154883041A3C0343A6E8C39A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87e78302-9f69-8db1-8a0a-b40e1f29d9c6@linux.intel.com>
 <BN9PR11MB5276E0C6F1063E581F29BB978C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2a103a6d-af9f-456d-eda4-f1e15f8367b6@linux.intel.com>
In-Reply-To: <2a103a6d-af9f-456d-eda4-f1e15f8367b6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7106:EE_
x-ms-office365-filtering-correlation-id: 332f35bd-d6fb-4a06-146e-08db881a966d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFLc80Gsdu1yzn0J+TOAvskVGIUSG6+lTWtIwJqeIwcT49O/awIRWaTcXILXF5Gydmi9DG92qFIvOl5PSqIaeM6xawkGyQREmd6vQi6QkzFmglKNl5LqYepI5zkuBB+8lvB2AHfbAjzjuqAYGj/dqMQR4O9O/PgpIZAcrLX2RViBN4PreXgr2InwSRQnSj9w8Gr8GPcDzN+8NkqrkemaC9kOpLr03suI3a7UrilDSJqi+fiV+JcrQyXWo8TSoJoplnL6M69AH7O04ybe2gzesY4BQ2fZqMDUWMVnuf/XSDbSuqJ3DTnNSYyAezJKj0Tg92tJSwwiFGw59TE0+x+CpivqPju0Ec4YDAS1NG+upqiXXCAGHMhZ8jGm45AfoVJJU5uBTqId3M8bEWpJArMvOTK525ccSWP1KFzlL28rkSCGobUOf3y182dY6FmUhQjmQgHp4yvJ6kahLG22R6fWYc2V+nsRoFnUa9c6HvaI7M/zqyq/irplgdNjYn0t/Z8C2hbfdzoJ77ZLT6nKO42I/S8tEA6byUY3XniXaXoYQdy7FTNHFTGlxQOEOy0yH3rLse1AZlZyUqEJcL0mZeUwIWBN5I2dj4Um2AQ+AUPrIRQqnESpcqc35+9vBlnyreHu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(71200400001)(478600001)(7696005)(83380400001)(54906003)(110136005)(33656002)(86362001)(38070700005)(55016003)(2906002)(186003)(53546011)(76116006)(6506007)(9686003)(38100700002)(122000001)(66476007)(82960400001)(66946007)(4326008)(66556008)(66446008)(64756008)(8936002)(41300700001)(8676002)(5660300002)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnJkMHFMb2N3N01QdGJRK1U5VlBrbCt2VTNoTmdoNFl5RmRpZE5wWmVHTXB4?=
 =?utf-8?B?UVZyZG9Wd3NVQXhhSFhlemxnSFR2MnhRTUFKcW44RjIvQy9POEQrZ1hvZm9q?=
 =?utf-8?B?dzZ0Mm5LNFJxOTJkTnFRS2FaZjNBenhOVUJvWC92RTF1K1RCa1BwYWZhYUIr?=
 =?utf-8?B?NVlNQlZNKzRaa1pMMkxycHZ3d1pCRzAwQ2lTQXF6alFpdThtYXNkUERiYW96?=
 =?utf-8?B?amZhNURJOEVubEZNSjVKeFo5SlhwdWY3T3dDQTRSLzRHUnVpemZlNUUvaUY1?=
 =?utf-8?B?aUlncnFkTno4eFhyTXJxZnJaTUt5bElIUHpGWFVNdnVzVGlqSkorcjdvT1Q5?=
 =?utf-8?B?TXVJWFF1UWMrcDlqcmltVDNsUTFRQ3hlVnRORUJGcE50SDRpaEt1a0RLdVl6?=
 =?utf-8?B?ZXdwbFo3Mlk1dVhsdldSa2EwUVNjK1ZQZXVpNXFIeDN4ZE9oRFBlN3VkTWxP?=
 =?utf-8?B?WmcwYU5lSjZaeHJRUEIxNUpkSW12ME1wNnNuTWRHNUI4RnNrRnI4U1dqTVpE?=
 =?utf-8?B?QnhGN2ZWek9MekJZbEk1RlpVN2MrOTZwNTN5aGxibDFKdmwwbDFHaEZtaGly?=
 =?utf-8?B?ZUpwb25INkplclpmN01PYWloaThiZ0lJbWNya0JKZHFmUk8vVTRvVTlHaWdx?=
 =?utf-8?B?R1JmSCt1d0FZT3Q4Q3VFT3NmeU90bnVVM0wwM3RreW8xTmIrZ0xjYVJnNFhB?=
 =?utf-8?B?a0NkSUxvT29KUDZxdDE5Qks1SUlFTFBpY2FlN203YVI4cFlGb2Fpa2hxUnhZ?=
 =?utf-8?B?ODVRbTNicHdENm5ZV3lWMW9GVjBrOThleGF6aDRSaitqanVTMnF2Ym9xc0Z0?=
 =?utf-8?B?T3E1QThVODVhd01KdUNKNFFNeEhFTldWZHVtWFNpOU1SS0ROdUNhZHUvOU42?=
 =?utf-8?B?dnV5U09lOFJzWVNlSUFSaVppSXdOSDYrSG5tTzBKb3Z5RnNncG5JS1cvYWlC?=
 =?utf-8?B?TUQ2NktZL2RaUGg4aThidEZHa0lGb0pZcFdMNFhkaXBZdTRib0hsc0lHVXoz?=
 =?utf-8?B?OWh2WGhCUGtDQSt5bW9BRHBUdytZRzdFeVE5aWJIc3h4SFRyeVZvOC9XaXpD?=
 =?utf-8?B?WXp2eFRJZU9mTkNUUjhUZ1h2eXFKU1EwelRWekxCQ0NNa3IzWWpUaEs4WUx6?=
 =?utf-8?B?ajMyRDB5Ym40NmVYS2t1em1iR2p0U1dLcVptU0c0cnEyNE5HSjM0Njl3Y0Fp?=
 =?utf-8?B?VkhtRENWSWVYVE5NQVJ5WWJJNWxXR2FDWGFTYTNKNk5tRzNpNDdGRFFJdGc0?=
 =?utf-8?B?V3ZCYSt1S29RajhLcXY1bVUwcE01dWh0ZXRmeEhib09jWjJ3Z25DOEw2c1Nk?=
 =?utf-8?B?U29CODNWUHEwbFVwTnRSNDZqRzJNWnNjenorZjVBamZiQ0o4M3k2YTJwQTQz?=
 =?utf-8?B?WTREZVlXcFVuSWdhcFNaMmM4bmlydE54Z1pWd2xSUkFrVlpTT2JJUjV5T3BW?=
 =?utf-8?B?NGd1M1ZYVGkyeDhZNmJlWklZOURzUjZ1cm1Vc2dGeHJyZzI0UmRibndnc1RW?=
 =?utf-8?B?MVNXc21samJRbGs3YlJNeEdXZnNpT21DT2U2LzBuSDh3MVN6Z004V2tYanNs?=
 =?utf-8?B?Y0FvYWREeSs2cFg4UkNCbzN0MHdGcDF1RTFmcHphVUQzTjN3U2J6cVNUeUJJ?=
 =?utf-8?B?bWFrcmFhUnNOQzNoZW1rQnZZQVBIMVU3RXJqL3EyUE5HM1JCRXBYelNlY3Zy?=
 =?utf-8?B?cVJLOHhrOVhkdUEvOVJ3aWVoTkZ0YWVsbVJaM09IaE5md3FJYTcwNnB3N0VU?=
 =?utf-8?B?WFl6cXFRUXgrZHdOTHkzdnJDa0tMMzZGT1FneG9NdE1PUEo4SU1XTVpGNkgw?=
 =?utf-8?B?eFRQUFJ0elFodmJRNTlQaUJXWFRmWkRHdGJ3ZWQ0eUVKVzlEeWFyU3lGcGQr?=
 =?utf-8?B?aVo5ejkvb1lLOWdzWmJrekZ6VHJWK2JaRDNoeEVEUkNhYjlnQ3B4OUlONk5v?=
 =?utf-8?B?T0ZnaGVtWlF3UnVUa1F6TGZRUFZkNHNBTzRhOFpyb3pNcnI5bWd0Tzh5bEJi?=
 =?utf-8?B?aFBxbXdyRzlDN21Md2JVVTZFdTZ4S0tLSWwxZXNxV1k3Q2hReW1USEtmdjMx?=
 =?utf-8?B?RkhaSEY3KzdScDhyNFpnWDVhUUtPR1VSRTh6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332f35bd-d6fb-4a06-146e-08db881a966d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 05:39:57.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Efsr+4UcVlGN4x8ARGG9qT9KefMryBi9QfN/sS6yCilcEX8x/TSUad6Xd9g+QEersDR3Q2BBvxoDZ3NlnDjjyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMTQsIDIwMjMgMjowMCBQTQ0KPiANCj4gT24gMjAyMy83LzE0IDExOjUwLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBKdWx5IDE0LCAyMDIzIDExOjM0IEFNDQo+ID4+DQo+
ID4+IE9uIDIwMjMvNy8xMyAxNTo1NiwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gRnJvbTog
SmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBU
aHVyc2RheSwgSnVseSAxMywgMjAyMyAxMjozNCBBTQ0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiAt
CS8qDQo+ID4+Pj4gLQkgKiBTaG91bGQgbmV2ZXIgcmVhY2ggaGVyZSB1bnRpbCB3ZSBhZGQgc3Vw
cG9ydCBmb3IgYXR0YWNoaW5nDQo+ID4+Pj4gLQkgKiBub24tU1ZBIGRvbWFpbiB0byBhIHBhc2lk
Lg0KPiA+Pj4+IC0JICovDQo+ID4+Pj4gLQlXQVJOX09OKDEpOw0KPiA+Pj4+ICsJZG1hcl9kb21h
aW4gPSB0b19kbWFyX2RvbWFpbihkb21haW4pOw0KPiA+Pj4+ICsJc3Bpbl9sb2NrX2lycXNhdmUo
JmRtYXJfZG9tYWluLT5sb2NrLCBmbGFncyk7DQo+ID4+Pj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5
KGN1cnIsICZkbWFyX2RvbWFpbi0+ZGV2X3Bhc2lkcywgbGlua19kb21haW4pDQo+ID4+Pj4gew0K
PiA+Pj4+ICsJCWlmIChjdXJyLT5kZXYgPT0gZGV2ICYmIGN1cnItPnBhc2lkID09IHBhc2lkKSB7
DQo+ID4+Pj4gKwkJCWxpc3RfZGVsKCZjdXJyLT5saW5rX2RvbWFpbik7DQo+ID4+Pj4gKwkJCWRl
dl9wYXNpZCA9IGN1cnI7DQo+ID4+Pj4gKwkJCWJyZWFrOw0KPiA+Pj4+ICsJCX0NCj4gPj4+PiAr
CX0NCj4gPj4+PiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRtYXJfZG9tYWluLT5sb2NrLCBm
bGFncyk7DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiB3aGF0IGFib3V0IG5vIG1hdGNoaW5nIGRldl9w
YXNpZCBpcyBmaW5kPw0KPiA+Pg0KPiA+PiBrZnJlZSgpIGNhbiBoYW5kbGUgdGhpcyBncmFjZWZ1
bGx5Lg0KPiA+DQo+ID4gYnV0IHdoYXQgYWJvdXQgZG9tYWluX2RldGFjaF9pb21tdSgpPyBJcyBp
dCBjb3JyZWN0IHRvIGFkanVzdA0KPiA+IHRoZSByZWZjbnRpbmcgd2hlbiB0aGVyZSBpcyBubyBt
YXRjaGluZyBkZXZfcGFzaWQ/DQo+IA0KPiBZb3UgYXJlIHJpZ2h0Lg0KPiANCj4gTG9naWNhbGx5
LCBpZiB3ZSBnZXQgYSB2YWxpZCBkb21haW4gZm9yIGEgcGFzaWQsIHdlIHNob3VsZCBoYXZlIGEN
Cj4gZGV2X3Bhc2lkIGFsbG9jYXRlZCBmb3IgaXQuIFBlcmhhcHMsIGFkZGluZyBhIGNoZWNrIGlu
IHRoZSBjb2RlIHdpbGwNCj4gbWFrZSB0aGUgY29kZSBtb3JlIHJlYWRhYmxlPw0KPiANCg0KeWVz
DQo=
