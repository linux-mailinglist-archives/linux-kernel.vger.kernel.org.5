Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839237FFDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376973AbjK3VrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:47:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AFF10D9;
        Thu, 30 Nov 2023 13:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701380837;
        bh=X6P4Ic/jVR/ehQk8xDi+AsQIzeIiWoSBPu1D03k6dX4=;
        h=Date:From:To:Cc:Subject:From;
        b=Q5V2nzV2FGWLDZTKfh9HcZR7cjUPtxgdMT0oR8NmHy0tRxehCeUb+jqJNBuArqwch
         qBj0uQnKsVEhPUJBgtdVW324wt9cgTNyPq0kNZijSdL+NpM6z/bfU/Yy31wNi/hSq/
         kw74Wx0N1VRsXUflDbz0Ck5dF61bfIQHbT5WBb+hvMiE/ek0+LnWKAXeBGk7cyvLJ6
         4L3nvqALHj5MVy+lB2Mfr9pYRYXqSWyUcIo7hb3olfpuSgXr8R6sxyafSJJpfuRAXc
         ya6bGqDciWcRwrDl7FYMjfGSVrp/n537Fk02LyDMQkRdooR0ppupFq9W3ot1Njx6ed
         M4gmwBF41nLag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sh8tD6rL4z4xkW;
        Fri,  1 Dec 2023 08:47:16 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 08:47:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the riscv-dt tree with the
 riscv-dt-fixes tree
Message-ID: <20231201084715.11edd814@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ygxXbF.zZVQRrzdGe2cOBJQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ygxXbF.zZVQRrzdGe2cOBJQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the riscv-dt tree got a conflict in:

  arch/riscv/boot/dts/sophgo/cv1800b.dtsi

between commit:

  e80ed63affc9 ("riscv: dts: sophgo: remove address-cells from intc node")

from the riscv-dt-fixes tree and commit:

  5b5dce3951b2 ("riscv: dts: sophgo: Separate compatible specific for CV180=
0B soc")

from the riscv-dt tree.

I fixed it up (I used the latter version of his file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 1 Dec 2023 08:43:13 +1100
Subject: [PATCH] fixup for "riscv: dts: sophgo: Separate compatible specifi=
c for CV1800B soc"

interacting with "riscv: dts: sophgo: remove address-cells from intc node"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/s=
ophgo/cv18xx.dtsi
index d415cc758def..2d6f4a4b1e58 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -34,7 +34,6 @@ cpu0: cpu@0 {
 			cpu0_intc: interrupt-controller {
 				compatible =3D "riscv,cpu-intc";
 				interrupt-controller;
-				#address-cells =3D <0>;
 				#interrupt-cells =3D <1>;
 			};
 		};
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ygxXbF.zZVQRrzdGe2cOBJQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpAuMACgkQAVBC80lX
0GzG4wgAoOVTnujhByAtTrxoTWrpadvbQUICioJ25Xr5gdlmotHMfGsZTC/O9adO
ioqNP2eBLQSt0It1ez9Rajnn1tvANC8E4CaU/2o+fsrcx/59j7V5ElnMZ9RMLBDx
E/KWmkFn0Y8bP0Y9UUeDYoa7iKri29RlBuub94AB7dpSNt132J7vOTA3WPmfkW8R
3KYUWx4rXzcfTVdspwPLoLGKs8CzJK8/gUO7pK49HSnRl7sYa2vRb79PVTHUFrya
wXz2QOaBgHLtlOa7Ji06LawF0/eDiZtqmSZlEcbikh5RGevasPgGNI8VP9uzz0wH
lZv7kBj7MLxj4IcEoLqh1J2pBHaMrQ==
=1+6H
-----END PGP SIGNATURE-----

--Sig_/ygxXbF.zZVQRrzdGe2cOBJQ--
