Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B47D8DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJ0Ezf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjJ0Eza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:55:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606081A7;
        Thu, 26 Oct 2023 21:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698382525;
        bh=pn/MK2PwSd3NO/fy5gAheuSGiNydeLRHOjVKL3rZO80=;
        h=Date:From:To:Cc:Subject:From;
        b=NNRNq9VHCi50Uxd6ixpXE2LmG03uRZB/+Jp9sF6I02bJByTdcDGHdn1G8lvl6MQu4
         uGA2jj/q9GdWDSJDfK5rUAw0MVlvJnXu6oJcYIR89HbruuU8Klou+wZI5qxSRnpR6w
         IE3SBgqsa8qJ4cCJf+JbMUqRrCumKHasOg+HerI7NB83Xji5Mp6gG20GdnNWHzYxGv
         0d9Wgtbw2xXMxfrdFW79wZYYfW5nrEnzt2PF3lLZk4O+D8bpa316fEk4UhX4MMbwPU
         oAdz7qjfjqO2r+j1GwWphcodvpZbSnT8m24gwLmi2RlAQzybFB1MWhdx+FRCArePqa
         66Wy2zOPoPWzg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGr2M4MzDz4wd1;
        Fri, 27 Oct 2023 15:55:23 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 15:55:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231027155522.6b2863a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bmNe/dKWE5QI_gaZUeETryt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bmNe/dKWE5QI_gaZUeETryt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  drivers/iommu/iommufd/selftest.c

between commits:

  1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
  13fbceb1b8e9 ("iommufd: Convert to alloc_domain_paging()")

from the iommu tree and commits:

  408663619fcf ("iommufd/selftest: Add domain_alloc_user() support in iommu=
 mock")
  266ce58989ba ("iommufd/selftest: Test IOMMU_HWPT_ALLOC_DIRTY_TRACKING")
  7adf267d66d1 ("iommufd/selftest: Test IOMMU_HWPT_SET_DIRTY_TRACKING")
  a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
  0795b305da89 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEA=
R flag")
  65fe32f7a447 ("iommufd/selftest: Add nested domain allocation for mock do=
main")

from the iommufd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iommu/iommufd/selftest.c
index ee6079847091,6684ab4cdc7a..000000000000
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@@ -272,9 -435,28 +430,20 @@@ static phys_addr_t mock_domain_iova_to_
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
@@@ -293,8 -469,10 +462,9 @@@ static const struct iommu_ops mock_ops=20
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

--Sig_/bmNe/dKWE5QI_gaZUeETryt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7QroACgkQAVBC80lX
0GxGOwf9HDp0uSETtsl+pIsSYroDiWAMzI2zLn/AINQgJL8FkdeLQLdAzKr5KoL+
e5SRXhXHhGUrS6K3FSA9MkjOElYIsZmljZxXqfhXAReMy4Tw0r5x2NYApPK+zHrr
h54ny8Lzkn9tTTl6Xdu8rqWxuPmIybuerq9Oi3/j9i1kIWpFHY1/IV/IR63suWhc
SoU+jf7Hwu5ypr6OQDEqHzQ6yDhQSK2LxUtHz/CkM7xFBGbH2e1jS9OhGRJ0Wsmi
mAtX80/BGolXw7H9MBA0KIUb7BVAp2AlzjXhFGyTFJ9kEFysJXI9YblfD7/70x2y
T7qigIL88gApYW3jCqCcS7EI8eHKwg==
=76VA
-----END PGP SIGNATURE-----

--Sig_/bmNe/dKWE5QI_gaZUeETryt--
