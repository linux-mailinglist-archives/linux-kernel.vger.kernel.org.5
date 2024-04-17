Return-Path: <linux-kernel+bounces-148349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374F8A8144
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42821C227FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651413C686;
	Wed, 17 Apr 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zq95OrO7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A413AA47;
	Wed, 17 Apr 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350855; cv=none; b=o6KVCqC5V266f46Y0D9+P1sKFbhwR3HOb/ycbvtPe13cuP+vd0CiRML84ontxBs+gm6wuNewZWkbatGaOUifiFHHwEe5k+5kOf+iIGlAut+KF3/gdPEiPzcfqUSyG5tTi3Gr318AR7oM5G37HjyEIGJyr+qr0lpNHN8QwzcpnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350855; c=relaxed/simple;
	bh=z15lbw3E+MVh2E9Btp8J5lNMZuF6JooxbLbwXO8HnKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tny6iEaiHVljNcUn2WVv8EEyYoqSJcwAiHOSdsOZ/bNFmguelGDg2JtJKsWMFvOxYV2rNnmmU3Y9qvywLIaRjPt+x8/7xwuLskooPYBjjWMuXJk5jxeXmHJihRKLfM7lGWYQ1b3dHgYzvCcmv7KtgsS5Ph7kEQQT27OLsId+yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zq95OrO7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713350855; x=1744886855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z15lbw3E+MVh2E9Btp8J5lNMZuF6JooxbLbwXO8HnKw=;
  b=Zq95OrO7FK1Hs6a75Mbn5pZUpJLmGwgAU0bvl1XiYnmgtYY9et76M2x7
   6b5rTCnHDEWYRD/u3dNQDz5uj/Xnnfsvv88MWfNNEBULHDQqe0MeQ8rgu
   ePIHp/zWo9onKJbhKJdWXuW10LZTQ+4Bsm/jV9P/mOz8CBLEEH/adOs/d
   1WNx7jzF4QoOiyCK9UCu78GqaIG1V/vBv3tYEXpqZ+RDf55f/Jf7w2FmJ
   TsYWuRDXHkzvYh66S6lh3NMX8DnpwB6QtkVfGXqja0ZJlJrA9LAWxMyjn
   TngDVuD70ezQ2KZw+88F7436USes58yTXuryyMjBq4yd4xKzbg8LGyM9X
   w==;
X-CSE-ConnectionGUID: KWIxECnJQ+qFZ8Tn3wFmwQ==
X-CSE-MsgGUID: 23rsJ8vDTVOCEuqaVhaLNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11777157"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="11777157"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:47:34 -0700
X-CSE-ConnectionGUID: pUescb3cRMCFXivxEZAC9Q==
X-CSE-MsgGUID: FzK+3X84Swuuq6G/CDyoTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22465156"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 03:47:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1850F491; Wed, 17 Apr 2024 13:47:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yang Yingliang <yangyingliang@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH, resend v1 1/1] spi: oc-tiny: Remove unused of_gpio.h
Date: Wed, 17 Apr 2024 13:47:30 +0300
Message-ID: <20240417104730.2510856-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-oc-tiny.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 6ea38f5e7d64..7d8c5cd680d1 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -184,8 +184,6 @@ static irqreturn_t tiny_spi_irq(int irq, void *dev)
 }
 
 #ifdef CONFIG_OF
-#include <linux/of_gpio.h>
-
 static int tiny_spi_of_probe(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
-- 
2.43.0.rc1.1336.g36b5255a03ac


