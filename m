Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301E07D8CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbjJ0BuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:50:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB7111;
        Thu, 26 Oct 2023 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698371411;
        bh=FxqQioxgFWQDzlULRuwZiUIrEuL3ELgNmRP4kxtbK9w=;
        h=Date:From:To:Cc:Subject:From;
        b=N3PUQeqO5qyYL/6gVce3rB4YIAa460QObyawMmiw4InubVmGe2pU6E4XnZVtePtIL
         ClL3myGSTD9cAAfPrmeLtN/dPyaYB9rtsgI47J+ynSHK8R2frk9BL36VWP0oMhxYkw
         RUmjj6AEBnU7OEwixfZd1VdT8uz1LQb8XFE8AykmrUwgBBTrWEa6BOj6RutUN/qkz3
         5ae+tIAj/Pn0EIwhkZP65MOsAJWQKgl09Uqw8dvsWqfZIw6C7CRSXvJ0kuRS9QhSrU
         unWjN3K/NMeui8qGXUoEBFyzRDljxPiyGqg5O0M+UbwhsGQJPkYj1CPmA8zMKWrTDa
         UHaJLxrhwubfQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGlwb6lBKz4wd1;
        Fri, 27 Oct 2023 12:50:07 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 12:50:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: linux-next: manual merge of the security tree with the asm-generic,
 block and tip trees
Message-ID: <20231027125006.58d5e94f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vSVfm6BDLKc+oBR9f.VjDHL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vSVfm6BDLKc+oBR9f.VjDHL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got conflicts in:

  arch/alpha/kernel/syscalls/syscall.tbl
  arch/arm/tools/syscall.tbl
  arch/arm64/include/asm/unistd.h
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

between commits:

  2fd0ebad27bc ("arch: Reserve map_shadow_stack() syscall number for all ar=
chitectures")
  9f6c532f59b2 ("futex: Add sys_futex_wake()")
  cb8c4312afca ("futex: Add sys_futex_wait()")
  0f4b5f972216 ("futex: Add sys_futex_requeue()")

from the asm-generic, block and tip trees and commit:

  6d54f25e4605 ("LSM: wireup Linux Security Module syscalls")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/alpha/kernel/syscalls/syscall.tbl
index 18c842ca6c32,01f4d0889a36..000000000000
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@@ -492,7 -492,6 +492,10 @@@
  560	common	set_mempolicy_home_node		sys_ni_syscall
  561	common	cachestat			sys_cachestat
  562	common	fchmodat2			sys_fchmodat2
 -563	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -564	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -565	common	lsm_list_modules		sys_lsm_list_modules
 +563	common	map_shadow_stack		sys_map_shadow_stack
 +564	common	futex_wake			sys_futex_wake
 +565	common	futex_wait			sys_futex_wait
 +566	common	futex_requeue			sys_futex_requeue
++567	common	lsm_get_self_attr		sys_lsm_get_self_attr
++568	common	lsm_set_self_attr		sys_lsm_set_self_attr
++569	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/arm/tools/syscall.tbl
index 584f9528c996,e12db7b9fb8d..000000000000
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@@ -466,7 -466,6 +466,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/arm64/include/asm/unistd.h
index 531effca5f1f,f33190f17ebb..000000000000
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@@ -39,7 -39,7 +39,7 @@@
  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 =20
- #define __NR_compat_syscalls		457
 -#define __NR_compat_syscalls		456
++#define __NR_compat_syscalls		460
  #endif
 =20
  #define __ARCH_WANT_SYS_CLONE
diff --cc arch/arm64/include/asm/unistd32.h
index 9f7c1bf99526,557345b38893..000000000000
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@@ -911,14 -911,12 +911,20 @@@ __SYSCALL(__NR_set_mempolicy_home_node
  __SYSCALL(__NR_cachestat, sys_cachestat)
  #define __NR_fchmodat2 452
  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 -#define __NR_lsm_get_self_attr 453
 +#define __NR_map_shadow_stack 453
 +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
 +#define __NR_futex_wake 454
 +__SYSCALL(__NR_futex_wake, sys_futex_wake)
 +#define __NR_futex_wait 455
 +__SYSCALL(__NR_futex_wait, sys_futex_wait)
 +#define __NR_futex_requeue 456
 +__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
++#define __NR_lsm_get_self_attr 457
+ __SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
 -#define __NR_lsm_set_self_attr 454
++#define __NR_lsm_set_self_attr 458
+ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 -#define __NR_lsm_list_modules 455
++#define __NR_lsm_list_modules 459
+ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 =20
  /*
   * Please add new compat syscalls above this comment and update
diff --cc arch/m68k/kernel/syscalls/syscall.tbl
index 7a4b780e82cb,215547a74374..000000000000
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@@ -452,7 -452,6 +452,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/microblaze/kernel/syscalls/syscall.tbl
index 5b6a0b02b7de,24174dc2045f..000000000000
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@@ -458,7 -458,6 +458,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/mips/kernel/syscalls/syscall_n32.tbl
index a842b41c8e06,dc3395c37b1e..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@@ -391,7 -391,6 +391,10 @@@
  450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	n32	cachestat			sys_cachestat
  452	n32	fchmodat2			sys_fchmodat2
 -453	n32	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	n32	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	n32	lsm_list_modules		sys_lsm_list_modules
 +453	n32	map_shadow_stack		sys_map_shadow_stack
 +454	n32	futex_wake			sys_futex_wake
 +455	n32	futex_wait			sys_futex_wait
 +456	n32	futex_requeue			sys_futex_requeue
++457	n32	lsm_get_self_attr		sys_lsm_get_self_attr
++458	n32	lsm_set_self_attr		sys_lsm_set_self_attr
++459	n32	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/mips/kernel/syscalls/syscall_n64.tbl
index 116ff501bf92,06cad00543e8..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@@ -367,7 -367,6 +367,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	n64	cachestat			sys_cachestat
  452	n64	fchmodat2			sys_fchmodat2
 -453	n64	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	n64	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	n64	lsm_list_modules		sys_lsm_list_modules
 +453	n64	map_shadow_stack		sys_map_shadow_stack
 +454	n64	futex_wake			sys_futex_wake
 +455	n64	futex_wait			sys_futex_wait
 +456	n64	futex_requeue			sys_futex_requeue
++457	n64	lsm_get_self_attr		sys_lsm_get_self_attr
++458	n64	lsm_set_self_attr		sys_lsm_set_self_attr
++459	n64	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/mips/kernel/syscalls/syscall_o32.tbl
index 525cc54bc63b,6ecc14091da3..000000000000
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@@ -440,7 -440,6 +440,10 @@@
  450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	o32	cachestat			sys_cachestat
  452	o32	fchmodat2			sys_fchmodat2
 -453	o32	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	032	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	o32	lsm_list_modules		sys_lsm_list_modules
 +453	o32	map_shadow_stack		sys_map_shadow_stack
 +454	o32	futex_wake			sys_futex_wake
 +455	o32	futex_wait			sys_futex_wait
 +456	o32	futex_requeue			sys_futex_requeue
++457	o32	lsm_get_self_attr		sys_lsm_get_self_attr
++458	032	lsm_set_self_attr		sys_lsm_set_self_attr
++459	o32	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/parisc/kernel/syscalls/syscall.tbl
index a47798fed54e,5b321bb46374..000000000000
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@@ -451,7 -451,6 +451,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/powerpc/kernel/syscalls/syscall.tbl
index 7fab411378f2,491eea2f88ba..000000000000
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@@ -539,7 -539,6 +539,10 @@@
  450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_ni_syscall
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/s390/kernel/syscalls/syscall.tbl
index 7fa9b531d095,653400f82211..000000000000
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@@ -455,7 -455,6 +455,10 @@@
  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_m=
empolicy_home_node
  451  common	cachestat		sys_cachestat			sys_cachestat
  452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 -453  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
 -454  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
 -455  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
 +453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
 +454  common	futex_wake		sys_futex_wake			sys_futex_wake
 +455  common	futex_wait		sys_futex_wait			sys_futex_wait
 +456  common	futex_requeue		sys_futex_requeue			sys_futex_requeue
++457  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
++458  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
++459  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
diff --cc arch/sh/kernel/syscalls/syscall.tbl
index 363fae0fe9bf,a4bc4047858e..000000000000
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@@ -455,7 -455,6 +455,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/sparc/kernel/syscalls/syscall.tbl
index 7bcaa3d5ea44,b134ad689789..000000000000
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@@ -498,7 -498,6 +498,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803,e921e0d6c4b3..000000000000
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@@ -457,7 -457,6 +457,10 @@@
  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	i386	cachestat		sys_cachestat
  452	i386	fchmodat2		sys_fchmodat2
 -453	i386	lsm_get_self_attr	sys_lsm_get_self_attr
 -454	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 -455	i386	lsm_list_modules	sys_lsm_list_modules
 +453	i386	map_shadow_stack	sys_map_shadow_stack
 +454	i386	futex_wake		sys_futex_wake
 +455	i386	futex_wait		sys_futex_wait
 +456	i386	futex_requeue		sys_futex_requeue
++457	i386	lsm_get_self_attr	sys_lsm_get_self_attr
++458	i386	lsm_set_self_attr	sys_lsm_set_self_attr
++459	i386	lsm_list_modules	sys_lsm_list_modules
diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c,b70920626b8c..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -375,9 -375,9 +375,12 @@@
  451	common	cachestat		sys_cachestat
  452	common	fchmodat2		sys_fchmodat2
  453	64	map_shadow_stack	sys_map_shadow_stack
 -454	common	lsm_get_self_attr	sys_lsm_get_self_attr
 -455	common	lsm_set_self_attr	sys_lsm_set_self_attr
 -456	common	lsm_list_modules	sys_lsm_list_modules
 +454	common	futex_wake		sys_futex_wake
 +455	common	futex_wait		sys_futex_wait
 +456	common	futex_requeue		sys_futex_requeue
++457	common	lsm_get_self_attr	sys_lsm_get_self_attr
++458	common	lsm_set_self_attr	sys_lsm_set_self_attr
++459	common	lsm_list_modules	sys_lsm_list_modules
 =20
  #
  # Due to a historical design error, certain syscalls are numbered differe=
ntly
diff --cc arch/xtensa/kernel/syscalls/syscall.tbl
index 06eefa9c1458,e1fe5ed7cad8..000000000000
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@@ -423,7 -423,6 +423,10 @@@
  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
  451	common	cachestat			sys_cachestat
  452	common	fchmodat2			sys_fchmodat2
 -453	common	lsm_get_self_attr		sys_lsm_get_self_attr
 -454	common	lsm_set_self_attr		sys_lsm_set_self_attr
 -455	common	lsm_list_modules		sys_lsm_list_modules
 +453	common	map_shadow_stack		sys_map_shadow_stack
 +454	common	futex_wake			sys_futex_wake
 +455	common	futex_wait			sys_futex_wait
 +456	common	futex_requeue			sys_futex_requeue
++457	common	lsm_get_self_attr		sys_lsm_get_self_attr
++458	common	lsm_set_self_attr		sys_lsm_set_self_attr
++459	common	lsm_list_modules		sys_lsm_list_modules
diff --cc include/uapi/asm-generic/unistd.h
index d087a2cf86c7,f10906c71711..000000000000
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@@ -822,18 -822,16 +822,25 @@@ __SYSCALL(__NR_cachestat, sys_cachestat
 =20
  #define __NR_fchmodat2 452
  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 +#define __NR_map_shadow_stack 453
 +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
 =20
 -#define __NR_lsm_get_self_attr 453
 +#define __NR_futex_wake 454
 +__SYSCALL(__NR_futex_wake, sys_futex_wake)
 +#define __NR_futex_wait 455
 +__SYSCALL(__NR_futex_wait, sys_futex_wait)
 +#define __NR_futex_requeue 456
 +__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 +
++#define __NR_lsm_get_self_attr 457
+ __SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
 -#define __NR_lsm_set_self_attr 454
++#define __NR_lsm_set_self_attr 458
+ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
 -#define __NR_lsm_list_modules 455
++#define __NR_lsm_list_modules 459
+ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+=20
  #undef __NR_syscalls
- #define __NR_syscalls 457
 -#define __NR_syscalls 456
++#define __NR_syscalls 460
 =20
  /*
   * 32 bit systems traditionally used different

--Sig_/vSVfm6BDLKc+oBR9f.VjDHL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7F04ACgkQAVBC80lX
0GyvNAf9Fh7DI4uHZK0WWvUlmGenoYuM1ezlbuP4UsSrw40dVdDar+ZoQFFtWbiW
uFWpV1ZsI13njluauBvBqeDczboawMJj/Xg1Zz6Xx8hnJ1l5JZALGdTjVuYCy8I5
Chq0rDCFKVPpI73MqNmR6QTKj2KzLJVZtWRhNyyq7l1NBvXr0TvmFfhxWbKmdvxR
1XjJDbLYLF04Wf9wCLmicakvt4HZHtcxbL529WpP07LsLqe6w3+o9tb8AyJCyEZu
JixcRLv+av/xU1BZNXlVwU7a3Nn/G7Rvotn9TPZkrF26xPFPhwWmgA+zMmQFxTP+
KKIDcY/8ShX8HZw8Wsw3w2kxEjtaHg==
=3t1+
-----END PGP SIGNATURE-----

--Sig_/vSVfm6BDLKc+oBR9f.VjDHL--
