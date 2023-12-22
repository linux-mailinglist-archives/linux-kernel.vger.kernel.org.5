Return-Path: <linux-kernel+bounces-9763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B081CB14
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4231F227F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576022134B;
	Fri, 22 Dec 2023 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5IL5M0X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926A1CF8C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703253625; x=1734789625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DY9PyNMSTAj2535e7EGKERcNdQvQPVKOOme7KuU+fIk=;
  b=c5IL5M0Xsu1LwiVULPqx+ujlCNIiBB+d0LBWQ9W32SGYIigScJ7EHCI+
   Z40GFbQ7qWzMl9z24AJl3elvE3c6+sOxuePyTVcPWT76mGqMExOj5Z5tc
   lIc017WmxlxXCzPitqePiC8EqRE8MJ7u8D0QZsVN3ONQBxhr5cXbnnf8C
   Bxr/2knM6U5s7RWw4XvrfSCnWbnil/4j7V+Jkr4GR0FuYwbzgyOwh1lCO
   95J/GF1FFPaS8lYCeERJuOw7/5CCVvTqVy6P0m3jcZ2vDp0at7k7gg3U+
   F/O6DKfEPV0RJYsWKP5/mISHSMm2ZnYNpD8vW98MXC3oDCyg1zHvM2Dy0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="482295950"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="482295950"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="777047591"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="777047591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2023 06:00:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5C1E1345; Fri, 22 Dec 2023 16:00:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: Step down as a reviewer
Date: Fri, 22 Dec 2023 16:00:17 +0200
Message-ID: <20231222140017.2887224-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Too many things are going on, and reviewing GPIO related code
seems not the best I can do, hence step down as a reviewer of
the GPIO subsystem.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1af56dc3113..8b686a9fa068 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9110,7 +9110,6 @@ K:	(devm_)?gpio_regmap_(un)?register
 GPIO SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
-R:	Andy Shevchenko <andy@kernel.org>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
-- 
2.43.0.rc1.1.gbec44491f096


