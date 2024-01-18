Return-Path: <linux-kernel+bounces-30264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEE3831C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61D41F29086
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4425614;
	Thu, 18 Jan 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mZGaJeWL"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361422D616;
	Thu, 18 Jan 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591359; cv=none; b=jJJLWLLQVBninKNCmnGjKu6ryqmx6OrVHC/tqxhft6CoOVKd/h4xRw9MOFZtZmmtMaAoundgBRxYqzjlep4B27n6ZGIOXD0EBI92mtwbdBRB/ZtpfLINbbfftsgyneRZL0og66GKKLZBcZ5+1mhfXbkeV4K/LSk7sphncaUjNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591359; c=relaxed/simple;
	bh=i4xj6El2BfEWLwlSqlCUyWpVmsC2pN7T6k39iaUcdJI=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=Q6pAV/86G733Atm4skwfeN6obez69EqkzdnK+PMeLOO0qopiWkFrGjq7uUhROvACSXKJkxpFGlC9sJZ+YN/h0rUpkldLC3IDNvBpqrM18SJO7WWACCey8YAhwAlcqMPuMzItgwpZGD6xfllTFst92qoJ3zLPPflQRkUSyh5rL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mZGaJeWL; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=i0zXZTdF/p5LousnhgRj/bUoPKrlkQD8kZnJJ1Dwxd8=; b=mZGaJeWLvvQPLOFdUErrFOOb6n
	5mhYTRG61bu41lyk4S6i96bi5bWv+W5ZfR5/1N71CfXa7EF3YOigTW2NddECTHz9qmZTMOq/PgDJf
	vu31qi3RiSPK5CmrZGPJRDBbaI5NgRI9VJl0ONPWOEUR0fIb/umh62MUHMbc5KVrhm+A=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDx-0002lf-E1; Thu, 18 Jan 2024 10:22:34 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 18 Jan 2024 10:22:08 -0500
Message-Id: <20240118152213.2644269-13-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 12/17] serial: max310x: replace hardcoded masks with preferred GENMASK()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

GENMASK() is preferred when defining bitmasks.

Of all the masks changed, only MAX310x_REV_MASK is actually used.

No functional change.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 701bf54e4084..c93b326faf89 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -161,14 +161,14 @@
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
 
 /* Flow control trigger level register masks */
-#define MAX310X_FLOWLVL_HALT_MASK	(0x000f) /* Flow control halt level */
-#define MAX310X_FLOWLVL_RES_MASK	(0x00f0) /* Flow control resume level */
+#define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
+#define MAX310X_FLOWLVL_RES_MASK	GENMASK(7, 4) /* Flow control resume level */
 #define MAX310X_FLOWLVL_HALT(words)	((words / 8) & 0x0f)
 #define MAX310X_FLOWLVL_RES(words)	(((words / 8) & 0x0f) << 4)
 
 /* FIFO interrupt trigger level register masks */
-#define MAX310X_FIFOTRIGLVL_TX_MASK	(0x0f) /* TX FIFO trigger level */
-#define MAX310X_FIFOTRIGLVL_RX_MASK	(0xf0) /* RX FIFO trigger level */
+#define MAX310X_FIFOTRIGLVL_TX_MASK	GENMASK(3, 0) /* TX FIFO trigger level */
+#define MAX310X_FIFOTRIGLVL_RX_MASK	GENMASK(7, 4) /* RX FIFO trigger level */
 #define MAX310X_FIFOTRIGLVL_TX(words)	((words / 8) & 0x0f)
 #define MAX310X_FIFOTRIGLVL_RX(words)	(((words / 8) & 0x0f) << 4)
 
@@ -215,8 +215,8 @@
 						  */
 
 /* PLL configuration register masks */
-#define MAX310X_PLLCFG_PREDIV_MASK	(0x3f) /* PLL predivision value */
-#define MAX310X_PLLCFG_PLLFACTOR_MASK	(0xc0) /* PLL multiplication factor */
+#define MAX310X_PLLCFG_PREDIV_MASK	GENMASK(5, 0) /* PLL predivision value */
+#define MAX310X_PLLCFG_PLLFACTOR_MASK	GENMASK(7, 6) /* PLL multiplication factor */
 
 /* Baud rate generator configuration register bits */
 #define MAX310X_BRGCFG_2XMODE_BIT	(1 << 4) /* Double baud rate */
@@ -235,7 +235,7 @@
 
 /* Misc definitions */
 #define MAX310X_FIFO_SIZE		(128)
-#define MAX310x_REV_MASK		(0xf8)
+#define MAX310x_REV_MASK		GENMASK(7, 3)
 #define MAX310X_WRITE_BIT		0x80
 
 /* MAX3107 specific */
-- 
2.39.2


