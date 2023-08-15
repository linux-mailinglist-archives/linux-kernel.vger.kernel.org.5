Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26F77C69E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjHOEGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjHOED2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:03:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110972122
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692072064; x=1723608064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X7R+xsKPIy2ba1t1rPtDGi2Qiu3K+tVaRKYqm+0k4Mg=;
  b=oBsL7VGm/q7h9YssKq484Q4qmJomYj1bAMEHYYGMYFkiIFFBBppiHR+r
   SKMMifri+DVN1EusezlCd1xdvuhFm7FSQ21MvmtCNHFndJ+KBhprbP+Lz
   eiIToiqLW52wd5eAGRFIM/vITdbXkkXa0F8VwnJb+aiR9/6o+vfFmACkF
   xIgHDyd9BrC31iMvHRVSb3JyenhMfJKNGysE/2zK273onDqcVAa/OwL9X
   Cl3FfXnKp1aPZUEbA97l6FMxOoGehSVuA1n526pcILbzbCv4cNcHv69NM
   Hm83T0kPDtdf9nWCiY97fFtzw7mh7cNpODCWWG0aFrjZxIF41H+1bGg3o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438536267"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438536267"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 21:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="799066659"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="799066659"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 21:01:01 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 21:01:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 21:01:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 21:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4IeGvoEhFb/1sEbwlFdc2XTo3IZgldde+ADZPG1e9m6LZsh808vqk1HSn9HE+voXGysC8gp3RtuxCI9B62wdEk9AZtzUnJYyWGS9TG7ATPhW6kWc0p30x72ApuPcBCjnieVE9wHB3AyjbtO9K9DUrSxFewMwFCuaFfux2PpOnqBWdNj4AVSniod+/7+YT01thyleB65JX9GSIEWhK3+PeZLZnd/Nt97tSPAi2IGaGvNCobOCUs/L+M/V3Bmim2yqhZJ+gIXieU0y9AEr0xKOu2/K86Ag4cXOWPP+sUsDec9rZHxWzVO8gqOOePmfPKkrpLO50+r2artjgztcjM5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7R+xsKPIy2ba1t1rPtDGi2Qiu3K+tVaRKYqm+0k4Mg=;
 b=DGnPKsS01JE8FaxCbdL8Z9uUpu6i7NH6BNdmNNi6G6U4ORNJJYucrmqk/BDKN6IE4af24188k/fXBnFnGlWVw1IbRgeTh82iyBJxnjBg/Ir38XVcsIaceyNMNHzLfuT2x9kTcbOhe2NxJ4oLjZOTYSx/4POXpdsi3+Led6FmtCjE4UFHGiGdGsPstL0pycpjwrMkj+tm/NFMZX3m0g0lKVhbyyrMEPzATLTvD03ZTtoB/NM1ZB3c0ELB6zK1lryYKbR5jp1uYcq32MA3Vs+r+/I++bg4ucjuu9P2+6GdhAFH6y0VOiglQzsadlgv1kOXgANXukbG4gqlJTM3AF1HxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 04:00:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 04:00:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jie Ji <jijie.ji@linux.alibaba.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>,
        "kaijieguo@linux.alibaba.com" <kaijieguo@linux.alibaba.com>,
        "daishengdong@yeah.net" <daishengdong@yeah.net>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Thread-Topic: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Thread-Index: AQHZzqiOto4tPD4iOUyuKbSpwIowhK/qnL4AgAAQEMCAAAzVAA==
Date:   Tue, 15 Aug 2023 04:00:58 +0000
Message-ID: <BN9PR11MB5276D897431C7E1399EFFF338C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
 <4b356a28-5637-d492-9540-d7f5e6c617ec@linux.intel.com>
 <BN9PR11MB527619D76C1ACFA5B85E2DEB8C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527619D76C1ACFA5B85E2DEB8C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7116:EE_
x-ms-office365-filtering-correlation-id: 6ab368b6-7905-4da6-8dac-08db9d443bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5k+A368Naxyw3uk4Jz226OZoTebtB71gvxUZ2y8/7zP4XkH5t9Ksnxlep0VSWnptmLVPe+bo3zhuapNvGM5ek7y0vrlN0zjrWmhX9CDF9W7t6UfJcVrGbMYemsnZ/zUSMJC5gi9YzsIhvd+EITAJvFCHakZu7+doYdDwKUXZvDwCLOBL8kCbbtLMqN9cs+dHMGLHRA33oABHDtszIcGAJ/BhzpmsYGbG8bIexfIMYOacxU/eWWLQgohuOaR+Z7Bfw+vJK/1W9nNZevlFOnmkvA5mzwoQNtV4r7I6aiid1thFBUWjNMWs8NaicuW1y3iPEvqE3dCstVTy01i79WEiwrJp2QrJkr5Xxp0rN5AWm0sndK6Tx0fAiBtPVq6hIZY9fSm2tfebCMQLsBKWYIUHQ9RwEeYaHznpKinz4LMu/nrTqXR/w5+9eqn3YbCYzDkIAFC8UkJoVbuI2FqVqozm/TKggt6+qSab0woBikBeky0ESC3ibBuSpYI3jfVVcDDs5wncrHI6irZAeX2DH8tiWf0lXv8+F9wel6G/TYBDDfJolQsejirKvUad49kfjrWpC3qVZ3YRLowps+rFpR1+PDLUO+5fn6Mk++ESg8SlTmOEHsgoHRooc9KjJdhrHEeK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(136003)(396003)(1800799006)(186006)(451199021)(2940100002)(83380400001)(53546011)(26005)(6506007)(71200400001)(54906003)(7696005)(9686003)(478600001)(38070700005)(110136005)(38100700002)(122000001)(33656002)(86362001)(82960400001)(5660300002)(66476007)(66556008)(66446008)(64756008)(316002)(76116006)(41300700001)(4326008)(66946007)(2906002)(55016003)(8936002)(52536014)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjdvV0xuNER3dHNJL2E5RHFsaHdhNEd2LzRxYitvVGs2Q2d4WGE3SUsvM2I5?=
 =?utf-8?B?UVh0SFl2VDFqaHdCNTk5b05YMmtDMk5EL05XdkR6N2tPYTIyOHlOdng0MXZR?=
 =?utf-8?B?bGkxTkpnSUJ1aGNTaEJKdjNOK0R1VXh2N29NNHMwUE5ISW1sLzB2SlVlZVJh?=
 =?utf-8?B?cVliYVNFQUhnQUpLakovazViLzErL3hUL1cxVnVZYmloQTN0VEpDZlJscWxE?=
 =?utf-8?B?RHFqQWFSSVVhc1M0WmpZSzRXU0VWQzc0MURJaHRGQjRPTnU2VlJpSXlmK2pC?=
 =?utf-8?B?a3YvQXdkTThCcFZPeFVSWWhGeEZCZjZ1Z2xQT0xKU1gzcW91cm9KTWs0N3gw?=
 =?utf-8?B?RmJtVVh6ZmU0UktzYWlDSjVnYVR3WExKYngyc24vVlhacmllVEF1Sk1tcVhW?=
 =?utf-8?B?aFB2RzFYODJNWnFQQkdxZzJwdC9TRGZuMCtNR2FBcVYwUzNMcGpEZVdvRzhK?=
 =?utf-8?B?dXZxZ1hERklkVG96TUVEUTlqN2wxME1EdkVrS3VWQlNDUlB4cFZOdGZqLy9S?=
 =?utf-8?B?Y2RmV0pMZWtkOHFMZ0J5RnhHdmdTdnBnOE1lSWdPS2xlbFJRdC9JeGZsbVpE?=
 =?utf-8?B?LzI0KzdBbVZPUVE1L2xsc1dxYldma3RQdTM3dkk4RldGc2dQd0RadUNMRXNL?=
 =?utf-8?B?Y21kYzdRTzA5Y0Z4ODBEcEU3aTk3VThpT25iaGUrV3FqUlhITTI0d0pQN2hs?=
 =?utf-8?B?NGJnYU9JdXhNY1Q3MklnaHp4TDZEdkhubVBCeGNDNmxjU1JTRmNDMlM2aGlC?=
 =?utf-8?B?b3NLNnBkZkM2anhCMFVNRVo4MzFwYkp2QjVLUEdoZGorSEJKL1FFZjkwVHN0?=
 =?utf-8?B?K0ZBSXlUTVFPWVA3MS9teVQzNnBsNUdrNFpvYTlZdjFBVGdEc3JTWVNXUm52?=
 =?utf-8?B?WXM3bjhlUkNCSngrWHZFc0NtUXFOT1Mxbk5RRnV5VGw2RTBqVkJZUnB6VHkz?=
 =?utf-8?B?SjAvejgvYld0WFJKdEpRWUI5MFhXNHZKV0pDZ1RWS0hBbjZjZFRsRkdNVExo?=
 =?utf-8?B?SjRTK3cyUkZ5Y2Y4VExFOWI1dlByTTIyMEx2Z0tBQlNGQXBvaWZKYWorcVNT?=
 =?utf-8?B?OWNnSDNlTS82MDZ2b1Y5NHNqODRsb3RzVDVQRmZvWVRvZHpmU3BEUWJ0dHhs?=
 =?utf-8?B?TjRlR3MzbFdFK2ZOWE93OERMc3JPVy90dnlUNTFVcmljL2RpYlEyYWViTGFi?=
 =?utf-8?B?RFZyK24rUWQzbXBRN0ZuaW9MS2FuVEI4bVJsZlBiS1V3cFBhWHRnZDZscjBv?=
 =?utf-8?B?dUYyWlUyVXE2OE52UXpzVTJkajRyckgreXpSWDZwWW9OQXVvTU5DaGEvaE1q?=
 =?utf-8?B?UXZlMWt1a1hiaU9oRFNTU2NiNFk1NS9xNjJGTGJrNjNKWDJjWVdUK0R3U2Fz?=
 =?utf-8?B?Z2JNSytnejdHWDJhZnYxcjJDSWhlZ1BnSkZ1ZHU5anFCZ0tic3RMV0VxdG5j?=
 =?utf-8?B?YlR5UWVrVXZneXVEb0oyK0xUSVd3RmZnMC9GWENTd1FBK0s2OUM4Zzd2a05j?=
 =?utf-8?B?NzFpYk5lRm42UHlTQ3Q3OWdDek1WYkhJRDBhWWs4dkFhRFNJbTBxSUJWbUJH?=
 =?utf-8?B?dnI3VTJCYzhPdlhia2ZzNzc0TUhMNnpZZC93RnpMMVBSdTMwbm43Q2t4d0Nj?=
 =?utf-8?B?NzgrSUtmMEI4aXZMRXBSQ2x3VWU0YnBaRFdpZUw0ZzhKNFkvVFBFam03aVE2?=
 =?utf-8?B?Y21WbUVQN1BTN1hnNVlubGs3RlJFdlpVUFBqOEdaTjd4b2NpK0pBTWVFOVIy?=
 =?utf-8?B?NXk1WnAzTE0wWHZKNFAyS0dUd2F2K1JLemtzaU9Cd09UYmNRamdIM20xWStq?=
 =?utf-8?B?UE1NK0VOdUZubFUzTWVHYlhQQnNhRFBjdVE4ZDNVS3dvMkl1YnhlTXRBVlI5?=
 =?utf-8?B?WkFPNDlUeVZCRzJtenRYaEtZcTY3THlyQkQ2MGV2L3paZUdZZFl0VlFPVjhE?=
 =?utf-8?B?SDJRVkRRVXlKckZiVDRaMFdOOGxMWHNiN1NzSXNXY09lNTVwM2ZXYWVHZm9q?=
 =?utf-8?B?cmNsK0JqNGhKeVNVZlhrWk9KSThJc281a0cxSnRMMWljb3VFb0lxQ1V3WVBh?=
 =?utf-8?B?RllhOHBJOEZEM2ZWcndRK1FyMHpoWFNPaTZReEtLeU5HQUcwSndMbEpnVElK?=
 =?utf-8?Q?zkDA2fVfGHJbmCmx/SGtK07RB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab368b6-7905-4da6-8dac-08db9d443bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 04:00:58.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnoGrID32mUGpFz56y8+yps8irgpcRh2PNBX0caxLjxdyM4TG3vvQAygYMyMu+Rno+yXuO4UaG4B4A34qCHj1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
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

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTUsIDIwMjMgMTE6
MTUgQU0NCj4gDQo+ID4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4N
Cj4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTUsIDIwMjMgMTA6MDYgQU0NCj4gPg0KPiA+IFtQ
bGVhc2UgYWxsb3cgbWUgdG8gaW5jbHVkZSBLZXZpbiBhbmQgQWxleCBpbiB0aGlzIHRocmVhZC5d
DQo+ID4NCj4gPiBPbiAyMDIzLzgvMTQgMjA6MTAsIEppZSBKaSB3cm90ZToNCj4gPiA+IFdpdGgg
dGhlIGFkZGl0aW9uIG9mIElPTU1VIHN1cHBvcnQgZm9yIElPIHBhZ2UgZmF1bHQsIGl0J3Mgbm93
IHBvc3NpYmxlDQo+ID4gPiB0byB1bnBpbiB0aGUgbWVtb3J5IHdoaWNoIERNQSByZW1hcHBpbmcu
IEhvd2V2ZXIsIHRoZSBsYWNrIG9mDQo+IHN1cHBvcnQNCj4gPiA+IGZvciB1bm1hcHBpbmcgYSBz
dWJyYW5nZSBvZiB0aGUgSS9PIHBhZ2UgdGFibGUgKElPUFQpIGluIElPTU1VIGNhbg0KPiBsZWFk
DQo+ID4gPiB0byBzb21lIGlzc3Vlcy4NCj4gPg0KPiA+IElzIHRoaXMgdGhlIHJpZ2h0IGNvbnRy
YWN0IGFib3V0IGhvdyBpb21tdV9tYXAvdW5tYXAoKSBzaG91bGQgYmUgdXNlZD8NCj4gPiBJZiBJ
IHJlbWVtYmVyIGl0IGNvcnJlY3RseSwgSU9WQSByYW5nZXMgc2hvdWxkIGJlIG1hcHBlZCBpbiBw
YWlycy4gVGhhdA0KPiA+IG1lYW5zLCBpZiBhIHJhbmdlIGlzIG1hcHBlZCBieSBpb21tdV9tYXAo
KSwgdGhlIHNhbWUgcmFuZ2Ugc2hvdWxkIGJlDQo+ID4gdW5tYXBwZWQgd2l0aCBpb21tdV91bm1h
cCgpLg0KPiA+DQo+ID4gQW55IG1pc3VuZGVyc3RhbmRpbmcgb3IgYW55dGhpbmcgY2hhbmdlZD8N
Cj4gPg0KPiA+ID4NCj4gPiA+IEZvciBpbnN0YW5jZSwgYSB2aXJ0dWFsIG1hY2hpbmUgY2FuIGVz
dGFibGlzaCBJT1BUIG9mIDJNLzFHIGZvciBiZXR0ZXINCj4gPiA+IHBlcmZvcm1hbmNlLCB3aGls
ZSB0aGUgaG9zdCBzeXN0ZW0gZW5hYmxlIHN3YXAgYW5kIGF0dGVtcHRzIHRvIHN3YXANCj4gb3V0
DQo+ID4gPiBzb21lIDRLIHBhZ2VzLiBVbmZvcnR1bmF0ZWx5LCB1bm1hcCBzdWJyYW5nZSBvZiB0
aGUgbGFyZ2UtcGFnZQ0KPiBtYXBwaW5nDQo+ID4gPiB3aWxsIG1ha2UgSU9NTVUgcGFnZSB3YWxr
IHRvIGVycm9yIGxldmVsLCBhbmQgZmluYWxseSBjYXVzZSBrZXJuZWwgY3Jhc2guDQo+ID4NCj4g
PiBTb3JyeSB0aGF0IEkgY2FuJ3QgZnVsbHkgdW5kZXJzdGFuZCB0aGlzIHVzZSBjYXNlLiBBcmUg
eW91IHRhbGtpbmcgYWJvdXQNCj4gPiB0aGUgbmVzdGVkIHRyYW5zbGF0aW9uIHdoZXJlIHVzZXIg
c3BhY2VzIG1hbmFnZSB0aGVpciBvd24gSU8gcGFnZQ0KPiA+IHRhYmxlcz8gQnV0IGhvdyBjYW4g
dGhvc2UgcGFnZXMgYmVlbiBzd2FwcGVkIG91dD8NCj4gPg0KPiANCj4gSXQncyBub3QgcmVsYXRl
ZCB0byBuZXN0ZWQuIEkgdGhpbmsgdGhleSBhcmUgaW50ZXJlc3RlZCBpbiBJL08gcGFnZSBmYXVs
dCBpbg0KPiBzdGFnZS0yIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gcGluIHRoZSBndWVzdCBtZW1v
cnkuDQo+IA0KPiBCdXQgSSBkb24ndCB0aGluayB0aGlzIHBhdGNoIGFsb25nIG1ha2VzIGFueSBz
ZW5zZS4gSXQgc2hvdWxkIGJlIHBhcnQgb2YNCj4gYSBiaWcgc2VyaWVzIHdoaWNoIGVuYWJsZXMg
aW9tbXVmZCB0byBzdXBwb3J0IHN0YWdlLTIgcGFnZSBmYXVsdCwgZS5nLg0KPiBpb21tdWZkIHdp
bGwgcmVnaXN0ZXIgYSBmYXVsdCBoYW5kbGVyIG9uIHN0YWdlLTIgaHdwdCB3aGljaCBmaXJzdCBj
YWxscw0KPiBoYW5kbGVfbW1fZmF1bHQoKSB0byBmaXggY3B1IHBhZ2UgdGFibGUgdGhlbiBjYWxs
cyBpb21tdV9tYXAoKSB0bw0KPiBzZXR1cCB0aGUgaW92YSBtYXBwaW5nLiBUaGVuIHVwb24gbW11
IG5vdGlmaWVyIG9uIGFueSBob3N0IG1hcHBpbmcNCj4gY2hhbmdlcyBmcm9tIG1tLCBpb21tdWZk
IGNhbGxzIGlvbW11X3VubWFwKCkgb3Igb3RoZXIgaGVscGVycyB0bw0KPiBhZGp1c3QgdGhlIGlv
dmEgbWFwcGluZyBhY2NvcmRpbmdseS4NCj4gDQo+IHRoZSBpb19wYWdldGFibGUgbWV0YWRhdGEg
d2hpY2ggdHJhY2tzIHVzZXIgcmVxdWVzdCBpcyB1bmNoYW5nZWQNCj4gaW4gdGhhdCBwcm9jZXNz
Lg0KPiANCj4gdmZpbyBkcml2ZXIgbmVlZHMgcmVwb3J0IHRvIGlvbW11ZmQgd2hldGhlciBhIGJv
dW5kIGRldmljZSBjYW4gZnVsbHkNCj4gc3VwcG9ydCBJL08gcGFnZSBmYXVsdCBmb3IgYWxsIERN
QSByZXF1ZXN0cyAoYmV5b25kIHdoYXQgUENJIFBSSSBhbGxvd3MpLg0KPiANCj4gVGhlcmUgYXJl
IGEgbG90IHRvIGRvIGJlZm9yZSB3ZSBuZWVkIHRha2UgdGltZSB0byByZXZpZXcgdGhpcyBpb21t
dQ0KPiBkcml2ZXIgc3BlY2lmaWMgY2hhbmdlLg0KDQpBbm90aGVyIG9wdGlvbiBpcyB0byBkaXJl
Y3RseSB1c2UgS1ZNIEVQVCBhcyBhIHNwZWNpYWwgaHdwdCB0eXBlIHRoZW4NCm1vc3Qgb2YgdGhl
IGlvIHBhZ2V0YWJsZSBjb21wbGV4aXR5IGZvciBwYWdpbmcgaXMgYWxyZWFkeSB0YWtlbiBjYXJl
ZCBvZiBieQ0KS1ZNIG1tdS4gaW9tbXUgZHJpdmVyIGp1c3QgbmVlZHMgdG8gcm91dGUgaW8gcGFn
ZSBmYXVsdCB0byBtbSBjb3JlDQphbmQgaGFuZGxlIGlvdGxiIGludmFsaWRhdGlvbiB1cG9uIEVQ
VCBjaGFuZ2Ugbm90aWZpY2F0aW9uIGZyb20gS1ZNLg0KDQpmcm9tIGlvbW11ZmQgcC5vLnYuIHRo
aXMgc3BlY2lhbCB0eXBlIGlzIG1hbmFnZWQgYnkgYW4gZXh0ZXJuYWwgbW9kdWxlDQpzbyBpdCBk
b2Vzbid0IHN1cHBvcnQgbWFwL3VubWFwIHZpYSBpb21tdWZkIHRoZW4gZXhpc3RpbmcgbWFwL3Vu
bWFwDQpwYXRoIG5lZWRzIG5vIGNoYW5nZS4NCg==
