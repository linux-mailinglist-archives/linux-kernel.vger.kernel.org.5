Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03B7F9E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjK0Lb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjK0Lb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:31:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA3C0;
        Mon, 27 Nov 2023 03:31:31 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:31:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701084689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf9JetOvZH0lMfipFdKAeTki4Ool1/gZmRBNarGOB7Q=;
        b=qWCiaOSLqUI6MGTe80mmFfj9cl/vcinjPrjGNaQcIvM3HVTdi1mDdhXwrQ1WvRc7zy6l+s
        BcO2p4eKGpFMJQduNvBeNRCA8+TvWJOilYXn4ewB2Ix/6l85AQkjDH0qtyzqHaFXT+fncf
        n36V4ClWa4mnqWvPwqu9C5R9l+CLLeaw2k3m3X5y4P/vuPmtXzYRw3buDb1UE3Ek3QjERH
        0Q8U9U3dlLUXqnUtACNI10khWQkAeIhTCkkSjaedy5DBWByujgmRLkcZKQW46nZdctaql0
        P7GOVgkNdrh1Oh3Nu3s2XgLrXKJIFC33izbbrJiAqAmNPj1pqicxedG4qqtezQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701084689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf9JetOvZH0lMfipFdKAeTki4Ool1/gZmRBNarGOB7Q=;
        b=rJkj7PCFMWccsTziuWRymWOZfgSPOY9et+RNvBVoJX/hdONTVqAbA4dd8lwnSyf+Owqmxh
        iN9mtNm39wDvSaCw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd, EDAC/mce_amd: Move long names to decoder module
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231118193248.1296798-5-yazen.ghannam@amd.com>
References: <20231118193248.1296798-5-yazen.ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <170108468829.398.11053786865426002698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     ff03ff328fbd0a2b3a43e8b9bbc2a1d84265e77e
Gitweb:        https://git.kernel.org/tip/ff03ff328fbd0a2b3a43e8b9bbc2a1d84265e77e
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Sat, 18 Nov 2023 13:32:32 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Nov 2023 12:16:51 +01:00

x86/mce/amd, EDAC/mce_amd: Move long names to decoder module

The long names of the SMCA banks are only used by the MCE decoder
module.

Move them out of the arch code and into the decoder module.

  [ bp: Name the long names array "smca_long_names", drop local ptr in
    decode_smca_error(), constify arrays. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231118193248.1296798-5-yazen.ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |  1 +-
 arch/x86/kernel/cpu/mce/amd.c | 74 +++++++++++++---------------------
 drivers/edac/mce_amd.c        | 46 +++++++++++++++++++--
 3 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6de6e1d..4ad49af 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -333,7 +333,6 @@ enum smca_bank_types {
 	N_SMCA_BANK_TYPES
 };
 
-extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
 
 extern int mce_threshold_create_device(unsigned int cpu);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f3517b8..f6c6c1e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -87,42 +87,37 @@ struct smca_bank {
 static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
 static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
 
-struct smca_bank_name {
-	const char *name;	/* Short name for sysfs */
-	const char *long_name;	/* Long name for pretty-printing */
-};
-
-static struct smca_bank_name smca_names[] = {
-	[SMCA_LS ... SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
-	[SMCA_IF]			= { "insn_fetch",	"Instruction Fetch Unit" },
-	[SMCA_L2_CACHE]			= { "l2_cache",		"L2 Cache" },
-	[SMCA_DE]			= { "decode_unit",	"Decode Unit" },
-	[SMCA_RESERVED]			= { "reserved",		"Reserved" },
-	[SMCA_EX]			= { "execution_unit",	"Execution Unit" },
-	[SMCA_FP]			= { "floating_point",	"Floating Point Unit" },
-	[SMCA_L3_CACHE]			= { "l3_cache",		"L3 Cache" },
-	[SMCA_CS ... SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
-	[SMCA_PIE]			= { "pie",		"Power, Interrupts, etc." },
+static const char * const smca_names[] = {
+	[SMCA_LS ... SMCA_LS_V2]	= "load_store",
+	[SMCA_IF]			= "insn_fetch",
+	[SMCA_L2_CACHE]			= "l2_cache",
+	[SMCA_DE]			= "decode_unit",
+	[SMCA_RESERVED]			= "reserved",
+	[SMCA_EX]			= "execution_unit",
+	[SMCA_FP]			= "floating_point",
+	[SMCA_L3_CACHE]			= "l3_cache",
+	[SMCA_CS ... SMCA_CS_V2]	= "coherent_slave",
+	[SMCA_PIE]			= "pie",
 
 	/* UMC v2 is separate because both of them can exist in a single system. */
-	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
-	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller v2" },
-	[SMCA_PB]			= { "param_block",	"Parameter Block" },
-	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
-	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
-	[SMCA_MP5]			= { "mp5",		"Microprocessor 5 Unit" },
-	[SMCA_MPDMA]			= { "mpdma",		"MPDMA Unit" },
-	[SMCA_NBIO]			= { "nbio",		"Northbridge IO Unit" },
-	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
-	[SMCA_XGMI_PCS]			= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
-	[SMCA_NBIF]			= { "nbif",		"NBIF Unit" },
-	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
-	[SMCA_SATA]			= { "sata",		"SATA Unit" },
-	[SMCA_USB]			= { "usb",		"USB Unit" },
-	[SMCA_GMI_PCS]			= { "gmi_pcs",		"Global Memory Interconnect PCS Unit" },
-	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
-	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
-	[SMCA_GMI_PHY]			= { "gmi_phy",		"Global Memory Interconnect PHY Unit" },
+	[SMCA_UMC]			= "umc",
+	[SMCA_UMC_V2]			= "umc_v2",
+	[SMCA_PB]			= "param_block",
+	[SMCA_PSP ... SMCA_PSP_V2]	= "psp",
+	[SMCA_SMU ... SMCA_SMU_V2]	= "smu",
+	[SMCA_MP5]			= "mp5",
+	[SMCA_MPDMA]			= "mpdma",
+	[SMCA_NBIO]			= "nbio",
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= "pcie",
+	[SMCA_XGMI_PCS]			= "xgmi_pcs",
+	[SMCA_NBIF]			= "nbif",
+	[SMCA_SHUB]			= "shub",
+	[SMCA_SATA]			= "sata",
+	[SMCA_USB]			= "usb",
+	[SMCA_GMI_PCS]			= "gmi_pcs",
+	[SMCA_XGMI_PHY]			= "xgmi_phy",
+	[SMCA_WAFL_PHY]			= "wafl_phy",
+	[SMCA_GMI_PHY]			= "gmi_phy",
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -130,17 +125,8 @@ static const char *smca_get_name(enum smca_bank_types t)
 	if (t >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	return smca_names[t].name;
-}
-
-const char *smca_get_long_name(enum smca_bank_types t)
-{
-	if (t >= N_SMCA_BANK_TYPES)
-		return NULL;
-
-	return smca_names[t].long_name;
+	return smca_names[t];
 }
-EXPORT_SYMBOL_GPL(smca_get_long_name);
 
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 {
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 9215c06..28363eb 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1163,11 +1163,51 @@ static void decode_mc6_mce(struct mce *m)
 	pr_emerg(HW_ERR "Corrupted MC6 MCE info?\n");
 }
 
+static const char * const smca_long_names[] = {
+	[SMCA_LS ... SMCA_LS_V2]	= "Load Store Unit",
+	[SMCA_IF]			= "Instruction Fetch Unit",
+	[SMCA_L2_CACHE]			= "L2 Cache",
+	[SMCA_DE]			= "Decode Unit",
+	[SMCA_RESERVED]			= "Reserved",
+	[SMCA_EX]			= "Execution Unit",
+	[SMCA_FP]			= "Floating Point Unit",
+	[SMCA_L3_CACHE]			= "L3 Cache",
+	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Slave",
+	[SMCA_PIE]			= "Power, Interrupts, etc.",
+
+	/* UMC v2 is separate because both of them can exist in a single system. */
+	[SMCA_UMC]			= "Unified Memory Controller",
+	[SMCA_UMC_V2]			= "Unified Memory Controller v2",
+	[SMCA_PB]			= "Parameter Block",
+	[SMCA_PSP ... SMCA_PSP_V2]	= "Platform Security Processor",
+	[SMCA_SMU ... SMCA_SMU_V2]	= "System Management Unit",
+	[SMCA_MP5]			= "Microprocessor 5 Unit",
+	[SMCA_MPDMA]			= "MPDMA Unit",
+	[SMCA_NBIO]			= "Northbridge IO Unit",
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= "PCI Express Unit",
+	[SMCA_XGMI_PCS]			= "Ext Global Memory Interconnect PCS Unit",
+	[SMCA_NBIF]			= "NBIF Unit",
+	[SMCA_SHUB]			= "System Hub Unit",
+	[SMCA_SATA]			= "SATA Unit",
+	[SMCA_USB]			= "USB Unit",
+	[SMCA_GMI_PCS]			= "Global Memory Interconnect PCS Unit",
+	[SMCA_XGMI_PHY]			= "Ext Global Memory Interconnect PHY Unit",
+	[SMCA_WAFL_PHY]			= "WAFL PHY Unit",
+	[SMCA_GMI_PHY]			= "Global Memory Interconnect PHY Unit",
+};
+
+static const char *smca_get_long_name(enum smca_bank_types t)
+{
+	if (t >= N_SMCA_BANK_TYPES)
+		return NULL;
+
+	return smca_long_names[t];
+}
+
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
 	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
-	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
 	if (bank_type >= N_SMCA_BANK_TYPES)
@@ -1178,9 +1218,7 @@ static void decode_smca_error(struct mce *m)
 		return;
 	}
 
-	ip_name = smca_get_long_name(bank_type);
-
-	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
+	pr_emerg(HW_ERR "%s Ext. Error Code: %d", smca_get_long_name(bank_type), xec);
 
 	/* Only print the decode of valid error codes */
 	if (xec < smca_mce_descs[bank_type].num_descs)
