Return-Path: <linux-kernel+bounces-58930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A553B84EEBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427DE1F27134
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AC17BD0;
	Fri,  9 Feb 2024 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="XG1bmh/z"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FACA78
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443940; cv=none; b=As4PHayCtSVRp+SmN4+r1YQfYNvt0UV7TrpWS6XOvuD8+tX/nP52ehE3+XbLw7F/Xs+5fTxkLw0Nwvhi+bGWYx3tD9IHuP3nbFlD20cvPYeIEkZtllI/rSz9xunyxDOnN+nB3SpGp80pWNwYhf7Tt3sl76Hlx0IFMzJhCIp7+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443940; c=relaxed/simple;
	bh=UxX6J0lf2fRxDy/VkE8jOTXGeQ82iNLc+jLezLzr2Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+cqXdaOpKMEO++MCiXrNocJSxyESDXdJ29p4XhtAJsAIRPenLy7nXou4jo6d1e5tXe8HI2yR6SmQORkz5CFnal/bYxQzj7qrgDTzHI7Zis1BA3fGaqghxV0J284LpkP/Vp8sQc5xm8pYEHhXEjoliMusO93j7T4uM6/C3IF26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=XG1bmh/z; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=4/BUBmbZ/LSwVFmUWyfewKl+qpPxom7Xk9eOiW4h+3Y=; b=XG1bmh
	/zImcO1EwLJ4iaT/pb3K5soRNHnb+FUcMMq8vmLLL2FJ3O7f7LXj9gyqldqJMlxP
	6PRNllvlS5s5hObf5cZ0KIxuSasHvFmDbc2UoA668EYzVtvdwp4ggX/VVuucVvLD
	5XirYoicHnlyKcqedOs72No3yynX7nZtq3WfkC3b60pyCx9z57RvoUjfvTYVLdDU
	QKnwgAwUfTR1aV8Zg7H2Tun4FunauTviJJpylbGvIiXAhnHviPmchLqJre9e4+uV
	5FTyHw63KILLNK8maOEoRFnsaZvHW1BMo+J2rnrXdf8UlS6sXKSn0ecJNVTRSit7
	uQkjYh4LtN9BA4GQ==
Received: (qmail 2792426 invoked from network); 9 Feb 2024 02:58:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 02:58:48 +0100
X-UD-Smtp-Session: l3s3148p1@loDSROkQpLMujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mfd: tmio: sanitize comments
Date: Fri,  9 Feb 2024 02:58:20 +0100
Message-ID: <20240209015817.14627-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
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


