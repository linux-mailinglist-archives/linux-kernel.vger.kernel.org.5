Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AD7D8E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345179AbjJ0GPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0GPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:15:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778C1BF;
        Thu, 26 Oct 2023 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698387325;
        bh=dZAEgQquByxTyOWNG5sJpM+ib6iTynmtMRqYF46g4FY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YOt7DT+8snrICRHOztXrDyLyZ2C1zHZbsig+BqJ5sbmjCuFpVHUkO34fqIiTLIQgN
         39HZpxUjcjcsdE9IjmEuRj1IEKmmNmTF52qX0J4brD5L9zlmn5Jx1d28+na0iiDwiR
         /CCwhPOIZxxLS5T4TerVugYoFtT5Riu1FCQwDiKVdvdUhsKQF8i6fyK6EQDxQN8m0P
         +hsfgLIbnnb/HAI0jyHniQKpZIpI6YNYcEGmPJbPgxwEeJ01+PuMNAn1UXZMExr5VL
         ip2/rcGN6BV2UwRx+3TJv5olosl4xQn7RjF3cf/CSXyWjfT4vBEOQXcT9nwHESt8SJ
         xXFzLOtc109BQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGspg5Qqwz4xF1;
        Fri, 27 Oct 2023 17:15:23 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 17:15:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu
 tree
Message-ID: <20231027171522.692a58ec@canb.auug.org.au>
In-Reply-To: <20231027155522.6b2863a4@canb.auug.org.au>
References: <20231027155522.6b2863a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xmJMZm=NjYI=7llw3LNgUlE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xmJMZm=NjYI=7llw3LNgUlE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Oct 2023 15:55:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the iommufd tree got a conflict in:
>=20
>   drivers/iommu/iommufd/selftest.c
>=20
> between commits:
>=20
>   1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
>   13fbceb1b8e9 ("iommufd: Convert to alloc_domain_paging()")
>=20
> from the iommu tree and commits:
>=20
>   408663619fcf ("iommufd/selftest: Add domain_alloc_user() support in iom=
mu mock")
>   266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")
>   7adf267d66d1 ("iommufd/selftest: Test IOMMU_HWPT_SET_DIRTY_TRACKING")
>   a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
>   0795b305da89 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CL=
EAR flag")
>   65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for mock =
domain")
>=20
> from the iommufd tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The resolution should have been as below (I think).

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/iommufd/selftest.c
index ee6079847091,6684ab4cdc7a..7d28ff9a278e
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@@ -155,6 -244,80 +239,76 @@@ __mock_domain_alloc_paging(unsigned in
  	return &mock->domain;
  }
 =20
+ static struct iommu_domain *
+ __mock_domain_alloc_nested(struct mock_iommu_domain *mock_parent,
+ 			   const struct iommu_hwpt_selftest *user_cfg)
+ {
+ 	struct mock_iommu_domain_nested *mock_nested;
+ 	int i;
+=20
+ 	mock_nested =3D kzalloc(sizeof(*mock_nested), GFP_KERNEL);
+ 	if (!mock_nested)
+ 		return ERR_PTR(-ENOMEM);
+ 	mock_nested->parent =3D mock_parent;
+ 	mock_nested->domain.ops =3D &domain_nested_ops;
+ 	mock_nested->domain.type =3D IOMMU_DOMAIN_NESTED;
+ 	for (i =3D 0; i < MOCK_NESTED_DOMAIN_IOTLB_NUM; i++)
+ 		mock_nested->iotlb[i] =3D user_cfg->iotlb;
+ 	return &mock_nested->domain;
+ }
+=20
 -static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_t=
ype)
++static struct iommu_domain *mock_domain_alloc_paging(struct device *dev)
+ {
+ 	struct iommu_domain *domain;
+=20
 -	if (iommu_domain_type =3D=3D IOMMU_DOMAIN_BLOCKED)
 -		return &mock_blocking_domain;
 -	if (iommu_domain_type !=3D IOMMU_DOMAIN_UNMANAGED)
 -		return NULL;
 -	domain =3D __mock_domain_alloc_paging(iommu_domain_type, false);
++	domain =3D __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED, false);
+ 	if (IS_ERR(domain))
+ 		domain =3D NULL;
+ 	return domain;
+ }
+=20
+ static struct iommu_domain *
+ mock_domain_alloc_user(struct device *dev, u32 flags,
+ 		       struct iommu_domain *parent,
+ 		       const struct iommu_user_data *user_data)
+ {
+ 	struct mock_iommu_domain *mock_parent;
+ 	struct iommu_hwpt_selftest user_cfg;
+ 	int rc;
+=20
+ 	/* must be mock_domain */
+ 	if (!parent) {
+ 		struct mock_dev *mdev =3D container_of(dev, struct mock_dev, dev);
+ 		bool has_dirty_flag =3D flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+ 		bool no_dirty_ops =3D mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY;
+=20
+ 		if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
+ 			       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+ 			return ERR_PTR(-EOPNOTSUPP);
+ 		if (user_data || (has_dirty_flag && no_dirty_ops))
+ 			return ERR_PTR(-EOPNOTSUPP);
+ 		return __mock_domain_alloc_paging(IOMMU_DOMAIN_UNMANAGED,
+ 						  has_dirty_flag);
+ 	}
+=20
+ 	/* must be mock_domain_nested */
+ 	if (user_data->type !=3D IOMMU_HWPT_DATA_SELFTEST || flags)
+ 		return ERR_PTR(-EOPNOTSUPP);
+ 	if (!parent || parent->ops !=3D mock_ops.default_domain_ops)
+ 		return ERR_PTR(-EINVAL);
+=20
+ 	mock_parent =3D container_of(parent, struct mock_iommu_domain, domain);
+ 	if (!mock_parent)
+ 		return ERR_PTR(-EINVAL);
+=20
+ 	rc =3D iommu_copy_struct_from_user(&user_cfg, user_data,
+ 					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
+ 	if (rc)
+ 		return ERR_PTR(rc);
+=20
+ 	return __mock_domain_alloc_nested(mock_parent, &user_cfg);
+ }
+=20
  static void mock_domain_free(struct iommu_domain *domain)
  {
  	struct mock_iommu_domain *mock =3D
@@@ -272,9 -435,28 +426,20 @@@ static phys_addr_t mock_domain_iova_to_
 =20
  static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
  {
- 	return cap =3D=3D IOMMU_CAP_CACHE_COHERENCY;
+ 	struct mock_dev *mdev =3D container_of(dev, struct mock_dev, dev);
+=20
+ 	switch (cap) {
+ 	case IOMMU_CAP_CACHE_COHERENCY:
+ 		return true;
+ 	case IOMMU_CAP_DIRTY_TRACKING:
+ 		return !(mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY);
+ 	default:
+ 		break;
+ 	}
+=20
+ 	return false;
  }
 =20
 -static void mock_domain_set_plaform_dma_ops(struct device *dev)
 -{
 -	/*
 -	 * mock doesn't setup default domains because we can't hook into the
 -	 * normal probe path
 -	 */
 -}
 -
  static struct iommu_device mock_iommu_device =3D {
  };
 =20
@@@ -293,8 -469,10 +458,9 @@@ static const struct iommu_ops mock_ops=20
  	.owner =3D THIS_MODULE,
  	.pgsize_bitmap =3D MOCK_IO_PAGE_SIZE,
  	.hw_info =3D mock_domain_hw_info,
 -	.domain_alloc =3D mock_domain_alloc,
 +	.domain_alloc_paging =3D mock_domain_alloc_paging,
+ 	.domain_alloc_user =3D mock_domain_alloc_user,
  	.capable =3D mock_domain_capable,
 -	.set_platform_dma_ops =3D mock_domain_set_plaform_dma_ops,
  	.device_group =3D generic_device_group,
  	.probe_device =3D mock_probe_device,
  	.default_domain_ops =3D

--Sig_/xmJMZm=NjYI=7llw3LNgUlE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7VXoACgkQAVBC80lX
0GwOugf/ffvG/EFF57tZ4seguiZ2JKWC0e9HYiQI21tn0dxx4Ikj9Hg1r/jLSLIz
0weOrycXXb3I9VTsjdUmHTMtWhOzcgg4iWDv9S/cUzbMMdCcf/dta+8dtbRG+zVA
CEakmQWI8j7tyrpL7tsSbTB33StaTaodiLLTGYS0SatqkoDB1g3nKp6eoFXeNCgP
opVc6TKsqJezGhBbiCZplBthBCxGCLqo3oysli8wCY9+7rvLXnKO4z5H/QbfDvQl
vW01uflRAqTIwV1L/cfE/fJ2XcMti3HWn0QDhoSIKVu8SQET51UfQ8n0aQBDfoRB
Q9pXFsjskq/Z2+rmS8EfE6YtbNcoDg==
=/xQM
-----END PGP SIGNATURE-----

--Sig_/xmJMZm=NjYI=7llw3LNgUlE--
