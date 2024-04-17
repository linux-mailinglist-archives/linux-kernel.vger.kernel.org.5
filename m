Return-Path: <linux-kernel+bounces-148946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C102A8A897A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C7DB22EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C82171E64;
	Wed, 17 Apr 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1LPlN6Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A717164B;
	Wed, 17 Apr 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373040; cv=none; b=MjSIAfHO1QHh7gXv+mEm2/K540JI0aqq76YxTtaBc/qrVfFy1xQq0756Z4vm/RbApgXTg2TWkzGiLxr0WYqeSQyLYpryAqjRs7Vd8ddkghla08wXkNluGwZZe8cDcvr3MYv9n+9XL5rcCBPgMKXFu6Vrezr4Vt68e9o4957lp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373040; c=relaxed/simple;
	bh=bgWGwCLui9Z4FRfsi9Q01Jk+7wL6L7PwnwPlqb0UfpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzTmQlCp4URaLny7pjZeXuLWQKQ9pdB9xP3Ab0sk32wvE2C9JPrMWyCfa8uv6eO4I/gSRstDujviZFapd7S3Hc/wDhilRhpD/tBYrbHfVISu4o6yHN5qQveklMIyZ0jVtIM3o3QHlNgcHKRkkVCC1g6vl68kgQxV7WtfASuKxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1LPlN6Z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373039; x=1744909039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bgWGwCLui9Z4FRfsi9Q01Jk+7wL6L7PwnwPlqb0UfpE=;
  b=b1LPlN6ZVsbK76Vl4ZYt43G6Tf0eedAu4q9ZwvHjb04mrfLD2SMUJFM5
   Kb6uU6yATo15Yv9Hp/v0K8yx7CIDPJSVwHEwqoT9Kq6fSKyFt+ybC9id9
   PZu4q14GBjOEqFWe4mgC6ZLWzQaaHYFtrb1UIbcwRqdKi0iZ9vcmGoMLq
   lCLo1GxaQ4Xc+cdlDCGB2mpqeXEv2FBcDt21H6fl9VEQ3ifsiltT4VD74
   oJOg/N9rGbR2N3RYaFuXEY7VBgTD0/0CqiJaYWs/m6Z3gZyP2+zJ4nGhz
   6GhBlwgLsARSpsmHFBwXvVJnEujvUkZ0dhEgEQHCYsExQaOPABwVrAxvI
   g==;
X-CSE-ConnectionGUID: WFFryQz1RvuTE+L9ou+ylw==
X-CSE-MsgGUID: y0+nqwCPRhuO1fWGUF17rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737029"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737029"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:57:18 -0700
X-CSE-ConnectionGUID: rq6sC2tpRaSZZU4PxKytyQ==
X-CSE-MsgGUID: 5SSBCHV2QnKQii/ZGQR1gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22571643"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 09:57:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BB892169; Wed, 17 Apr 2024 19:57:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v1 5/5] mmc: atmel-mci: Switch to use dev_err_probe()
Date: Wed, 17 Apr 2024 19:55:17 +0300
Message-ID: <20240417165708.2965612-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
References: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 3ae17b8584a2..c4502482d967 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2548,7 +2548,7 @@ static int atmci_probe(struct platform_device *pdev)
 	}
 
 	if (!nr_slots) {
-		dev_err(dev, "init failed: no slot defined\n");
+		dev_err_probe(dev, ret, "init failed: no slot defined\n");
 		goto err_init_slot;
 	}
 
@@ -2557,8 +2557,7 @@ static int atmci_probe(struct platform_device *pdev)
 		                                  &host->buf_phys_addr,
 						  GFP_KERNEL);
 		if (!host->buffer) {
-			ret = -ENOMEM;
-			dev_err(dev, "buffer allocation failed\n");
+			ret = dev_err_probe(dev, -ENOMEM, "buffer allocation failed\n");
 			goto err_dma_alloc;
 		}
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


