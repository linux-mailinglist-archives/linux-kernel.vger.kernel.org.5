Return-Path: <linux-kernel+bounces-73128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07885BDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD6B1F23509
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8B6A359;
	Tue, 20 Feb 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iQqKYbty"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB56A325
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437481; cv=none; b=Sb+BynIzh6Rgpsv3bKIg7IJRpXCeGAJLKGPIjS6y7La+PN5BVar1U7zkWTQAVyHJZgW5sy9gVEjaIVVietHnJZO/E0oj6uw0IaolQI1WqoRSYNq7lLi8bWGCGX32r6Y9jcmg/GX1/TPSDgUq8vuCbB356tpqfLny2Au7BCGVmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437481; c=relaxed/simple;
	bh=SJvdo4uH0j32A067Z2YrvdwzldRIKb3RArVYhG1ZZUY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=QN2giOozWM9vc0Ou1mj9o3G1QP9osdb9qpfd3UYvUrMofZ2syeSfNCdr4yaYsCOzg/fOb7mGj8At3Qr4csb4LYmwaxEg9Nd1RHU9DDsrh1vHO5I/L3p5ZIJ9L8GdyVJTF6LBc6jx0Gy9Ph8d/+kg6s4hNKx/+Yjz0ZsAaTCMeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iQqKYbty; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240220135755euoutp026288565cff2012447e457168a7a28885~1ltUphvaF2075220752euoutp02-;
	Tue, 20 Feb 2024 13:57:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240220135755euoutp026288565cff2012447e457168a7a28885~1ltUphvaF2075220752euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708437475;
	bh=ruE1PGIAtGZZCtsW3rOhV6jKQ5CNTyPaPxRrLuwk+AA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iQqKYbtyq4fUrdiJoFCQfFmu/aR/0qbBAZPnq0eMD0rS6er2lckkSdPMw59Y0GgIc
	 hYkWjRvev9zDH4a1lnyox/vcOrEm7r8xW/+Beob6G3KUMq3Niao2SJa1HZN2l9tCTH
	 rNztDT1/xIDWWJnNiv96R54tYUW5A/PoAswahGd0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240220135755eucas1p18c09fe41ba5522f0aaf66bef7105de54~1ltUdlDYO2867528675eucas1p1o;
	Tue, 20 Feb 2024 13:57:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8E.A8.09814.3EFA4D56; Tue, 20
	Feb 2024 13:57:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442~1ltT3hP-e3082330823eucas1p2p;
	Tue, 20 Feb 2024 13:57:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240220135755eusmtrp2e7394551595e0525f9f62aefd0136f38~1ltT2v-lW0511105111eusmtrp2F;
	Tue, 20 Feb 2024 13:57:55 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-cd-65d4afe37a19
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.7B.10702.2EFA4D56; Tue, 20
	Feb 2024 13:57:54 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240220135754eusmtip2b62f0c8a0dcb092685fdfb390f2a416b~1ltTplTEn1788517885eusmtip2g;
	Tue, 20 Feb 2024 13:57:54 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC02.scsc.local
	(106.1.227.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Feb
	2024 13:57:54 +0000
Date: Tue, 20 Feb 2024 14:57:52 +0100
From: Joel Granados <j.granados@samsung.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, <iommu@lists.linux.dev>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/8] iommufd: IOPF-capable hw page table
 attach/detach/replace
Message-ID: <20240220135752.vksznb4rdj73ln6c@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="pf2tgjfb6gzecilc"
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
	CAMSVWEXC02.scsc.local (106.1.227.72)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZduznOd3H66+kGpx4KWexeeJWNotfXyws
	lh5cz2LRsPoCq8XMGScYLTpnb2C3WPp2K7vF5V1z2Cz2Pn3MZnHwwxNWi+Vn57FZtNwxtZj7
	8xqLA6/Hk4PzmDzWzFvD6LF4z0smj02rOtk87lzbw+Yx72Sgx+Qbyxk9XmyeyejR2/yOzePz
	JjmPrZ9vswRwR3HZpKTmZJalFunbJXBlrNy1kaXgpk/Fg1t1DYyP7LsYOTkkBEwklj3oYe5i
	5OIQEljBKPHk2jcmCOcLo8Srha+hnM+MEifudQE5HGAt6/7VQMSXM0r8+fqcEa5oQ98DhFm/
	WiaxgSxhEVCVWP/2NAuIzSagI3H+zR1mkEkiAuoSz74EgNQzC2xnllh3pIMVpEZYIFzif28H
	I4jNK+Ag0T/9FguELShxcuYTMJtZoEJi5u7dbCBzmAWkJZb/4wAJcwrYSRxbcZkd4jdliTmv
	dzBD2MkSLX/+gn0jIfCOU2Ld1DNMEAkXibOL3rBC2MISr45vgWqWkfi/cz5Uw2RGif3/PrBD
	OKsZJZY1foXqtpZoufIEqsNRYtHF06yQMOKTuPFWEOJQPolJ26YzQ4R5JTrahCCq1SRW33vD
	MoFReRaS12YheW0WwmsQYR2JBbs/YQprSyxb+JoZwraVWLfuPcsCRvZVjOKppcW56anFRnmp
	5XrFibnFpXnpesn5uZsYgcnz9L/jX3YwLn/1Ue8QIxMH4yFGFaDmRxtWX2CUYsnLz0tVEuFl
	Kb+SKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cBUdK7t
	wcTOWfKW0ZW/wg0t97x8pHb54gnHUz9uh9rx9ObrifPUf378i823wd/jgsvbzqnvu7TKQ1Xl
	uhQ8tl9V/1E84/zWuSkxvBuKN5Qc8/lYKpxTLTKvRSlc+t9Vdi97C7OXK+KfXI+7sFrqi9ia
	mNozj8Qjg5Zfs5h9QOLPhYrJUx9o3uRrNDZVOiL9f53ezNrKD3w6irWxE/wUGAJKOI/+fJE+
	1fONkyTj6kVnP2SYxKhqZrx7HXvQwJjVf7uHhr7LKWvXlxf3XFxQy/OzLv5dFNPttbcD6ySb
	qmTPzG1dsS/BU37LVlutX/ZnNTYzfzlRudNtuc6DmaZ57jKHtUPNNkSu7BTtmSK/fo4SS3FG
	oqEWc1FxIgCmtF8dGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7qP1l9JNbhz09pi88StbBa/vlhY
	LD24nsWiYfUFVouZM04wWnTO3sBusfTtVnaLy7vmsFnsffqYzeLghyesFsvPzmOzaLljajH3
	5zUWB16PJwfnMXmsmbeG0WPxnpdMHptWdbJ53Lm2h81j3slAj8k3ljN6vNg8k9Gjt/kdm8fn
	TXIeWz/fZgngjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
	LdK3S9DL6Dvwi7Hguk/F46utLA2MD+y7GDk4JARMJNb9q+li5OIQEljKKLH/91/2LkZOoLiM
	xMYvV1khbGGJP9e62CCKPjJKrHp0kQnCWcEosfPODLAqFgFVifVvT7OA2GwCOhLn39xhBtkg
	IqAu8exLAEiYWWA7s8S7X9EgtrBAuMT/3g5GEJtXwEGif/otsFYhgUKJCT+Ps0PEBSVOznzC
	AtFbJtE7+SUbyEhmAWmJ5f84QMKcAnYSx1ZchrpZWWLO6x3MEHayxKQ9vxgnMArPQjJpFpJJ
	sxAmQYS1JG78e8mEIawtsWzha2YI21Zi3br3LAsY2VcxiqSWFuem5xYb6RUn5haX5qXrJefn
	bmIEpo9tx35u2cG48tVHvUOMTByMhxhVgDofbVh9gVGKJS8/L1VJhJel/EqqEG9KYmVValF+
	fFFpTmrxIUZTYBhOZJYSTc4HJra8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILU
	Ipg+Jg5OqQamueJvrQ/pvbyoYibE9+mS6uX5Su5fVfzsHNana6mIbZhf6DPtoa3Gh66Nn9dO
	UPJa/eHo5q+pW+s5j6r8cpXed+/7q1tTXf4xXPt9yfSnOIc/y5OfS39GBJY8eahetu736YWM
	z+b8KnD1eSEs1vXq/qfZwU9v7F+2M/52zdlNqm8yyv8lzKgQtvlcujf4Mo/B9L1BwtOT/JkK
	dauue16qO7KxQ3tl3JT2lMd1HQdsa/oPHZm4xHoVU9X1e30tvj/NHqZvdfRusuHXK2vz6f4T
	K9rde3HPpjS3/33/rVZLrtOI26C18fabMytn77Vde6ZFLdem92eHkkj5hOcXF128s4R7e0J8
	UpqjLTefglqbjhJLcUaioRZzUXEiAL2TYXy0AwAA
X-CMS-MailID: 20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442
X-Msg-Generator: CA
X-RootMTR: 20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
	<20240122073903.24406-7-baolu.lu@linux.intel.com>
	<CGME20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442@eucas1p2.samsung.com>

--pf2tgjfb6gzecilc
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:39:01PM +0800, Lu Baolu wrote:
> The iopf-capable hw page table attach/detach/replace should use the iommu
> iopf-specific interfaces. The pointer to iommufd_device is stored in the
> private field of the attachment cookie, so that it can be easily retrieved
> in the fault handling paths. The references to iommufd_device and
> iommufd_hw_pagetable objects are held until the cookie is released, which
> happens after the hw_pagetable is detached from the device and all
> outstanding iopf's are responded to. This guarantees that both the device
> and hw_pagetable are valid before domain detachment and outstanding faults
> are handled.
>=20
> The iopf-capable hw page tables can only be attached to devices that
> support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
> iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
> the device. Similarly, after the last iopf-capable hwpt is detached from
> the device, the IOPF feature is disabled on the device.
>=20
> The current implementation allows a replacement between iopf-capable and
> non-iopf-capable hw page tables. This matches the nested translation use
> case, where a parent domain is attached by default and can then be
> replaced with a nested user domain with iopf support.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |   7 ++
>  drivers/iommu/iommufd/device.c          |  15 ++-
>  drivers/iommu/iommufd/fault.c           | 122 ++++++++++++++++++++++++
>  3 files changed, 141 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iomm=
ufd/iommufd_private.h
> index 2780bed0c6b1..9844a1289c01 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -398,6 +398,7 @@ struct iommufd_device {
>  	/* always the physical device */
>  	struct device *dev;
>  	bool enforce_cache_coherency;
> +	bool iopf_enabled;
>  	/* outstanding faults awaiting response indexed by fault group id */
>  	struct xarray faults;
>  };
> @@ -459,6 +460,12 @@ iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
>  int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
>  void iommufd_fault_destroy(struct iommufd_object *obj);
>  int iommufd_fault_iopf_handler(struct iopf_group *group);
> +int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
> +				    struct iommufd_device *idev);
> +void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_device *idev);
> +int iommufd_fault_domain_replace_dev(struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_device *idev);
> =20
>  #ifdef CONFIG_IOMMUFD_TEST
>  int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/devic=
e.c
> index d70913ee8fdf..c4737e876ebc 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -377,7 +377,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pa=
getable *hwpt,
>  	 * attachment.
>  	 */
>  	if (list_empty(&idev->igroup->device_list)) {
> -		rc =3D iommu_attach_group(hwpt->domain, idev->igroup->group);
> +		if (hwpt->fault_capable)
> +			rc =3D iommufd_fault_domain_attach_dev(hwpt, idev);
> +		else
> +			rc =3D iommu_attach_group(hwpt->domain, idev->igroup->group);
>  		if (rc)
>  			goto err_unresv;
>  		idev->igroup->hwpt =3D hwpt;
> @@ -403,7 +406,10 @@ iommufd_hw_pagetable_detach(struct iommufd_device *i=
dev)
>  	mutex_lock(&idev->igroup->lock);
>  	list_del(&idev->group_item);
>  	if (list_empty(&idev->igroup->device_list)) {
> -		iommu_detach_group(hwpt->domain, idev->igroup->group);
> +		if (hwpt->fault_capable)
> +			iommufd_fault_domain_detach_dev(hwpt, idev);
> +		else
> +			iommu_detach_group(hwpt->domain, idev->igroup->group);
>  		idev->igroup->hwpt =3D NULL;
>  	}
>  	if (hwpt_is_paging(hwpt))
> @@ -498,7 +504,10 @@ iommufd_device_do_replace(struct iommufd_device *ide=
v,
>  			goto err_unlock;
>  	}
> =20
> -	rc =3D iommu_group_replace_domain(igroup->group, hwpt->domain);
> +	if (old_hwpt->fault_capable || hwpt->fault_capable)
> +		rc =3D iommufd_fault_domain_replace_dev(hwpt, idev);
> +	else
> +		rc =3D iommu_group_replace_domain(igroup->group, hwpt->domain);
>  	if (rc)
>  		goto err_unresv;
> =20
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index e752d1c49dde..a4a49f3cd4c2 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -267,3 +267,125 @@ int iommufd_fault_iopf_handler(struct iopf_group *g=
roup)
> =20
>  	return 0;
>  }
> +
> +static void release_attach_cookie(struct iopf_attach_cookie *cookie)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D cookie->domain->fault_data;
There is a possibility here of cookie->domain being NULL. When you call
release_attach_cookie from iommufd_fault_domain_attach_dev if
idev->iopf_enabled is false. In this case, you have not set the domain
yet.

> +	struct iommufd_device *idev =3D cookie->private;
> +
> +	refcount_dec(&idev->obj.users);
> +	refcount_dec(&hwpt->obj.users);
You should decrease this ref count only if the cookie actually had a
domain.

This function could be something like this:

	static void release_attach_cookie(struct iopf_attach_cookie *cookie)
	{
		struct iommufd_hw_pagetable *hwpt;
		struct iommufd_device *idev =3D cookie->private;

		refcount_dec(&idev->obj.users);
		if (cookie->domain) {
			hwpt =3D cookie->domain->fault_data;
			refcount_dec(&hwpt->obj.users);
		}
		kfree(cookie);
	}


> +	kfree(cookie);
> +}
> +
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	int ret;
> +
> +	if (idev->iopf_enabled)
> +		return 0;
> +
> +	ret =3D iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> +	if (ret)
> +		return ret;
> +
> +	idev->iopf_enabled =3D true;
> +
> +	return 0;
> +}
> +
> +static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
> +{
> +	if (!idev->iopf_enabled)
> +		return;
> +
> +	iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> +	idev->iopf_enabled =3D false;
> +}
> +
> +int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
> +				    struct iommufd_device *idev)
> +{
> +	struct iopf_attach_cookie *cookie;
> +	int ret;
> +
> +	cookie =3D kzalloc(sizeof(*cookie), GFP_KERNEL);
> +	if (!cookie)
> +		return -ENOMEM;
> +
> +	refcount_inc(&hwpt->obj.users);
> +	refcount_inc(&idev->obj.users);
> +	cookie->release =3D release_attach_cookie;
> +	cookie->private =3D idev;
> +
> +	if (!idev->iopf_enabled) {
> +		ret =3D iommufd_fault_iopf_enable(idev);
> +		if (ret)
> +			goto out_put_cookie;
You have not set domain here and release_attach_cookie will try to
access a null address.

> +	}
> +
> +	ret =3D iopf_domain_attach(hwpt->domain, idev->dev, IOMMU_NO_PASID, coo=
kie);
> +	if (ret)
> +		goto out_disable_iopf;
> +
> +	return 0;
> +out_disable_iopf:
> +	iommufd_fault_iopf_disable(idev);
> +out_put_cookie:
> +	release_attach_cookie(cookie);
> +
> +	return ret;
> +}
> +
> +void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_device *idev)
> +{
> +	iopf_domain_detach(hwpt->domain, idev->dev, IOMMU_NO_PASID);
> +	iommufd_fault_iopf_disable(idev);
> +}
> +
> +int iommufd_fault_domain_replace_dev(struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_device *idev)
> +{
> +	bool iopf_enabled_originally =3D idev->iopf_enabled;
> +	struct iopf_attach_cookie *cookie =3D NULL;
> +	int ret;
> +
> +	if (hwpt->fault_capable) {
> +		cookie =3D kzalloc(sizeof(*cookie), GFP_KERNEL);
> +		if (!cookie)
> +			return -ENOMEM;
> +
> +		refcount_inc(&hwpt->obj.users);
> +		refcount_inc(&idev->obj.users);
> +		cookie->release =3D release_attach_cookie;
> +		cookie->private =3D idev;
> +
> +		if (!idev->iopf_enabled) {
> +			ret =3D iommufd_fault_iopf_enable(idev);
> +			if (ret) {
> +				release_attach_cookie(cookie);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	ret =3D iopf_domain_replace(hwpt->domain, idev->dev, IOMMU_NO_PASID, co=
okie);
> +	if (ret) {
> +		goto out_put_cookie;
> +	}
> +
> +	if (iopf_enabled_originally && !hwpt->fault_capable)
> +		iommufd_fault_iopf_disable(idev);
> +
> +	return 0;
> +out_put_cookie:
> +	if (hwpt->fault_capable)
> +		release_attach_cookie(cookie);
> +	if (iopf_enabled_originally && !idev->iopf_enabled)
> +		iommufd_fault_iopf_enable(idev);
> +	else if (!iopf_enabled_originally && idev->iopf_enabled)
> +		iommufd_fault_iopf_disable(idev);
> +
> +	return ret;
> +}
> --=20
> 2.34.1
>=20

--=20

Joel Granados

--pf2tgjfb6gzecilc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXUr94ACgkQupfNUreW
QU+ZOQv/Wip7KOIrGYyBLCBQ30IEYCwyj195c62gJ76/wxu+HvwnyJowrYzU0ub2
LODfpdTmIcJusUFIiJFWMFmBYThJMgEE1UqjPhItqKXR0bZ4ALPxXZNrj3pLCB7V
E1g0K1Sq0Mvf11nAm97b4pv4CSXIfNoNezBucK0B34cX3qGcTXRz1UNaEFDYs4ZH
b+Ms9REbV3nlmZxssOycD+Q0pG13yGIzg5N3SEMSrCW70VK95kZZDUWSd1eGC7iY
uX6DLWilTLYz97BbrBGaoXX0VQXUoO0bdI31ye9W76UE20Dn8BDQmOLFciCqNfWT
MhyFihjGmMbJckIY1qPQq7dsucQ4D1VF6G5ckTgVGyI9xZjW61qz+0UhW2RIj1Nt
TJrwGxL99zIkeg5VxObdHQxq7uxX5UNAi4LFNroiLc2VWuHvrB4dmghEZS4C0aPk
2vtLYqDaPZzsRscRK5e7mF9VlcQlmmZyjr8vApF/mOkWiDYQCq6BKXW9g84tTsbm
QL+ayV9j
=mvOj
-----END PGP SIGNATURE-----

--pf2tgjfb6gzecilc--

