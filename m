Return-Path: <linux-kernel+bounces-164468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A739B8B7DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479781F258B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18F20013C;
	Tue, 30 Apr 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juM1tpYE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C471C8FCF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495914; cv=none; b=sDS7GqiVsPiK5SWCGnpARfKgJaCslTveSbO+1jr8Ak2nXCXWyl60/3mbCCW1HqwWFxPxE7Y+BSKR6AbjrrUl+iEJWToAgJmmO6h0kpzK8Cgi/r9DraWKP9Pya3hKFpnAyvkalTBWsIvSoWuROQzitaJZtDnXHXOhvAUo24gqXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495914; c=relaxed/simple;
	bh=xK5hwg6ILPkC2v4d4nuHc6WucRElJH7HgJqquuK12yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4JVurcZHfdANeZZECSQsc6yBKzFZWMgAslQRoF0+6quuuktxvv1J+pucwnqYzznBAcPCNjPCqQGMYrREIJA0RPyytEosAnRw2XCwu9yDezVMVBi0fDaFCMM1DXyZoVFFUEaSvyJUWkUEefPd2RcClT5uLZycwDfTeGaxSd2+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juM1tpYE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495913; x=1746031913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xK5hwg6ILPkC2v4d4nuHc6WucRElJH7HgJqquuK12yY=;
  b=juM1tpYEIKqReKHobb//+eNH6+FuKzuUn56p5sDiBCVdy6MfDk7lKa8z
   LrnifinGXT8MgZCL0afRi4ZUVE/dNERbyHAFCiHdgxTPeFt6jbIpXxjBT
   Rz20Pu41mFVJXfgVFOrkrpNe6aq4Q/ndKeKWjTg1E7tDnHAQ/DjJlEnoS
   VSAGLbcKTjtttiR/82ZbGeO2jJL7iHzp9fWGii4g17qGEFJxy6fnjbeR+
   PwXY564bK79o9GwwGjwZo5yaM6ry9DsbI7cTjEgPx7ARmOiDyw6xotNwL
   moSeJ6XLJw0i2RzM2Pq+6Cs0lBbkAfDbgMN2EnWjQ1Ot0gIoqgTUvOr8c
   w==;
X-CSE-ConnectionGUID: NQJxCcOHQe2nDrd/3yDIBA==
X-CSE-MsgGUID: yUucR4BqTM61ZrtyoyqfQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075804"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075804"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: y0ZVF9PoRYW+VcEpLNNWnA==
X-CSE-MsgGUID: i6DXGELcQuawBGsMwjQcgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515509"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:19 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v5 37/47] extcon: axp288: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:50 -0700
Message-ID: <20240430165100.73491-37-tony.luck@intel.com>
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
---
 drivers/extcon/extcon-axp288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a703a8315634..d3bcbe839c09 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -108,7 +108,7 @@ struct axp288_extcon_info {
 };
 
 static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 
-- 
2.44.0


