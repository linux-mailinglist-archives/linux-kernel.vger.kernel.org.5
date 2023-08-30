Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD52778E336
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbjH3X0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbjH3X0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:26:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA5C2;
        Wed, 30 Aug 2023 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693437951;
        bh=186s4Tfqp7nrDNY4bZMoxMHISu6qI4vQ8gucjtogO6s=;
        h=Date:From:To:Cc:Subject:From;
        b=ZpdkixctiOoF7NiysfgghFgh+r/EtA6JbCTkG7WCm6D7A3Hj2dpTTBRt/BKRBPW/Q
         8isnIDAMOHNdXZOkiULCmfiWispF+if5jZ0o/neqTMoSLPAmUOMuGTGEa0ai0Hm19x
         x0Q7XG4qBFYI/UpSUJnxyykLOsJirpoYFJMS/COo+VDtPW0O21tT5nYd19A3Wrck13
         2WDrfR4982lcvsksBBFcsaiJ/NX16hC8R5dnSpo1TYuVy/ocPtcSxYKEQhVh2uJckE
         q/y1Cd+TGgsKbpFohgX9SpWa1H+ZpRTSmk3Xg7NsVGaE0S/VvaHrC78p3O2/dhd5zn
         Aq2xcI0Yjtk9A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbgQQ2lpVz4wbP;
        Thu, 31 Aug 2023 09:25:50 +1000 (AEST)
Date:   Thu, 31 Aug 2023 09:25:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Chen Jiahao <chenjiahao16@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20230831092548.41e888b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.fPVUFsw+Gy7KoWaNIa8dzY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.fPVUFsw+Gy7KoWaNIa8dzY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/mm/init.c

between commit:

  b690e266dae2 ("riscv: mm: fix truncation warning on RV32")

from Linus' tree and commit:

  5882e5acf18d ("riscv: kdump: Implement crashkernel=3DX,[high,low]")

from the risc-v tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/.fPVUFsw+Gy7KoWaNIa8dzY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTvz/wACgkQAVBC80lX
0GxD+wgAofsiQ1ludVLHQx0aBosCXrlh3G0W00U7yEiqIJO9G2O3r4CkiiK2ZBBu
lPdadMDLoyod+g+bNB5ULfeRhL1z3iuGzQMXb7nvt5Ye0nulMSKMHA2OLmN1Y9Tb
LVnlwkV5x8cfmVDtAKk4bG9ri9IFb23j6iN2Kj4UrVtkhO2rztsARlOTw9yLvnRj
b0v/RnQBl54BG2sGT78DA0E55dEflHDklHhtFtbYd7yD0IiCC4tIurO2sfj04aEZ
2HOnD+muTQQamISitCq5+pwef3B6H597CAZrB9XGCN0sQeqHwC8F+nLr56omRRrS
95batL5O5/nuyKyVcdy+zzrtOKclPA==
=Iy8O
-----END PGP SIGNATURE-----

--Sig_/.fPVUFsw+Gy7KoWaNIa8dzY--
