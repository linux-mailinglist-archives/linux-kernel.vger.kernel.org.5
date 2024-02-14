Return-Path: <linux-kernel+bounces-65482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E14854D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759AD1F22B43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE45F845;
	Wed, 14 Feb 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A6M8tbB2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29859B46;
	Wed, 14 Feb 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926735; cv=none; b=UnXla/nunzHmd2VyHJ6fQ9cf5QPPPmcaLEt+MlbJw9v12TG9GPKewHLPRahWsVZe4bsM3zVuz+1kptTqdXdv5rF/ZlTly5yuGfKeypnX+uDwBuv/6vwJYC33iPBH1sjbAS3zNbqGNl9bReFCKoMXEFDMKBs1oGwSbweaVxWElmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926735; c=relaxed/simple;
	bh=vZJjX7v0+cZVtrXJb1qzjl54ZV3LHzmjSfzYPq/YME8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5Er2w2lqqxEzzj4O7MT74baEYB0ErRkO0cbN7J5fZwN/quHrabr53N6XXiTc1Jrf9Ng37JHg+FGbqpuux6LHKv3EMEo82etRvIi+PTdLyX18gIRI0acDW08Bk9QifKdyeky++qu0J2RLw4+xKJtEbAiiclW2rWgNMr6/yrO0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A6M8tbB2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20B8740E0192;
	Wed, 14 Feb 2024 16:05:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GcIdxJPXPwPb; Wed, 14 Feb 2024 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707926726; bh=MAkqJKknBcfdA6Ur6Ce0a958/WHpln9qM4AlUEpf32o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6M8tbB2cEpF91h07OFHYW0dL6zOCGrjO58iLd5/QPZHFtKCMA0Fh2w+F+o0nt9T9
	 BaEEZVI8+rJd+CcnBzZBda4igs4brScN0Tpw2ePcautM7gnVZiVfkwa63HD2ePtg1r
	 tw8Tg6a8vnjLEWiC7XH9+2TD3EOtP5WuR4fC2C8wEPj8gYeiypiw0KgQ49l3y6VWnE
	 fRaYLJCBrd72C7DUfvYgf2rJD3sApylNuEcE8mIOMtY3OZGDW3mcdbqF8sbtImne4N
	 1TBq4CJ76vJeOEOUnh2WuEzsTlbePl1WjiVAO+SPdTyvbdjkYH26i2VUsm92KTKH6w
	 Xt975PDgbDtRjaspIiYoWz+mgOSMF0GPqJzO0gM35AE53m+n0G0Q2kj3PDYLKv7zIg
	 jxRFySv/UQmBiLj0a9InMb9ALKy+c50iCOpz6k2kw/Pk5WJjLCDBjb6BxH4UM7BqK9
	 ibqX4FUFK7smP8i6psunhFmVpNwb7kluAUBEE6TZHb2Y8AzcU8tIHY4YetSzQNxitG
	 cuR9W25WOmvCgZtbiu6dCaXm/d/TsPqZ+x8fnGDcPcIul0ny4cmQJhK2cTunLzKIEW
	 G9MBervnKrsfrAAAD8MO644JGiebl9YP61iZ8yJMRcjepKjtssSBioCkj2WgpfOTXE
	 2ATw4O4yh/NP+UH5bOahKZ3Y=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 143DF40E00B2;
	Wed, 14 Feb 2024 16:05:17 +0000 (UTC)
Date: Wed, 14 Feb 2024 17:05:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 1/2] RAS/AMD/ATL, EDAC/amd64: Move MI300 Row Retirement
 to ATL
Message-ID: <20240214160512.GDZczkuNJf_VVZxNeI@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-2-yazen.ghannam@amd.com>
 <20240214083623.GZZcx7h_BcIWpoEmMJ@fat_crate.local>
 <d01ef2f5-10d9-410b-a6ec-d5eca05ffda4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d01ef2f5-10d9-410b-a6ec-d5eca05ffda4@amd.com>

On Wed, Feb 14, 2024 at 09:19:13AM -0500, Yazen Ghannam wrote:
> Yes, that's fine.

Easy peasy:

From 98ecd3942837df907fbf9ceff7e23f55e55e40b2 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 13 Feb 2024 21:35:15 -0600
Subject: [PATCH] RAS/AMD/ATL: Add MI300 row retirement support

DRAM row retirement depends on model-specific information that is best
done within the AMD Address Translation Library.

Export a generic wrapper function for other modules to use. Add any
model-specific helpers here.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240214033516.1344948-2-yazen.ghannam@amd.com
---
 drivers/ras/amd/atl/Kconfig |  1 +
 drivers/ras/amd/atl/umc.c   | 51 +++++++++++++++++++++++++++++++++++++
 include/linux/ras.h         |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
index a43513a700f1..df49c23e7f62 100644
--- a/drivers/ras/amd/atl/Kconfig
+++ b/drivers/ras/amd/atl/Kconfig
@@ -10,6 +10,7 @@
 config AMD_ATL
 	tristate "AMD Address Translation Library"
 	depends on AMD_NB && X86_64 && RAS
+	depends on MEMORY_FAILURE
 	default N
 	help
 	  This library includes support for implementation-specific
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 7e310d1dfcfc..08c6dbd44c62 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -239,6 +239,57 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 	return addr;
 }
 
+/*
+ * When a DRAM ECC error occurs on MI300 systems, it is recommended to retire
+ * all memory within that DRAM row. This applies to the memory with a DRAM
+ * bank.
+ *
+ * To find the memory addresses, loop through permutations of the DRAM column
+ * bits and find the System Physical address of each. The column bits are used
+ * to calculate the intermediate Normalized address, so all permutations should
+ * be checked.
+ *
+ * See amd_atl::convert_dram_to_norm_addr_mi300() for MI300 address formats.
+ */
+#define MI300_NUM_COL		BIT(HWEIGHT(MI300_UMC_MCA_COL))
+static void retire_row_mi300(struct atl_err *a_err)
+{
+	unsigned long addr;
+	struct page *p;
+	u8 col;
+
+	for (col = 0; col < MI300_NUM_COL; col++) {
+		a_err->addr &= ~MI300_UMC_MCA_COL;
+		a_err->addr |= FIELD_PREP(MI300_UMC_MCA_COL, col);
+
+		addr = amd_convert_umc_mca_addr_to_sys_addr(a_err);
+		if (IS_ERR_VALUE(addr))
+			continue;
+
+		addr = PHYS_PFN(addr);
+
+		/*
+		 * Skip invalid or already poisoned pages to avoid unnecessary
+		 * error messages from memory_failure().
+		 */
+		p = pfn_to_online_page(addr);
+		if (!p)
+			continue;
+
+		if (PageHWPoison(p))
+			continue;
+
+		memory_failure(addr, 0);
+	}
+}
+
+void amd_retire_dram_row(struct atl_err *a_err)
+{
+	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
+		return retire_row_mi300(a_err);
+}
+EXPORT_SYMBOL_GPL(amd_retire_dram_row);
+
 static unsigned long get_addr(unsigned long addr)
 {
 	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 09c632832bf1..a64182bc72ad 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -45,8 +45,10 @@ struct atl_err {
 #if IS_ENABLED(CONFIG_AMD_ATL)
 void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
 void amd_atl_unregister_decoder(void);
+void amd_retire_dram_row(struct atl_err *err);
 unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 #else
+static inline void amd_retire_dram_row(struct atl_err *err) { }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

