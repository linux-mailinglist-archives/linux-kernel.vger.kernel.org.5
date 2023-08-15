Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78477C684
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjHODxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjHODsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:48:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397D19B3;
        Mon, 14 Aug 2023 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692070428;
        bh=NJLMXPZTCFqfvqsBEJy6qEpOVQlgHMGJBFaGMfADDoI=;
        h=Date:From:To:Cc:Subject:From;
        b=TLDevwbRmZxOw2rqzOX93B0djGLtgMHHVxjeVVxDANIE8R8PIN2CWAWNGTnA20RYC
         QrpEJ7FnFj4dFzp/o2vU7HxwlPYOKsfpMDbtA4pd3pEWHbcYjTOza1y8gycgK1PDFC
         NWY178MA0kCFD9a1NB2SwiLZAEMSCX0vglhLEw4peGwSVUYGKjct2+FJcFCKixGIGU
         H4pae0jN/l3hx6IAeTLFwyNn+H91OH8kWc7NmHc6qa1B9q3w3Zp9F7koO5Qtb1I4b5
         wqq5nzVQG7JGIekaeeiH4ttNapdSJwUL7Evye7tn0vBul5v775Nhr7uGxCKkhW/unX
         BRZSZvjwb2PGw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPxgv0960z4wb5;
        Tue, 15 Aug 2023 13:33:45 +1000 (AEST)
Date:   Tue, 15 Aug 2023 13:33:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Song Liu <song@kernel.org>, WANG Xuerui <git@xen0n.name>
Subject: linux-next: manual merge of the block tree with the loongarch tree
Message-ID: <20230815133344.065973e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wZwGBSGFO4kMbathJvWW4Yd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wZwGBSGFO4kMbathJvWW4Yd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  lib/raid6/test/Makefile

between commits:

  cc801d708472 ("raid6: Add LoongArch SIMD syndrome calculation")
  810a9b654cee ("raid6: Add LoongArch SIMD recovery implementation")

from the loongarch tree and commit:

  02ccfde87432 ("raid6: test: only check for Altivec if building on powerpc=
 hosts")

from the block tree.

I fixed it up (the changes in 02ccfde87432 are also in cc801d708472, so
I just used the former verion) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wZwGBSGFO4kMbathJvWW4Yd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa8hgACgkQAVBC80lX
0GzZ6gf/cF9nkkTBc/IpBPjtE7xuKh1aKcz13D6xRfD2NzQ7KDSS1dhuNTtSLStP
x8Xlol9WLcNIpCp+0C/eOXd2+c+1zMRSNk596X4GmLrmc8wmCERlPozblCrHtdQk
BhleUEp1qJZbSFpW/UMlsIEjEDZDMp+zXyNdjCa5f/iSY4HeywmLc33twlzTQAsd
7/KlCpBXAMRx8TZQch5+OZImPLjAnnVFZ4v9uSjrxb8iXr87zLGvJjRUvRieo8Rc
VPCuWfjxPs9rX7XwzpUUQDAAcmQi7lDao8n4CXs/2Pi7XB4JGmq/3eUXeywIdFAY
Gmb4rqnAPH6KZgnJj3aoT7ysJfRbug==
=HMnT
-----END PGP SIGNATURE-----

--Sig_/wZwGBSGFO4kMbathJvWW4Yd--
