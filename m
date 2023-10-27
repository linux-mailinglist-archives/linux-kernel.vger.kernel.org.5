Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C341D7DA33D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjJ0WMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346695AbjJ0WLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72FC10FD;
        Fri, 27 Oct 2023 15:11:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 743653200930;
        Fri, 27 Oct 2023 18:11:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 18:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444690; x=
        1698531090; bh=GfLwAORI6DxI0P9SZsCprbtQo1SdXn/VrLRSxzuwQR4=; b=n
        YG6TLE93W20ZgxBA9/Dos/YhIY0YVVd8oVDdwWSEA7ZjYAJKv6+F741kEGJNM7cu
        gLwWSDNZ/UKNcv99cnU01CpJW0/xottYJIMzJsJ/oMAiQO/IwZvOEDu9xAryc10+
        iqHtWEcvUMqMHVqXzWzDPT0GV7LsEJXUfs2vOnbd7vEL/Ys7H1Bcxz60b7SQqMcY
        P4yBl+plaV+y0dsckCzB9k4yeLxKuJ6GF9LkCFfQmIcpT590lDw4hZH+J8Pn4651
        GdBxLFM634rAPCD2FSgTtyfpvpN6fjkZjGsZfGx/p53AfbGNZJzakSSr22Yw7GUL
        xp9JsD03HeTw3BYGOATyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444690; x=
        1698531090; bh=GfLwAORI6DxI0P9SZsCprbtQo1SdXn/VrLRSxzuwQR4=; b=M
        EdwpHWMA7reyomXBT6TJojaPnVxpChevCW3Gzk6MqX1OxezkX1jMWly9yaLymdao
        SNMVk7xMOeM/pYrmmg9Yxj+qARw6ahUn0wdYmuXhjD+ePukz2akoDWSoJONMNLo1
        2kmQ9wClXRB91T8b8Mj4Al36SoEJRNJ3DKTr8ByWfcL6e5f4QMWNEm5UdQAycII1
        urJ4c3Lx92LEMoLBSsVaCoThrhZeVwkpYf+kq5hmOsRK6LlfFf6Tf1ObAeBVZraC
        M0XkTy/90xAd/sXWRigBvXPDzPsB5fj7FJFGamBHc24PEAKqy0q8T1Fm6lK+UEju
        W+FX/O39Pfb50UkayReZA==
X-ME-Sender: <xms:kjU8ZfrbBnqC9Ie7vsVOQY-XRho3yE2Tg6eXSgYrILn3ku4NdbZkJQ>
    <xme:kjU8ZZph_PyMkCJVXszhi5HkLtsqz6XgN9mWPKg6Y-VeiF4DcxoMULi1jJqtOZuaZ
    qKYcFAE7XCkgRl2W5Y>
X-ME-Received: <xmr:kjU8ZcNCfvS1mK1m94Rf-q2hJHBXLazEkR9lomf5tr25lHi5ryEiMP07Yk7ywPG1d0vfHEpTFjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    peefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:kjU8ZS4LZXTU-lKRmmTIzHk96klL5Ep72Ip8TRRDuSRI7TTF-h6Kwg>
    <xmx:kjU8Ze7avMX3JVD8ZeRGbvqvSwhQe9DB02swUo7vlrK0xz2V1LuPUg>
    <xmx:kjU8ZainaZYLvFWJs6q1HQ_LavVb61Kpb_SljCsimuK4zAeSXXwrww>
    <xmx:kjU8ZZ2mE33NcLywpO1BJWYr6oPMorxppW1DzIt5wQB85cMTKK3_lQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:29 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 08/10] MIPS: Avoid unnecessary reservation of exception space
Date:   Fri, 27 Oct 2023 23:11:04 +0100
Message-Id: <20231027221106.405666-9-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowadays we allocate exception base from memblock for r2_r6,
so we don't need to reverse exception space at the start of
the memory for r2_r6 processors.

For older processors the reservation is moved to traps_init
where we have knowledge of exact size we need. We also add
a sanity check to detect possible overlap with kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/traps.h    |  1 -
 arch/mips/kernel/cpu-probe.c     |  5 -----
 arch/mips/kernel/cpu-r3k-probe.c |  2 --
 arch/mips/kernel/traps.c         | 12 +++++++-----
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index 15cde638b407..d3dddd1c083a 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -24,7 +24,6 @@ extern void (*board_ebase_setup)(void);
 extern void (*board_cache_error_setup)(void);
 
 extern int register_nmi_notifier(struct notifier_block *nb);
-extern void reserve_exception_space(phys_addr_t addr, unsigned long size);
 extern char except_vec_nmi[];
 
 #define VECTORSPACING 0x100	/* for EI/VI mode */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b406d8bfb15a..54e8b0fd4a2a 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1570,7 +1570,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_BMIPS3300;
 		__cpu_name[cpu] = "Broadcom BMIPS3300";
 		set_elf_platform(cpu, "bmips3300");
-		reserve_exception_space(0x400, VECTORSPACING * 64);
 		break;
 	case PRID_IMP_BMIPS43XX: {
 		int rev = c->processor_id & PRID_REV_MASK;
@@ -1581,7 +1580,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "Broadcom BMIPS4380";
 			set_elf_platform(cpu, "bmips4380");
 			c->options |= MIPS_CPU_RIXI;
-			reserve_exception_space(0x400, VECTORSPACING * 64);
 		} else {
 			c->cputype = CPU_BMIPS4350;
 			__cpu_name[cpu] = "Broadcom BMIPS4350";
@@ -1598,7 +1596,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "Broadcom BMIPS5000";
 		set_elf_platform(cpu, "bmips5000");
 		c->options |= MIPS_CPU_ULRI | MIPS_CPU_RIXI;
-		reserve_exception_space(0x1000, VECTORSPACING * 64);
 		break;
 	}
 }
@@ -1996,8 +1993,6 @@ void cpu_probe(void)
 	if (cpu == 0)
 		__ua_limit = ~((1ull << cpu_vmbits) - 1);
 #endif
-
-	reserve_exception_space(0, 0x1000);
 }
 
 void cpu_report(void)
diff --git a/arch/mips/kernel/cpu-r3k-probe.c b/arch/mips/kernel/cpu-r3k-probe.c
index be93469c0e0e..05410b743e57 100644
--- a/arch/mips/kernel/cpu-r3k-probe.c
+++ b/arch/mips/kernel/cpu-r3k-probe.c
@@ -137,8 +137,6 @@ void cpu_probe(void)
 		cpu_set_fpu_opts(c);
 	else
 		cpu_set_nofpu_opts(c);
-
-	reserve_exception_space(0, 0x400);
 }
 
 void cpu_report(void)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 651c9ec6265a..b6e94654f621 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2007,10 +2007,6 @@ unsigned long exception_handlers[32];
 static unsigned long vi_vecbase;
 unsigned long vi_handlers[64];
 
-void reserve_exception_space(phys_addr_t addr, unsigned long size)
-{
-	memblock_reserve(addr, size);
-}
 
 void __init *set_except_vector(int n, void *addr)
 {
@@ -2394,7 +2390,13 @@ void __init trap_init(void)
 	}
 
 	if (!cpu_has_mips_r2_r6) {
-		ebase = CAC_BASE;
+		ebase_pa = 0x0;
+		ebase = CKSEG0ADDR(ebase_pa);
+
+		if (__pa_symbol(_stext) < (ebase_pa + vec_size))
+			pr_err("Insufficient space for exception vectors\n");
+
+		memblock_reserve(ebase_pa, vec_size);
 	} else {
 		vec_size = max(vec_size, PAGE_SIZE);
 		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
-- 
2.34.1

