Return-Path: <linux-kernel+bounces-147609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D58A7680
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D44B24B25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96613B29B;
	Tue, 16 Apr 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTgdN8j3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501EB14A0AC;
	Tue, 16 Apr 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302532; cv=none; b=porurcUNYKisr1WALZPNMtPeZaOEepQpDA1P2d0lT6IwpbEP3YAZBIlS2rUms948q3OTJfC73G4gH5Yxhm0M/CsGOyWMwket1pP+FJMFSK0+2aRRVgVp/NN2c9o6e2IEGDXSTZW6ORyl83Pf7GeHebzSQUuIS7tOL3PFcYDTHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302532; c=relaxed/simple;
	bh=P/jfG3oJQnxJWF8y4/FRhX5DE6yIHQm3rt2+JP3bIkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD+r/gR/uWEhGciZFdGzhaRGKT3tiJWhs9o09N0CPEKMc3cz9S9+bwqBFX869uWMudr7720Nlmzh8vtCtqN9E1gKZu6JdkXrsXw6RC9lgEnvcADGhbD5tV1dwpmc+++2CGkii3mV45Zqx5C/DdyWKeARv7URitkFgcaRGV/AjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTgdN8j3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302532; x=1744838532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/jfG3oJQnxJWF8y4/FRhX5DE6yIHQm3rt2+JP3bIkc=;
  b=cTgdN8j3nO/eazGpKZ6WfwNwUHWdKMVadQJo/o6/WJMoAhRrWPM09sHs
   tpgLa09AxKXOXklSpuavES9eXOdVJzE3VxJydhUJM4ApinjnH6nJ5kQQX
   4XBD7ncUJppFuWWTCYmULGswm/tKT7X//QH+wtuX2tLptelT7LQUsZtTB
   llp8FHifMAVyDZFYIg0N0X4bVoxpxdlVqKK8CKSEPcamn2EufFCZw0G33
   xyOkCSaXp/U4yboMfR27KFTVJQjJlPhegOCkvXZn49+nqbsZDioKxTesX
   xAsvNDRPt16bIuva+0Q6ne1nrbdXIMdda+ZYA5E5fXLo4ZBqtmXRMhIoD
   w==;
X-CSE-ConnectionGUID: 6BdOTNxIQk2yjS2EOw07sg==
X-CSE-MsgGUID: 5EX/vSxtTQW8mMNFwA15Pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19328772"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19328772"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:11 -0700
X-CSE-ConnectionGUID: ZL+GyJCKSyyerg211JyOxw==
X-CSE-MsgGUID: GwMQFiJwT5K3pkj+r8Ul2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27071916"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:11 -0700
From: Tony Luck <tony.luck@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 46/74] x86/cpu/vfm: Update drivers/edac/pnd2_edac.c
Date: Tue, 16 Apr 2024 14:22:09 -0700
Message-ID: <20240416212209.9528-1-tony.luck@intel.com>
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
 drivers/edac/pnd2_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2afcd148fcf8..f93f2f2b1cf2 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1511,8 +1511,8 @@ static struct dunit_ops dnv_ops = {
 };
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&apl_ops),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&dnv_ops),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&apl_ops),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&dnv_ops),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
-- 
2.44.0


