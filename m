Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971BA76D5F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjHBRsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjHBRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:48:17 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B02D70
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998479; bh=H+gqT93pGMpLYzs7aWs5HvBFQTz7T+NliWq7UTrCds4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aiEjsECQej+3GwX3+70to6ATa0DmgyyXjRIA4eDyf/nw+ai/JzkYsxUO/EdO6h4U8P/+S9KK9z5TQxT8AZMLly+v3fNIo83XMag5c9ePaPBIiM/dyHcs/in2qIOT6ISCPhH4CVu5zwcJvM0AHBdonVwRXt3KpuE7aYP6MkYQN1boy5pnbPkEnf5O46FYsy8gkse0zLYP6zj9iSbGVWN60/AfBeKRSizaUCellFoFBLWtSLm0buBQpqqjuWIKCxm8mf/4jvGpx5iDMve9MgxgHeLrsewryHp8rB5HndMuZBp4Y8qMhoRJQiSFWOW9I9GBEJhS8+Lhejwv4JxvYnNmpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998479; bh=b/tTbfoN/M8SwCV8Ev1gMVdg9sKtzVCI6xU3vjA4ipT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ksGns/vZ/6RirHdw9lOo3Woz3Sup7m0WXed4//I+S3Nq5wjtVbHVugeIpXxzTTyatKadTXy2o5GQie3FisdBjSX8+LHgb5HIY85cy9Ar5wANjBsdUIR9JfP46KIq9gURbQLqcR4AAnWWK+4RNS6PfaKtAgs1gH6fK5ZXJgsBrFEPm/aQ/686rc5ekLMVxfhatqoDvnfLTzsnzXuadq3UecilnOHb+yguRMD7FqzsOVPBKeOKYexn1CRgE42MQdEqlJDwq8g9+5MWIIWmZrOt+6qkjUorXq0Y0gmn6OBlGbIIHx91+vX4Pw8b76prNiunUkA5LPuvvK/0kJvX3a5NbA==
X-YMail-OSG: bUAUj58VM1nm0_VDlPQLCEqwSjpUgzBrwTdz2UnJk1XiDIM19YtBlbeFVfBGsSt
 USqVjnBFgMp.b0Sc5DvuoP8V4lBzW1QLGL6NTYI_SuUqzhWyhDDaeeFo5cURVas3q73oa50ynHOP
 YRhljzmfLCp_49LA2.l.6IB.NvgjjWdOvQVIwsXNc54MMDAOC5eNz5oqiWxqwn1oYdJ7PLavGvAX
 N_haSk5ETYyaU6BvgLB5TGulYnFmcKtSYYgp8sWXzyGNG74yWOqP0PukJfUyBgchuRCHambqSwU3
 YlmBvAW7axvYzyy8D._du1L7qXan3bNd0SAowNQwk8hGVs4RGfXlrzi8MnYvxEyE_5utzB.pf_rO
 5DCwtOW_MKUXh4Tfaan02TjOfD6tL3eorvEPmdyg9EEsadmASA_koyCIEKullDCfAL8zqDneSicN
 N4a5b4vNpBD6yfFJS3Ncc7uj9GPmpvYo4zplzHg1yo.FPtCc00G18r5Qc7E_vRG5FtiiSJI4H920
 2MGsiqONFcKDj6tjBjzUJt_BzTDpM_Hwyu1P3pTdckuMcg2ug2Fw0i40d4NFke18ww9TUObHuMcs
 MrPjMTQBuGUHkPQYh5g4aC46ggzdJaqh_yb4bX1RfSdcPAI2s0X_6CJdNT9bpceQNJQ_6hQ6VIw7
 5dFjH3LQAhE.E5sfn5U3e7vpGeap1jpu1uLDF7Xe8bGuIi30gncpNl5mTtO0eAXJzEotv.VILqs7
 9cw6.yFbtfdDznb.nV8MVw4XiS4J1OSzzV5XAxfrFvcQzf4.VeTL2RA3q9zXj13OQdGDZRXckgRf
 GjtKp8cSVOtkglJ0xHVygEDU19Ao0c2xVZ1lEE03VVAVT5p4Hq5Owz1yMXpt4qAZUFxBgbrZUYp1
 JkaNrem_lLw.o5.iRkoPpmhMCVzRHrkcyIE6GI97qlObnpGdGE9PPhweGVk0gqdl26H0zDioWDHh
 QKMnwIY5F4ub41gMEqj6ltdPEtUoZit5QtiaWpHxSOeIG_nSJtSv3r4z87t4YYEdyRc3NGv6IM8C
 izFdWMduPuiYBtUp.7KgyOnPPxSTXDt9sMd6GgHihld4kD80H9hkg.yU5Q1V8xa4sJWFezyXXglm
 jbZqJKxl68t7IPXyzhuAKNlXCJXkWBgDbaABAGCoKbFPldZnW1ucj68NGohydF9MJM63Agpa2OEE
 s1C7cbrJQa0axQzugVlchXAtZ6V.4hMbXN1uJPRnXSzEM8in3smQ36CKen3mtHQpEc4GH5L3eIsg
 l2o17e72SdJfRHoJPLkV3ATRzQzO3L4ZWKuE3tWrANVafpwVWtp4._JGms3HE0QV6KcHrdXbrj8c
 TcIPTF8vOGGcsNczhe3iBY_YwokKSqgJD36UfJgyOLEPy5Jk3LZxcX7S1v6csm6Ukha.bJ3V5FZs
 KyMX.Q2jzb6BC1vFPjoJi3Yfopi73zA7qWL9hDfFdNJoFkNV5tdLJuuB5USjpeiwW9Rcac.nf3OP
 PYRhuLexm1TcmI1O984IrBDSMTGtyHm2ASdA.qezYw73kov4maZgM3cZSnBZ1xafFcgUEfOV4d5B
 oS7lM.LsWUCRGOgik_mScmfLQhw_TjuLpewXrIegPHU_KZnwxowL1Uzvg5t5EC5QA0HZQ24DOl9G
 tjFjf0UZfZxk.bYUBBuWfx1hjDhpLHpiOWWMRq5Js_UkJNCNcr33wMgywW4xlIt1OsRLhIzsf_Ir
 fds_KH652NqSX_zgBwKZ9GJO5tpgIdru5exUBvi6y.XZ5GaMOHh7OguLknbRKHQ13Gzuc0OOESYC
 EH6nSIzTnDG85m1n1S0YYZboQc_djjSmFdbToDdNYUxuPAMYENgVyi1Oz2240_Tzh2YNjccXKtaU
 vzy7ophtnfiIbbMSBaqR7VuDHzzOmBBX4_ZSWf1fxrgsBerEfUEVAF0NoASkDWSSjdwVs4fQFayb
 Hv92go6pN1PO9LAsUCDgMtHIibXEBT5cnq0OAIYlBlrZhT0M_S7_itT_YoVvVs5DbaXyXzhowyIn
 x8XMmGXzE_Tp8YsEhBQLS33e9u6zO0c4vVInBFCF9OjEcRjUeNLxgZs6BXmxzF7COOTzJJUCVrV2
 ObAQjdhpSQNl4wY36VbITrTzIxphQAP8mQs3oBrEMun1TDcolbfX8ZjIRceJbpS6FDKXpYIpjMZY
 RAXQZ65xEJTc4lYfVMLdp9Zna659SZmo6kjKW.9Y6pmaUkz5_odjwBPqt.jbjDgqtFh1ikLniAnX
 qpWagFIxemlTOc4_wV90TAagUmefju.FEOJy8ZVKtRsIkKe9NoNsw7NYRqozRTbJLXfQO8F.iIXA
 _tDBWbYUHbeZNGZMHuA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1ef6f890-2890-4c9f-a3d7-98e0644e2656
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:47:59 +0000
Received: by hermes--production-gq1-7d844d8954-t8s9w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9cf20a3b1a5c807479089b2cf544b53b;
          Wed, 02 Aug 2023 17:47:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v13 06/11] LSM: wireup Linux Security Module syscalls
Date:   Wed,  2 Aug 2023 10:44:29 -0700
Message-ID: <20230802174435.11928-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

