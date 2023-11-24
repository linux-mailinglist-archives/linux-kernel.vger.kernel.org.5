Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172177F6AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjKXCZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:25:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8011F;
        Thu, 23 Nov 2023 18:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700792748;
        bh=Mo4Vg0x4Tn1NUCtfTQlN1y65FYD9yKKHBRdITJKRr8M=;
        h=Date:From:To:Cc:Subject:From;
        b=MNFwLHZ8ZPZCtEEnNcb9Bf/Db/cAB9wZWBOQ66GN5sdys9bH9nO1nKqdptpOxHLT6
         /++Nh+9YPRx+T7WUO46uSY2oP3SBQdeDwQILrx7cNsuAo8W2Nnp4koZ+eQkjFyn0Mo
         mCAW/Rm2yafb5kdmfLgSrgLEAgM1PLt0f8fMs9pSZDMQ5wmlnxHNNRCTWW6TMEO+Pj
         t0CpTf5fnByCxaz0fE/K/lGFlwKHbscLvUH15CE+slFdQWFH8QdFecN1vyCHdGEIlO
         N3azyH9IpOUI6PFgrTcoaBy64ZxR35PFd4l7HDToD/TCgbJKgD0XMqmzcpNZClChUL
         D5O9Iziw8n5lQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbzNq6Nmvz4wcX;
        Fri, 24 Nov 2023 13:25:47 +1100 (AEDT)
Date:   Fri, 24 Nov 2023 13:25:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20231124132547.00f7e599@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QOy1sNj_Z7qHo9VKn37dU9+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QOy1sNj_Z7qHo9VKn37dU9+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
this warning:

include/uapi/drm/pvr_drm.h:1: warning: 'Flags for DRM_PVR_DEV_QUERY_HEAP_IN=
FO_GET.' not found

Introduced by commit

  1088d89e5515 ("drm/imagination/uapi: Add PowerVR driver UAPI")

--=20
Cheers,
Stephen Rothwell

--Sig_/QOy1sNj_Z7qHo9VKn37dU9+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVgCasACgkQAVBC80lX
0GwdZQf+J8wlWgeQszsEbsJAC8oGRCweif258C339Hc83kwzrGcvzs0dSnQUF2PX
xJ6FC+zf6gJpexBwMHHXRYRv3KrVek56Jllo9BoHHHeXoNKowPlvfDNhga2IIxOc
aa/P+PabhE5cGBE/NqsGRBSizNMa3xLrmR55kx5LcuVlj1OKj1pM8uuJErNeLekY
Ep65b7+iXQinfj0W3G4sJCv6CLl6/QHFSUu9qxywPm+9LUFFE4KGMxa8CnDgs0AI
99Qv/oKBwN7Oo1XisHMxK7EjSYaxWLoM5Xw0q6onUupFxKuR4Ttokc0SO30h7JLA
hYrejy90N7C3hRjH+Ol8sQZ837hIBg==
=q6XM
-----END PGP SIGNATURE-----

--Sig_/QOy1sNj_Z7qHo9VKn37dU9+--
