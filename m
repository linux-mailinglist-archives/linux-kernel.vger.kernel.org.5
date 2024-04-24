Return-Path: <linux-kernel+bounces-157502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EAB8B122D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C2284574
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AB1C233D;
	Wed, 24 Apr 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/jpg0t4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90F1C0DFD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982536; cv=none; b=JHG2Ic2I8eRdcu7RqP5qONzMbGmL/YmFq9HbCRDG4T+qejsQeH+8GhwUZl/U6FiDQUEnIWbGKIb3ejVxzlmxhcWvT8gH38GARv/9rzdzI9OUPlZZMK1zIAWFO277KkwswvDcMtcUDcvdB1OJNj+KwysCE5lqJvTpwyhQCWak1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982536; c=relaxed/simple;
	bh=xK5hwg6ILPkC2v4d4nuHc6WucRElJH7HgJqquuK12yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb0g8LybFE0kYJzJeWYdfbw5Uen+kdI9ZXDmkpEoms/XNGGlrueOJumsoYhfd5YrA39mMLTptzrrqHBD01fUWGqPwIKI2OJipBRnCM/CZiLlTDooetxki9BbUE/hrbj8OwGuvqfckOPACZpOMQMkNdbeEfBTFQXYP+QFDjMaruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/jpg0t4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982535; x=1745518535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xK5hwg6ILPkC2v4d4nuHc6WucRElJH7HgJqquuK12yY=;
  b=F/jpg0t4vTwEpKlznAESztsUeBlVK3ro1IHap8nAgPwoS1cjes94QiZt
   qGRobq71EH+p5i7f25BgfmL5ggjVfCQ5vXmLlDeOVfrkK0FT49AIZY8qQ
   8Wh9gU2CR/KLvmyQwlsCIk0teVNSuvx3nbHnIsBqjTB0s+SX2eReve/MN
   xYf3yHyrgp9nWfQprO8okmHkopt111ySsxdvNHwPSHo5YGsJIAWsakbcT
   xicwkaWFFeysf0z2lah/GN7i3HoK0TP68Vkz1BAtgWF+roiYOLZZhYa/J
   1KeX4RdxAIrYXTd8TDef6U/eejUxwj8DbfXAOdbDmKdPK3t2o2DtDPPNf
   Q==;
X-CSE-ConnectionGUID: vL8Smqe/Ri+Csd+HLn1Wgw==
X-CSE-MsgGUID: zoPAOcR/RGaEPGaWBFETGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503640"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503640"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:33 -0700
X-CSE-ConnectionGUID: g73wVqPSR2S9jaEoDl2w+g==
X-CSE-MsgGUID: 7OARLnhRQjGS6vNr5SQNMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750215"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:33 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 53/71] extcon: axp288: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:32 -0700
Message-ID: <20240424181532.42178-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
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


