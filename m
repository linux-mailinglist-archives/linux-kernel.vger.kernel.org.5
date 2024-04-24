Return-Path: <linux-kernel+bounces-157499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF5B8B1227
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5242E1F21440
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D6C1C0DEE;
	Wed, 24 Apr 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ye+31v7B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309961BED7C;
	Wed, 24 Apr 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982533; cv=none; b=hWtAmTgjdxZxQanMN/EWgq+OR1B0jqW4HgCSDShWBa5LriEK8HfUixsEDaaj77xLZfBtgxEfAAeWeBpehgba/AZvctUQaTM5OaCXEbqmT+JMovslaJL+NzKt3Sf5MAyjCdSK2pyz7mnnoVx9B82aMSTvVyVTCr4aycM45EXx4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982533; c=relaxed/simple;
	bh=P/jfG3oJQnxJWF8y4/FRhX5DE6yIHQm3rt2+JP3bIkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj/O97uJxnwR2rHr/NwTr1FxsO0vMmH3AG48jaLS+AczmgKD4YDV7w9l6iAbmBUyuJVCHIKfYjJ8Tf8Jhyx0u7C2El2UkO1LAiioD4ULUrUaCI7GcKcadjPARHH8fyyhouXFSg9/0jAEwpHZ6A94LZ4c+y8og1/OI0eOH7UlGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ye+31v7B; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982532; x=1745518532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/jfG3oJQnxJWF8y4/FRhX5DE6yIHQm3rt2+JP3bIkc=;
  b=Ye+31v7B6tYX6yg4GgTlFiM6bmz16yI+WgW4aToU8GvV2MErIVCUbPsI
   UohZ2Maq+35t2bSPPnvLkffT66l8S71uvdKeP4Gx8R2lm+14NymjHUKUZ
   ++cqq65LA+lvTJ1j3cFDSYYWOkafzR/leVb2QXKRbJEGX9DmNU+UIOgDy
   C9FdYTa9sPnIq4eLDLgcdUhAHfee+9KWYkl3oAtxD6Ot1NbfmJbNeis4/
   SUncPgooVy8emDorZjvR2RELRXgmzLH9+VnLfXF4X5PlvVbFxaQ37LyyW
   vqK7jd8wRMGuffvraz/hZXGG6f7wvLRRYOGFhu6EE5xzj33kWotjHjxeJ
   g==;
X-CSE-ConnectionGUID: udmEeXSQTO68iGM8EhgXig==
X-CSE-MsgGUID: 1PjNHqh2Q1G3kpwKppIA9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503622"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503622"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:30 -0700
X-CSE-ConnectionGUID: SmaQI6wxS2CfDZeOA3ESxw==
X-CSE-MsgGUID: OnPj3JbXTy6F8A61VfqaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750186"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:30 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v4 50/71] EDAC, pnd2: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:29 -0700
Message-ID: <20240424181529.42121-1-tony.luck@intel.com>
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


