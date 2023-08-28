Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2229878B8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjH1UC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjH1UC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:02:28 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC476E41
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252891; bh=H+gqT93pGMpLYzs7aWs5HvBFQTz7T+NliWq7UTrCds4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AuF6E+moujbLNq9PS3WzGSdy8FcIoWl28R+vBWjKtsJhETFBCGW4ENflWCH1Ef5nB2wzeqq9OAz9jvOXCWAmP29tn/oDLZOxL9es5FqqL3BthKlSfz2sLSY2/BXBG2zmXM2V0gsue77KCwqPh9DCDo6IPIG4AARcCE6T2MlEMbqCvxMQ4hO1xmxE8G5mVqaBVoSXsWa+p7VFyjxoWjp68hDhzsRBiHzLDgOn/GPCiGeK0nR1zEBUyNu8pagg0mmf0/7gnG0ym4NLf5dIz7hAfNk2EK8On0xSI+qGEE0xlZi4cBO08HqJY2wRnSX8KcJcyXESv+JrgAO4nAPmKmcxkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252891; bh=haFV8EykDXQMtQ6Q2Bjej24mcW6VbNW1jCO0bYjlZPO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UAI3z2EAWl8Y79ECtQ3/sLYF3jg/YUD+xH5G5SnAa8NkMMzohlexJ5fm6eBF698MzLpFLXMjfIEHkcqq9ZD5vaoLxcgcR7hzVSjfFLRdmXq10Hddj5IxDtpaPOPQGEgKvyHx26plMY+noSOq3Lu42DiCYCf7DmvYbu+c6gmvZdjGfE5yxSajZl0Obl9DDuX5T9B5M/4RDkM5O5CuiHrOcd0UiK2vDCc1RCIRQqG7pJT9o3ZFliUtUggIkcpRPFnwLW6KlvDPZ+Kzyj2kcyQwoPrho3etQX29oA1FVjyDw1C9HgHGVYeecaHgf4RHOcUy4jnXuces2ZjAw8lYfqYXaA==
X-YMail-OSG: JNJxwRgVM1mV0t3YYgOA9GGcqeWzwuDjilJbdrpyfd13fSVxL2ivYB459kDyf7F
 _4n97MFnweg0SsiyYGyV39mO.o6QBWDPVp0mT_uQX9l7q3KZthTvCc3pPUcTtboKaF1T7HgUgSIf
 2SGZnCstQU9_QgZqmSB35iWOXQ8joumBLD_JopO1lxhAKiQzaUYqW9SC51kSvlJkUlwIVKhWypTf
 .jm2NrA5H7bKTCGD29YhWlm9bzgIa2Np5eynGgUG_P5DKCrj5nGjGSht9v_uIHhj8CDnrkXPBkla
 9yj2PEVuuSUYNH5euS72iwViOIBXg5Nn6SJns0LaXl4Md3wzRoF8E6sYgfT4SYslt5aKoT9v3L2g
 I.M78XOP32Vxa0itY.UKGDwfbR.lU0AtqYvgFRuaoe761vJlNXCs6_EgIzF6h1xERKZGC80Xz2Lc
 IVqezvdLs22eJyIqQC25FPWBAqLbknjEumTWG4sDHZgERN2Qw.MS7wkDdcc2M.bw0FgtzQytHycB
 cdNZENRidBl5Ytn2qcZ3njI_Zf7NNygI6j8nKFok8LBnvPoSOzlhfdhKtnZtWgaHSxJ2LguWAHur
 lViX9bijzobfDIVVGwPP.8Yv6cxmFbFJjmqagyijMx3Ha.VxYmrob8.OlGeMIQe2rv7HUSMhbr9n
 tOISzX4Z59HfRDPFd23RN0OTx3VRAbV7a7g7yBmgTrEtlMg43LtobxZXdPq3UYPWx412pX5wSyqJ
 MaVgGTntE4Fnp6w_Uk_KG_Dqao5h.vrNpUxQCijD_QYcGn_6xBk9kzbynOXWziyhsdqfxlJ4Z0bK
 hNTfDMRJEMTOPm7MT.XpQajeEvscz56ugIPTdzRsvFhqnVVVfxscEHuMRabCbs6cU0uXhJbtyagr
 hndY23G73ZYRbsmG7abvP0EoBB_16ZLrN_4wwKvxPgccYD7pL0T41kgR5c4hDUD8cQdmmogypLbb
 I8jmNaNCemd7hZYcY3G7djsvEQjCzKak80EnE_BxugHZ6XJjqukJs3jjwZVTprSbYxPcv2FhumQi
 HupV_sRrIr8m5KSImxjy3fV2CW0gCM7MTRiXy5HtZRrljS2B3TcHAzO6ahps.iA6f_QJBxqM0mrY
 ri8x_Q5a1wuh.yv1lkygAF7V647By7jxI2jlddj5d1uAPSazOMpctB12aRz2ohVDVcjCA7kJCDRm
 Qpjb2UCMo9.3lLu9X2D_Rp4ZQbnxhCpZT44xdu3mc1uY0ji7NTZX0jU9jTa6sG.JLX.8g4LqIh0m
 XprzxTU54H3z2Gr9Ys_oAVPratqxlDXBTl7_Wdq06n1ZXzsf7T.9Pnqqa8mvrbogXbXm25vlSS9Z
 BzLKj3228rDeOEDDu2WWXySAMht9zOyYgtGCFNXC1NW2t3aJq761gV6uMCXK4yiN0G4IEHbeZtj2
 1uQuz4kKWwNVHtkdrr.W7ndK5Uu0TCkuos8rlp4Vt6Z2N6UZRM5hNQUrEC998._Q5xOukPmXimj6
 X8kMTRJ.ZsNBm_hoL41SC1JsBC2Y0zzBhwsHTOBoJ7Xyk0bODoxlxoeHjdZ1bjlTwK3eD.daQzsD
 v.8tPRttCG.EuuNIpeE9IEpzqpVqtqr8FIYewdUkWUD0iMqllhsHlZJ3LzAcOmDvL0sPNaQvgu8R
 6qafOFCvA0URf.rjYyEqznvnfwk7qVjUEJxZX5H9AAme3R3x0SWv9wvhOKtItkZonu7e7k8FFyyd
 cyTim7GYhFGO0Suf2u8xu74o9kRRx7GlvcKurNfezjuw8FGoGBsQhUze9N8VNZ_YsbnZduehHDlN
 yWIdbeFTk4.tWK40rXlYI0omgPPcAen812CDShktBI6CMnctAW3kZXN8xyG9bcsdYNTVj_ZfW52x
 E9qbHuFZ1y4H37QB6m1OflOD2lynhBDhkZUElkaCYEdFU5eIOTAEkjcBsaUKYyDb6QUDSdddG1vY
 TLzDTpZIvCzGw2LM09nwBrnxKcc2WPepmH5TPVISGVW9P9vxjX1Bm7fTaXTFeA.h0xLfV207skCd
 UXXN58Uncz1gsykShAp1vIT0a7LQZg6UWhElGxWSz14aNCYu8p5QD06Vfafscl2uL06uUtcW0uuH
 aO_zq1__5sbBU6Sy3NBmi9Hsuo9KfpHIB7cyYrJ6wfRWL67oh1l_olRq6pfo35ZBsyg6pTgf43v6
 3qX0CObmrtLpJqBsuUu8VyBUW5oByGyDUWG5DZ_v23bVLRVR3R_fjcATmAd0rqFL5adyJSyIC7pQ
 EuJTjKYhYvgqoaRjxmg3z67p44uYBa_Fb99K58KEHwjctxskYhH57AmMjQrozYmHugs3eAR8u_Jo
 j7kMfw22XNdCLyghBTAM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b5774d0b-8639-4901-a9e4-987c528b17d9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 20:01:31 +0000
Received: by hermes--production-bf1-865889d799-xc84r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41e108e68e35436397144cebae3e0d39;
          Mon, 28 Aug 2023 20:01:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v14 06/11] LSM: wireup Linux Security Module syscalls
Date:   Mon, 28 Aug 2023 12:57:56 -0700
Message-ID: <20230828195802.135055-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1f13995d00d7..bb00aecf1dc4 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -491,3 +491,6 @@
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
+562	common	lsm_get_self_attr		sys_lsm_get_self_attr
+563	common	lsm_set_self_attr		sys_lsm_set_self_attr
+564	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 8ebed8a13874..a148e71905a7 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -465,3 +465,6 @@
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 64a514f90131..63a8a9c4abc1 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		452
+#define __NR_compat_syscalls		455
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index d952a28463e0..df214b7ec5dd 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -909,6 +909,12 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
+#define __NR_lsm_get_self_attr 452
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_set_self_attr 453
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
+#define __NR_lsm_list_modules 454
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index f8c74ffeeefb..1b53f9d28514 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -372,3 +372,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 4f504783371f..f7a91d458f0c 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -451,3 +451,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 858d22bf275c..2b24b19a9bec 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -457,3 +457,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 1976317d4e8b..0ff4072ed024 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -390,3 +390,6 @@
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
+452	n32	lsm_get_self_attr		sys_lsm_get_self_attr
+453	n32	lsm_set_self_attr		sys_lsm_set_self_attr
+454	n32	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cfda2511badf..9c38818dd9f9 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -366,3 +366,6 @@
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
+452	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
+454	n64	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 7692234c3768..a07e1ba91511 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -439,3 +439,6 @@
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
+452	o32	lsm_get_self_attr		sys_lsm_get_self_attr
+453	032	lsm_set_self_attr		sys_lsm_set_self_attr
+454	o32	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index a0a9145b6dd4..36cc0130ee1d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -450,3 +450,6 @@
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 8c0b08b7a80e..fe2ba9e8a413 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -538,3 +538,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index a6935af2235c..fe3fc23697b0 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -454,3 +454,6 @@
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
+452  common	lsm_get_self_attr	sys_lsm_get_self_attr		sys_lsm_get_self_attr
+453  common	lsm_set_self_attr	sys_lsm_set_self_attr		sys_lsm_set_self_attr
+454  common	lsm_list_modules	sys_lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 97377e8c5025..319968dccde9 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -454,3 +454,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index faa835f3c54a..9ca3fb4c05de 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -497,3 +497,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index bc0a3c941b35..4caa3c415528 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -456,3 +456,6 @@
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
+452	i386	lsm_get_self_attr	sys_lsm_get_self_attr
+453	i386	lsm_set_self_attr	sys_lsm_set_self_attr
+454	i386	lsm_list_modules	sys_lsm_list_modules
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 227538b0ce80..c5f85f93e80b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,9 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
+452	common	lsm_get_self_attr	sys_lsm_get_self_attr
+453	common	lsm_set_self_attr	sys_lsm_set_self_attr
+454	common	lsm_list_modules	sys_lsm_list_modules
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 2b69c3c035b6..509379512c27 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -422,3 +422,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index fd6c1cb585db..b5588efc0933 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -820,8 +820,15 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 #define __NR_cachestat 451
 __SYSCALL(__NR_cachestat, sys_cachestat)
 
+#define __NR_lsm_get_self_attr 452
+__SYSCALL(__NR_lsm_get_self_attr, sys_lsm_get_self_attr)
+#define __NR_lsm_set_self_attr 453
+__SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
+#define __NR_lsm_list_modules 454
+__SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
+
 #undef __NR_syscalls
-#define __NR_syscalls 452
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index cfda2511badf..9c38818dd9f9 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -366,3 +366,6 @@
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
+452	n64	lsm_get_self_attr		sys_lsm_get_self_attr
+453	n64	lsm_set_self_attr		sys_lsm_set_self_attr
+454	n64	lsm_list_modules		sys_lsm_list_modules
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 8c0b08b7a80e..fe2ba9e8a413 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -538,3 +538,6 @@
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
+452	common	lsm_get_self_attr		sys_lsm_get_self_attr
+453	common	lsm_set_self_attr		sys_lsm_set_self_attr
+454	common	lsm_list_modules		sys_lsm_list_modules
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index a6935af2235c..a18e9d7cf92b 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -454,3 +454,6 @@
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
+452  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
+453  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
+454  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 227538b0ce80..c5f85f93e80b 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,9 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
+452	common	lsm_get_self_attr	sys_lsm_get_self_attr
+453	common	lsm_set_self_attr	sys_lsm_set_self_attr
+454	common	lsm_list_modules	sys_lsm_list_modules
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.41.0

