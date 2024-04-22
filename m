Return-Path: <linux-kernel+bounces-153143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD728ACA1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10341C20C01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D7713CFB7;
	Mon, 22 Apr 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ef2wO9+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGnIVHzm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAF6518F;
	Mon, 22 Apr 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780074; cv=none; b=hpahLlMxtnXTU7YwiqnwQFKOxfPfGCUtYvhKW3CDP4DPNfxuyl/CzwafK0a1YbZELLmiEXbn4SumdFTYnBEVot5H+jL9mu08WITOKU57FwEfHIWWHn5oHoFWutcPmdZZH/mUJH/PBUzQaPsndste9ieFnvdrtpYF1ks3HdXOInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780074; c=relaxed/simple;
	bh=BmYENEXDN0xAfqgj5FhEWxPMBxEHPT9mLHNE4e9Se00=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aLVY3HzFc6OMLNc4kEJlLSSQQSAMh5bMJsJSNbekYFDB3ZmlAFUCQt1sGs5yKIKs7tr4v5Jtuzf0bX9TXXA3xKe9S9ZvPOWCAEUXMmg35ZnPqU8dYsk9eJEOOrZ6RKHcz8UhMONyf+3SOqhrJQhQRyUGMp/9Epd9bcoWDUFd31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ef2wO9+A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGnIVHzm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 10:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713780069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9hI7A6km8WqPAn1moauJLIkkzsRvNZx2A1wWvsp/r4=;
	b=Ef2wO9+AgSPtZLyVi1yxNTWAz5a0JzPhW7J6Lv49WRwQGLnnEECKnAln91w3B8380UCDR3
	akLP15d5dWL0n9zfzstClSTztiDbKaPb6Ldcvdwe4jBZ1Fb0zFPFOqr0FIyY6xp520Zdii
	e4Wb8PEvXVyhMFQShbo9ZJaxnWcC7PMT40w0f/JDX8u5x+vJpTMdKWRtjomqZUh3Yhw81G
	vLsG2EhoqWYqaUvxR6HmB9u8zN5YSmLj/W8zNtuHiBbpyZDEfa8YdrU97lNNQYQuXJKJmI
	PMqaRWqSJDNU1l1zc0fACDG7nTARQRkWbkz/mfl9pdkr1arA6LI0CnmPqUnLEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713780069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9hI7A6km8WqPAn1moauJLIkkzsRvNZx2A1wWvsp/r4=;
	b=zGnIVHzmSaZgZSqY2Vx67xU/1wF9MQ7GH0idF7dc9AJVr3VzeE7WIzu81CMTa98HLZGSd5
	LLDNiGhiPGgHO5Aw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/vfm: Add new macros to work with
 (vendor/family/model) values
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240416211941.9369-3-tony.luck@intel.com>
References: <20240416211941.9369-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171378006732.10875.16181122194584504255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e6dfdc2e89a0adedf455814c91b977d6a584cc88
Gitweb:        https://git.kernel.org/tip/e6dfdc2e89a0adedf455814c91b977d6a584cc88
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 16 Apr 2024 14:19:04 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Apr 2024 11:43:55 +02:00

x86/cpu/vfm: Add new macros to work with (vendor/family/model) values

To avoid adding a slew of new macros for each new Intel CPU family
switch over from providing CPU model number #defines to a new
scheme that encodes vendor, family, and model in a single number.

  [ bp: s/casted/cast/g ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240416211941.9369-3-tony.luck@intel.com
---
 arch/x86/include/asm/cpu_device_id.h | 93 +++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index bf4e065..970a232 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -3,6 +3,39 @@
 #define _ASM_X86_CPU_DEVICE_ID
 
 /*
+ * Can't use <linux/bitfield.h> because it generates expressions that
+ * cannot be used in structure initializers. Bitfield construction
+ * here must match the union in struct cpuinfo_86:
+ *	union {
+ *		struct {
+ *			__u8	x86_model;
+ *			__u8	x86;
+ *			__u8	x86_vendor;
+ *			__u8	x86_reserved;
+ *		};
+ *		__u32		x86_vfm;
+ *	};
+ */
+#define VFM_MODEL_BIT	0
+#define VFM_FAMILY_BIT	8
+#define VFM_VENDOR_BIT	16
+#define VFM_RSVD_BIT	24
+
+#define	VFM_MODEL_MASK	GENMASK(VFM_FAMILY_BIT - 1, VFM_MODEL_BIT)
+#define	VFM_FAMILY_MASK	GENMASK(VFM_VENDOR_BIT - 1, VFM_FAMILY_BIT)
+#define	VFM_VENDOR_MASK	GENMASK(VFM_RSVD_BIT - 1, VFM_VENDOR_BIT)
+
+#define VFM_MODEL(vfm)	(((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
+#define VFM_FAMILY(vfm)	(((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_BIT)
+#define VFM_VENDOR(vfm)	(((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_BIT)
+
+#define	VFM_MAKE(_vendor, _family, _model) (	\
+	((_model) << VFM_MODEL_BIT) |		\
+	((_family) << VFM_FAMILY_BIT) |		\
+	((_vendor) << VFM_VENDOR_BIT)		\
+)
+
+/*
  * Declare drivers belonging to specific x86 CPUs
  * Similar in spirit to pci_device_id and related PCI functions
  *
@@ -49,6 +82,16 @@
 	.driver_data	= (unsigned long) _data				\
 }
 
+#define X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(_vendor, _family, _model, \
+						    _steppings, _feature, _data) { \
+	.vendor		= _vendor,					\
+	.family		= _family,					\
+	.model		= _model,					\
+	.steppings	= _steppings,					\
+	.feature	= _feature,					\
+	.driver_data	= (unsigned long) _data				\
+}
+
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_FEATURE - Macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
@@ -164,6 +207,56 @@
 	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
 						     steppings, X86_FEATURE_ANY, data)
 
+/**
+ * X86_MATCH_VFM - Match encoded vendor/family/model
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * Stepping and feature are set to wildcards
+ */
+#define X86_MATCH_VFM(vfm, data)			\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @steppings:	Bitmask of steppings to match
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * feature is set to wildcard
+ */
+#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		steppings, X86_FEATURE_ANY, data)
+
+/**
+ * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
+ * @vfm:	Encoded 8-bits each for vendor, family, model
+ * @feature:	A X86_FEATURE bit
+ * @data:	Driver specific data or NULL. The internal storage
+ *		format is unsigned long. The supplied value, pointer
+ *		etc. is cast to unsigned long internally.
+ *
+ * Steppings is set to wildcard
+ */
+#define X86_MATCH_VFM_FEATURE(vfm, feature, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
+		VFM_VENDOR(vfm),			\
+		VFM_FAMILY(vfm),			\
+		VFM_MODEL(vfm),				\
+		X86_STEPPING_ANY, feature, data)
+
 /*
  * Match specific microcode revisions.
  *

