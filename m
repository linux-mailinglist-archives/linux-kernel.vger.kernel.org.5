Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7921771928
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHGEv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHGEvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:51:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2206E8;
        Sun,  6 Aug 2023 21:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691383882;
        bh=+OHTUnG9hspN6Fioz+w37//G9Ztq2/bB4C6owqkbznQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Bpa9SUAzrC49ddXsxa5hXLRU2D+58OMQVtseJTB9FfBSBj4soTfRdPwGWx6usM+fW
         w9tXtmH68oNOUczI5dJUcSwmVaJ47cHVCB1kyktMgd8l4oLDXDNL4/CFcKnUUF2OHP
         dSGhzno1aAHXyGWQpd+GvspOYkA2bViNPv7eVRZFmBTihInpfaHZCKVIwcS/yLtlTl
         rlhjcbfJ72ae76n/PZM4iI7/CgVzGun7abhjJRMdCprOOq1XWxD8fcC5U/6CYrk1LF
         wKnmZO4jk+oWQwFKUqrvB30C0sgtmHyh4YvImJrF5r61jsEcNS6PQeBsUH+YhwPefD
         hBJkKwbrMi8ww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RK3n639NCz4wbv;
        Mon,  7 Aug 2023 14:51:21 +1000 (AEST)
Date:   Mon, 7 Aug 2023 14:51:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the block tree
Message-ID: <20230807145120.6c2080a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x7vkhY6wo7V0xR8IwaV9ZIV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x7vkhY6wo7V0xR8IwaV9ZIV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the iomap tree as different commits
(but the same patches):

  634aae6c3333 ("iomap: support IOCB_DIO_CALLER_COMP")
  4d184b3fd1ab ("io_uring/rw: add write support for IOCB_DIO_CALLER_COMP")
  d6cb42b086fe ("fs: add IOCB flags related to passing back dio completions=
")
  7e8dcad9affa ("iomap: add IOMAP_DIO_INLINE_COMP")
  448373a0bd1d ("iomap: only set iocb->private for polled bio")
  661687f531ef ("iomap: treat a write through cache the same as FUA")
  0e40c9e86011 ("iomap: use an unsigned type for IOMAP_DIO_* defines")
  062ef9f4932e ("iomap: cleanup up iomap_dio_bio_end_io()")

These are commits

  8c052fb3002e ("iomap: support IOCB_DIO_CALLER_COMP")
  099ada2c8726 ("io_uring/rw: add write support for IOCB_DIO_CALLER_COMP")
  9cf3516c29e6 ("fs: add IOCB flags related to passing back dio completions=
")
  7b3c14d1a96b ("iomap: add IOMAP_DIO_INLINE_COMP")
  daa99c5a3319 ("iomap: only set iocb->private for polled bio")
  3a0be38cc84d ("iomap: treat a write through cache the same as FUA")
  44842f647346 ("iomap: use an unsigned type for IOMAP_DIO_* defines")
  3486237c6fe8 ("iomap: cleanup up iomap_dio_bio_end_io()")

in the iomap tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/x7vkhY6wo7V0xR8IwaV9ZIV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQeEgACgkQAVBC80lX
0GwoSwgApNO3/LZnCAuKKvlj79O3JnvLODoG407G1eUJxKuoryqCgmvBt0BiqKnf
KrSoaHnS4/sTTe6C85QN2H5kZFTZkaZE9fursTyiY/37hM3fsp1E1eV/o9ukVmHU
lByrWDT20qdbJVLVfxGncV83XxxNaP499mYak7WE8oyBfZe6PKb2kpQWuNRHOqQX
ZMxGy3SMmZC/HH5Xvo2D86BGv0N81UnO6ilGYpRt456GOIR3+kOP60N2YHx7R4eG
Qfr80GVd/5MBa82MCBlz/KmRxm8e4JnLm+pS2cB1YLwJ3fA8WL6mYauQiX224URq
Q5QYwGUExSo7Xn7OI7ewiGr+K85xeQ==
=RqbT
-----END PGP SIGNATURE-----

--Sig_/x7vkhY6wo7V0xR8IwaV9ZIV--
