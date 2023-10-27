Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B407D8F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjJ0HBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjJ0HBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:01:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EAD1BE;
        Fri, 27 Oct 2023 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698390092;
        bh=+swhSQD/acGanmAxUjewo7DdrhtqNnLV264jn27WGcA=;
        h=Date:From:To:Cc:Subject:From;
        b=t1ZbdDMerkNpvjYOUyCn7yvuzyT9Bp+fnuGjwUHX2nK0mdrfOZ8TEBRh9s+txNas0
         FrcYt8UY3DVACG+HyUPfqCMH3Yk41ur8z3dUQgyHUIvA5ULbyXrrtcN3nqMmjXELYU
         VaX/nTPQVOWEKImFVaOQ/l9SSWThWd+g3aPaj4/vJRQ7g/BkTxiJQuNmwms9zqXgk2
         2H2qCmCCv6z39Bub1x1dJebMgUvWX8AcVtuX8/bZ7pkuQi7GP17bf4UCwzPPKt67iV
         XKbH6MSBs+Yb/J0/FeXHaeynhPXtOMHBVm9d10h30wZ6NnDcO68OUIUnRAFkcABqr4
         788Y6npl9KEzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGtqw554vz4xF4;
        Fri, 27 Oct 2023 18:01:32 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 18:01:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cxl-fixes tree
Message-ID: <20231027180131.302d8355@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aeysTEBVZFgfJLQxdJ=sUtM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aeysTEBVZFgfJLQxdJ=sUtM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cxl-fixes tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/cxl/memory-devices:456: drivers/cxl/core/region.c:=
1556: ERROR: Unexpected indentation.
Documentation/driver-api/cxl/memory-devices:456: drivers/cxl/core/region.c:=
1563: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/driver-api/cxl/memory-devices:456: drivers/cxl/core/region.c:=
1564: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/driver-api/cxl/memory-devices:456: drivers/cxl/core/region.c:=
1574: ERROR: Unexpected indentation.

Introduced by commit

  9f3899fd1bb5 ("cxl/region: Calculate a target position in a region interl=
eave")

--=20
Cheers,
Stephen Rothwell

--Sig_/aeysTEBVZFgfJLQxdJ=sUtM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7YEsACgkQAVBC80lX
0Gw9SAf9GodDa2P+iBCjLRg1QaMcDlAqF2ACZ888H8s449zGkwjUDkO461XvOywA
/NsA7h+s7Atb/7RlkGP2VyKdowXGgbT3Syq8z0mJBBfV3m+vBw1qUDVG6FZI69w7
sbeV95IDpoyxK1ryWcVc79lPBKj6Bb/2QtJ0wv9M8Kq4FXUtOSRJVNaurZ4UEJi6
BSbXhpX5Z6l5PKwz10YEzMYYQ7IglzxjTimwc/SbVemfY14hDUtC75dH8HoWQBdc
bcqIUpjN5XGTpM3FPGERilcQ+8/hTeMSUhdoaxDfW4i6FkQH8O2zDJF8A/IjKJb7
Kf+2Mj93vWGdU7djdoeLCr5+O1bE2g==
=n6Hj
-----END PGP SIGNATURE-----

--Sig_/aeysTEBVZFgfJLQxdJ=sUtM--
