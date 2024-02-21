Return-Path: <linux-kernel+bounces-74893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4285DFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931242861ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE345CA1;
	Wed, 21 Feb 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="fFq/tAUQ"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659017BDC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525839; cv=none; b=UR0afKv34pBX0rBFm2i8C1s0ka9s7ZgAN5BWcUQJg3TpwPbv/UAsdkd/JIhWs+/F7UG4ITeuRDS06qyMLr1yM5Ogz3W/CGIqVBhK7rB9Lq60TbpYPEWTeXl4s8tedo6EJtONFrNnRKNb8AQEuM9iPA0drDPckyrlL0LuSo/bATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525839; c=relaxed/simple;
	bh=GrxON3lYNCAufVUexAxR/Gp6ZPDPCKxndYGM/vP6fyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqEkjWLy2oTcpBBUl8tj1TdyQGym6C8X/SDTjtUtQQ1kVrWduZndYx+G/Lck0uO0MrJaF0DoDd4MIbIednZ9CGSUiVS5J2VLLrdw2O0Fy9RDobVjJ8t7oUIvLlu+bTzowPOl6YiOSsC4Y+LAoCOFSV8IOHq0nxm7IGiaBvYUYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=fFq/tAUQ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240221143030b49f6abf3d31adae55
        for <linux-kernel@vger.kernel.org>;
        Wed, 21 Feb 2024 15:30:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WD5sp0uEiG8G/0YYO+dG4YqOi0XkzyajJD2J/jfY3c4=;
 b=fFq/tAUQ+oYgNPMLW2f5fBEmJQ1PKMaHRI170KiT2rYs4goB+kFWJ+riOlAje8ruXayh9K
 /D+hYJNERjToUeWrmY1wC546mOzW+gh8IJmk5bSMkhKgCTA7p58mlFUuQ6+v0wtnsBQlyLDl
 actetFqLMOa2tMZjDS8nbRzvrFm0I=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	stable@vger.kernel.org
Subject: [PATCH] mfd: twl: select MFD_CORE
Date: Wed, 21 Feb 2024 15:30:18 +0100
Message-ID: <20240221143021.3542736-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Fix link error:
ld.bfd: drivers/mfd/twl-core.o: in function `twl_probe':
git/drivers/mfd/twl-core.c:846: undefined reference to `devm_mfd_add_devices'

Cc: <stable@vger.kernel.org>
Fixes: 63416320419e ("mfd: twl-core: Add a clock subdevice for the TWL6032")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 90ce58fd629e5..1195a27c881e4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1772,6 +1772,7 @@ config TWL4030_CORE
 	bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
 	depends on I2C=y
 	select IRQ_DOMAIN
+	select MFD_CORE
 	select REGMAP_I2C
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
-- 
2.43.0


