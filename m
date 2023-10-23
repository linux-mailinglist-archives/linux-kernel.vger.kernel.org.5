Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34327D3FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjJWTOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjJWTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:14:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B81100;
        Mon, 23 Oct 2023 12:14:12 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 9546D5C0381;
        Mon, 23 Oct 2023 15:14:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 15:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698088451; x=
        1698174851; bh=axCOXJ1HMSIUr/oFZjhnVtqXrX+b0q0P4G/a7WUwdbo=; b=v
        sLaEWs92HWTR+7DJmUj2C5j4L3zPRmjgOhMu51FdXoiwbWRGb/Vr9Yum7Sy9z9Ax
        QDizshS8CFvxX9KSLEC6K8RgBc5toBasXpaErwFUWlgCxIF2GRJsNi6ONkVJKhYP
        +1P9b1HCvOtXeP39IFh7gy0gLxI/cOLsC0BUk0HDFr8G+2LaYifAKHeWvUuuvtOq
        iW+wFNLZTT4y2NOSOIaXS3n4DemEcLhMk557ohgWpofuvKHlS66jjwVGNTahJiuT
        OIXwVdQi2Qt588OSbXYm0JfkXu9DJEpvqBesAnAkhLqIy2Y1aI9Kks5N4YEeV8mz
        9Z6kOFIKmhU77BoEz+jjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698088451; x=
        1698174851; bh=axCOXJ1HMSIUr/oFZjhnVtqXrX+b0q0P4G/a7WUwdbo=; b=H
        1HXqrR9VDzPz5pGLgnhATMlkXnkYo86IZ9veC3/fX/6JB5Ld5oW3BBmazE5YeWBD
        oHTFg16AiKsjH/+voYWMYnv++Ul84E5BOdcG1AOniGBNobX9b3y1i86/Ebd1D+1J
        4Z3VUh0hZpvJA7+/YTRHq9eHuqbG5Hbn8jfRupaMLkLHu4KUsgU+0FkJTpgTewta
        yH/I7lYLaaG/EGw/bcaCU5OG8h5vW7tNsQXkaeb4W4t7HxEdK3Smv0EnRExopxol
        DfdIe2JKMZTLJ/mo/Bs2wU/ts2Kf412st0cmoXRQRYN10IU5d+zAYProreRpejHy
        ej0t5GO+Z/Bhgvx/t0jCw==
X-ME-Sender: <xms:A8Y2ZfZD7wHWTSCxQUGTfnTerCkSOKnHeiaVvxMUFpy2YIJK0kK-hw>
    <xme:A8Y2ZeYPrQylwYDygkRKHUySSoQUgg70wMWGpCa5US6JGePBH_GBRC1XQ6elgGtyS
    X7gqMkPtoLE9ipurKA>
X-ME-Received: <xmr:A8Y2ZR_BYPW6OSya_HTFUAoIYh3TnlTHXMFzGRnhkkmL41iftGsCn926D5SZntgLwCnyE7TOfsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:A8Y2ZVqAK5dywdaReBsYhsgT5C_ltyxsv_oBbb_xzQzcAoV5mNin6Q>
    <xmx:A8Y2ZapGEg4LO4Owh6xdjMEmAipax-SWJ81-nON2i9e8J-BKB5p9oA>
    <xmx:A8Y2ZbRu43pgV5BMAJCk--_ir35O3sFnR2oYTRMusFHWb9fdOzxcrA>
    <xmx:A8Y2ZTmWOHNtgCXV03pwhxeBttbeCRZfnryfWi5CAMYbRkIhm3sdEA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 15:14:10 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/5] MIPS: Handle mips_cps_core_entry within lower 4G
Date:   Mon, 23 Oct 2023 20:13:59 +0100
Message-Id: <20231023191400.170052-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set CM_GCR_Cx_RESET_BASE_MODE and use XKPHYS base address for
core_entry for 64bit CM when mips_cps_core_entry is beyond
KSEG1.

Also disable SMP and warn user if mips_cps_core_entry is
unsuitable as reset vector.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Note: IMO it does not solve the problem of MobileEye,
which have mips_cps_core_entry beyond lower 4G,
it just enables me to test kernel in XKPHYS on boston.
---
 arch/mips/include/asm/mips-cm.h |  1 +
 arch/mips/kernel/smp-cps.c      | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b1..15d8d69de455 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -311,6 +311,7 @@ GCR_CX_ACCESSOR_RW(32, 0x018, other)
 /* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch from */
 GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
 #define CM_GCR_Cx_RESET_BASE_BEVEXCBASE		GENMASK(31, 12)
+#define CM_GCR_Cx_RESET_BASE_MODE		BIT(1)
 
 /* GCR_Cx_ID - Identify the current core */
 GCR_CX_ACCESSOR_RO(32, 0x028, id)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index dd55d59b88db..623dfd05585b 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -26,6 +26,7 @@
 #include <asm/uasm.h>
 
 static DECLARE_BITMAP(core_power, NR_CPUS);
+static uint32_t core_entry_reg;
 
 struct core_boot_config *mips_cps_core_bootcfg;
 
@@ -37,7 +38,6 @@ static unsigned __init core_vpe_count(unsigned int cluster, unsigned core)
 static void __init cps_smp_setup(void)
 {
 	unsigned int nclusters, ncores, nvpes, core_vpes;
-	unsigned long core_entry;
 	int cl, c, v;
 
 	/* Detect & record VPE topology */
@@ -94,10 +94,20 @@ static void __init cps_smp_setup(void)
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 
-	if (mips_cm_revision() >= CM_REV_CM3) {
-		core_entry = CKSEG1ADDR((unsigned long)mips_cps_core_entry);
-		write_gcr_bev_base(core_entry);
-	}
+	/*
+	 * Set up the core entry address
+	 * If accessible in KSEG1 just use KSEG1
+	 */
+	if (__pa_symbol(mips_cps_core_entry) < SZ_512M)
+		core_entry_reg =  CKSEG1ADDR(__pa_symbol(mips_cps_core_entry));
+
+	/* If CM is 64bit and with-in low 4G just use XKPHYS */
+	if (mips_cm_is64 && __pa_symbol(mips_cps_core_entry) < SZ_4G)
+		core_entry_reg =  __pa_symbol(mips_cps_core_entry) |
+					CM_GCR_Cx_RESET_BASE_MODE;
+
+	if (core_entry_reg && mips_cm_revision() >= CM_REV_CM3)
+		write_gcr_bev_base(core_entry_reg);
 
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
@@ -114,6 +124,11 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 
 	mips_mt_set_cpuoptions();
 
+	if (!core_entry_reg) {
+		pr_err("core_entry address unsuitable, disabling smp-cps\n");
+		goto err_out;
+	}
+
 	/* Detect whether the CCA is unsuited to multi-core SMP */
 	cca = read_c0_config() & CONF_CM_CMASK;
 	switch (cca) {
@@ -213,7 +228,7 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	mips_cm_lock_other(0, core, 0, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
 
 	/* Set its reset vector */
-	write_gcr_co_reset_base(CKSEG1ADDR((unsigned long)mips_cps_core_entry));
+	write_gcr_co_reset_base(core_entry_reg);
 
 	/* Ensure its coherency is disabled */
 	write_gcr_co_coherence(0);
-- 
2.34.1

