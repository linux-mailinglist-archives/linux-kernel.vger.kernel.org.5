Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D47DB1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJ3ByB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJ3ByA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:54:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83BBE;
        Sun, 29 Oct 2023 18:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698630832;
        bh=dYFDOWaS0KfiTiA61olW9Oj7YVFUk+87DhnSiTj61xk=;
        h=Date:From:To:Cc:Subject:From;
        b=OfS/cGpW2qh3SITHSOjtk1Cl3fiLJXiEEoQJiciz234dGfd3V1hTizNYkZ8vSvm1m
         dMYcpAl1wq8AXRfRGhIRt96qz9wetJKxZ5y2CSAFNEDPXrUsDSpQcVEWAqfkYLl4o4
         EFPisaLIuVI80l2WTb16U8X6uzh2vui+5k1pqH67a1WsAjWylq2ks60uWq0Ir+pRq4
         sU0WRJ/OnLLC+nllgZuh9JAuOEFfhj/Zw2zzb2Ns0MsJ77gnJKbcXT6lzbyoLvHcT/
         97jnPv6KTleENBrFB9WbNRrKmd/P/uM4l1W/5SZeHxnGfgHRivHzS40AVZm803DRxa
         rHuKNRCbZ/MUA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJbsW5dB1z4wcH;
        Mon, 30 Oct 2023 12:53:51 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 12:53:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the kvm-riscv tree with the risc-v tree
Message-ID: <20231030125302.250fc7e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ev_P.ii7gIhH2ye4yyf81x8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ev_P.ii7gIhH2ye4yyf81x8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-riscv tree got a conflict in:

  arch/riscv/include/asm/csr.h

between commit:

  43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")

from the risc-v tree and commits:

  db3c01c7a308 ("RISCV: KVM: Add senvcfg context save/restore")
  81f0f314fec9 ("RISCV: KVM: Add sstateen0 context save/restore")

from the kvm-riscv tree.

I fixed it up (I just used the latter version of this file) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ev_P.ii7gIhH2ye4yyf81x8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/DH4ACgkQAVBC80lX
0GyRDgf9E9dcPDl6hTobFU7kCPXVeo1tdZ4WYCTQ0YrOs2ywVdWTzk6L3V88sI62
7b8W4LlG7Dgze4L7amOflXScckkJRHNermO1pIvZ4lYgP2/dQtRIygPGlnnWWmgv
d2lNAzBm0vKUATKLtFrA6NQS8yBG4Rc4HidUUs72kVXnFYwrvXXMoC8ESfgA/J9D
SBmYDpnTpZHoI6jbeDr22hH1v9TtNJH9Txrqh464mAw4y1yyGeUnxT73PtoHKd3R
CFMjR9hWfEReYfwLhBw3MpgKqm5/TDH+O9xAST0I2AYSKYaeP3hao8RzJRJFI4Yo
TSll0iW4CrlBaThO3PW6td7FMc2M/w==
=qbeN
-----END PGP SIGNATURE-----

--Sig_/Ev_P.ii7gIhH2ye4yyf81x8--
