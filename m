Return-Path: <linux-kernel+bounces-147628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23D8A76A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633BC1F223A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8067A15532F;
	Tue, 16 Apr 2024 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdUMnn7t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFE155308;
	Tue, 16 Apr 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302564; cv=none; b=P4HjdnTOUXbvuZhDnM7s5GeuLXG5B1SdoXW70KlNen9HN1M4t7FmCHNI6+kGMzASM09KdSLSYNGch8L5mqtb3Ml983gimWW7v59+MrLVar0jIn4Zm7bqKeXIYPFqyrTH5FpdbYuOuVEhsG+Jx8NTU2G7KAP6A5pRcKSjmYezeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302564; c=relaxed/simple;
	bh=NHkS+PLB8tCqh4PRqBz9xJFe66d4//WHYse1TcAmK38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XllP7+SVcazlMmFvF2B+xuUtVxkPSmTT9zAb6YCFUVdVWJhx65876jZIY92CjtVjTooh7jaK8WBE0G1quOYvEOTaSTDKiNSxT37YYofWOwc2JSwEqfTJimunMrCHwD7RhSng7pG9jTRJRnaU4CRRRAFtEuWGx9BdS863G43uJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdUMnn7t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302564; x=1744838564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHkS+PLB8tCqh4PRqBz9xJFe66d4//WHYse1TcAmK38=;
  b=KdUMnn7tnQDNbmC5V+KSZUKBQ+Yvw1m8Ux6/pv7qAMWKJGus+u+RCUnK
   7YxL3/zACc/VDG+OR0JxPTXlPFaX+OMkaJPOMpr0CnI2F0eXL5zR3wTSV
   7BDMzoPzwtDflg+tTdWMSEZ+U1t/aHJ/laMPDwschwsHrbzOCTfzyJs9Y
   /zB6glJXpzVI5KATysjNjmxioI+wl2uj3YNEI7JIbCbB2T5BvUzsfpCTp
   aKGA5XoNAfnC1tGs944HHQI8RT3/541RTjYQcQW/JvWZZnWfmqElh3N34
   fCtM7SW1vcdXR90fL2l9rnyeOAFbn6YVfw50F3BlSv41ftv5tsaoZUpwq
   g==;
X-CSE-ConnectionGUID: 9ixbHLjcTbi22Tmi5JKTAw==
X-CSE-MsgGUID: WZh0DlQ7RYGoKdSG+dZsiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234985"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234985"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:44 -0700
X-CSE-ConnectionGUID: CWiLvwUlQ3KLEGIfcRl7qg==
X-CSE-MsgGUID: I8zxmdTuSDGrL2Y8iU9mxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267180"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:43 -0700
From: Tony Luck <tony.luck@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 65/74] x86/cpu/vfm: Update drivers/platform/x86/p2sb.c
Date: Tue, 16 Apr 2024 14:22:42 -0700
Message-ID: <20240416212242.9891-1-tony.luck@intel.com>
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
 drivers/platform/x86/p2sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 3d66e1d4eb1f..8cfbf0bbd346 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -24,7 +24,7 @@
 #define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
-- 
2.44.0


