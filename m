Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F9783702
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHVAQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjHVAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:16:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C091A8;
        Mon, 21 Aug 2023 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692663378;
        bh=k2ZrAAORqZd1ybuBEXkZq8qLjVGqshyS/ofyxUhkJk8=;
        h=Date:From:To:Cc:Subject:From;
        b=eYuYRY9QKqPLF/nAstussaWknreBAk+B/WEpFUK5NEgqsKt0SXx1oTQStoHFDJWd0
         06pY5vJ37BZb8t76hOvUzaBi8C/82HndW6Yih8BtmQX1YrGapxnRccCqVVXny6e0bc
         6cNVIq6RI9vq5rFOWnDKFS3gp22FFKIwYmApvgJcfYV/gHgjl7ffWtP0qi1hx9iFZm
         9vnlYBQ1nEowXAorfdr5vUTZhukyz3K6YGGSFpGaosFuDO58aeoPlCa+8yDR8DI1uF
         rX/7B1BTUn5Okqvbsc4KvP/WLmSxSteZdFF/Pm9E6NcpZI+CGp1x05ITOwZvDs8hhJ
         rthk/M5UR50FA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RV8yp3Zgmz4wb0;
        Tue, 22 Aug 2023 10:16:18 +1000 (AEST)
Date:   Tue, 22 Aug 2023 10:16:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: linux-next: manual merge of the powerpc tree with the mm-stable
 tree
Message-ID: <20230822101615.046f0c32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qXSVAU3nkCzwSZSkVMZ_B4y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qXSVAU3nkCzwSZSkVMZ_B4y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/Kconfig

between commit:

  8d05554dca2a ("powerpc: mm: convert to GENERIC_IOREMAP")

from the mm-stable tree and commit:

  0ceef6e99cc3 ("powerpc/idle: Add support for nohlt")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/Kconfig
index 21edd664689e,c831e20cf40f..000000000000
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@@ -195,7 -194,7 +196,8 @@@ config PP
  	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
  	select GENERIC_EARLY_IOREMAP
  	select GENERIC_GETTIMEOFDAY
+ 	select GENERIC_IDLE_POLL_SETUP
 +	select GENERIC_IOREMAP
  	select GENERIC_IRQ_SHOW
  	select GENERIC_IRQ_SHOW_LEVEL
  	select GENERIC_PCI_IOMAP		if PCI

--Sig_/qXSVAU3nkCzwSZSkVMZ_B4y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTj/k8ACgkQAVBC80lX
0GxCMAgAlFzgy+Rn2m3nNB1KybK8ks+xuSJdcicuO00rmVqXUhb9zRM9uLuF9HK8
yNvBMZ6D23sDyBuW+NN51BhHxU5PMx2uAqNpt0TStImpGdPcL/rrQ66wZcaxNijH
pxy0MAGxpm985rw7Ua8esMUon09AHrne98AJh9fMQ3lk20/eGIbal9P4VwClay+W
MohrkVd2LaHyOPI6FjnK7GHlmYilVncq3zt0L3kuEwWNJR0UB34ZA7kRBPC1qj3q
j9n94Vz5/u9h6lju4T7pnfw59QE8gFt2n5rTjP3T197oXNBy0nzrSZ7r7MpQeQJP
eWEFpn4punhaXMq4BWZY+0nQA2f/iA==
=T/9b
-----END PGP SIGNATURE-----

--Sig_/qXSVAU3nkCzwSZSkVMZ_B4y--
