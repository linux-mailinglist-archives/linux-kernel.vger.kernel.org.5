Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCF79DA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjILVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjILVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:00:28 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F21199
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552423; bh=Akwyqcsww5wfwBoCwraOpddrN8qmbdeZf0exZ2qg8W8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=p/xiVKHL6zlT2g9qXSf5FZl6m4VCkTDxCdFUOHfKBRQeQ21W3aKoz6/pkeErQttG4u4FZsauQ+O2iLtgv7YGPDnpcCSSrmYeC05CywQN5w+xEqRyE7ouoWveAgimGebDWv7sh6wN6XuEttZ9uosdxubSzalBiXpDGe5vdsh5OwYMGfUfRYqBRSZJB97otHBKseRWnKlUn3Zly737kW227IH3Ajjod+Tx5UQNtQXToYkncb8oU/hLljOVEPW5tjsSYSnQLDX4I+bGM2d2vmeE8gnq87PRe8o9by69RYrW0HdTyjY1lsshUuV4S7cJyOevUvfejruwfFrz4tUaZnJPMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552423; bh=yszVlrO1bexngv1RIYzjkMcG1ELw1den9HWaleBYI+y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eY604PUTiTDU35GKYDA8EImdd6qU3QfCLnl490caO7mFYgmxOO3NWHnmKSeQZo83Vt/EkqFaTgFxwC8i+YFEDc/weKa44cdAEszDl91Ha72o2eXY0Z1DaWvzDcevU/xy35vQ+CE2J5YvVXHp7YIIi3vvelZbFdoRhrisgU7DeNoG+lC3iNZClchcyInS3ppOf5nM6ODqFbiUgh7Pb8t3ESI+nrrlehXVPTMZrvsnpyzVXJjjbuRMDrnFUJ476IFGRsPdktc3ZwfQ27oEEIEGBhAhyqpvH/58O6XTPMLn/mDqgpnbFeFRsTWL5RHiLBAz6XCySSQ04gFywZG4KZ/xFg==
X-YMail-OSG: gQtK1kUVM1ntB92xyvyMxL2kEup5_M6ssIHit9YAtbVMPAVI5c3jjg5OZM6KuXf
 2ItDNg8Cf_CjsOQXJRzFI67SmuTxRUhcPfHWEovGtv_ySWVL7Bj5myqSMra1zi_aB9GmcrocA3oN
 tfSEpRcC18wKFl2a4MOVrfYG8s3xIVprBuEuJ7AyzhvnqYtQPOj7IaHELuMDiwuqhvqwYyK2tnRJ
 0ejZcj58CtIxshbAi7Om1LwxzrUebUAsk_vS0Cpt3B3AdPFSnveB5J3IYHtq77kR.HdjEHZ5SPj5
 im57hIXunRX4eIf3018AN8vxRy_Jn5OMVvzvJiS7_Qdm7WgMn2g6wKM1X41m1PLbuze89W4imsBP
 UUyLxbn1aEi9sMx4QVCsySPMREVspHv3bVVKvrOcqHXAsGEVjGvM.aBZkBEGc1U8EkFEtTxRTtoX
 ibxU9aVhKCIIFl_fA1mLTPSw6bFKY0d1a4hDXGc2JUy1YMS_lKCi.wN_Zh2ruTOm7uPUQRFxG8vz
 UlGUzYiWpMe8eMBezp4XUfKmm8wTaO2yy3fTcUYqLwOFPan3677fUX7ndfGq.GlAZpFJsgTaLUrv
 lI561CJ4RaFg5lgsqufSD7.CnOSGcJvMXl3QlrHVrNV71bcYXAewrJh4TDjmWCZyto7sIRJaTSna
 BdTTT3hxY6MuTxowk3oOJ3ycJ1YXNMTC_ENpcSPCiT5S7NGYwGA.Uy9hWR2wy3wdOKt4ZUFFj0ue
 .ixoozrdGCBRAT5EnWOzd8cCydUxm6d3nGYzV5HFZFfhvAshgFYRR1rmrRpNY09EMcuLFxIFrs77
 2CPJYt.eAuWL5P2su_W0WmR_gAeW4fHztRR_Q_UcphMCyxmxlRR3lYW3f.xiy1Ki46PCWveZt5ib
 gen218Apo99_Rt4RxnF.j50qaVkZc2cy3VREL6hM2LShj5KZC2re_TIxtIn9.Uo5ULCZNkj4Z9sw
 mzAJLJzYKrynTU3dwolEoW7_TH6aI8waqbzw2EuKAeDfQnoN2XxCmrjqaEK8KPwwPXJgJDOVo_hP
 BpD92z_11saTqEsV1fP9RsSdVgqygGaI.sUEquHxAZ.Uygb3RHp.axhUi9Xmiq2qPPbtYk21NKZ6
 BSozK1dVXSIhCfNhtbA9Yrz8rhDHqRtpJo.cq7tG5ZXaVQ4E_thpVhqYDDIlv_W4Ke1I9EuF4mvp
 msYlyZiLjmouofm5k.DbQD6f4ngvRXkw_bKf5lYo6AAdKK05Xf3LRhUvSv.FtcqFYPBHiVa_9WeZ
 ntxiV4d40fFNw18wW5RRvBxqoiIDhMfFsgGoZq2hHYO8uYks_v0NoqmzUC4FM1HbZsBfv499Hdvk
 Tp48ghbzwKcMAsCdrOPpV0BDTVUQ94YQLkWHYhzjRHhJWGPLkGlHvDZBICNKLn6YUTH9ZGg3JI9N
 xZsGbMMhxJdAROcyeDiZYoGAHBYoN85RcuZhZHBSXhuCaZVeGmD.FoezA9BkebFUYVBGWVjHfCOa
 oipEiWm3yVmsdAG_i3xYrTTY9.SZiDv6asAfWezK5Uf7J7LTu7qZDiwkQkNVcnAh4fcp1RAinDZD
 W1Y7vXwaFid53acCHWrUtJ8ZPbAKw_.rdzjKfWSz.vQhIXdNE6C1o.MPEu.8PqECfLirnatPw9Ce
 UanH76ovCin0xPj5FTo5d8IIwaZ7IERZRMS1KlRR5JYp8dT1XkLZDPK6uvunA3If5cHBKoMdgVPx
 vPbxaASKS7gjB3F_3dxxOPanSnipezMckM1P8yZmwrtklVWp2UUi06YCTL6qzaXO9v8FoKyLGdD1
 iFSEAk1myVbRVY0s.xHpdiW3HKAfuO267BUvHsEt.C32GfUNicdjXDYV83fHTM3tVCoIOV_s4FF3
 eTqC1tYaKlzkb0Ju1FST1eRUajW794UgT60RrNSKrYeSfhuM3RUAJ6ao.0XpXPmZi5qNVuDmh3jj
 FlcVgaGUEyuGuX9CY3jy4uOqGY_pzCv.EgtbaJ9KcI9zSdberOvM2dCVsi7DAWo2mW5ckw5LQmS3
 KGL7hvYW5wUAjU4wXWeAjRtoHnRQiMwL01Z33j7opaiHqFTXAt95stvSzj3n76HLy7E2.0uSzfVB
 63M_k.ht9nPXpR0GLsLbTz_jFMqWqCmSbmgHmquMgYIbt6XCGPbIBAxcewZgFLWulgV6ALFuDz13
 QNWV5h9EO17b9Lc_TiRkXUK2FVb_FOSd11M7TLUJBClfePQxBX_awcnrUMuD6cPKx746q7M.eNSt
 6l3ezb0ubk4EFRoBl.aSTNKgfm0T86wyYa9ty.qU0b.ZXFco6ErHpxzof4vUood_aSx6vXhsOn2v
 fdpGEhc7L2bAKKyvqHYU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ee64c6c2-fec4-48dd-973b-b353ca7cc02f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 21:00:23 +0000
Received: by hermes--production-gq1-6b7c87dcf5-j6k2s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a386478821340d4a39b6ed725da40e04;
          Tue, 12 Sep 2023 21:00:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v15 06/11] LSM: wireup Linux Security Module syscalls
Date:   Tue, 12 Sep 2023 13:56:51 -0700
Message-ID: <20230912205658.3432-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_list_modules
system calls.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org
---
 arch/alpha/kernel/syscalls/syscall.tbl              | 3 +++
 arch/arm/tools/syscall.tbl                          | 3 +++
 arch/arm64/include/asm/unistd.h                     | 2 +-
 arch/arm64/include/asm/unistd32.h                   | 6 ++++++
 arch/ia64/kernel/syscalls/syscall.tbl               | 3 +++
 arch/m68k/kernel/syscalls/syscall.tbl               | 3 +++
 arch/microblaze/kernel/syscalls/syscall.tbl         | 3 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl           | 3 +++
 arch/mips/kernel/syscalls/syscall_n64.tbl           | 3 +++
 arch/mips/kernel/syscalls/syscall_o32.tbl           | 3 +++
 arch/parisc/kernel/syscalls/syscall.tbl             | 3 +++
 arch/powerpc/kernel/syscalls/syscall.tbl            | 3 +++
 arch/s390/kernel/syscalls/syscall.tbl               | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl                 | 3 +++
 arch/sparc/kernel/syscalls/syscall.tbl              | 3 +++
 arch/x86/entry/syscalls/syscall_32.tbl              | 3 +++
 arch/x86/entry/syscalls/syscall_64.tbl              | 3 +++
 arch/xtensa/kernel/syscalls/syscall.tbl             | 3 +++
 include/uapi/asm-generic/unistd.h                   | 9 ++++++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 3 +++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 3 +++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 3 +++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 3 +++
 23 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ad37569d0507..01f4d0889a36 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,6 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
+563	common	lsm_get_self_attr		sys_lsm_get_self_attr
+564	common	lsm_set_self_attr		sys_lsm_set_self_attr
+565	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c572d6c3dee0..e12db7b9fb8d 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -466,3 +466,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index bd77253b62e0..f33190f17ebb 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		453
+#define __NR_compat_syscalls		456
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 78b68311ec81..557345b38893 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,12 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_lsm_get_self_attr 453
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_set_self_attr 454
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
+#define __NR_lsm_list_modules 455
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 83d8609aec03..b4f9746a36fb 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 259ceb125367..215547a74374 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a3798c2637fd..24174dc2045f 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 152034b8e0a0..dc3395c37b1e 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,6 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
+453	n32	lsm_get_self_attr		sys_lsm_get_self_attr
+454	n32	lsm_set_self_attr		sys_lsm_set_self_attr
+455	n32	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cb5e757f6621..06cad00543e8 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
+453	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+454	n64	lsm_set_self_attr		sys_lsm_set_self_attr
+455	n64	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 1a646813afdc..6ecc14091da3 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,6 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
+453	o32	lsm_get_self_attr		sys_lsm_get_self_attr
+454	032	lsm_set_self_attr		sys_lsm_set_self_attr
+455	o32	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e97c175b56f9..5b321bb46374 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 20e50586e8a2..491eea2f88ba 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,6 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 0122cc156952..653400f82211 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,6 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+453  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
+454  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
+455  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e90d585c4d3e..a4bc4047858e 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4ed06c71c43f..b134ad689789 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..e921e0d6c4b3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,6 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+453	i386	lsm_get_self_attr	sys_lsm_get_self_attr
+454	i386	lsm_set_self_attr	sys_lsm_set_self_attr
+455	i386	lsm_list_modules	sys_lsm_list_modules
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..b70920626b8c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,9 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	lsm_get_self_attr	sys_lsm_get_self_attr
+455	common	lsm_set_self_attr	sys_lsm_set_self_attr
+456	common	lsm_list_modules	sys_lsm_list_modules
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index fc1a4f3c81d9..e1fe5ed7cad8 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..f10906c71711 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,15 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+#define __NR_lsm_get_self_attr 453
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_set_self_attr 454
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
+#define __NR_lsm_list_modules 455
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index cfda2511badf..371fce3750c2 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -366,3 +366,6 @@
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
+453	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+454	n64	lsm_set_self_attr		sys_lsm_set_self_attr
+455	n64	lsm_list_modules		sys_lsm_list_modules
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 8c0b08b7a80e..35b07f417059 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -538,3 +538,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+453	common	lsm_get_self_attr		sys_lsm_get_self_attr
+454	common	lsm_set_self_attr		sys_lsm_set_self_attr
+455	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index a6935af2235c..2d196937aff3 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -454,3 +454,6 @@
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
+453  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
+454  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
+455  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 227538b0ce80..24dc86e52ddd 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,9 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
+453	common	lsm_get_self_attr	sys_lsm_get_self_attr
+454	common	lsm_set_self_attr	sys_lsm_set_self_attr
+455	common	lsm_list_modules	sys_lsm_list_modules
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.41.0

