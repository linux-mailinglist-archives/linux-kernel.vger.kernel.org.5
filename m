Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823477D2927
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJWDni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWDnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:43:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01803E9;
        Sun, 22 Oct 2023 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698032609;
        bh=L4G7r3JKX/EKtlPlRiCIHwdaJDX0XxVWfwQ/mnLSrN8=;
        h=Date:From:To:Cc:Subject:From;
        b=PA8VN58FCQc6wgh1CgA3hJVu4N5qo622L+anqrGYroAAReRdfXatWrE+Q7TaX23iy
         15YUUZvuORUkuj8CLWO+4WoEGhw8mNzZSDucmF7TJn9mtHo32GatgcxC8KhUXPZcyZ
         XsBhmAg2Xv/Kx5IH20P5lnjZ0TKkRTtZlRxk9SiUDrhu3vDgbgNb6xXVyynoAhlqeM
         R9/FQdBI+PSitZb9oeA1FIHY5bnKWTsmZcecj0nOYagxeBmdj0LPiaobYj6xx7RBjc
         2bAMi5CnqPT6l8wZ7MnOAX6lrktuUCisWQbezpgsfX9wohbX94lo1RnpATYj+eopB7
         8FfwRvS+9ZVsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDLdD4Rt1z4wcZ;
        Mon, 23 Oct 2023 14:43:28 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 14:43:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the asm-generic tree
Message-ID: <20231023144327.7d18a847@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lY6zbmuHc_NYgREe9GwRz7g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lY6zbmuHc_NYgREe9GwRz7g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got conflicts in:

  arch/ia64/kernel/setup.c
  drivers/firmware/pcdp.c

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commits:

  8a736ddfc861 ("vgacon: rework screen_info #ifdef checks")
  acfc78823326 ("vgacon: remove screen_info dependency")
  555624c0d10b ("vgacon: clean up global screen_info instances")

from the tty tree.

I fixed it up (I deleted the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/lY6zbmuHc_NYgREe9GwRz7g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU1698ACgkQAVBC80lX
0Gzw6Af8CwiYTjOWYSB1KYDeZ3mWFgbZuLbzIwoB3Xcacx63y7xOTE3kE8IwIJXY
M356nrLmbipWG+aly01ofbSO+2qO7/P2/mLnzCrNpYWLxS/46m9EWBKtvIYMqgfO
n1P+St/S5Zo85qVACqMyuQlYNvRCoOlTXiiTCyXFgZNfmOqyQQWi+FSN6qnNhS1k
FpNiVwm+e6ZPkOFU+YCdfWeOjxdwl0DHd7NmSGwX6D+CHw8m0IoxBVfh+CUWBcNA
JEkgU95/LjbG9pvCXOUPGjN5i/FJbgnu9OS35AfI7bZDOPEmtK+JmqJu3IQmvxvS
EKv++w9a3XwcGj3LBxms9fOUNueEog==
=GwjP
-----END PGP SIGNATURE-----

--Sig_/lY6zbmuHc_NYgREe9GwRz7g--
