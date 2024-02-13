Return-Path: <linux-kernel+bounces-64416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F7A853E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3583129458C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639E63125;
	Tue, 13 Feb 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XfrCeWhB"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C26280E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861787; cv=none; b=aJx9gi5+nW5IYLVo2fs2BZmP2bgJWfwj7CHolPrj+gPOhpd6CWI54JpKxM0MHuvK4spYMkgriJfRx31s02y6PHSpgU/39RgBh1RPo9Nc/wNg5RnPF1glyfVZ7xYJPuNJQ6pKhKQKtSA2ygUoRyQvWcbE//k0UtR5Z/hf+99tTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861787; c=relaxed/simple;
	bh=0DPP6Qz0Q9rQtsigtC4nC1BLzOQOC0N9GzcWL+h1pnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzxueK+0S9drmWxak9kvFS0eHDy99yoRdvxwopyunw4UO/8n5E5HnjtTngNBSfsST63/PgBBuYRNco2eIIEwSY4n76mhRZhzW0guQuKThitGaYJqnPt3TSQGP+3j/P2pSdj3n6ldjUL022BqEKuL/xkQrIB0JuXuscNBF6acMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XfrCeWhB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=/R9rxQeU7BUXa1RMmyrPVN4ROjK67IZpHdMoXe0Wxtc=; b=XfrCeW
	hBihKHw8R7S+6MDbH8eYSnLmoJcX28MPmqGsPpBB11dz48CygGM7WS/xviFXFbZr
	l+aruclM51+T/aLFe+ZrF8DNVO07pSfHomT8xmy+hSGiz8FpQXzGEKOoMABMpIKd
	ZC76cGTFUKUotao8nHsKXn1iQ91beVFE21JSfho9guu/wULbCkJLY17YPiuY4++6
	t6Sy+AkWq2l7WON11uYUVPmOJrIGhL1aLEAsMgY3zSKN6po9EhGmpu2ukEoUoGUU
	w6vOGMs3Nb734IQG6qI5u3Swyfh5fnwuuLtjfCdPfKStl5MlhRbaUEkmhXi7tQqs
	ynLZ6fZN3HpgEcYA==
Received: (qmail 1211894 invoked from network); 13 Feb 2024 23:02:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Feb 2024 23:02:55 +0100
X-UD-Smtp-Session: l3s3148p1@lOVujkoR8N8ujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] mfd: tmio: Sanitize comments
Date: Tue, 13 Feb 2024 23:02:24 +0100
Message-ID: <20240213220221.2380-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat the comments to utilize the maximum line length and use single
line comments where appropriate. Remove superfluous comments, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 include/linux/mfd/tmio.h | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index f71d4e507dcb..1cf418643da9 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -5,23 +5,23 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
-/* tmio MMC platform flags */
+/* TMIO MMC platform flags */
+
 /*
- * Some controllers can support a 2-byte block size when the bus width
- * is configured in 4-bit mode.
+ * Some controllers can support a 2-byte block size when the bus width is
+ * configured in 4-bit mode.
  */
 #define TMIO_MMC_BLKSZ_2BYTES		BIT(1)
-/*
- * Some controllers can support SDIO IRQ signalling.
- */
+
+/* Some controllers can support SDIO IRQ signalling */
 #define TMIO_MMC_SDIO_IRQ		BIT(2)
 
 /* Some features are only available or tested on R-Car Gen2 or later */
 #define TMIO_MMC_MIN_RCAR2		BIT(3)
 
 /*
- * Some controllers require waiting for the SD bus to become
- * idle before writing to some registers.
+ * Some controllers require waiting for the SD bus to become idle before
+ * writing to some registers.
  */
 #define TMIO_MMC_HAS_IDLE_WAIT		BIT(4)
 
@@ -32,31 +32,21 @@
  */
 #define TMIO_MMC_USE_BUSY_TIMEOUT	BIT(5)
 
-/*
- * Some controllers have CMD12 automatically
- * issue/non-issue register
- */
+/* Some controllers have CMD12 automatically issue/non-issue register */
 #define TMIO_MMC_HAVE_CMD12_CTRL	BIT(7)
 
 /* Controller has some SDIO status bits which must be 1 */
 #define TMIO_MMC_SDIO_STATUS_SETBITS	BIT(8)
 
-/*
- * Some controllers have a 32-bit wide data port register
- */
+/* Some controllers have a 32-bit wide data port register */
 #define TMIO_MMC_32BIT_DATA_PORT	BIT(9)
 
-/*
- * Some controllers allows to set SDx actual clock
- */
+/* Some controllers allows to set SDx actual clock */
 #define TMIO_MMC_CLK_ACTUAL		BIT(10)
 
 /* Some controllers have a CBSY bit */
 #define TMIO_MMC_HAVE_CBSY		BIT(11)
 
-/*
- * data for the MMC controller
- */
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0


