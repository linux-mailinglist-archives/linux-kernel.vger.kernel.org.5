Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0157606E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGYD4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYDz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:55:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40D199F;
        Mon, 24 Jul 2023 20:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690257349;
        bh=BH4UTRdRmd24JQEWNHfnv+/JaAXumppvZJulRp8ng2U=;
        h=Date:From:To:Cc:Subject:From;
        b=hb/RnJSeSHs3OR4SHC8sGBV38ecvtgj0U2qIXlDxdwcmpuO0Zhv81b4qpaj9DD0Ip
         9B91nBGouy5LHP2nLn5jfVCZl+J8hW2XSefQa5qQV1buSVse9vlRu5LBiaFE8nmvAo
         9LOpKsNgVVVqn8NFxpUxFXjNSCPV/XUCrqwUBZ9q5+zm2Q2TOqwKRKw5YYdTZvinZl
         AWtVrhwIrqMCXuy+4Gdg5PtKPC9SL2i6246nLWreOq1NhqRn3vkDRV6dqh+ZXDXs4l
         +i+RxzUIjAuLSDyLKx5d6i6b81Rr2qBc3eiPcJku8XIVSzftVcH0yOFsVHkSt86Nua
         eXeSQaqKmDehg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R93906Sccz4wqX;
        Tue, 25 Jul 2023 13:55:48 +1000 (AEST)
Date:   Tue, 25 Jul 2023 13:55:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm-hotfixes tree
Message-ID: <20230725135546.28334fe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MyaaVDkmd.S=2C61eWdglOq";
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

--Sig_/MyaaVDkmd.S=2C61eWdglOq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/tmpfs.rst:116: ERROR: Malformed table.
Text in column margin in table line 4.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
huge=3Dnever   Do not allocate huge pages.  This is the default.
huge=3Dalways  Attempt to allocate huge page every time a new page is neede=
d.
huge=3Dwithin_size Only allocate huge page if it will be fully within i_siz=
e.
             Also respect madvise(2) hints.
huge=3Dadvise  Only allocate huge page if requested with madvise(2).
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  a0ebb5aa2de3 ("tmpfs: fix Documentation of noswap and huge mount options")

--=20
Cheers,
Stephen Rothwell

--Sig_/MyaaVDkmd.S=2C61eWdglOq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS/R8IACgkQAVBC80lX
0Gz/8Af9GflZmthFsEaWNWSd87yDwi2WfLK1lyZ3JX9DQ361LIAA3vvlKT4c8v9b
EUFwVzbivOKmi048IlvfQlmrO20dCO0yGgV4KF/PxHwlUB8kbyxUIZe2UlnD2P4O
jJK0d1XZs6UIAj4Ci07r4YvCUFF63dcTKLwT4RMrRg3dV4CxWJcPaNv75/SJZdPP
hZDnZEQUWbr+2oSC/oJFOcXbFFD21lpUuQSrrRwnnPnd1dZultb8yp9P6HbCL2xV
pvYvRbOjpGsyEhtTvl8Hjd4rwyAMojCjAnjlgPmb7hYb3BtvOXVJM8FfW74rDQcL
n//e9XbKB48kdRg73s9xIvI8fg+lHg==
=mkLl
-----END PGP SIGNATURE-----

--Sig_/MyaaVDkmd.S=2C61eWdglOq--
