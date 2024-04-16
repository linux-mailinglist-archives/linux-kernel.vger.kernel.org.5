Return-Path: <linux-kernel+bounces-147615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946E8A768C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39C11F21B53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20910152DE3;
	Tue, 16 Apr 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9Azzt1O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6415217A;
	Tue, 16 Apr 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302542; cv=none; b=mJklT9t2Heqw1B2PD/+X3xqyfig1EtpJgBDIwGCPBZO22+d8LKVFTZUh6HpKECgTOfQJPgofcUqzd16+3ZPj+fd5viFssZkZCAAMObpaja6lWrrwKf6UlkEbAER9inUifoXK4ko74zuy16KrrKr9QlGfi3dYEsMWoHAN6Ca8zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302542; c=relaxed/simple;
	bh=/298Une+Q9Sn9FwIP6fJUsWhONOKrs7AQEbwqwMcHfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRvoyvS66NxE1HneKu0B9fn6IBKqebywfLk4vqRz4fFcEU2hsOFNFxjmSOt3a6FtFtzTUmCT8NT8DN0/mGeGfzTGR+pGvp7B9CFipayobwPEYsyjBRA8CJaeBWXhgBI2DJp8b9az5HWvZGhjrI6przODM1vwcj+sQSjnu0cwOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9Azzt1O; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302542; x=1744838542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/298Une+Q9Sn9FwIP6fJUsWhONOKrs7AQEbwqwMcHfA=;
  b=A9Azzt1O1bL922yQrVMtH/WKMKZY2yci28bELn4PUAFED5j4V2qQ9aMz
   Av/0fmYbCDMy7+UgJUWMGETKErkoxngysVhMcsun3yLDfbCgPG9h5pXqn
   H7ILBIfo8aBJRgNHDOWKF3jO0rcJkha+5Kc02X1AM9KzmLHtFIZMSGtqP
   jsFlPcrQ/H7+Qiw0PJNs5siUaXyURZJRHHQ7x/ANasbVjlH37MlJOMifV
   Zchm0wIMgJvyBBRKAPF7DGKo3jhNu9MS5j6z7j20Jgo4FzCNzLyRKM8hA
   jGNyK9YH6v6AwFvi1FtjdcXNWWy1FN8wMEywW7tfEfzd8zU176z/rd7jA
   w==;
X-CSE-ConnectionGUID: qRzKmqxcSUiKTt/WM3NkhA==
X-CSE-MsgGUID: sQmN4IhZRhmAvl6ObJsoUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234919"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234919"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:22 -0700
X-CSE-ConnectionGUID: KffXtiapTRG3ueqR0c23dA==
X-CSE-MsgGUID: UTuuVrIbQ9elOnRDRiUixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267091"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:21 -0700
From: Tony Luck <tony.luck@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 52/74] x86/cpu/vfm: Update drivers/pci/pci-mid.c
Date: Tue, 16 Apr 2024 14:22:19 -0700
Message-ID: <20240416212219.9643-1-tony.luck@intel.com>
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
 drivers/pci/pci-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index fbfd78127123..bed9f0755271 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -38,8 +38,8 @@ pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * arch/x86/platform/intel-mid/pwr.c.
  */
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SALTWELL_MID, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, NULL),
 	{}
 };
 
-- 
2.44.0


