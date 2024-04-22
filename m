Return-Path: <linux-kernel+bounces-153205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B48ACAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FEDB230CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170A1474B1;
	Mon, 22 Apr 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBfyJcP4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A161474AE;
	Mon, 22 Apr 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782298; cv=none; b=rLmKfIyRSM6UN4jehHNHK0I7jjgVUyoUZrVj2Bek3xNmGQyYyRKY9Km7XDVByOkXvAYHiJpFPGY+VBP6AOA5+hXWcuWZuKtzSbGOe+W6xuTyctqvWeymZD4376H1EtL0flHNg3E/PQjCXdDBevRxKJL78Fu8vHmzmAvv2IfR04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782298; c=relaxed/simple;
	bh=urHhvNgFjlJC0RUvDI1zmMHs1AZTnco7V3JoqsJKmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lccCFOrASK+x4m0i7G1nTS0X3uFMTJXs6oZ3x1/E7uqCswNpyA5x2Ojml8qBdqLA9d7t5Jl7U8Mx/cvFrA3REIHmQas+S9Gk4MOiNh4egutRQdvfHWOMqMcsriW8dna49ogC8iHWm+YUUkzYX0crp41lRdgr5UpFmIoeOLYuYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBfyJcP4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so27671645ad.0;
        Mon, 22 Apr 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782296; x=1714387096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=FBfyJcP4VJV46QxaxKDPgjZEJdvK6MVak/ns3DtScSMLQ31Ambd0FDHjueW+kkUUbe
         Xu4yPgNfwxtvbvHhrbpWoiFMUdLHvLDrv7DSOzDUh2SAUnrEZtiEkMIkTvxrZ2dLQ9rN
         AbMow1an4EoFibwe9Km1mJ0V/UFIgxEwIRu6tZinTUi0035ddg7fXsar+7BPK4ljZgnE
         29maX+Znox+exvUtQYqY4ltnXWa9UwtThK0ahupBdaUthkYAbLwYA9BLr0+dtnYtpa3V
         xQwlnWKhLJ4WL5WlOVN8rS7tDSU4oXltqzZGYsajcRo31SF5i5++435Qt40hZSZZ3J3E
         iYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782296; x=1714387096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=isrCpvC+1/j0ahgQfQVpWyp/cCyyoQtoSRGB87J+LzbxHLtTnrHcwuYfH2Zi8iehiR
         PZugRhtPcoCWX+sCMtR7JkKcZ0/nJ9mrkLFdlOD3j0T3EeLgN6yFcv2SxyjTgLrRrAGX
         WEqopyaF7udDUhJSypP1i7DIQhyJNXAAisub43BNcA2ghgen1zc0IcSkwAVzzlZzvHGD
         ZBUYjt/ZQoHtjbkLIQ4TO8w90Lb+63MDZxBLLGooRmfcZfK6nWsnAMooU/L0KayhBVed
         qMV9jx4KZx2bAcUnmx0gpyVgxfm7CX86Sle18gV+Zt9fOGSh1NRkO5h45bkYZOTJsznK
         jrRg==
X-Forwarded-Encrypted: i=1; AJvYcCX0aSmaSJeyWPd44QPnoHicJwxcClTHgGG4AuJva1nabA5jYdqtG62mru/NTeILB6U5SIc+BJsqBeXr/lfrLnGjZC5OthSQH/RTW9KP
X-Gm-Message-State: AOJu0YzrVN+ZnhjHHTtGrOfSFvYPwxq0/JtQMxqHCSCtG+8s9DBDq6B1
	GrMS/0vh/xNZlVKUCMquo8w8icsOQWKp/eda7LTuqMWZ07J0DiE/mupB4SCA
X-Google-Smtp-Source: AGHT+IHXmv6gWxRBe0vorxzzJtgX76A2RrHGzArQX7yEGqGGjRhOhF0dPxIQSZ1kpkOIsb7ZzbaKBQ==
X-Received: by 2002:a17:902:e807:b0:1e0:c0b9:589e with SMTP id u7-20020a170902e80700b001e0c0b9589emr21129605plg.25.1713782296414;
        Mon, 22 Apr 2024 03:38:16 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:16 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V15 06/22] mmc: core: Add New function to re-factoring the code
Date: Mon, 22 Apr 2024 18:37:29 +0800
Message-Id: <20240422103745.14725-7-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add __mmc_go_idle function to re-factoring mmc_go_idle function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/mmc_ops.c | 24 ++++++++++++++++--------
 drivers/mmc/core/mmc_ops.h |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..5c8e62e8f331 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
 	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 }
 
+int __mmc_go_idle(struct mmc_host *host)
+{
+	struct mmc_command cmd = {};
+	int err;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_delay(1);
+
+	return err;
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
-	struct mmc_command cmd = {};
 
 	/*
 	 * Non-SPI hosts need to prevent chipselect going active during
@@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
 		mmc_delay(1);
 	}
 
-	cmd.opcode = MMC_GO_IDLE_STATE;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
-
-	err = mmc_wait_for_cmd(host, &cmd, 0);
-
-	mmc_delay(1);
+	err = __mmc_go_idle(host);
 
 	if (!mmc_host_is_spi(host)) {
 		mmc_set_chip_select(host, MMC_CS_DONTCARE);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 92d4194c7893..3eaefe989c80 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,7 @@ struct mmc_command;
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
+int __mmc_go_idle(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
-- 
2.25.1


