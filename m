Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20D680DFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbjLKXrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjLKXrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:47:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A73B5;
        Mon, 11 Dec 2023 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702338420;
        bh=PalGBobXg3qAUYZb0g5tjxFjYZtNWkQxoOPR3JpFqTQ=;
        h=Date:From:To:Cc:Subject:From;
        b=iOA7okWTXICn7PcPShZJc9DQL4imaChNXKvidnIoaKUENtwrNeFRBJ2Tb8jSVykGc
         ML6u6ElQWbnYq2Oi3XxlqjioQXqDHWgujwbolRLomiQTpj5SZHSa608KQ/xwR0b7qm
         6DyTXKUSjxLsfsJgIW2FThWN0SntM4/52RyHC99TomhQYMMk+JNVrI4TiYAnlpyEED
         oB6ZHuolEmCP83PJ0pzt05q4EPPwmTwErf2smsrasS1iW1aLAVFEWxR7RpAYzVm4yC
         efA6C8/Xkeq+OS4UwzMqs8KkSYennwJ5EM4X5ePekcmiOsgSzXOGSx0qPh5cZXS0yK
         +8zwOGp2o/O6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Spz1H5wgSz4xGR;
        Tue, 12 Dec 2023 10:46:59 +1100 (AEDT)
Date:   Tue, 12 Dec 2023 10:46:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ma Jun <Jun.Ma2@amd.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: linux-next: manual merge of the amdgpu tree with the jc_docs tree
Message-ID: <20231212104657.524d359e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nNudTIv73jjuAoRzRQkI/gf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nNudTIv73jjuAoRzRQkI/gf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  Documentation/driver-api/index.rst

between commit:

  50709576d81b ("Documentation: Destage TEE subsystem documentation")

from the jc_docs tree and commit:

  2128f3cca5a2 ("Documentation/driver-api: Add document about WBRF mechanis=
m")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/driver-api/index.rst
index 9511db303446,8bc4ebe7a36f..000000000000
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@@ -112,7 -115,7 +112,8 @@@ available subsections can be seen below
     hte/index
     wmi
     dpll
 +   tee
+    wbrf
 =20
  .. only::  subproject and html
 =20

--Sig_/nNudTIv73jjuAoRzRQkI/gf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV3n3EACgkQAVBC80lX
0Gxi1Af/Y171I44mKx5Cj1rfmUiZsqAxDYk8ugg8oPLht4IMUWgh0tqkKIHZBBEn
ded/9/9oa6ByLkRNEnusVT/z8lTRns3jEPoIbHPQFr8q4nV0V64V/qdDY5pHlZoP
p4OM+tgmLbynzNelTugIL4Lt8mgLEXILqUmjGd+8SE6VODjNKok6o1fKmsAPW7F+
CQuZHJB6PpYDAsnzy2zxCT0eqHrM7MbgKwvbr3/Cpffp0apHkIUS/DYZaxb7UbsH
GkRaAqha9JgL/OoyvJW4vSWyWkAFP3aLoRNrnM6LSN7OvgMcLmstatfTes358CuA
ANeCN6iSo2fCOOUiRrhQHnhC+5KDQA==
=/6WC
-----END PGP SIGNATURE-----

--Sig_/nNudTIv73jjuAoRzRQkI/gf--
