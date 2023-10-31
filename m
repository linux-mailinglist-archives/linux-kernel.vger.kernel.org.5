Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8147DC5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjJaFMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjJaFMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:12:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFA511D;
        Mon, 30 Oct 2023 22:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698729138;
        bh=bxStzz6nOrEXdZNDwkU7etS4G1iLolFxrkKrbs09ZDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=psu1CyEJqPHl0uI9x4wig77w/YMF4e7kS55Q/oetq9n4VoNC6IgRlPlmujk29mTzC
         5CLo2TB9kvc7rCGOC7A4vWfHVdPfQZyAFczaJ0+fQL+ER9ITMoI6ysnOhV2WYs10rz
         u/IRas3KU/Y+GJBf+17qQQqFgoH1im0QQhBrmVA9xr7H3E87LjPh9ewQ18gB6a2JQQ
         0LI2gNRMapkTiL9KHQyLuvRxrPLP7ebvw3j76HK8Ruptuc+sg84eo/Lf2kwOiFvznm
         BtHfBnUpsf8NMSdKLJFKCcp+773MxhH+caDabIfau1H8XgBlczEvDoiAra4jJ7VC6F
         VaU9w8dJs1S5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKJD00c9dz4x5k;
        Tue, 31 Oct 2023 16:12:15 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 16:12:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu
 tree
Message-ID: <20231031161214.25560598@canb.auug.org.au>
In-Reply-To: <20231030182621.GV3952@nvidia.com>
References: <20231027155522.6b2863a4@canb.auug.org.au>
        <20231027171522.692a58ec@canb.auug.org.au>
        <20231030182621.GV3952@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/suJhAFsV/.WPioJKy0M+F+_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/suJhAFsV/.WPioJKy0M+F+_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Oct 2023 15:26:21 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Oct 27, 2023 at 05:15:22PM +1100, Stephen Rothwell wrote:
> >=20
> > On Fri, 27 Oct 2023 15:55:22 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > Today's linux-next merge of the iommufd tree got a conflict in:
> > >=20
> > >   drivers/iommu/iommufd/selftest.c
> > >=20
> > > between commits:
> > >=20
> > >   1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> > >   13fbceb1b8e9 ("iommufd: Convert to alloc_domain_paging()")
> > >=20
> > > from the iommu tree and commits:
> > >=20
> > >   408663619fcf ("iommufd/selftest: Add domain_alloc_user() support in=
 iommu mock")
> > >   266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKI=
NG")
> > >   7adf267d66d1 ("iommufd/selftest: Test IOMMU_HWPT_SET_DIRTY_TRACKING=
")
> > >   a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
> > >   0795b305da89 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP_N=
O_CLEAR flag")
> > >   65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for m=
ock domain")
> > >=20
> > > from the iommufd tree.
> > >=20
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your t=
ree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particula=
rly
> > > complex conflicts. =20
> >=20
> > The resolution should have been as below (I think). =20
>=20
> This was too horrible, I pushed a patch to reorganize the new iommufd side
> code to more closely match how the domain_alloc_paging stuff is
> supposed to work

I have used the conflict resolution below now.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/iommufd/selftest.c
index ee6079847091,d43a87737c1e..5d93434003d8
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@@ -155,6 -240,81 +235,72 @@@ static struct iommu_domain *mock_domain
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
 -{
 -	if (iommu_domain_type =3D=3D IOMMU_DOMAIN_BLOCKED)
 -		return &mock_blocking_domain;
 -	if (iommu_domain_type =3D=3D IOMMU_DOMAIN_UNMANAGED)
 -		return mock_domain_alloc_paging(NULL);
 -	return NULL;
 -}
 -
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
+ 		struct iommu_domain *domain;
+=20
+ 		if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
+ 			       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+ 			return ERR_PTR(-EOPNOTSUPP);
+ 		if (user_data || (has_dirty_flag && no_dirty_ops))
+ 			return ERR_PTR(-EOPNOTSUPP);
+ 		domain =3D mock_domain_alloc_paging(NULL);
+ 		if (!domain)
+ 			return ERR_PTR(-ENOMEM);
+ 		if (has_dirty_flag)
+ 			container_of(domain, struct mock_iommu_domain, domain)
+ 				->domain.dirty_ops =3D &dirty_ops;
+ 		return domain;
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
@@@ -272,9 -432,28 +418,20 @@@ static phys_addr_t mock_domain_iova_to_
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
@@@ -293,8 -466,10 +450,9 @@@ static const struct iommu_ops mock_ops=20
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

--Sig_/suJhAFsV/.WPioJKy0M+F+_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVAjK4ACgkQAVBC80lX
0GzB7Af6Ajc3Y1Rc9nIBa+dW+jo55qcKzEHZB4P/ew9JiF4O/vA1V+tLFeqEcrzQ
n2WSJEEq7qYw9UC0iQosC3l6lqEgCfq2BFEltAx2fC+IiaMK8Ewg6yqsq4blZtVk
dyTIztTyDKr6qF3RJcW4KvVsD4YYoKCM//g25WbTrvEQ+6fYv92kCQ91Q09kg8M6
DpruHLfAtNzPDRJzUAsbqwEMPl++YsoHt6MPm+fHN0iTKTq4tHe9374qbTF0yzwv
Qez+po+kzbC+D4LQBMArw0t3Zpp6E0yap3S1YHy+6Mv2I0DT3bh5mqeYx/TCol9L
LfEvWxI1CawibzJMttOPaqf2TZh3XA==
=uZ6P
-----END PGP SIGNATURE-----

--Sig_/suJhAFsV/.WPioJKy0M+F+_--
