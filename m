Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A27ACDDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjIYCGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjIYCGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:06:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04C1B3;
        Sun, 24 Sep 2023 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695607548;
        bh=09PcNWi1mHAWRXNLBv08f+/B1IUWwQ1VMQIQA1+lCv4=;
        h=Date:From:To:Cc:Subject:From;
        b=X/x6ZHFzmnX5AW75ZjzjzWtLTXbXULpU6JJkr4ErUP6+xfd3p8RMVAxVD2ZtOMH2U
         adu1UFvse+ubxT3nJdtKktp6oSdlEN6y91GRYtlUljE5JiI+xrMbnupGgj1xfWUvWk
         xRUxPfWNySLk5+mNjRFRsvjkoeYoOLzpdYY/MBQpey2cqyyWGJWJmKEL9EjEHgWXAt
         SM1P7FwthGPVHOCCBEjqD0hH9VM1Wc0Sh6hbCTyyQM3J5ABMbEopCMUQvcK1giuGAH
         d2Aghs9exCF0Rl6DKm1HIyFWDl+3u0aovbCUhjr+PqIop3YnFkivpFLiml7nQTiD+8
         fxChXjBbsXn0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv5nR22JLz4xPd;
        Mon, 25 Sep 2023 12:05:45 +1000 (AEST)
Date:   Mon, 25 Sep 2023 12:05:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20230925120544.7b1baece@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vS4yXq8BsaB70Zn7TO+nQ_a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vS4yXq8BsaB70Zn7TO+nQ_a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  arch/ia64/kernel/syscalls/syscall.tbl

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commits:

  9f6c532f59b2 ("futex: Add sys_futex_wake()")
  cb8c4312afca ("futex: Add sys_futex_wait()")
  0f4b5f972216 ("futex: Add sys_futex_requeue()")

from the block tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vS4yXq8BsaB70Zn7TO+nQ_a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ6vgACgkQAVBC80lX
0Gzdvgf/QEeWnf4vJ6D8wEWSHt1omMGeNhKh6nl36O1k92EafU0J9UzPGBhBqwr9
0CRrgTrJZ23ghFDk2LBIDxplHPdjOaqr/ZbXit2RCzYGRKtHeNgds5UQghIdZAYm
EI1P6JUO5xL9CCdZn46RMvHLfQHuU9U8Fdrn6hOAGl8mcIIgHGNMBHd+T9iG0Qy2
S5Lb6L+wTnEEQWqfHvkW9DpHdyL96gmJzmiYomQXMO9nUvJlGtMvEqeh4FXOMc/X
j9nXYYw1zKzvloFO0miNyktXx8CZcLloYdgItSD5SF32A/A4eqXec3BVM6pfNsRP
/1RYFlfO66KMLQPLNbjEs4V5yRgGtQ==
=XddB
-----END PGP SIGNATURE-----

--Sig_/vS4yXq8BsaB70Zn7TO+nQ_a--
