Return-Path: <linux-kernel+bounces-157514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2668B1242
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789C91C2112C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A8200116;
	Wed, 24 Apr 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8LnyUJO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6021C8FDA;
	Wed, 24 Apr 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982545; cv=none; b=D9gjaUtyv3uC+tmOwAEdAz0nL8ptVUgOW+8UPsYbJu28Qerq8/8/eOUoGe9kEo0q1bjJO7n/AKmQHtb0UERQ5ILfaRpcZFsXb2WbCO4QRFcMz/kzSq27vZhQ4j2RXatNiBYtZ9MRR8RqOy1AD12oUjOCXDtJgJKqBk7WHQZf00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982545; c=relaxed/simple;
	bh=lGxY6/fpKVjagJiMiQslsjgDFgL5ZPdXodSr7eR0UbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDs/54858fiaRr6HDQTXT+vFaQFK8oHF8zv+JPTJWOegqXpRAaBs8o+FHhiT4q4VmiOab+MWdhmRDMQIsh/1JT11DbHDe/a99POKrX8U1GkiLzijgmyF+G0arwY7IxGdiwrmzwQDJAj2u+TTdNnj1Ju2xqjDXetQTYRroe7ccfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8LnyUJO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982543; x=1745518543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGxY6/fpKVjagJiMiQslsjgDFgL5ZPdXodSr7eR0UbE=;
  b=e8LnyUJOEhhs7Iuow34O40EgnBvNbvdePbMtPl2b7qOCsFP7LCFOOche
   52VVr7GqQEPZB3WouC61jKZHVTEpY601buw4Pg5QNXvioE7WMKQe7N7Q5
   reVcuaPU2pRpGeXtfFl5z04fq9gDYFfu6k9j11RtVM4jPqxSCEUvrKKxc
   UICiqLzcZ1h5QlI3Us6k8p3THvIyXomL1vgFOUSl+r3/Is8p+8bjpLl2l
   Y7kjAz39jT6+mdj8m0SgsqAV+qd7W/c0KNmonhb3vHJ5Iq4jkUErnYukl
   F25MkB7THKxO8T6KatdRhS3ExZpOcgnECOL5VlNLt0674JGzrJq1oRN4t
   A==;
X-CSE-ConnectionGUID: 3mLzCEvTQ8qlYhHK/vf4KQ==
X-CSE-MsgGUID: 7KlF1o++ToG+3blqcDznpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9503708"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9503708"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:42 -0700
X-CSE-ConnectionGUID: Cad7/xTSRxy05dj+edwlJg==
X-CSE-MsgGUID: MPlg/ATjQAixgaR1TFMaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55750330"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:42 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 63/71] platform/x86: intel: telemetry: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:41 -0700
Message-ID: <20240424181541.42368-1-tony.luck@intel.com>
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


