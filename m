Return-Path: <linux-kernel+bounces-136344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207D89D2E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B68D1F2316D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E67B3FD;
	Tue,  9 Apr 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZD4b5XoO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BEB77F3E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647226; cv=fail; b=E7sQtSrGsjVewNAsF5n4KIm/y8sH/cwqlWYBxOM0NLow+16909FJWMHtxj7urO+Bq82ouGKZm3xQO28+7CfA1NxQKVHkj/gCk5r6hRYClWmcCQna1i5Y5SJ231LGSKBZ7YVTZRe2fkNTDrke8yTC/29FOLe7F2IqorAVSiFuWs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647226; c=relaxed/simple;
	bh=FpTzuqwtFX3BdhsGf6fTdAPY49ZkbexZkeS5zwNi/ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qf5p9XQJLYTEz55NfADaUMInffSeKAH75S6SdHkxax1GevItA7J5igkBV5KTg4C3QEP88WhaqVY+9kFOurBLkEFS294pSI7go9j4jFwdnC8yotxJpj+75gywGTYEAAne/krZ0iPH8Ir5VAJpKfgi8jO98LDSnQejl4pZ9qgdMxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZD4b5XoO; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712647224; x=1744183224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FpTzuqwtFX3BdhsGf6fTdAPY49ZkbexZkeS5zwNi/ds=;
  b=ZD4b5XoON/cC/Y8sfZJYfY0x7pb7RZXtS3DDijBxMvjfV1rmuIRy8xjV
   MqFGVZzcH8EsGIIHFHlfqQDGJlg1hsLIAW4wY13E8wjfrm+bhxWRHIB7X
   qq7871XXeVt1ZvqXitruc8pK2j3Wb1LdKPKuSQG6yd8PrMoFa9kymMD/4
   PIqoDsZfobhk3p6vqL6MaGRMoEQHv5A1O78K44GzHuwl+trp5Cb2R8DSw
   z6JA8+v1PRVVwtArwO9hHZa1NBaotHQ2N//fbGcJiuQaL5oUjf5Xemx2o
   AO/Tu7+kYq4wwdnYqVezz3ylCLFA7BtNwg4detqvDNK9xqOl3oiR/f74y
   w==;
X-CSE-ConnectionGUID: m+Ftnds9TQ+vD8jhLfk8Vw==
X-CSE-MsgGUID: d+Qr86UTSYmpY7wq+79O2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7862927"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7862927"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 00:20:23 -0700
X-CSE-ConnectionGUID: DY8Zj0mbToSZQvhfQWQlgQ==
X-CSE-MsgGUID: m93sZI+mTma0Blm+TwXOXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="43333746"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 00:20:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 00:20:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 00:20:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 00:20:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAguGMr3g4dCpvEylJ5SzijW8EGYehK6ZXZBF8xlPIW8M9sEo5gU91B77rnFi6c1JWFAfS7h+bhGFagXhmgSsGyzcv5GSP2pkP9+C6CClyOsO5arwXNuy4SIIVO8kTlHA7raWV9210ciyS/94JH9ArIXDqO56PGqDTwwNZvruSdG3hTUBGGr/KeegeztzlZHacGpiqFSDnW0Ilm8gJlIdBKpur/g9RVD3eFlFm6HDWHGaNM44WjsnhLvY0RHbHC5kHL8DrxPCuPpTemnafqxvaosDAaApnrz1yrui1vdoj49bjwxW8c/HX6kZ/qC35frjmZTn0MkdJCt2kGTr9J/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amd27cm1A9iYJJHs73uSMBoj+7lrmXVDwL3DzkPUnxE=;
 b=XMcRVTtP3SJAYOSCkjdtvTzTD+FLl6FrXcGyPqq4Dzl8T9A6U/scu6YGkxUhXj5FaQEXflNP+2cnPe5qIZIWvyy373T++QWfBUkuGw40Shoa7Bp+hkrB3o3Bi5AKrxnAfEzVjWbWQLwKMrbAq2HoWUMU7MD1/qssyA9S+CVqJxJYfAg+IE+0o/8X6mp21hd+KNWca39K987WWK5tW4BWK62lPYWcf1WHCSpk+FYt9g9j564DdVXIVvu1VYH59qCuP7N8J/czJ6ewwLzCteM1ase9edMslkKtPIcLV8lqILglosSaswij2lUY78TVw1KXc93tciZPjyl15jjqFJzpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 07:20:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 07:20:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Avoid unnecessary device TLB flush in map
 path
Thread-Topic: [PATCH 1/2] iommu/vt-d: Avoid unnecessary device TLB flush in
 map path
Thread-Index: AQHaiPn/q4hRm40VZ0qfWlbJiHpMrrFfiK5A
Date: Tue, 9 Apr 2024 07:20:20 +0000
Message-ID: <BN9PR11MB5276DD9779553C20EF16BB4B8C072@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240407144232.190355-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6608:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7c9SxcKpYG8vBSjdyi58/HMp5MN9OXe6ll27sYDX+KTDwzqHpMPtUganY751BLvp6OuTvQOkCAgRAHGfI873DQ92eQuUKGCyO/NAmmFdR4GBd6vp9NxHQMdOMtmDNTWGA08ag9MAv7g+3D5hHWsXe7E6Nf3XFki3htAVEoo0KYCzlRo8EOpm5E3xMVW3xhLgD7h0ei0WYsgfRz4h3V6mPUqXlnIfWeQFEt8gL7p3Wu/AF7QBeAsYLWQ0o3/MsxL4NWBAQnZVodEiYpZHBeW7AL/JOtJ9TKq3GJpz06amuF4IW4m8pW4p5+9Baqlc7qN28cdiXsRpMspSjJXeDUJVa8pKiSElmkl8iwR53GucT9fggFU35oaIV1UtT/naIBUW5AbyONQyDtEKvDLKLNp2bKrpYyHnRRIireUBxTT3IY/C+7xMVLhrLDS0oiu6P8X/6h3M+zz7/BS3QJAbjzveOwO5kEoPSMa3/vKkhcYWFPyKlVBr4UY4biU9VZYz2cpUrd5O6xyBCpyoyP0I58b8SK3/D6hufsjrSiAwvcShAYi5SjB6I0TB3VR4BM/8JslxYOXlhO8Z6oNJ7JfmmRAvnnQbHbVmz3pMf1aJgjwtS6H8lIElxVyEdkm7hvy/eetwpDhykYvWpJNgSD6VwWFw3+RPhYxGMov1emFYNT0yeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mBmoU52yo2CajSr/bBV/3eUX1zTsbAgrRWCJSwnndAxTn25XrHI5BFeapAM?=
 =?us-ascii?Q?f9vB25ziYnfrTt1U+SDjdsMzK5XZSIM+5/pIb6zFnOSXIw9XCi3VYlPYf0Y3?=
 =?us-ascii?Q?N44Tx7JzhhCuX1hK+xzzEU5797kHe6vH8kgW7AxdazDFjOfSyU0ZhaD7w1Tf?=
 =?us-ascii?Q?Q1HV/K66kmyscsM2pCpFIPvtkex+aMKYpit2Mo06pK/HYYXct/ihAxWaf+OW?=
 =?us-ascii?Q?d2+uds3cpAUHHzjLOXlcvBxLwx4ZMulTtNfSMZV/sROJGU3uGfD81BW7K7Ms?=
 =?us-ascii?Q?vVj0MOv5UB5/ZGptynmtgMD7M06tJBhyF3tb3wGO5dhTp+FlBUpQjl47hY21?=
 =?us-ascii?Q?s86N73Bg8h62A0WMwtXJOS3i45QcZMtr/YCOwF+sS/1wjGhrrCMJ9xUBemGw?=
 =?us-ascii?Q?2VlS+kan/nx1JauRHkc8uyn/fb9KtZ20PX7Vkjmkh+oZacdBeicjcgak2XmT?=
 =?us-ascii?Q?oVr8qggmldt9ZBGi8OcuItDM52oG2H5YQXnxUZXkLrtazsGfXqSk5UXH3i4u?=
 =?us-ascii?Q?jsmZ5FIUGPC0Cs7oFnvomLzHLe2qGTHg/2kYLJqEvC2AxOHeN1OZ+vv6T0zz?=
 =?us-ascii?Q?x44QpSdVJJI8fjIO2MvTvZVn4ePCEtUeRPP/Hh/pn0P0PQHy2tMKjFfaQQdC?=
 =?us-ascii?Q?QhMoti33SM+CL5JQhrd9arALfy7WcPETQPzlEalrKM5RihjLH27VU1f4p+gX?=
 =?us-ascii?Q?qdSJfbzdSN1ckf/DkJsFWsolE9y4M0brp2BtdlsmBwRLWCkupqNvebLZ+jfA?=
 =?us-ascii?Q?WIVxPqH3XweMsRWai5S5abUVjHQpi5wzcC1EaxrjWnWi8pn53hbUc3ScL24S?=
 =?us-ascii?Q?uS+pn6AM1HVDyMacotXYHaHcX4Cbfx9BIrtVvGjvpz5CfQZtvotcYcRAHoLC?=
 =?us-ascii?Q?CFuVEEg0/HyUHqpJQWvea+jnoNSl+l5EZS71lyeKUs/KpdCXT/ncLkJphwCM?=
 =?us-ascii?Q?ztM1bV1wu31BPIH5qo33VlCJJFz1eHpq6SUrxMc3hAnG/PSTvILxZr+vIs5G?=
 =?us-ascii?Q?R9UIf1Ia9K9VoaQKx5fC5HOa3kiaZ/YpPqRiJ1XcgXg2twtJGdNgcLG+nc+q?=
 =?us-ascii?Q?1INjkQoxcsJDfKZmmnhnh5Z+HxjnQb06ys9eUBo/Y38+CeFei6ZT8EfkstIF?=
 =?us-ascii?Q?cxxquVMAznvQttr/4rR8OxclAepUEuHXiAuZdgPN7vv57PnBSIXfXxRvQim9?=
 =?us-ascii?Q?4N4+SD+wbJ1GB87zZrAiNTRh9KQOLkwOVMo3P/8QKxM+jC7EJbxrm+I21Rvm?=
 =?us-ascii?Q?IDx7qvEx23ec7cpItO2T9GK6sggns0CoomC4zucKDctv33B9LKd/+hd15EL2?=
 =?us-ascii?Q?/wSUJ8VDwnlmw9Mh7d9NBJjUs045tPUnm4mw5H/FXdEvHuu6OOUf3a1O28CE?=
 =?us-ascii?Q?5FSGjm8YGndGgtYEahCgCAe7GAXkfQTxf52cb3soeORRTozZJQyDPG/ZMW7V?=
 =?us-ascii?Q?hAocmUsH/irJ4XSDiu+BOYcKeCR822yQEpGw4WhhE+ORsjy0NH/mQ3DrL0kt?=
 =?us-ascii?Q?MY2edBjPhzV1rV+0+Wm/rYMle9hBan8ddnz+Zbz1qVANCPouHQ2sTUrd9MSw?=
 =?us-ascii?Q?yOJzxcIAVOdc90DyZR1qPmRPsAMgaplu0dgY8icT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2fcdb-f3ca-47fd-98cd-08dc586583c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 07:20:20.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh2ogDEsxRJSyp+pO0yYjK8FkN2lxHPZbpVFgKWcyl5f7rIkDH+nbzvn6KwmCo34Snl11Ak4PUCNQ8uOfLFkxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 7, 2024 10:43 PM
>=20
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in the caching mode.
> This is inefficient and causes performance overhead.

s/inefficient/wrong/

'inefficient' means that it's a right thing to do but just inefficient comp=
ared
to other options. But here by definition it's not required and caching mode
is irrelevant in the context of devtlb.

>=20
> Make device TLB invalidation behavior consistent between batched mode
> unmapping and strict mode unmapping. Device TLB invalidation should only

I don't quite understand the connection to batch vs. strict.

> be requested in the unmap path if the IOMMU is not in caching mode.

I'll remove the part about caching mode as it's irrelevant.

>=20
> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for
> domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc..493b6a600394 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct
> intel_iommu *iommu,
>  	else
>  		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>=20
> -	/*
> -	 * In caching mode, changes of pages from non-present to present
> require
> -	 * flush. However, device IOTLB doesn't need to be flushed in this
> case.
> -	 */
> -	if (!cap_caching_mode(iommu->cap) || !map)
> +	if (!cap_caching_mode(iommu->cap) && !map)
>  		iommu_flush_dev_iotlb(domain, addr, mask);

It's a bit strange to do this half-baked way and then rely on next patch
to do the right thing. It temporarily removes all devtlb invalidations
for caching mode here and then add them back for unmap in next patch.

caching mode has nothing to do with devtlb. So I'd just do:

	if (!map)
		iommu_flush_dev_iotlb(domain, addr, mask);



