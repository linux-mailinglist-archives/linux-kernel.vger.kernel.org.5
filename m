Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3999879DD65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjIMBKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:10:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4310E6;
        Tue, 12 Sep 2023 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694567403;
        bh=Bgqmvp6Vvzr/QlZJbVXlrj7k1IFmb3uGG7LW/EaoHdM=;
        h=Date:From:To:Cc:Subject:From;
        b=ZkKQVRR2DriYryMHGjVtGxLWECn8xVT9Nvnbx6+agJI5dZWsMiYtgJmZdg/i6RfNK
         7bXR8yWVs8Opqvl1PFMTEiF1bzD8dlmzx/X1hm+sb8L6C/JoUMztuOvoNPRL/tWf8m
         XsQAYyaCSxygaASOojLtt21AemFTM1yxeDWkpl8JPskkPVmqFOpjbiOvxhSrvfvHLN
         Vlc6REtBvgxtWB84NyoyXRNOnzY2wqyisM4pjPVhcNMAPlZz/MWM24CegtCUIlhRDW
         QmWb5+cNSNQVjH3q4OEohV77tSUnsvnGEUUuDR5yFImh9KlmcHIMfwi6ZvCGqyfoax
         b671Ul1Y7xuTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rlj6f62ktz4x3D;
        Wed, 13 Sep 2023 11:10:02 +1000 (AEST)
Date:   Wed, 13 Sep 2023 11:09:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20230913110939.574c7ec2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ed9H9=+yKJKWcjudP/1OMa+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ed9H9=+yKJKWcjudP/1OMa+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/mediatek/mtk_dpi.c

between commits:

  47d4bb6bbcdb ("drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()=
")
  90c95c3892dd ("drm/mediatek: mtk_dpi: Switch to .remove_new() void callba=
ck")

from Linus' tree and commit:

  c04ca6bbb7ea ("drm/mediatek: Convert to platform remove callback returnin=
g void")

from the drm-misc tree.

I fixed it up (the latter is the same as 90c95c3892dd) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ed9H9=+yKJKWcjudP/1OMa+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUBC9MACgkQAVBC80lX
0Gz+YQf/czaMUHm7Pn2zchw6gWWTMLOVA5z8YP5XY+9R7tyumgL77f8Dk/HX3Z3v
8pd5sID37cNZUYraYV3hEi2FgmYRvf6zMiyy4jhqpz6VGgeD/zwRPfDuMsiaxaTp
7QbO5d5CmzAZk3lEBCnJjOKxhapgdSggB8l3iLgWjhKGLENt7Oc2jjQf+VmeYE3o
OyZwR04TndcYbUODmqR40l7xomTTd2jyshXKcdAtDU+wZNyQM+SP/zSq5jQTCg3b
R649yfI0T2ZzMw2dXxRQkGDZbsa9GoPCk036EesHzQUDa0kKN3irPrJmPYq5Vgw5
NYtZX/qmr+3kKxEyysZI4dIJpP9JFg==
=kpxN
-----END PGP SIGNATURE-----

--Sig_/Ed9H9=+yKJKWcjudP/1OMa+--
