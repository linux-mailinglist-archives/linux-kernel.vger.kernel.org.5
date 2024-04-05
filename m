Return-Path: <linux-kernel+bounces-133338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EB289A27A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30BFB21778
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B8171647;
	Fri,  5 Apr 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP5WL9x8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675A16F8E9;
	Fri,  5 Apr 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334388; cv=none; b=WbZrhGrvh/1r/GRm/Fo01vVSu4dpLU3wOir0tv619X+Za86lagc9Hxc9o19LxN3rjlxkF4fseL2wLQik5gRClMWWM5Hf6iHWurkPeN9VHD4gBkJg4wPDl7NQZWhsFz3bGxAkj32LO2aYYZ1eSQNES3/l390W9f0Uc73LqM569+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334388; c=relaxed/simple;
	bh=0GefKEZoElHgH0AhZRnpbZJVuc1sSIcMwfQxw3FwB48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLMBT8VFUYXhmGI5D3irJLrS8/UH6j0QwJzLdhT56we++9IUOPCgruTbmxfCSgdO6IjAjMoyQ2h9L5ppqLS0IWHvt+80AdRx0Qv13zlaVoDe5ACw9UloPJXjr/MflwFAwk9lnfX+5M8RWpBDP1h2SY5w4Xa1DmyDuc/yM6VPoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP5WL9x8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712334387; x=1743870387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0GefKEZoElHgH0AhZRnpbZJVuc1sSIcMwfQxw3FwB48=;
  b=BP5WL9x8YOkj1d6uZ82AVZ4XMbTmm6WwRkVhEre/sCGhf/Ia8sI1Lje5
   HfRWSjkSUcPJT18EwvAeViUDLaSHKr0k1NGIbmZGQeT4jwfGj3XOEQH+B
   p4SS9ruM59CxIZC26HASqSb1SvejlHrU9tGqXf3IjGngIG2EtQxGsHL7u
   AmG9FUKvHLfMejcyb+LsZB4gl2kqUH0uPG2UiC5X3g40oPAI50pqTDw3C
   4k5cpbsMKZlkVrTGyuMerhlzlV/2SiiHx5hfeyXo2IAFVba6apVjGUC6d
   +K90k0mmrddba4cYI3lPJHpynRxJCqtdamXIODAkj/wRKjaENRLOVGpTM
   g==;
X-CSE-ConnectionGUID: ga6XqdgiSfSDND4r1jzUyQ==
X-CSE-MsgGUID: RU1av1xkQ+OgTrRH/9RiwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7535513"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7535513"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088063"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="937088063"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 09:26:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CFD6C3E5; Fri,  5 Apr 2024 19:26:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	peng.fan@oss.nxp.com
Subject: [PATCH v1 1/1] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Fri,  5 Apr 2024 19:26:22 +0300
Message-ID: <20240405162622.3774231-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-crystalcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 1ee62cd58582..25db014494a4 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -92,7 +92,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096


