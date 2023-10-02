Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A37B5DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjJBXhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJBXhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:37:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31038B4;
        Mon,  2 Oct 2023 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696289835;
        bh=ZrA7I8jcs22PJNQSuzapXP+rXCoCoW1xUIsZd4l4XmI=;
        h=Date:From:To:Cc:Subject:From;
        b=k92f4Dqs4P6Fo0AbW2VHBQvxnhkpYXvz7zOAFtoODQCCTP6LUHnuazXhj8cnvPAsy
         akvXM0B1kWYOgkWezC388pOEl8JpC+0OsIAvXOyTNDUBkQc2CJnEMOB+Wr7aLug6Sz
         HptI2OTA8Z7XT8lfcDaPcVcJ8wxmFkHwdZ4ekVjhwZlc+rn2Eu/wtJ3qB0qw+Q34Tw
         RzgxjoRWSpjarQf4B3Mbe5XVEbemrQaL7WVGsFVYVWTVOEGH1uVdISfm1+CbFjuyAK
         oW8hPmssxpXbU1ijpk/JCiAoURdMiBy2tK/p0jPAtnKAmz7XxemgxB8FtAVZbE19kg
         2f4cKzQGpjx6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rzy6L1G3Lz4xNg;
        Tue,  3 Oct 2023 10:37:14 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 10:37:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: linux-next: manual merge of the mlx5-next tree with the net-next
 tree
Message-ID: <20231003103712.5703b5e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/audx8+6=rD2Db8A9QbMBV5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/audx8+6=rD2Db8A9QbMBV5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  include/linux/mlx5/device.h

between commit:

  ac5f395685bd ("net/mlx5: SF, Implement peer devlink set for SF represento=
r devlink port")

from the net-next tree and commit:

  0d293714ac32 ("RDMA/mlx5: Send events from IB driver about device affilia=
tion state")

from the mlx5-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/mlx5/device.h
index 8fbe22de16ef,26333d602a50..000000000000
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@@ -366,7 -366,8 +366,9 @@@ enum mlx5_driver_event=20
  	MLX5_DRIVER_EVENT_UPLINK_NETDEV,
  	MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
  	MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
 +	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
+ 	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+ 	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
  };
 =20
  enum {

--Sig_/audx8+6=rD2Db8A9QbMBV5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbVCgACgkQAVBC80lX
0GwXlQf/Ta0GYkWCHnuXhPZD4IN/SWBGyNK6uxsf9Pfsr0JfvwYZ0XvQ0nx5QD8g
w6h5inIBuLaEH8zSqJzXAxCPuBaN4JSorgRT4rZb7SHhn1J7PvHbEA8lqMyDOcit
0+G86x8rhz9E5hyUmq65x7UBr1/fIHOOks9D3G0wJ63DIoQqCbhRJBRxJuFnNrsf
DmdOEwxJetQF23cpt6Pgxq85+hgtb6itt9+l6NfM0tHMetlkKWe8FAOWRCv4utrq
eL20KbA73N+pNEm41XMIc6IzplkHuuZSxSLxzT7jBtwvoC8gWkE6Z5lgsgpQMFIs
qhKdk7V72zP/4vuo77OSDLowRMKMxQ==
=6jwz
-----END PGP SIGNATURE-----

--Sig_/audx8+6=rD2Db8A9QbMBV5E--
