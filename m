Return-Path: <linux-kernel+bounces-164445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888C98B7DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D79287E65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633681A38D4;
	Tue, 30 Apr 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2Ep+ZIJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D4190682
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495901; cv=none; b=OdPzmNxQZNYArwQWZa/nBWsva2JJL1AlB8mymyKjhUQ0ZucEekOONyQcuyJ7H+GxOAFZeVN5SSTOW7zXN2DIc4RynEZ/wqw+WqlgKuB1P/5z/LLQylLvRz/f9gKidCIKBhkk6CD4erw1CtY7NAzgQkl87BTVrvsSJm/BbpTI7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495901; c=relaxed/simple;
	bh=eB9PfcugR7Y4foLLI2s5L7tsFJT7F2JDjIJfJLy0Dqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLo8hpzWeBVEB8v8Z37IPOp9aIaOLn2cfrger6dDzDKDMZhQ1ibePofA1kiArQdNKtcNKSThGDDoaRviCzinlNecwhUq6+n4WnxskPqBkJtbdPeMrUF8KmIKdmqaEWlJzCGTj7f8aPrXboBe84ZBf3SpbxnkXUttYc0V8se+8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2Ep+ZIJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495899; x=1746031899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eB9PfcugR7Y4foLLI2s5L7tsFJT7F2JDjIJfJLy0Dqo=;
  b=Q2Ep+ZIJy4X6tPIU53V8j7+gncwF14CDzjMqodLMLbe+rjn0WbSjV0w+
   +ACDnevFXOrVbhpfogpqNFDtCtbfv1V9DEHXxCJmX+uHbUNHoeSabvDeY
   xMJOjQ7TxpQehdN76qM5PuhRBFRTTppXjwRj7ofhY2SkuVzwI64007CKf
   nEhTaoC60efugSoipokqxA7eylsBPv013wO0DQJro8kcYJWCFFu6HNEAT
   m3uTdOs+3t/6LikhZ+T1mQ+1a7B0qKQOocuilBZLWH59bmVsHvGIEN+vy
   v2SbpY9rYrUm4Uv41s1PHcnXQNXw95Amrdv/2Os8+zQMyXhaEK5WZG2vc
   A==;
X-CSE-ConnectionGUID: S2PXaMekR7qDGYCySFSdFA==
X-CSE-MsgGUID: ZYCS4d+kTmyPIE2GsKQHMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075670"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: 5fKwosolTLaFAsj/d0r4MA==
X-CSE-MsgGUID: QnvLzvnhQzekkftFO+N/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515415"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 05/47] platform/x86: intel_scu_wdt: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:18 -0700
Message-ID: <20240430165100.73491-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_scu_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
index a5031a25632e..d0b6637861d3 100644
--- a/drivers/platform/x86/intel_scu_wdt.c
+++ b/drivers/platform/x86/intel_scu_wdt.c
@@ -50,7 +50,7 @@ static struct intel_mid_wdt_pdata tangier_pdata = {
 };
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &tangier_pdata),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &tangier_pdata),
 	{}
 };
 
-- 
2.44.0


