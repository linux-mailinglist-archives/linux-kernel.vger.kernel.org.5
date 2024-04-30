Return-Path: <linux-kernel+bounces-163603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50DD8B6D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61091289E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39DC1BED80;
	Tue, 30 Apr 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHKtOcAJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB471A0AFB;
	Tue, 30 Apr 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467197; cv=none; b=LsiGITkhm7DVR6jYun05O92YXbOyvMTvPumaa7J67XrH8byMvRZE5rip0kwnSbPqgv37PaRMxzAWMtHMN9mWA8diTm8rgZQwtSA3MsyUbVdFcdkd8t+SlhlI2sIMAJCJMj5XqA6jHgDTVMPm9fOMmnT3cRFUnvmwrk4aFba2Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467197; c=relaxed/simple;
	bh=nsT1fHcZuDOMnnkyajwqgfQmhXr/KNG+7QbC/xy9bQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8KKGI9QerX6lKOEs39+3bOzBrTLp3YqZMw/tFTXtnD01drDw/fjGSiFNnUXvEKKJzNyG0EXeacspz86+J7PGB/6P//WE059n/lGwU6JZRC3pYFeFyKIygg9al2UtYa57rGjFM10q1bsYaVAJMf6joSIzYXzc7D6IBI4XH2y/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHKtOcAJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467196; x=1746003196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsT1fHcZuDOMnnkyajwqgfQmhXr/KNG+7QbC/xy9bQU=;
  b=CHKtOcAJoKdZqT6QoavSd5sbeRtqV5c/PQr43q+RF2HpkVbrjlSkVYl6
   vCcP6N6mkA1CV6pRFvQK7nhaq6FGiC6S/TU5rdJE60hztDHbAnL/lHMbc
   jQakTEN7mvDmjdbnf+Nu3jAAllh9Qev7ZiJadfhF/HIHLiE7xFVushoc8
   hAvjSHeNbXvibeE1dGI6ZYxXkTF0RuUDeI6ITj9hxjNMU7ROnLXnG4TXR
   CEbndW/M606dPD2FBjBOEjyu6TFjMSscD33IvnCw+WHBSlFW01itSS1hs
   AqEgCzvWXAx1E8cOPfp09HYQP38j8UDN+lPA6yeIxNnz6cL/S1VbCo6I9
   Q==;
X-CSE-ConnectionGUID: l9NDQIt8S/OHgC6tMSt/Tg==
X-CSE-MsgGUID: EqKPRA5BQ02XFYN7RJNSXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311419"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311419"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:53:15 -0700
X-CSE-ConnectionGUID: zhTc8/nxT/yRhvzIncDbKQ==
X-CSE-MsgGUID: hhZxfrHWRTu7Tk7BdZaqSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891595"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:53:08 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v7 06/12] ALSA: hda: remove convert_art_to_tsc()
Date: Tue, 30 Apr 2024 14:22:19 +0530
Message-Id: <20240430085225.18086-7-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

The core code provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

All what is required is to store the ART clocksoure ID and the cycles
value in the provided system_counterval structure.

Replace the direct conversion via convert_art_to_tsc() by filling in the
required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 sound/pci/hda/hda_controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 206306a0eb82..6f648fae7a7b 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -463,7 +463,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


