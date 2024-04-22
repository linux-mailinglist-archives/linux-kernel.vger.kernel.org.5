Return-Path: <linux-kernel+bounces-153144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815608ACA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ED22838B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8771713D53F;
	Mon, 22 Apr 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afKVtqe9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bn26bzgy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7D4317E;
	Mon, 22 Apr 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780074; cv=none; b=lwz+75zprB/p8Dc+SUwo1jnT6VX1XdTQAwHe33YueKQHKchpKIw1m8RFfj2mvHalMljeIXKLPL1fX7o5LOeGRTndhr2eKjQPJgKciK6LMM8Wp8v6U09Yi5BBvHjR/186+IR8oZTT2gPEFK6BVLlguzUmX6Ytu1oZEcuolgi6qIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780074; c=relaxed/simple;
	bh=wilP0S9yaOdBx5I7eoy1Qc59E30aSdSCDKDYOjHJU34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Apf6ilm8oVSU0jLehpfJi2ez8ZRQ5YvkHHMCaLgeycZPHIbURWIC3+BtQQXXVYkiv7C/uyx0NgUTUFLGQpbkoIKCzxfD+EibcQzIS48hezHQCq3roGWbu8mRGg1gdgzIihwHbCosPe2uvWAIgtRcoIP3vgDdoKaIwPxjQKT0IOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afKVtqe9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bn26bzgy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 10:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713780067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PaFcwvx0HxLXQNouwoFlbpKBiArhh44BFbrFu03K8w=;
	b=afKVtqe9zcd8U41s7AEFliHzNjl5Mahlq0EY4/PyKxT8m82yQx4fywteXprqs29ryKv0VG
	rqlo+f6ald4bipURBrNwDULJX3+3rYGaLoP80HmodRSptONfHmijkZoLXgvCR64Y8tlEm/
	CTqPV29XmA9IjQ33nXre5P8WT9aIRaocn35Z3CNwtY6eNnNUUyO9a4aLSfxBdYsylJ8nEG
	higK90fH4KbvYqtUhJBR0grweRQ8H7F4vnXaxMX4aRjmUw7qXPkPqpH3bU6IU2d5ksMkxs
	Tb4cCzPGuk8utKtuotAN0tLr+cDHmVVKv93T/2HG9FJ+MTBkaPvz3Bw68yrcaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713780067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PaFcwvx0HxLXQNouwoFlbpKBiArhh44BFbrFu03K8w=;
	b=bn26bzgyxyZ5cIhtd4ftUYzAGgeILHb2GTZ/VTy0VNSX7GKxcR26gi3B4ElyM10KE3Nr6C
	7tegG2nhhrO15bAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240416211941.9369-4-tony.luck@intel.com>
References: <20240416211941.9369-4-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171378006652.10875.2184254283727922342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f055b6260eb3ef20a6e310d1e555a5d5a0a28ca0
Gitweb:        https://git.kernel.org/tip/f055b6260eb3ef20a6e310d1e555a5d5a0a28ca0
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 16 Apr 2024 14:19:05 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Apr 2024 11:44:00 +02:00

x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h

New CPU #defines encode vendor and family as well as model.

Update the example usage comment in arch/x86/kernel/cpu/match.c

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240416211941.9369-4-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 84 ++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/match.c         |  3 +-
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index d0941f4..f81a851 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -40,137 +40,221 @@
  * their own names :-(
  */
 
+#define IFM(_fam, _model)	VFM_MAKE(X86_VENDOR_INTEL, _fam, _model)
+
 /* Wildcard match for FAM6 so X86_MATCH_INTEL_FAM6_MODEL(ANY) works */
 #define INTEL_FAM6_ANY			X86_MODEL_ANY
+/* Wildcard match for FAM6 so X86_MATCH_VFM(ANY) works */
+#define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
+#define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
 #define INTEL_FAM6_CORE2_MEROM		0x0F
+#define INTEL_CORE2_MEROM		IFM(6, 0x0F)
 #define INTEL_FAM6_CORE2_MEROM_L	0x16
+#define INTEL_CORE2_MEROM_L		IFM(6, 0x16)
 #define INTEL_FAM6_CORE2_PENRYN		0x17
+#define INTEL_CORE2_PENRYN		IFM(6, 0x17)
 #define INTEL_FAM6_CORE2_DUNNINGTON	0x1D
+#define INTEL_CORE2_DUNNINGTON		IFM(6, 0x1D)
 
 #define INTEL_FAM6_NEHALEM		0x1E
+#define INTEL_NEHALEM			IFM(6, 0x1E)
 #define INTEL_FAM6_NEHALEM_G		0x1F /* Auburndale / Havendale */
+#define INTEL_NEHALEM_G			IFM(6, 0x1F) /* Auburndale / Havendale */
 #define INTEL_FAM6_NEHALEM_EP		0x1A
+#define INTEL_NEHALEM_EP		IFM(6, 0x1A)
 #define INTEL_FAM6_NEHALEM_EX		0x2E
+#define INTEL_NEHALEM_EX		IFM(6, 0x2E)
 
 #define INTEL_FAM6_WESTMERE		0x25
+#define INTEL_WESTMERE			IFM(6, 0x25)
 #define INTEL_FAM6_WESTMERE_EP		0x2C
+#define INTEL_WESTMERE_EP		IFM(6, 0x2C)
 #define INTEL_FAM6_WESTMERE_EX		0x2F
+#define INTEL_WESTMERE_EX		IFM(6, 0x2F)
 
 #define INTEL_FAM6_SANDYBRIDGE		0x2A
+#define INTEL_SANDYBRIDGE		IFM(6, 0x2A)
 #define INTEL_FAM6_SANDYBRIDGE_X	0x2D
+#define INTEL_SANDYBRIDGE_X		IFM(6, 0x2D)
 #define INTEL_FAM6_IVYBRIDGE		0x3A
+#define INTEL_IVYBRIDGE			IFM(6, 0x3A)
 #define INTEL_FAM6_IVYBRIDGE_X		0x3E
+#define INTEL_IVYBRIDGE_X		IFM(6, 0x3E)
 
 #define INTEL_FAM6_HASWELL		0x3C
+#define INTEL_HASWELL			IFM(6, 0x3C)
 #define INTEL_FAM6_HASWELL_X		0x3F
+#define INTEL_HASWELL_X			IFM(6, 0x3F)
 #define INTEL_FAM6_HASWELL_L		0x45
+#define INTEL_HASWELL_L			IFM(6, 0x45)
 #define INTEL_FAM6_HASWELL_G		0x46
+#define INTEL_HASWELL_G			IFM(6, 0x46)
 
 #define INTEL_FAM6_BROADWELL		0x3D
+#define INTEL_BROADWELL			IFM(6, 0x3D)
 #define INTEL_FAM6_BROADWELL_G		0x47
+#define INTEL_BROADWELL_G		IFM(6, 0x47)
 #define INTEL_FAM6_BROADWELL_X		0x4F
+#define INTEL_BROADWELL_X		IFM(6, 0x4F)
 #define INTEL_FAM6_BROADWELL_D		0x56
+#define INTEL_BROADWELL_D		IFM(6, 0x56)
 
 #define INTEL_FAM6_SKYLAKE_L		0x4E	/* Sky Lake             */
+#define INTEL_SKYLAKE_L			IFM(6, 0x4E) /* Sky Lake */
 #define INTEL_FAM6_SKYLAKE		0x5E	/* Sky Lake             */
+#define INTEL_SKYLAKE			IFM(6, 0x5E) /* Sky Lake */
 #define INTEL_FAM6_SKYLAKE_X		0x55	/* Sky Lake             */
+#define INTEL_SKYLAKE_X			IFM(6, 0x55) /* Sky Lake */
 /*                 CASCADELAKE_X	0x55	   Sky Lake -- s: 7     */
 /*                 COOPERLAKE_X		0x55	   Sky Lake -- s: 11    */
 
 #define INTEL_FAM6_KABYLAKE_L		0x8E	/* Sky Lake             */
+#define INTEL_KABYLAKE_L		IFM(6, 0x8E) /* Sky Lake */
 /*                 AMBERLAKE_L		0x8E	   Sky Lake -- s: 9     */
 /*                 COFFEELAKE_L		0x8E	   Sky Lake -- s: 10    */
 /*                 WHISKEYLAKE_L	0x8E       Sky Lake -- s: 11,12 */
 
 #define INTEL_FAM6_KABYLAKE		0x9E	/* Sky Lake             */
+#define INTEL_KABYLAKE			IFM(6, 0x9E) /* Sky Lake */
 /*                 COFFEELAKE		0x9E	   Sky Lake -- s: 10-13 */
 
 #define INTEL_FAM6_COMETLAKE		0xA5	/* Sky Lake             */
+#define INTEL_COMETLAKE			IFM(6, 0xA5) /* Sky Lake */
 #define INTEL_FAM6_COMETLAKE_L		0xA6	/* Sky Lake             */
+#define INTEL_COMETLAKE_L		IFM(6, 0xA6) /* Sky Lake */
 
 #define INTEL_FAM6_CANNONLAKE_L		0x66	/* Palm Cove */
+#define INTEL_CANNONLAKE_L		IFM(6, 0x66) /* Palm Cove */
 
 #define INTEL_FAM6_ICELAKE_X		0x6A	/* Sunny Cove */
+#define INTEL_ICELAKE_X			IFM(6, 0x6A) /* Sunny Cove */
 #define INTEL_FAM6_ICELAKE_D		0x6C	/* Sunny Cove */
+#define INTEL_ICELAKE_D			IFM(6, 0x6C) /* Sunny Cove */
 #define INTEL_FAM6_ICELAKE		0x7D	/* Sunny Cove */
+#define INTEL_ICELAKE			IFM(6, 0x7D) /* Sunny Cove */
 #define INTEL_FAM6_ICELAKE_L		0x7E	/* Sunny Cove */
+#define INTEL_ICELAKE_L			IFM(6, 0x7E) /* Sunny Cove */
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D	/* Sunny Cove */
+#define INTEL_ICELAKE_NNPI		IFM(6, 0x9D) /* Sunny Cove */
 
 #define INTEL_FAM6_ROCKETLAKE		0xA7	/* Cypress Cove */
+#define INTEL_ROCKETLAKE		IFM(6, 0xA7) /* Cypress Cove */
 
 #define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
+#define INTEL_TIGERLAKE_L		IFM(6, 0x8C) /* Willow Cove */
 #define INTEL_FAM6_TIGERLAKE		0x8D	/* Willow Cove */
+#define INTEL_TIGERLAKE			IFM(6, 0x8D) /* Willow Cove */
 
 #define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */
+#define INTEL_SAPPHIRERAPIDS_X		IFM(6, 0x8F) /* Golden Cove */
 
 #define INTEL_FAM6_EMERALDRAPIDS_X	0xCF
+#define INTEL_EMERALDRAPIDS_X		IFM(6, 0xCF)
 
 #define INTEL_FAM6_GRANITERAPIDS_X	0xAD
+#define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD)
 #define INTEL_FAM6_GRANITERAPIDS_D	0xAE
+#define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
 
 /* "Hybrid" Processors (P-Core/E-Core) */
 
 #define INTEL_FAM6_LAKEFIELD		0x8A	/* Sunny Cove / Tremont */
+#define INTEL_LAKEFIELD			IFM(6, 0x8A) /* Sunny Cove / Tremont */
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
+#define INTEL_ALDERLAKE			IFM(6, 0x97) /* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
+#define INTEL_ALDERLAKE_L		IFM(6, 0x9A) /* Golden Cove / Gracemont */
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7	/* Raptor Cove / Enhanced Gracemont */
+#define INTEL_RAPTORLAKE		IFM(6, 0xB7) /* Raptor Cove / Enhanced Gracemont */
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_RAPTORLAKE_P		IFM(6, 0xBA)
 #define INTEL_FAM6_RAPTORLAKE_S		0xBF
+#define INTEL_RAPTORLAKE_S		IFM(6, 0xBF)
 
 #define INTEL_FAM6_METEORLAKE		0xAC
+#define INTEL_METEORLAKE		IFM(6, 0xAC)
 #define INTEL_FAM6_METEORLAKE_L		0xAA
+#define INTEL_METEORLAKE_L		IFM(6, 0xAA)
 
 #define INTEL_FAM6_ARROWLAKE_H		0xC5
+#define INTEL_ARROWLAKE_H		IFM(6, 0xC5)
 #define INTEL_FAM6_ARROWLAKE		0xC6
+#define INTEL_ARROWLAKE			IFM(6, 0xC6)
 #define INTEL_FAM6_ARROWLAKE_U		0xB5
+#define INTEL_ARROWLAKE_U		IFM(6, 0xB5)
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
+#define INTEL_LUNARLAKE_M		IFM(6, 0xBD)
 
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
+#define INTEL_ATOM_BONNELL		IFM(6, 0x1C) /* Diamondville, Pineview */
 #define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */
+#define INTEL_ATOM_BONNELL_MID		IFM(6, 0x26) /* Silverthorne, Lincroft */
 
 #define INTEL_FAM6_ATOM_SALTWELL	0x36 /* Cedarview */
+#define INTEL_ATOM_SALTWELL		IFM(6, 0x36) /* Cedarview */
 #define INTEL_FAM6_ATOM_SALTWELL_MID	0x27 /* Penwell */
+#define INTEL_ATOM_SALTWELL_MID		IFM(6, 0x27) /* Penwell */
 #define INTEL_FAM6_ATOM_SALTWELL_TABLET	0x35 /* Cloverview */
+#define INTEL_ATOM_SALTWELL_TABLET	IFM(6, 0x35) /* Cloverview */
 
 #define INTEL_FAM6_ATOM_SILVERMONT	0x37 /* Bay Trail, Valleyview */
+#define INTEL_ATOM_SILVERMONT		IFM(6, 0x37) /* Bay Trail, Valleyview */
 #define INTEL_FAM6_ATOM_SILVERMONT_D	0x4D /* Avaton, Rangely */
+#define INTEL_ATOM_SILVERMONT_D		IFM(6, 0x4D) /* Avaton, Rangely */
 #define INTEL_FAM6_ATOM_SILVERMONT_MID	0x4A /* Merriefield */
+#define INTEL_ATOM_SILVERMONT_MID	IFM(6, 0x4A) /* Merriefield */
 
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
+#define INTEL_ATOM_AIRMONT		IFM(6, 0x4C) /* Cherry Trail, Braswell */
 #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
+#define INTEL_ATOM_AIRMONT_MID		IFM(6, 0x5A) /* Moorefield */
 #define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
+#define INTEL_ATOM_AIRMONT_NP		IFM(6, 0x75) /* Lightning Mountain */
 
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
+#define INTEL_ATOM_GOLDMONT		IFM(6, 0x5C) /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_D	0x5F /* Denverton */
+#define INTEL_ATOM_GOLDMONT_D		IFM(6, 0x5F) /* Denverton */
 
 /* Note: the micro-architecture is "Goldmont Plus" */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+#define INTEL_ATOM_GOLDMONT_PLUS	IFM(6, 0x7A) /* Gemini Lake */
 
 #define INTEL_FAM6_ATOM_TREMONT_D	0x86 /* Jacobsville */
+#define INTEL_ATOM_TREMONT_D		IFM(6, 0x86) /* Jacobsville */
 #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
+#define INTEL_ATOM_TREMONT		IFM(6, 0x96) /* Elkhart Lake */
 #define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
+#define INTEL_ATOM_TREMONT_L		IFM(6, 0x9C) /* Jasper Lake */
 
 #define INTEL_FAM6_ATOM_GRACEMONT	0xBE /* Alderlake N */
+#define INTEL_ATOM_GRACEMONT		IFM(6, 0xBE) /* Alderlake N */
 
 #define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
+#define INTEL_ATOM_CRESTMONT_X		IFM(6, 0xAF) /* Sierra Forest */
 #define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
+#define INTEL_ATOM_CRESTMONT		IFM(6, 0xB6) /* Grand Ridge */
 
 #define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+#define INTEL_ATOM_DARKMONT_X		IFM(6, 0xDD) /* Clearwater Forest */
 
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
+#define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_FAM6_XEON_PHI_KNM		0x85 /* Knights Mill */
+#define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
 /* Family 5 */
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
+#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
 #endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index ad67760..2243083 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -17,8 +17,7 @@
  *
  * A typical table entry would be to match a specific CPU
  *
- * X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_BROADWELL,
- *				      X86_FEATURE_ANY, NULL);
+ * X86_MATCH_VFM_FEATURE(INTEL_BROADWELL, X86_FEATURE_ANY, NULL);
  *
  * Fields can be wildcarded with %X86_VENDOR_ANY, %X86_FAMILY_ANY,
  * %X86_MODEL_ANY, %X86_FEATURE_ANY (except for vendor)

