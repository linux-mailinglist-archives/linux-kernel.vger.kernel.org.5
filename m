Return-Path: <linux-kernel+bounces-155798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022F58AF744
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F91F227A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F8141991;
	Tue, 23 Apr 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHlBiw4v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4413D884;
	Tue, 23 Apr 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900338; cv=none; b=ndz1iI5ApTp6ESAH48tE1x3SywoE8ktqebduPgQoOBHUvz7KRYfGE1/8NDCmT/bhWPOsGf8f2oKCHhGYOx10FZzIkzDjkln2mKjJYleZLG7+8cpXMLORdzmR0W5dNYLdqXJWPvdiH8XnrdDjSbVcPZXAvme1cPw8rt/Jta4CSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900338; c=relaxed/simple;
	bh=GFgvUWu7beexxqgqYJWuWc2RAm6vGMhqSdFbjSi68w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNNi7Ta6Xs67MwvTqRbzC+n6zvKcHQBWlNq28vSCoyDE0JRBu0sT2mqCv46WWALt48M3Sb6sqp8cMV+87hY6+t/v7TeMcCV/Lw8U6E5jyscVBfNuh45YLhePUIUcxUpNMmJya6jGv9gKTIT9wH/DRu7rvpmOwVf47iE6tIZkOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHlBiw4v; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713900337; x=1745436337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GFgvUWu7beexxqgqYJWuWc2RAm6vGMhqSdFbjSi68w0=;
  b=DHlBiw4vf02vsEvsF8I6FhcM/pEEct8JHd7/v9x+apFGQSW2saWXXKy+
   dteeswAkUcjMGsQ9U5oaJWvnjxX/f0SrWO688+BCeNFgyy8Kn2nvGd+c/
   sBiRS2nuSTL8RSL6idNzVeF7pp6tAd5MAa+NsrYxy+ICFMZjZSluxAAK+
   BBHWplhngeC0MBA2VhZtCPrQTxZi5TJN1hHomcULobzCQ8z5WMH8gRgqQ
   GdmobycfEx9bXupAQeCUR18sRHIcjg34kjq2ahrzJyC3cU+LgAty2yvUd
   GGoFlsv+l7xpKfCmVUzSJ384hmAwtZB/lVhCaZSx0v7XZ3QKVB3woFATL
   Q==;
X-CSE-ConnectionGUID: mkWbkA5gSyO/eT0jNF5QBQ==
X-CSE-MsgGUID: VT8eihNSSXaDIn6FazOguQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9669104"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9669104"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:25:36 -0700
X-CSE-ConnectionGUID: LIxgFSoYQRiMXQah94XU/Q==
X-CSE-MsgGUID: uRkgrTKnQBm24ipxZkoGzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61923095"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 23 Apr 2024 12:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BB7F9142; Tue, 23 Apr 2024 22:25:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Sean Young <sean@mess.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/3] media: rc: Add missing io.h
Date: Tue, 23 Apr 2024 22:23:08 +0300
Message-ID: <20240423192529.3249134-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
References: <20240423192529.3249134-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many remote control drivers the io.h is implied by others.
This is not good as it prevents from cleanups done in other headers.
Add missing include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/rc/mtk-cir.c   | 1 +
 drivers/media/rc/serial_ir.c | 1 +
 drivers/media/rc/st_rc.c     | 1 +
 drivers/media/rc/sunxi-cir.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index 4e294e59d3cb..b2f82b2d1c8d 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 96ae0294ac10..fc5fd3927177 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/serial_reg.h>
 #include <linux/types.h>
diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
index 28477aa95563..988b09191c4c 100644
--- a/drivers/media/rc/st_rc.c
+++ b/drivers/media/rc/st_rc.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index bf58c965ead8..b49df8355e6b 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


