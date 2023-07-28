Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7137662AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjG1D4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjG1D4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:56:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841A52D51;
        Thu, 27 Jul 2023 20:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690516600;
        bh=anotzehS965Qfz/VuQ8/6Xu5j+6SUU0tQfkZVUCA1H0=;
        h=Date:From:To:Cc:Subject:From;
        b=Kf4ZHBvB2hSogh+y1z9vz4FWxwZymogZ0X7caGubmIQ7yzHse2yHKJrMSceT1j0+D
         1IqaunE0azTPutE2kVuM+U56Kv8iVPBAzr72qBdgUC6SxYMdmPLMfqy+oPfLtdlxp4
         elp8ZSIBpI4E8SU2z0oCwD7ysep/50slWUY2Ivz4rYVgH24e1l+mEFyFSVJn/9NAdK
         aWKtbA5OS0wdfTmMUM4Fr5b1sLEsTh0WkZqCVjzmD1YexsSM0jFhJ2tbfrCjtZwaOZ
         5H003ZuhLzkNpkjyDEndQqXVS92zvplGSN1lt5wc3S0bIyp2Q8cl0ZoULvDzpYFtKi
         UDoEo6dMTRjTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBv2b6kvCz4wbv;
        Fri, 28 Jul 2023 13:56:39 +1000 (AEST)
Date:   Fri, 28 Jul 2023 13:56:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the iommufd tree with the iommufd-fixes
 tree
Message-ID: <20230728135638.2ac25a2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wCmSbf.q8uEVjUf2p9oTgGO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wCmSbf.q8uEVjUf2p9oTgGO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommufd tree got a conflict in:

  drivers/iommu/iommufd/device.c

between commit:

  99f98a7c0d69 ("iommufd: IOMMUFD_DESTROY should not increase the refcount")

from the iommufd-fixes tree and commits:

  91a2e17e243f ("iommufd: Replace the hwpt->devices list with iommufd_group=
")
  d03f1336fd91 ("iommufd: Move putting a hwpt to a helper function")

from the iommufd tree.

I fixed it up (I used the latter version of this file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 28 Jul 2023 13:52:56 +1000
Subject: [PATCH] fix for "iommufd: Move putting a hwpt to a helper function"

interacting with "iommufd: IOMMUFD_DESTROY should not increase the refcount"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/iommu/iommufd/iommufd_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommuf=
d/iommufd_private.h
index 5cba9107f873..cc3d534b0caf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -280,7 +280,7 @@ static inline void iommufd_hw_pagetable_put(struct iomm=
ufd_ctx *ictx,
 {
 	lockdep_assert_not_held(&hwpt->ioas->mutex);
 	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(ictx, &hwpt->obj);
+		iommufd_object_deref_user(ictx, &hwpt->obj);
 	else
 		refcount_dec(&hwpt->obj.users);
 }
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/wCmSbf.q8uEVjUf2p9oTgGO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTDPHYACgkQAVBC80lX
0Gy93wgAlJSA40kArB7lDC3p9+R+98gWNm1UGBL+gcK8V837qRfASKjialyoS1hW
HuciInTeSS3pmLxkX2CvaPrjSLIw2l+NemEKKVb4b3ZJV0P5g4qHwz2rjXKtEaau
lf/zpWWS7+2iMTWawAEeSck3pnZ3PeB+mLdtZ/80fLASaWyupzhmoFX8+ao1TgLX
4I87DjXqvWjmPhvv9MmNo2Ce1qOz4EyEyHGUEKWttyVrcXQXI8pT45YKzazNI0h1
bhbb/Lk9KZxAqWo1hjoxP6saDP0uS8z8UQodO2p4grybzOIzrSorVsfobNskLIVH
4ePi9PI7tr7LP/uKZOzYp1y5deNr/Q==
=gjXK
-----END PGP SIGNATURE-----

--Sig_/wCmSbf.q8uEVjUf2p9oTgGO--
