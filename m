Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E317AE4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjIZFHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjIZFHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:07:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B594DC;
        Mon, 25 Sep 2023 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695704847;
        bh=rPl29/hKkAYhwb6F2YYjYbVG6pDFFsoBZrCdnWQ03b0=;
        h=Date:From:To:Cc:Subject:From;
        b=iGElojQm92YMdrvQ/mErsmobQ03a5nX7xslMdO7sUVVIoMzSs45BfPsgJbNEzO4VV
         Vwm4WNtSk9AdkL5iWsLRFKZwrSEBsmHM4ZU4JS8XflN/1MdQ49igK3yRfm1j+2owQ4
         7tClCSW+czeWtLtKKbPJvTemcyN65QacBrkOkoZysHXTCLAnIsVYdilOgkxNjqh02X
         CS+1GGzETsXwcdv9aCHeDJ73hsXsLPxaTSn0GPy4vHfz1F5iOniXToN4XIBVdsVBmm
         YYtI2mqEnB01MiYR9c+RyvGTj+8FK1tO2FW2nPjz0Hv4SAgeviwIG7RLMnPM40adXD
         4VF8MJxWUQUVw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvnmZ3lLnz4xF2;
        Tue, 26 Sep 2023 15:07:26 +1000 (AEST)
Date:   Tue, 26 Sep 2023 15:07:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20230926150725.4cca5fc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UA1dOjMCDC.F0M8CKXjUB0=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UA1dOjMCDC.F0M8CKXjUB0=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

Error: Cannot open file /home/sfr/next/next/drivers/gpu/drm/drm_gpuva_mgr.c
Error: Cannot open file /home/sfr/next/next/include/drm/drm_gpuva_mgr.h

Introduced by commit

  f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_g=
puvm")

--=20
Cheers,
Stephen Rothwell

--Sig_/UA1dOjMCDC.F0M8CKXjUB0=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSZw0ACgkQAVBC80lX
0GxXwgf+LffYpQq1ue5A6iy9m1V/AWULRZ83AdeMHSyEt9uZXB6wYu3aAHlyeC/O
luJoEIUpXPfE3sDxK1IkRxe4ZUwnzU/1DvZRLZgSLHfcY2iBXH1/vWswXd5vo845
kZKMr2fyJkY0s2gN1lw8gYDg0pKEqF3KzdXPpxDe6C1o/G3cqmlldQD2DsI5My+P
Obkf8V+7MC65vwIfMkyTMjAMlulI7k3p/ECk5lUx5lx7oDMxHbDsxyruNeux1iZ8
Fj4PI9StAJJE01A6xKrAR7UMminnf2vlKPeI71Bwz3J4UtPZ0jL3OkWb89wcS2HO
oIcX0V4y1U9dYBU0iupc7Sq8sfc6mg==
=BrNT
-----END PGP SIGNATURE-----

--Sig_/UA1dOjMCDC.F0M8CKXjUB0=--
