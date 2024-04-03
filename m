Return-Path: <linux-kernel+bounces-129042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA38963A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6969FB24791
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1945976;
	Wed,  3 Apr 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2hi31bG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591B1E880;
	Wed,  3 Apr 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119971; cv=none; b=kA/pb6qCUHKTviBiVP072vwzkntLJ6aMr7uVcdf9qdwHp1217AErV1CcEZnbMcuorZaFdkL7XUMp6oDq0o7gmBS9AZ1n+8CHJcAQoapgcVWv3mklmvFgd4OZNs7q+CX9SGAOV5CxJsneO/EumOErhVewibylYqLKSE8bYGI6Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119971; c=relaxed/simple;
	bh=3rsE3q6dytT9So/UVsWaVTkje+2sES8TOIqAYIknR6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7qxOkG1rA7KfPyGvcJ7iMc/zaVeDvhplhmSrMflh10h+QTgBFFhu2el7CBQgJP50WdUEh/knEyRjkq/fDP+bhvorcJy0p6TXA2eqSMZBUveC0/0/HoVT2RHTcFl7UKinvOu/83tMwjiVhavgj38ozm520oHi7VEXIvK9Jf+aQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2hi31bG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712119970; x=1743655970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3rsE3q6dytT9So/UVsWaVTkje+2sES8TOIqAYIknR6U=;
  b=a2hi31bGfDKt8z1rGcZQc1Wph0YMazrsWSNw6NWzI9imrJieu+LJ2pKE
   UJ1rfpF7kWRndqCjob7FSKwnhpCasXGf6ozJQreB1F0dURogtgTJEOdk5
   RNtmCqA/3dkxB3+yzL7vNeh1jdbA8V/r3Aw5pRhsTq4ARaCMOAhSTtFPx
   JhH0cXvXac+Roj9mSRW+Gmt/qWVqHj2aHOcvHup6zzL7sBN2r2/XobuX5
   pPaJqvWMNV2l2xAoheXKZyeXbBDZWN1PmALmOM3mMBZOY0drOmBOHeT40
   ed9Yt3Bs1GhkKgmtngYOg8NgHTCOOwwhdOLAcRTbtHK5A3bP7T8JoRAqm
   A==;
X-CSE-ConnectionGUID: QwUcc8FQR5Cg80zIVSRD1A==
X-CSE-MsgGUID: /jA2HieqQYCAzK7uH4V2Rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24786548"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24786548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 21:52:49 -0700
X-CSE-ConnectionGUID: ez+kKMdbQsWV7JEQsN8MXw==
X-CSE-MsgGUID: KM0nSPTaQhyLnesGbsN+tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18352670"
Received: from wentongw-optiplex-8070.sh.intel.com ([10.239.154.12])
  by fmviesa006.fm.intel.com with ESMTP; 02 Apr 2024 21:52:47 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	hao.yao@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Revert "mei: vsc: Call wake_up() in the threaded IRQ handler"
Date: Wed,  3 Apr 2024 13:13:40 +0800
Message-Id: <20240403051341.3534650-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

This reverts commit 058a38acba15fd8e7b262ec6e17c4204cb15f984.

It's not necessary to avoid a spinlock, a sleeping lock on PREEMPT_RT, in
an interrupt handler as the interrupt handler itself would be called in a
process context if PREEMPT_RT is enabled. So revert the patch.

Cc: stable@vger.kernel.org # for 6.8
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/vsc-tp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index ecfb70cd057c..968a92a7425d 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -419,6 +419,8 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
 
 	atomic_inc(&tp->assert_cnt);
 
+	wake_up(&tp->xfer_wait);
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -426,8 +428,6 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
 {
 	struct vsc_tp *tp = data;
 
-	wake_up(&tp->xfer_wait);
-
 	if (tp->event_notify)
 		tp->event_notify(tp->event_notify_context);
 
-- 
2.34.1


