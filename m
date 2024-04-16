Return-Path: <linux-kernel+bounces-147594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CEF8A7663
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E991C21C47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59E145FE1;
	Tue, 16 Apr 2024 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3+P2mPP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8A13D525
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302414; cv=none; b=cZhOTn1fMa3Xlcdhnc9hOBszajvQdlnFzAZP2yODVv7H5jPlxzwyiS3Vo4Vw7Tgp25OfcEfXvg3HNkR7hRONJCvpw2goT5UkYKXJs3/sH2Z1N4/XkorJ5O7k5vtCAQ0QV0INH33hvLNS3fZ3tuFZi+r4bjs5ELpevUDg/p6cudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302414; c=relaxed/simple;
	bh=obhXYEmt6d4ZPBEnG583vH7Ox14Ir+rTrmmNAEgF6jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jru9H9AhQiSYDn7gUerEldcQoglcRpkX6NC9oqA1a7r1TAMAbuLB/0bDaiqdhSg/7QIpPVlakKqay0jp8z8HFGXS5tahrGGO4LR6J9c+4G3wgLQ5QwvLX/i7lbxNR6o6qZQjIZCswhtYqWaq+MmjAyEzkBeWG02fI+MEsLzDE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3+P2mPP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302413; x=1744838413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obhXYEmt6d4ZPBEnG583vH7Ox14Ir+rTrmmNAEgF6jg=;
  b=k3+P2mPPK67yIxxBQNnjBkyKxtwcZsFqTjT9LHR282xIpfw2mPYZHFHw
   ktbOc4mhjoxScSPqrMZOW5xmhczwyJiHEhgdcBfYN7e67tIIXguoKH2lJ
   f82A5sFW8V9EO/Xl3to8pXQTxxuiekzgPqYF/P1ZrN35a+G5Lvr0sxcFS
   nMsTyJOogevJFoaD9d5zVIDwS1WJbP5UK2tCI5HOLMwagBhyDSYvXiiyV
   6dV2efVqteIVyye3ezMM3w9oEn190oypVp1MY6sTGCxomxcpfCe3sUYWn
   umYYvGPnOxIYx33oyL7L4UjMsN3KeEXaf2acZowyqP7YG+i0ZhvsbGWZF
   Q==;
X-CSE-ConnectionGUID: UZdbxlkgQFGknIodI8/56g==
X-CSE-MsgGUID: Cqa5eWUgSEeElYKyRZf+qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914825"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914825"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:02 -0700
X-CSE-ConnectionGUID: aLDOVuQbQLmAFipp3XT1Gw==
X-CSE-MsgGUID: yGJbytZUQOi4wI2Bs5YLNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22872027"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:20:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 33/74] x86/cpu/vfm: Update arch/x86/pci/intel_mid_pci.c
Date: Tue, 16 Apr 2024 14:19:35 -0700
Message-ID: <20240416211941.9369-34-tony.luck@intel.com>
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
 arch/x86/pci/intel_mid_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd62206604..933ff795e53e 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -216,7 +216,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 }
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
@@ -243,7 +243,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		model = id->model;
 
 	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT_MID:
+	case VFM_MODEL(INTEL_ATOM_SILVERMONT_MID):
 		polarity_low = false;
 
 		/* Special treatment for IRQ0 */
-- 
2.44.0


