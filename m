Return-Path: <linux-kernel+bounces-164470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E59B8B7DED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9FC286AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A620FA97;
	Tue, 30 Apr 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEDd+M2t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65A1CB30E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495916; cv=none; b=fov2E+PU4TACAo5BT2D1KYY4ZXQeTWfSFt3YVXH35mrnAglW5GzX7+OGB8Xhk66yvebavYYM97O9AuhwBNiQHZkiHCIYadePqLK9burklvAYfJuSu2UFh70dv9kI7O+lxo+D+taPTwUI/Uqh1IU3sx7jUFGwd2KqKvZOeiAEXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495916; c=relaxed/simple;
	bh=KI0qEXYT6wupWkGzuL3OY5xqFep3SpstABMy3/LeX9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNQz8TM/A8bZOkTe26hKjBF7UnY/Q74S/RaRrSIiHY02JIr9TE3RLKvM0AqRz+7km7KLKtMJZQVL++wOlDO8lKuXk/JoqA43jcv3C6luy960NEB7aR3A0W2j0Vu7PrQg9BHFyJyBEvoBuXiaw+LX8iMuWeJOmudns9gSfFQNcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEDd+M2t; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495915; x=1746031915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KI0qEXYT6wupWkGzuL3OY5xqFep3SpstABMy3/LeX9E=;
  b=lEDd+M2tMq7q0IOMPEzZNe4zyicILDO2QO/UXZVs1l7X0QEEFlKJ2Bvq
   zzF3xUDVuGWxi/ZTwo1jA+TgbIMS12f7lLCr7K/c64uS/QGGEUKArRTfG
   Ygv4FG5ncrGhBbZUihtFVTsgMnlvndovOl3vqdUzyBeTTXjw+ikxmtQ9+
   VHu7nY+ClBpJHGbz6mIDQ2mgON+IUxTF8toTc5AhooaeE0vn8YubFVGC+
   QpOJ5z9n5zqGlnJpyy2qbfoz5PeLOT96YluMmMNvpWL73MC8ATOcSWUM8
   cpHaDWC6xAbeRFiO1ERWg/7PGH+AlSCyhpgz5OmOEr57iegtzZ7Dm8jDb
   g==;
X-CSE-ConnectionGUID: uHbmVXX5R6Gu9QLGCII6nw==
X-CSE-MsgGUID: 4UvdpY5/RQK9iHSX+maROQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075821"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075821"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:24 -0700
X-CSE-ConnectionGUID: vLqWvcXHQROUmtpcfjSoqw==
X-CSE-MsgGUID: A34n5mQ3RV+fPpMRYckiTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515522"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:20 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 42/47] platform/x86: ISST: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:55 -0700
Message-ID: <20240430165100.73491-42-tony.luck@intel.com>
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c..96f3b221b6c8 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -719,8 +719,8 @@ static struct miscdevice isst_if_char_driver = {
 };
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	NULL),
 	{}
 };
 
-- 
2.44.0


