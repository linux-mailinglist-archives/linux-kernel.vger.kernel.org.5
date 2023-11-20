Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526477F0B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjKTDb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjKTDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:31:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76D194;
        Sun, 19 Nov 2023 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700451073;
        bh=41vaAHAVcWBqrA5rpQm/1MvoK8h+H9ebiB9GI+r1uEI=;
        h=Date:From:To:Cc:Subject:From;
        b=t0ABQHEC4Ag3RT7HPK7ug7eTUeNneE6pqQibW3RdTQggeM3bCLMNI2r/afUoZY4dj
         U8ZCrqJ2x8CUp5J0Bgp8Mwo48o9tRlq6ek/IKS12jrhT+h46c0hsjk2IgBnxtd7tye
         JBI8k67z+u+l2vE/Ggn6TlDC0uLDCoZqZsKGlDkP5LTYXchrlNM6r9AtEmMtCE8Nl/
         losigdHzG4wplHFdizaMr/y/QVglX51icWIaCVUH5x+Le0woY0PSKD4Ae19i/b5EBe
         zip6awBNOvncd2jUkQ2b11fIj06nBQxnZ4Swc26+CyR27ioMy50Qm+p0X88hVV2ClW
         qod7+EVdnmrAw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SYY265y0rz4xSX;
        Mon, 20 Nov 2023 14:31:10 +1100 (AEDT)
Date:   Mon, 20 Nov 2023 14:31:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: linux-next: manual merge of the security tree with the vfs-brauner
 tree
Message-ID: <20231120143106.3f8faedd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e2HIq=u2beJtMd/Pn+4yFD_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e2HIq=u2beJtMd/Pn+4yFD_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got conflicts in:

  arch/alpha/kernel/syscalls/syscall.tbl
  arch/arm/tools/syscall.tbl
  arch/arm64/include/asm/unistd32.h
  arch/m68k/kernel/syscalls/syscall.tbl
  arch/microblaze/kernel/syscalls/syscall.tbl
  arch/mips/kernel/syscalls/syscall_n32.tbl
  arch/mips/kernel/syscalls/syscall_n64.tbl
  arch/mips/kernel/syscalls/syscall_o32.tbl
  arch/parisc/kernel/syscalls/syscall.tbl
  arch/powerpc/kernel/syscalls/syscall.tbl
  arch/s390/kernel/syscalls/syscall.tbl
  arch/sh/kernel/syscalls/syscall.tbl
  arch/sparc/kernel/syscalls/syscall.tbl
  arch/x86/entry/syscalls/syscall_32.tbl
  arch/x86/entry/syscalls/syscall_64.tbl
  arch/xtensa/kernel/syscalls/syscall.tbl
  include/uapi/asm-generic/unistd.h

between commit:

  9fa5392c080e ("wire up syscalls for statmount/listmount")

from the vfs-brauner tree and commit:

  5f42375904b0 ("LSM: wireup Linux Security Module syscalls")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I also needed this merge fix patch (the former commit neglected to
update this file).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 20 Nov 2023 14:27:19 +1100
Subject: [PATCH] fix up for "LSM: wireup Linux Security Module syscalls"

interacting with commit "wire up syscalls for statmount/listmount"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/include/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unist=
d.h
index abe10a833fcd..491b2b9bd553 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
=20
-#define __NR_compat_syscalls		460
+#define __NR_compat_syscalls		462
 #endif
=20
 #define __ARCH_WANT_SYS_CLONE
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

diff --cc arch/alpha/kernel/syscalls/syscall.tbl
index 186e785f5b56,b04af0c9fcbc..000000000000
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@@ -496,5 -496,6 +496,8 @@@
  564	common	futex_wake			sys_futex_wake
  565	common	futex_wait			sys_futex_wait
  566	common	futex_requeue			sys_futex_requeue
 -567	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -568	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -569	common	lsm_list_modules		sys_lsm_list_modules
 +567	common	statmount			sys_statmount
 +568	common	listmount			sys_listmount
++569	common	lsm_get_self_attr		sys_lsm_get_self_attr
++570	common	lsm_set_self_attr		sys_lsm_set_self_attr
++571	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/arm/tools/syscall.tbl
index d6a324dbff2e,43313beefae7..000000000000
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@@ -470,5 -470,6 +470,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/arm64/include/asm/unistd32.h
index 8a191423c316,ab1a7c2b6653..000000000000
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@@ -919,10 -919,12 +919,16 @@@ __SYSCALL(__NR_futex_wake, sys_futex_wa
  __SYSCALL(__NR_futex_wait, sys_futex_wait)
  #define __NR_futex_requeue 456
  __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 -#define __NR_lsm_get_self_attr 457
 +#define __NR_statmount 457
 +__SYSCALL(__NR_statmount, sys_statmount)
 +#define __NR_listmount 458
 +__SYSCALL(__NR_listmount, sys_listmount)
++#define __NR_lsm_get_self_attr 459
+ __SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
 -#define __NR_lsm_set_self_attr 458
++#define __NR_lsm_set_self_attr 460
+ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 -#define __NR_lsm_list_modules 459
++#define __NR_lsm_list_modules 461
+ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 =20
  /*
   * Please add new compat syscalls above this comment and update
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index 37db1a810b67,90629ffc6732..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -456,5 -456,6 +456,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/microblaze/kernel/syscalls/syscall.tbl
index 07fff5ad1c9c,c395dece73b4..000000000000
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@@ -462,5 -462,6 +462,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/mips/kernel/syscalls/syscall_n32.tbl
index 134ea054b1c7,4a876c4e77d6..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@@ -395,5 -395,6 +395,8 @@@
  454	n32	futex_wake			sys_futex_wake
  455	n32	futex_wait			sys_futex_wait
  456	n32	futex_requeue			sys_futex_requeue
 -457	n32	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	n32	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	n32	lsm_list_modules		sys_lsm_list_modules
 +457	n32	statmount			sys_statmount
 +458	n32	listmount			sys_listmount
++459	n32	lsm_get_self_attr		sys_lsm_get_self_attr
++460	n32	lsm_set_self_attr		sys_lsm_set_self_attr
++461	n32	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/mips/kernel/syscalls/syscall_n64.tbl
index 959a21664703,b74c8571f063..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@@ -371,5 -371,6 +371,8 @@@
  454	n64	futex_wake			sys_futex_wake
  455	n64	futex_wait			sys_futex_wait
  456	n64	futex_requeue			sys_futex_requeue
 -457	n64	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	n64	lsm_list_modules		sys_lsm_list_modules
 +457	n64	statmount			sys_statmount
 +458	n64	listmount			sys_listmount
++459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
++460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
++461	n64	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/mips/kernel/syscalls/syscall_o32.tbl
index e55bc1d4bf0f,bf41906e1f68..000000000000
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@@ -444,5 -444,6 +444,8 @@@
  454	o32	futex_wake			sys_futex_wake
  455	o32	futex_wait			sys_futex_wait
  456	o32	futex_requeue			sys_futex_requeue
 -457	o32	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	032	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	o32	lsm_list_modules		sys_lsm_list_modules
 +457	o32	statmount			sys_statmount
 +458	o32	listmount			sys_listmount
++459	o32	lsm_get_self_attr		sys_lsm_get_self_attr
++460	032	lsm_set_self_attr		sys_lsm_set_self_attr
++461	o32	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/parisc/kernel/syscalls/syscall.tbl
index 9c84470c31c7,ccc0a679e774..000000000000
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@@ -455,5 -455,6 +455,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/powerpc/kernel/syscalls/syscall.tbl
index 6988ecbc316e,a6f37e2333cb..000000000000
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@@ -543,5 -543,6 +543,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/s390/kernel/syscalls/syscall.tbl
index 5f5cd20ebb34,4b818e9ee832..000000000000
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@@ -459,5 -459,6 +459,8 @@@
  454  common	futex_wake		sys_futex_wake			sys_futex_wake
  455  common	futex_wait		sys_futex_wait			sys_futex_wait
  456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
 -457  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
 -458  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 -459  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
 +457  common	statmount		sys_statmount			sys_statmount
 +458  common	listmount		sys_listmount			sys_listmount
++459  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
++460  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
++461  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
diff --cc arch/sh/kernel/syscalls/syscall.tbl
index 3103ebd2e4cb,1a3d88d1a07f..000000000000
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@@ -459,5 -459,6 +459,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/sparc/kernel/syscalls/syscall.tbl
index ba147d7ad19a,e0e8cec62358..000000000000
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@@ -502,5 -502,6 +502,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index 56e6c2f3ee9c,6e45e693f339..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -461,5 -461,6 +461,8 @@@
  454	i386	futex_wake		sys_futex_wake
  455	i386	futex_wait		sys_futex_wait
  456	i386	futex_requeue		sys_futex_requeue
 -457	i386	lsm_get_self_attr	sys_lsm_get_self_attr
 -458	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 -459	i386	lsm_list_modules	sys_lsm_list_modules
 +457	i386	statmount		sys_statmount
 +458	i386	listmount		sys_listmount
++459	i386	lsm_get_self_attr	sys_lsm_get_self_attr
++460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
++461	i386	lsm_list_modules	sys_lsm_list_modules
diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 3a22eef585c2,d3b41d059d4d..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -378,8 -378,9 +378,11 @@@
  454	common	futex_wake		sys_futex_wake
  455	common	futex_wait		sys_futex_wait
  456	common	futex_requeue		sys_futex_requeue
 -457	common	lsm_get_self_attr	sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr	sys_lsm_set_self_attr
 -459	common	lsm_list_modules	sys_lsm_list_modules
 +457	common	statmount		sys_statmount
 +458	common	listmount		sys_listmount
++459	common	lsm_get_self_attr	sys_lsm_get_self_attr
++460	common	lsm_set_self_attr	sys_lsm_set_self_attr
++461	common	lsm_list_modules	sys_lsm_list_modules
 =20
  #
  # Due to a historical design error, certain syscalls are numbered differe=
ntly
diff --cc arch/xtensa/kernel/syscalls/syscall.tbl
index 497b5d32f457,284784ea5a46..000000000000
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@@ -427,5 -427,6 +427,8 @@@
  454	common	futex_wake			sys_futex_wake
  455	common	futex_wait			sys_futex_wait
  456	common	futex_requeue			sys_futex_requeue
 -457	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -458	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -459	common	lsm_list_modules		sys_lsm_list_modules
 +457	common	statmount			sys_statmount
 +458	common	listmount			sys_listmount
++459	common	lsm_get_self_attr		sys_lsm_get_self_attr
++460	common	lsm_set_self_attr		sys_lsm_set_self_attr
++461	common	lsm_list_modules		sys_lsm_list_modules
diff --cc include/uapi/asm-generic/unistd.h
index b67b18e71fbd,55cc0bcfb58d..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -829,14 -829,15 +829,21 @@@ __SYSCALL(__NR_futex_wait, sys_futex_wa
  #define __NR_futex_requeue 456
  __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 =20
 -#define __NR_lsm_get_self_attr 457
 +#define __NR_statmount   457
 +__SYSCALL(__NR_statmount, sys_statmount)
 +
 +#define __NR_listmount   458
 +__SYSCALL(__NR_listmount, sys_listmount)
 +
++#define __NR_lsm_get_self_attr 459
+ __SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
 -#define __NR_lsm_set_self_attr 458
++#define __NR_lsm_set_self_attr 460
+ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 -#define __NR_lsm_list_modules 459
++#define __NR_lsm_list_modules 461
+ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+=20
  #undef __NR_syscalls
- #define __NR_syscalls 459
 -#define __NR_syscalls 460
++#define __NR_syscalls 462
 =20
  /*
   * 32 bit systems traditionally used different

--Sig_/e2HIq=u2beJtMd/Pn+4yFD_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVa0voACgkQAVBC80lX
0Gxg1wgAlyfOWCiTKsXEx5gA3DDU/I6MYRxj7LjiOenxums4I4KT2DRw1/JHLExz
6Q/BVBtI+JrQ3uUbkj664eXn2e7RBubtl8Dehe8dP2DZQfi43AMIUK9OuWXxSxuN
ffKuGRf58NNNUBvayBZipRKfuY9d6Ez6KDG8+8ASzuxXHghWs/OdKG1BRAJ093Ug
hfpmfJkhVLcM4iOChBES9ck50cL9dKrUGmqlwKilSCgSDnNlbmRwk2g4fvRwmRVE
kWsc9xvH71cPs0zm4vcilH6pDp2vo8zsc0/7IQxGUqfDeH6T9LtEyNTPyWCmK7VT
PGz1SIQB7+DNBeeubw4SGvp4cGlWEw==
=X3NJ
-----END PGP SIGNATURE-----

--Sig_/e2HIq=u2beJtMd/Pn+4yFD_--
