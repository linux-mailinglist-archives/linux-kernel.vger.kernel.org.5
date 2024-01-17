Return-Path: <linux-kernel+bounces-29501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F5830F61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B100A1F21F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4E32C87D;
	Wed, 17 Jan 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="K//4QQHC"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C228E2B;
	Wed, 17 Jan 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531162; cv=none; b=uz7fi44Gpuev4vLzrh0+ZMR35Y93tp43SlGBbm/hEJO0ilYTgH7f+36UPYOXIJcfRNj3t7brcDPE0+J27ory7ZdA8EHgvoT5zHTbuY2Tt1yi3TNIe2kOEejDeQHQLbs88t+vR3HG+02aHk8UNEeTyWMC9R2eMKcbA6OXRzQENCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531162; c=relaxed/simple;
	bh=ckncuOpRDKxo+TA4+doB+7yZe9n3LBknz2dpJ+dm1Zk=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=rUiuQcj8nuWBYBzXhN3XzFDxkfRh+aO58lqA5/KwDyy5nGTSoQL/TsicdgZM+4cxbQa6lAZbr6jq24pw0CRIfGEJOpBPPTOhDs6z5hXT4L3nY25KkgwRrTgREoquIN2+xUlxzPS3TueIM7pmaPChzM7eZ4HE0KZNwEzPED2Z4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=K//4QQHC; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Bdu3ac8KRxJMDVqkymkch5p5g9KhiXHXkxBCucSVolU=; b=K//4QQHCVtFZtApuuzSVQCDTpd
	Ai2uum+15moop3o8oz1yTrXFwrW4T9zHF9v6yT3ddsaVAdUlQRsXJY31Y0DmwMRBlF4dpQhanV5Fo
	3tePZLVRLoeakcWeG3e8s5ZcGqwVWojTYcRTO/fF/XsPgQz56DkTRXJeZY2mM2RayocY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52924 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQEZ3-000155-9a; Wed, 17 Jan 2024 17:39:18 -0500
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
Date: Wed, 17 Jan 2024 17:38:50 -0500
Message-Id: <20240117223856.2303475-13-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
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
Subject: [PATCH 12/18] serial: max310x: replace hardcoded masks with preferred GENMASK()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

GENMASK() is preferred when defining bitmasks.

Of all the masks changed, only MAX310x_REV_MASK is actually used.

No functional change.

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


