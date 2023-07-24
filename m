Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569376033E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGXXkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXXkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:40:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229951700;
        Mon, 24 Jul 2023 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690242016;
        bh=6TF4rTDCnEeLmpa+s/bHmP4F9sA3NfG4Z+Y5NgPOx6o=;
        h=Date:From:To:Cc:Subject:From;
        b=mmFjBMv1NncnWp1P3bsXTwpPKa2LTG+OKU1jOxXBRW8yPQwZHpVFi8VYRJu6s4ZM4
         QPfq/KrLFX7gsYtQAhquY3cFPMk+BDZLIdWDB5bHUhLHsrdDnmL3AAfHFByqaVadWR
         iOnuAAQeqrR8u5J4d0TJDlD4qcwG8jKsVJ09w9gO/6qHjmardwp7P83CLl8U+8HSv0
         dAagsQeprGqg/Ww+huEN3clrX0nztdUJncSxM4zrliQ2CWc9Mz2HI7GI3Gok8LGE+h
         LT3iKzZkn29xGunrS+Q2BZ8XaBQ2HQrCAQfD/NDIexK3xOIbh1Y5CWcZmmaTyqlNqK
         9jUjQ8Su9hGtQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8xV74Z3Gz4wZw;
        Tue, 25 Jul 2023 09:40:15 +1000 (AEST)
Date:   Tue, 25 Jul 2023 09:40:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anastasia Eskova <anastasia.eskova@ibm.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the s390 tree with the mm tree
Message-ID: <20230725094013.2dfb0168@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B8tY7A9iU/ozSC9TTOSK89E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B8tY7A9iU/ozSC9TTOSK89E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the s390 tree got a conflict in:

  arch/s390/Kconfig

between commit:

  b2d2d291f588 ("s390/kexec: refactor for kernel/Kconfig.kexec")

from the mm tree and commits:

  8cf57d7217c3 ("s390: add support for user-defined certificates")
  37002bc6b603 ("docs: move s390 under arch")

from the s390 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/Kconfig
index 736548e4163e,d9d50a7a2016..000000000000
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@@ -246,28 -245,6 +247,28 @@@ config PGTABLE_LEVEL
 =20
  source "kernel/livepatch/Kconfig"
 =20
 +config ARCH_DEFAULT_KEXEC
 +	def_bool y
 +
 +config ARCH_SUPPORTS_KEXEC
 +	def_bool y
 +
 +config ARCH_SUPPORTS_KEXEC_FILE
 +	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
 +
 +config ARCH_SUPPORTS_KEXEC_SIG
 +	def_bool MODULE_SIG_FORMAT
 +
 +config ARCH_SUPPORTS_KEXEC_PURGATORY
 +	def_bool KEXEC_FILE
 +
 +config ARCH_SUPPORTS_CRASH_DUMP
 +	def_bool y
 +	help
- 	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on th=
is.
++	  Refer to <file:Documentation/arch/s390/zfcpdump.rst> for more details =
on this.
 +	  This option also enables s390 zfcpdump.
- 	  See also <file:Documentation/s390/zfcpdump.rst>
++	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 +
  menu "Processor type and features"
 =20
  config HAVE_MARCH_Z10_FEATURES
@@@ -506,6 -483,46 +507,16 @@@ config SCHED_TOPOLOG
 =20
  source "kernel/Kconfig.hz"
 =20
 -config KEXEC
 -	def_bool y
 -	select KEXEC_CORE
 -
 -config KEXEC_FILE
 -	bool "kexec file based system call"
 -	select KEXEC_CORE
 -	depends on CRYPTO
 -	depends on CRYPTO_SHA256
 -	depends on CRYPTO_SHA256_S390
 -	help
 -	  Enable the kexec file based system call. In contrast to the normal
 -	  kexec system call this system call takes file descriptors for the
 -	  kernel and initramfs as arguments.
 -
 -config ARCH_HAS_KEXEC_PURGATORY
 -	def_bool y
 -	depends on KEXEC_FILE
 -
 -config KEXEC_SIG
 -	bool "Verify kernel signature during kexec_file_load() syscall"
 -	depends on KEXEC_FILE && MODULE_SIG_FORMAT
 -	help
 -	  This option makes kernel signature verification mandatory for
 -	  the kexec_file_load() syscall.
 -
 -	  In addition to that option, you need to enable signature
 -	  verification for the corresponding kernel image type being
 -	  loaded in order for this to work.
 -
+ config CERT_STORE
+ 	bool "Get user certificates via DIAG320"
+ 	depends on KEYS
+ 	help
+ 	  Enable this option if you want to access user-provided secure boot
+ 	  certificates via DIAG 0x320.
+=20
+ 	  These certificates will be made available via the keyring named
+ 	  'cert_store'.
+=20
  config KERNEL_NOBP
  	def_bool n
  	prompt "Enable modified branch prediction for the kernel by default"

--Sig_/B8tY7A9iU/ozSC9TTOSK89E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS/C94ACgkQAVBC80lX
0GzKTwf+O430WpSO8cWrvBRBn79P4xascKyk+fMYw3JRbQBGHHa4uhP4Q/JllMgi
TeveP0AocecBKJ1zIT7Ua/HMQcBhi3ExdP2xDAdcyElijGzrSwXvylAfSvcQN3Oe
nM17Pd2IfeXJJBpuw+bOTgvMUZRz/XmIyDHZZ9yL+LL+GCLTr6bieItTXplXqZcc
lmGETpX9JLfi5jzfLEWQVeN0BXdOJNTTtO2UupCSU4UgH+p3TgzCZowWOOzAHShB
5vOILxMOZ2AFsKogxZi+jHNvkE7v6/1rUG3uNXFKAAI/at2KIaKz8OsuJd3zHSF0
oAJajbqV0XLtCFr4KAZB291SkQs0Nw==
=ZgbY
-----END PGP SIGNATURE-----

--Sig_/B8tY7A9iU/ozSC9TTOSK89E--
