Return-Path: <linux-kernel+bounces-158603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C908B22D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F2B1F218F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26314A0A0;
	Thu, 25 Apr 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Po6YliNx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292E14A09A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051846; cv=none; b=NRTLanvOcEJVF6rjo9jWczFAsDVPco6xc4Q7eIjSa2U+ubodPoR9FLnTZRzmecxPHFB5MMP/YnBxdKrEWG34DTKwkClJ2j8qo3XplnbKHBN5IaH8roH9GOfDAe7qzvfgUUYh7+D3lwtVf9mswSb8aWwdU0/NGCZ3KAczInTaDkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051846; c=relaxed/simple;
	bh=EoWMxLo5INoQqLvX5iNLGZoSAD+nAVTybp3fuwGirrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e2HZTAaucSGtSgtExOTylLnshTmEmDfsW9WKlGa6ZPEEz+i1wzQd3HAvZbEwHrTb3IJ9mYITlaH4W+I9v59t826g9fBye9ZgFSyFhoByTXCF+YHKe2IVxOfHU3ONIOlky0kfjIH9vMGo8Ldo5TJfWR3a3NssSBX64VBg4VRWOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Po6YliNx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d264d0e4so1889370e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714051843; x=1714656643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+tdO/UIC3b/X5P2tckJN1J8odXZjxVoO/7WKXxrhTE=;
        b=Po6YliNx4sOHGUOCS5UlWCtEjYK7iEp2uGm45NmS9TZ7L23SRADPiNRPheFQnlv+OS
         mPHO8WJiSXa3R0WdOYf11PiNkAKCiEAp5lKIyjt/kqdk0tenTrFn/HweRP/v7gMzA9ls
         Lo20Awy3AXJfRrqJc9w6tNcrSV72eFKEgMn4+9DkWZs2Iicm/AQgZtmtGkA29mjvTThP
         q7RyetBUGuFLsAPptVfuCovySlC2a3zGkkAmXjjqx1Zt16rFEWxBW8R9rWNxmxnidPwH
         JbM3MMdG414dthEZPUApiNkJTkp4XdOadC7oJfTFyQT8ZbqeysGRoD4dLKtVe587sK1b
         HmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714051843; x=1714656643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+tdO/UIC3b/X5P2tckJN1J8odXZjxVoO/7WKXxrhTE=;
        b=vwZn7cv4mGPI9zrpJYlLZRefhDWxpYaIVdYm/+fn4CanByoMP03EmgObKcLxO61X03
         w5/um27u1enhwkOkTuARAmDMtjFBtDlBBcXFlSi5n4dwdh/R4r2etDMpApR64nS3DNsI
         ebATrWNEpOsGOGgNBVeYH39OjASTv375kMWtZ+2eRXtL+9JuhrT/aUDG3jk8FRrWjAbe
         f8kgdvDla4GoACne3ZxT84lPPjfLRpfWPkZB/r7FNCmMEFN8YFn6gk6mQ4Y/RC3JjKfJ
         yl4oXqWxJ8xGWsscr3nld1tnnDu+g/hQ4v8iIYOVG85r/LnlyZeaj5HABtJjltf/Igd+
         DAcw==
X-Forwarded-Encrypted: i=1; AJvYcCVZUDuIElhH8RQ2C6fn10zK7PFkEpl5ycXHKYNKe+rCxld22pOrCPaLf+bajVuYH/fgXwxy7V/OzSU2VaUp5+In5GVw3bfPHFQfroRQ
X-Gm-Message-State: AOJu0YzNZzKjsJKuPt6tY9M+tJ1BdOFCcaSiqSD3fH7P1CVE3IalY7A0
	DIuekgswB0ygpKwhQT7CsTxpJZAY3JJMD0xZUHJiYZQpe4cxOT+auH7N2b3O0W4=
X-Google-Smtp-Source: AGHT+IEW0aa8yBIv50goI4Mi10vAgRT8hVO2OmLTeiao6aGSd1rPtqW6Jiouo17uZuM1PLgR6UjHbQ==
X-Received: by 2002:a05:6512:60f:b0:51b:ae4c:f20a with SMTP id b15-20020a056512060f00b0051bae4cf20amr1002286lfe.28.1714051842896;
        Thu, 25 Apr 2024 06:30:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id g2-20020a19e042000000b0051884ea2a32sm2856052lfj.31.2024.04.25.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:30:42 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Felix Qin <xiaokeqinhealth@126.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Convert to use __mmc_poll_for_busy() SD_APP_OP_COND too
Date: Thu, 25 Apr 2024 15:30:34 +0200
Message-Id: <20240425133034.79599-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to what has already been changed for eMMC and the MMC_SEND_OP_COND
(CMD1), let's convert the SD_APP_OP_COND (ACMD41) for SD cards to use the
common __mmc_poll_for_busy() too.

This change means the initial delay period, that starts as 10ms will now
increase for every loop when being busy. The total accepted timeout for
being busy is 1s, which is according to the SD spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd_ops.c | 77 +++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index a59cd592f06e..3ce1ff336826 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -19,6 +19,15 @@
 #include "sd_ops.h"
 #include "mmc_ops.h"
 
+#define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
+#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
+
+struct sd_app_op_cond_busy_data {
+	struct mmc_host *host;
+	u32 ocr;
+	struct mmc_command *cmd;
+};
+
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
@@ -115,10 +124,44 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
 	return mmc_wait_for_app_cmd(card->host, card, &cmd);
 }
 
+static int sd_app_op_cond_cb(void *cb_data, bool *busy)
+{
+	struct sd_app_op_cond_busy_data *data = cb_data;
+	struct mmc_host *host = data->host;
+	struct mmc_command *cmd = data->cmd;
+	u32 ocr = data->ocr;
+	int err;
+	*busy = false;
+
+	err = mmc_wait_for_app_cmd(host, NULL, cmd);
+	if (err)
+		return err;
+
+	/* If we're just probing, do a single pass. */
+	if (ocr == 0)
+		return 0;
+
+	/* Wait until reset completes. */
+	if (mmc_host_is_spi(host)) {
+		if (!(cmd->resp[0] & R1_SPI_IDLE))
+			return 0;
+	} else if (cmd->resp[0] & MMC_CARD_BUSY) {
+		return 0;
+	}
+
+	*busy = true;
+	return 0;
+}
+
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {};
-	int i, err = 0;
+	struct sd_app_op_cond_busy_data cb_data = {
+		.host = host,
+		.ocr = ocr,
+		.cmd = &cmd
+	};
+	int err;
 
 	cmd.opcode = SD_APP_OP_COND;
 	if (mmc_host_is_spi(host))
@@ -127,36 +170,16 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 		cmd.arg = ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	for (i = 100; i; i--) {
-		err = mmc_wait_for_app_cmd(host, NULL, &cmd);
-		if (err)
-			break;
-
-		/* if we're just probing, do a single pass */
-		if (ocr == 0)
-			break;
-
-		/* otherwise wait until reset completes */
-		if (mmc_host_is_spi(host)) {
-			if (!(cmd.resp[0] & R1_SPI_IDLE))
-				break;
-		} else {
-			if (cmd.resp[0] & MMC_CARD_BUSY)
-				break;
-		}
-
-		err = -ETIMEDOUT;
-
-		mmc_delay(10);
-	}
-
-	if (!i)
-		pr_err("%s: card never left busy state\n", mmc_hostname(host));
+	err = __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
+				  SD_APP_OP_COND_TIMEOUT_MS, &sd_app_op_cond_cb,
+				  &cb_data);
+	if (err)
+		return err;
 
 	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
 
-	return err;
+	return 0;
 }
 
 static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
-- 
2.34.1


