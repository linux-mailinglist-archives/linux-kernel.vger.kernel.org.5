Return-Path: <linux-kernel+bounces-119670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312888CBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341591F8595A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16E13C3CE;
	Tue, 26 Mar 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL2PW6QK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441821272DE;
	Tue, 26 Mar 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476776; cv=none; b=S3ikp+V8/rdhgZcfu07deSWuoiRlLnQp33KiNjEhEA0SRQc9T4p7mTO7Flw9zN8qTurcHLA3jR/U7dGZT5snbaeWPAXnuNg7V8Oztk9XoW+PidVMecCKd16mT/ahOuVZWzCQ+7t5Bkh1WOS8xOWg7j09UXbgrqx/pSU6ooZlmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476776; c=relaxed/simple;
	bh=SR4b9sG42Ntm39HGvhuiOO4rN1X46bP3jVFzFyKMirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2wGt5CXBquK6aq8HqB/JcxrgiKjnmIRaz4YwH03FgEHkTT2mZGCpA2QG8aYmgKMXbMycvgdIIpYNEOKVctRzg2VwHLtSaeSLyLvDjR/Uimp4sWhilj4VEuPIHTLgv0urEM81AO+vfQOLM0uW5wVFBGbpRNPD8uGQ5HW9uHwWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL2PW6QK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476775; x=1743012775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SR4b9sG42Ntm39HGvhuiOO4rN1X46bP3jVFzFyKMirA=;
  b=gL2PW6QKSDNyzb+iH6/THA0sEbJ0+nmZBJP6/0w4cZ7aC7gvzMFz6Fpn
   Dewheqic8FP/vnlRe/SZE2PGlJtetFVAV8SsSmSOnK94tbpTetYSQbRox
   MOE7plFnr26UEwKtunZjI8hcTeZYY43wEIMUl3lLkpEXPdSzBo7mR6hbc
   w9iOdBjz8LU+gQwg3LQca6ptE3d4Pi0JmxfKDTiYJnAnuvBOwu+T+CvNo
   Kn8FM5BG7r4ZAIo5Rjs02UBJ75Yf9fLimiJzgo0AhVzJFwZ4eiWTnwTjb
   r9SThoSv95KPLVh9mQBfUVEqfo4l8O7BSlbQhP9vf8kZTEtMG/W6FfKdO
   Q==;
X-CSE-ConnectionGUID: H49TG4z3Q2+SCp1kjW9bFg==
X-CSE-MsgGUID: CyUAKkQeTJWitOivnTyqdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325994"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325994"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072947"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072947"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:12:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A33A42CA; Tue, 26 Mar 2024 20:12:51 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpiolib: Do not mention legacy GPIOF_* in the code
Date: Tue, 26 Mar 2024 20:11:20 +0200
Message-ID: <20240326181247.1419138-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
References: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to remove legacy API from kernel, don't mention
it in the code that does not use it already for a while.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5589e085ba25..f749ece2d3cd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -364,7 +364,10 @@ int gpiod_get_direction(struct gpio_desc *desc)
 	if (ret < 0)
 		return ret;
 
-	/* GPIOF_DIR_IN or other positive, otherwise GPIOF_DIR_OUT */
+	/*
+	 * GPIO_LINE_DIRECTION_IN or other positive,
+	 * otherwise GPIO_LINE_DIRECTION_OUT.
+	 */
 	if (ret > 0)
 		ret = 1;
 
-- 
2.43.0.rc1.1.gbec44491f096


