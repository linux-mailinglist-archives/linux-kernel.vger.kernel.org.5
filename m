Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C216C751A52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGMHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGMHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:49:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411D1B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689234597; x=1720770597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sb5QF/G5Q0IFM0mjZ5JZnsPUaYcihn51hmuHoGiIGrE=;
  b=Qq7i4NXcgysWwTzZ7dVqZwXKAnoS4/iJc8lG5IJBlVvLCkb/GpetcEPv
   BkJymljK7V28IpOVxokxzy0vz2k2gIX0/VkMRrgq+YT+6Md801S8Gd63p
   FK5OW2MADTWSvv4xiWEaW/RjJIIuOxAZTxHQxd9Vlw7Uncw27o0gDziC5
   9en2J03+FKGTV8slB/G36fihGidsj2RE5IS3YhvqfH+An/NttOjwSYKlx
   q78Q0+zkREjCXegK1dZgeY1XCcbGg3jrGWpB7I9KSqW1IJw26Di6P9jmr
   qbZM2W7gcQnOI/njn+b7MRPnrL5yDmnVf7h5tkDRuUQOjCvqKXLWeikEt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="365151551"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="365151551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 00:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="725205023"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="725205023"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 00:49:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 00:49:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 00:49:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 00:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYnX72H0F2xeZ3mAH/hW+DUP2mzJPqIWo2nLpmT4Aiy6+zg6NWMO3oi5OGKqKwjDZLaO6bhwr4p/65fiD5bl7J+FX9nFQp8lCWJUkzxrAqK9BlACPrBAbCLkUqTj57CQZVTVpWgVrwQ2WJiqhAcEqQS9aWT1Rh6B1S8Ck537DzJ+GfP5oe6ugkqVGLfWlhBxVI42ElIHHFDUhWiZHd7+vNPMZ8K7JEe+lBkCbQ9iOivIywNjm0mHSjGtvVc8+16Fh5pdG0WGgUEI3nxKmrI+Q3vybxq5DEfpautSxYpQOH/MpQXG3Y98gT4Rh3vGigBLymnBHXMKTqER6ezm85YiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+FfR/20Y55VWy2MO/1hfkEJFPILrCp7ZG92HedwQtc=;
 b=PGGhD5SqDAa0126TV7EC+EdyjVDWZQqwyWtAshB1SStmAh1fAO2t25OjD1HD1WoWzDA/uD5X0uU5hvIIvklwA0/Sj/mO7OPa9DpI/WlU3QGL1615Ra+aT3H+Pp6f/9MDUG2VuPDQ0jMap505aWjXKgHGrMpaw+pBzUKu6EsEJdZLpYxRyU2ipMZPjfu3pjRTW5n/kus+5XkMBztym0lhFtLxCbLr5qf9IrJsz5MTnQOxR/YWFu6QUhtqbT2n5vAx0dmUeGWx8UVynR5gbZ4Csu7MkoZISDxHFCoDv5X9naiYnR0OqANliI8AdgflXm9+GcPYsqTacK5ojSUmzI9abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:49:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:49:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
Thread-Topic: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
Thread-Index: AQHZtN37ZjGAjXNxukKTOXN/kBSnIq+3UoFw
Date:   Thu, 13 Jul 2023 07:49:53 +0000
Message-ID: <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5816:EE_
x-ms-office365-filtering-correlation-id: 48cd24b3-29f3-4fa2-d146-08db8375be7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH4CwvdOiTOG3ioO3+3EPTmOmdGkrDv/9sq4DHcS8Xz16N3ke1IcFHjiDlmLBMAPfMObpJIEctVAsplkgVu6wqF1NqB7NBeDFaKv/tbJSnssClVCd7EBkW7kMPusv6/lPtKVl7K8KaKlX2Nsn3WZqb+0iu53U+Ops8NLlcPe9m/cs63PVMi8VUH2ZUX7cRJWpXHbdBJUOAXHFFd84oi3MZSfrlqKbvG6c0/bIlQvK141wagHo6Q94GSSJouQjdSavUSs2Olj64hPvdesd+vOM9f3OPNXGOMYfQiE0ljKqS9jirtcRw9dbT0MWnRP36hzEsUjdPqNfhVFvtnnQiggIC1QHJQeP0O5Cr7BCutWo0mmGawfr1cPqaxyOMLeo1699C5r08TriHY526bA3M3/d1RxLkEZ2QdNi89h0C06PXaqVuX88pnNjmL7IYOpp6RTDup+PkCi2qfeIVK+KRAheGsaxWP9oLkHAtG3WsjWmj6OvCv1fzZoOlj7UszNd5spGRCEimlx4RsiB/YJExT3BnrP9Y+UTBVV6659gTX9WtyHgjH4vCb33yImHuKws7NJLFJ6JX6PX7FUfMAmvB2/q5RB/Rr5Y9qx7uGFAT0L+WILmoCf+8veKfnw5uSLetJfJYVfzIc95Pen6cifJLlD6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(7696005)(9686003)(71200400001)(33656002)(186003)(6506007)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(55016003)(26005)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(41300700001)(4744005)(2906002)(316002)(52536014)(5660300002)(8936002)(8676002)(110136005)(54906003)(478600001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Um8UwR9w63NZGaM9sP3K3ipj5H55boP55epb9CdC927Lvez1+8KF8NS0dLYr?=
 =?us-ascii?Q?gQmVxMqSix8xTR89GwBwmOFa/ClqnYTu9p7tWaFEoC5B2ENH6fzlptumqe6c?=
 =?us-ascii?Q?ZXoDX3qIjyGMetObbtpnNItdSPygnyRWZS6Sr6suFriEJwaiXEFLZI+OjsXv?=
 =?us-ascii?Q?eLfMbfN6h9H6wJcqDTNCWkQO09qW9WG6mRHhsnxib81AmhznTvqrxuQ08Jia?=
 =?us-ascii?Q?UWU+lxJ4CjOnjOG4eLRHnTdHqAFApNeeMxE50cPzwOXYTzGbcJ10oT+TtZ0f?=
 =?us-ascii?Q?L66QhrBo/yzZjMKL2kTjXvzCVqmdYs0s3+EaBeDP0L384MBeUTdYj5cJhqfG?=
 =?us-ascii?Q?GlY0cS0oaVd1omIixc2PArbyj2FA6SaM7n9nzzsl1nj8pXgk5CKzIqHhIsKc?=
 =?us-ascii?Q?qZ9eW9MaLJnUEoFyeo/zUieH63QdK0qp1fbb27O/w75R01jY2eIWkL7r1p0d?=
 =?us-ascii?Q?Jb4132wdvXU6wODCMc9CVRUR3XEmT7Z8vCggWWQOrZ+1gFWnxJm1IP1kPFrL?=
 =?us-ascii?Q?wkkCBMl7i3EIisd7LNTSrGtLjVwlg3c41yZptZWpV3G7T7iupUVow/+fa/tL?=
 =?us-ascii?Q?EBdOLy0fW8ABeY65NEmIYffu1+Pjt2YFevriB/1sYMTOkw95Z31FSsmpDAkY?=
 =?us-ascii?Q?Zq5A6ZMjhgKC5OPCfeBgDjdsS369W6ghYm6RshDt1zRgcywCyL0bh3bh6Xmh?=
 =?us-ascii?Q?TLx1lorTZETg5QymZEQUiGqBlEugBmj1Y27HStH/64cNCFzpBnAGDv/zOFBB?=
 =?us-ascii?Q?H6Tpc7UOXf7eK8Y7jVWAe5NVJxwfzPt3+ywVkxRWIdbHeBkcGpj0eAILyaCg?=
 =?us-ascii?Q?Kvd1LmSA2o/tKXu0KzaHcZA6Q2DeJtq/Ck4zkHvshcqNmVeuocJig51CvxlU?=
 =?us-ascii?Q?mhdO71w4tANxYcYxXKZVNKgMJrfVfT2wsJITU/imbE5xr7ahwh7lRzEYMWYu?=
 =?us-ascii?Q?K1DqZIPUVWB6lnDi2JV16amfYjXfpo09A9mHvHcFp+RgxcFpjUv/P2p76kQg?=
 =?us-ascii?Q?yvU/tftmKIqMgC5fvPj8Z77Kz0jvQ0ByeQ5wB6C7cdAp7pgFCDoDIZJyjXHj?=
 =?us-ascii?Q?b6lXmKv3rRcuxnApS5azNsjmofT0ftRryC3dBUbHuo5E9WvJpgSsvNCXBGza?=
 =?us-ascii?Q?XDUr4/zQZkpbFiv8BK6Gx//t69BYBWWUZ7yb77Hq6D1VbQWQQAtdPmwP7yeV?=
 =?us-ascii?Q?iRgIibT0Ip8p2n765841dAiP0iI40CpsPAtCitfMRLgchQVtfe3SMI0a2Qjc?=
 =?us-ascii?Q?K5ie3oKA4j03Q/9qqYofGpB4ipBmkzKpV4//Ezk+2O3UZK8WkPy3YHIjLVqo?=
 =?us-ascii?Q?BnjsZcRyffNrBFpY0fJ+jKCp+RIaHM2rzVW62fAWCs8K9aWH4NkN241DQwpH?=
 =?us-ascii?Q?kUfxskWdp4BtYEItB/Jcl8JdHvpzhkRIAX7jR3Cm+7T0p4o9zVO8StETDjvn?=
 =?us-ascii?Q?u/xS76CPRJsl3fJH4CNR1Nb1uRiY1e+s+fRbwcgJRxkGwP0Lf9F/iE7m2DMf?=
 =?us-ascii?Q?ajsb7OgRz9SA6ISgfyu7vWdY/ZIwlQDPvKB6xeGjuAn6Z3any7v1PTh1PLCR?=
 =?us-ascii?Q?K8Wvx8D0pfn618x4qPaQKVnz2VurJYJ/AMzc1HuY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cd24b3-29f3-4fa2-d146-08db8375be7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:49:53.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I/kVkVpm0HXcK+L/Q7Nxtsd0x+PUnkkyO6UE85XAF3xgCJjXrhO37e/OvSHJCHI2nZ5IZvv+q86EiXnCirvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, July 13, 2023 12:34 AM
>=20
> -	/* Domain type specific cleanup: */
>  	domain =3D iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> -	if (domain) {
> -		switch (domain->type) {
> -		case IOMMU_DOMAIN_SVA:
> -			intel_svm_remove_dev_pasid(dev, pasid);
> -			break;
> -		default:
> -			/* should never reach here */
> -			WARN_ON(1);
> -			break;
> -		}
> +	if (!domain)
> +		goto out_tear_down;

WARN_ON()

>  		 * large and has to be physically contiguous. So it's
>  		 * hard to be as defensive as we might like.
>  		 */
> -		intel_pasid_tear_down_entry(iommu, dev, svm->pasid,
> false);
> -		intel_svm_drain_prq(dev, svm->pasid);

after removing the 2 lines the comment above becomes stale.

> -static void intel_svm_drain_prq(struct device *dev, u32 pasid)
> +void intel_drain_pasid_prq(struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	struct dmar_domain *domain;

later we should move generic prq handling logic out of svm.c into
a new prq.c
