Return-Path: <linux-kernel+bounces-148772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988668A872F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54177281BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76739147C89;
	Wed, 17 Apr 2024 15:13:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42A146D56;
	Wed, 17 Apr 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366837; cv=none; b=YIQ4xguanxxX068B0bd4bJnMdeZ3UrzkEcuz9tEV9wgNAtCk4OD77V2sCDffMvl3akRABbQ7tZlGT79axQjebR22heKD55NEBhcNaSJyT1q12rPfmMPR3zy/xANJ64sv6uQ7QKZgP+HuV03qN7Y+yMV5r1OGkyZYvg/Fw1kxHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366837; c=relaxed/simple;
	bh=nJjGtUnwDKua1iw4lX8BX7gh9RSzpuswBQi+p9c105c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mtf3zhyPWtOSybdy6G44wSEAIdPwbWv3sjCwhYuAzS8iRZXrbp2Nr7J4V89F1+D26Wcs4il5LYbnRSWF3JisW2+afHFHla9xWjtHz6XlgnHK7WPGK3LEPJO+Oa+ZF0Ek+NVwuC45jL2V6eFpGQgFZfcgVYnEU85iaDk8zEp9o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKPWr6YZKz6H6yd;
	Wed, 17 Apr 2024 23:11:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D59E1406AC;
	Wed, 17 Apr 2024 23:13:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:13:52 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 16:13:52 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>, "jonathanh@nvidia.com"
	<jonathanh@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>
Subject: RE: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Thread-Topic: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Thread-Index: AQHajVTpda5PtrGZ80+YonTPgO6cRrFphU4AgAKXr6CAADwLgIAAP9dA
Date: Wed, 17 Apr 2024 15:13:52 +0000
Message-ID: <85e7752fed7444ea8611dbc5be288044@huawei.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <20240415171426.GF3637727@nvidia.com>
 <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
 <20240417122445.GO3637727@nvidia.com>
In-Reply-To: <20240417122445.GO3637727@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 17, 2024 1:25 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>; will@kernel.org;
> robin.murphy@arm.com; joro@8bytes.org; thierry.reding@gmail.com;
> vdumpa@nvidia.com; jonathanh@nvidia.com; linux-kernel@vger.kernel.org;
> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> tegra@vger.kernel.org; Jerry Snitselaar <jsnitsel@redhat.com>
> Subject: Re: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
>=20
> On Wed, Apr 17, 2024 at 08:01:10AM +0000, Shameerali Kolothum Thodi wrote=
:
> > We do have plans to revive the SMMUv3 ECMDQ series posted a while back[=
0]
> > and looking at this series, I am just wondering whether it makes sense =
to have
> > a similar one with ECMDQ as well?  I see that the NVIDIA VCMDQ has a sp=
ecial
> bit
> > to restrict the commands that can be issued from user space. If we end =
up
> assigning
> > a ECMDQ to user space, is there any potential risk in doing so?
>=20
> I think there is some risk/trouble, ECMDQ needs some enhancement
> before it can be really safe to use from less privileged software, and
> it wasn't designed to have an isolated doorbell page either.
>=20
> > Not clear to me what are the major concerns here and maybe we can come =
up
> with
> > something to address that in kernel.
>=20
> I haven't looked deeply but my impression has been the ECMDQ is not
> workable to support virtualization. At a minimum it has no way to
> constrain the command flow to a VMID and to do VSID -> PSID
> translation.

Ok. That makes sense.

>=20
> I suggest you talk directly to ARM on this if you are interested in
> this.
>=20

Sure. Will check.

Thanks,
Shameer

