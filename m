Return-Path: <linux-kernel+bounces-164452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F38B7DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F03B1C23988
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D517BB0C;
	Tue, 30 Apr 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdcW81JA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71E1C0DCF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495907; cv=none; b=FQkPcLBiDlXDTnEslfP6RHYaEPO1rD2bNHPQcSyAbI0bobktB5gqRVtUDj7IEt4GxWgR8zBpBCd5TYBz+vIEXQCBF4B0sYp3zu33vfEZ+NmZkGOoF2+P4f+YMx+kV2Vpv51jXodLYbAUTPO0Cl2vXu/98sW8l6IXwwnwFDbYc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495907; c=relaxed/simple;
	bh=DjW81tHfP000Qq9cwTltickR0vyQ37yeIrDTrxUYdMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7zcYFliOfudYuQvHpLR+q06EffyDaQGeuaECsVPwBdNq2QKb/5/c6QX01fs059tUSDeh0rB+9BtveOkOwopQFzwRX7v0iNQetuWYOHHGEXs90Ha63DiV8zHhzIfnj4aDmQKOSyOyMQ32lnM5H3PY7MT1NODsQjsWS8A4mZ52qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdcW81JA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495905; x=1746031905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DjW81tHfP000Qq9cwTltickR0vyQ37yeIrDTrxUYdMQ=;
  b=IdcW81JAQgyqYV1M7OPdTVnINzXh/FGrth3vfXjn3toBgG/NMfgS4OSB
   2B8Q3bM1TFrlRxf4yGcZ98XiQzO3Z2aezoCKs3AZfJm1OzfOvgB3dj23l
   4puB8M8yZcAlumRLz9yKg6bH6obEj4EGNWdkh5ie76pe/3x1wh52mkZyY
   8vR45c2jgKZS74rOr+pF/9Csk4AAKCrLiDhOrdy6a2AmlCPxidoKTkzPD
   TTAI+NGdhjyzvnkCQN/izVFcZfihhHXeLcFgnHClRLepw2taDFRHgQ1IP
   78fXQuBSqWZKlif7FRAfr9jeQyHvH163Z21QKd8St8xLyGhnCDCQv9WOU
   A==;
X-CSE-ConnectionGUID: 59JYaP2NR+qtb8bA1XF7Sw==
X-CSE-MsgGUID: bXAiufWySCam7UdttC4jDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075686"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075686"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: VNOcgkTeShOfHc02yxWK2A==
X-CSE-MsgGUID: /17gissDQeike9vi2lazcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515454"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:17 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 19/47] platform/x86: intel: telemetry: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:32 -0700
Message-ID: <20240430165100.73491-19-tony.luck@intel.com>
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
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/telemetry/pltdrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/telemetry/pltdrv.c b/drivers/platform/x86/intel/telemetry/pltdrv.c
index 06311d0e9451..767a0bc6c7ad 100644
--- a/drivers/platform/x86/intel/telemetry/pltdrv.c
+++ b/drivers/platform/x86/intel/telemetry/pltdrv.c
@@ -177,8 +177,8 @@ static struct telemetry_plt_config telem_glk_config = {
 };
 
 static const struct x86_cpu_id telemetry_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&telem_apl_config),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&telem_glk_config),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&telem_apl_config),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&telem_glk_config),
 	{}
 };
 
-- 
2.44.0


