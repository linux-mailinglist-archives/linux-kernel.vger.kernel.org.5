Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD677D8CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjJ0Bwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0Bwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:52:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC70CAB;
        Thu, 26 Oct 2023 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698371548;
        bh=Li+m75JduWeN0U8a8jow4Lt4LACk0nHbPR3A0Le1Xa4=;
        h=Date:From:To:Cc:Subject:From;
        b=begZ/e8AviitVI2YR+siU6cB95Xzg15/uG8E/rnBioZ4hQqa06Nf9FUV+ph02pmRc
         8BAWtEOjmlJKGBcdPtjH4YeYrR2zWzIycZ16Brp3h6Hr2AGGjfvKzrMR8uVH/WRXro
         rzV19cbSjMHUqpKzIgiIdeQGPpFY94sVqEo1161uar9lSQUcOLdKl0FrOfE4qdUdZ8
         C5r1qRvS+wLJXP7jTUhnMDoDVAPBjMy7WB3VYHGgafdwR/rJ8kaWvScQq6swHbCVnj
         fGKLK5OkNdNIJo6p1BIRBrwaKe6X/7rIySkkaIJe38mE/F9ogXBfe2kVkY621NnhXG
         4CeLUSRWeuTMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGlzH6jPlz4wcc;
        Fri, 27 Oct 2023 12:52:27 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 12:52:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with the asm-generic
 tree
Message-ID: <20231027125226.1ae3d41c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wK35L_caDVSj5x1VjO5Kon2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wK35L_caDVSj5x1VjO5Kon2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  arch/ia64/kernel/syscalls/syscall.tbl

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commit:

  6d54f25e4605 ("LSM: wireup Linux Security Module syscalls")

from the security tree.

I fixed it up (I just deleted the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wK35L_caDVSj5x1VjO5Kon2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7F9oACgkQAVBC80lX
0GzknQf+MxTph56NYMrQUILc5J1ljqH1T1lmfkl9assSznkMZkl/PGH1aYO8c5z9
6gmCST01UwcQK0AeC8iFtuk9Qid4elcjD/rACnBKAb/rX7FPodlP1quu0trRHCoC
MT02mMjbnk9yWA9rAJMvHTcnyj81xPa5N0HkQt1Bpo8480iWq2s7MdHdK39OZa/r
XbkAzlLBv2PGxzIOFFx95n2kPzM3Mx7OATwbZmQXrlsmf1pEkUXnWa9PozR/A9eF
XV2DAxCDS6hIS/qQLwtFY79s9XWoInUrmE0N+ch8ThTo+BwYl4E5nNh3VwL+ydsn
zKo492DoQ5tBxewM0xC0cz/WDcdVkw==
=3ys8
-----END PGP SIGNATURE-----

--Sig_/wK35L_caDVSj5x1VjO5Kon2--
