Return-Path: <linux-kernel+bounces-147569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD48A7648
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8DB1C22AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B3213AA2D;
	Tue, 16 Apr 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmH6QiZz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38186E5F6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302403; cv=none; b=g98N5TLnCe4C/zps98mtzOavLOTowEPe+Dv1k5r5JesApS7l60JyP+g9S5vFM23jooJxpuUqExiOGHzIs4iC9C486nJDrgW+7wmLU7IV5kWAD1Ua76tIvV5PUWvPiMw8JcsPQvU2xC66Tqc1Wxi+SiQaH2GKKJk26JwC8ckpI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302403; c=relaxed/simple;
	bh=CwybUVe8crx1l4CZK03c9vCx8DvC8Bgt8uPcKdw9g+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t58agEVcTPk5NhdNPwKixgf1AWEuyhac56WoD2iPC2Uwps6pwBBMcyg6+x6MDZPk9Tzwio6DODB/06ABa5J/ecbOZjLqkS7BgrS/x8Gv7KKUZX956KKiFZal5VJnWXTnIjg+sMnUpUhbny2YWsfmLKnEaRYyF9gXxEmICEXmMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmH6QiZz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302401; x=1744838401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwybUVe8crx1l4CZK03c9vCx8DvC8Bgt8uPcKdw9g+E=;
  b=GmH6QiZzuwu3BkgYxxFBTlF3cqB1Wk9oQagpNQUq9iOC+H6p4uCxwiK4
   m4aQzbXdJSQtIMO8QYsT4+cP4h8izoEhsRR+u8tFbWM9BTY2UCctM64yO
   s8H7GB2wWbJO1IWTNG7vtyjEDC5NgfTVc3cd6RWxjjS5wDI3Nt+/+rkni
   9LcUoBpRmvCUzWJYf3Apcdpg4zAJ9y8rbJJg9vGgXMsZu3iuTrsVszqsk
   SjJu1fTfaQgRiradHb4tWEICP/54obAgtZkGxgQp2HUiVhMq7xpQ5jUwj
   uCpvx8M2if6pLGK81EdJiWiAwjR/8bnPU3XZrGSSSEDvbZGSjU665NPO8
   w==;
X-CSE-ConnectionGUID: Hjt1yRTDTz6O0cJpi1azug==
X-CSE-MsgGUID: gPeJIVgCT06QdOoUaTYE0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914687"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914687"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
X-CSE-ConnectionGUID: w2qRgShKTTufJxObSaJ2zQ==
X-CSE-MsgGUID: YL19oXZbR/i4bqkwfFkLPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871886"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:57 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 05/74] x86/cpu/vfm: Update arch/x86/crypto/twofish_glue_3way.c
Date: Tue, 16 Apr 2024 14:19:07 -0700
Message-ID: <20240416211941.9369-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/crypto/twofish_glue_3way.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 90454cf18e0d..82311249048f 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "twofish.h"
 #include "ecb_cbc_helpers.h"
 
@@ -107,10 +109,10 @@ static bool is_blacklisted_cpu(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
 
-	if (boot_cpu_data.x86 == 0x06 &&
-		(boot_cpu_data.x86_model == 0x1c ||
-		 boot_cpu_data.x86_model == 0x26 ||
-		 boot_cpu_data.x86_model == 0x36)) {
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_ATOM_BONNELL:
+	case INTEL_ATOM_BONNELL_MID:
+	case INTEL_ATOM_SALTWELL:
 		/*
 		 * On Atom, twofish-3way is slower than original assembler
 		 * implementation. Twofish-3way trades off some performance in
-- 
2.44.0


