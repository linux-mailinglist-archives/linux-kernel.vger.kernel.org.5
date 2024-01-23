Return-Path: <linux-kernel+bounces-34776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B4C83875F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856B21F2481B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9B54F9E;
	Tue, 23 Jan 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFJzf+3K"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066215479F;
	Tue, 23 Jan 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991338; cv=none; b=WS9teLWvQGCkYkmVkySimeG+Z8St1jLwq+xuMfRLAwmVcTkHy4lUldSJXGlIOmZ9G499QhW02LcUftZ7HLdg0UNoVdfJKDBrmyW2fRII1tRUb6VEWFBZalrWVbKW/OTKD1l/uo28Br/Z3SZdxjArQsUgqxJNzy92j0UW8RNrIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991338; c=relaxed/simple;
	bh=urHhvNgFjlJC0RUvDI1zmMHs1AZTnco7V3JoqsJKmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nobMISxN07FID7ef1UF7k3wInvgg8PwTXAx4koFD53uCuSvAzwv+AmqZ/wNjTRPM7ei4mcKfOjfYMAyHBPFp4G6UVTVwWbZ4/o2XJZ1p8bG18uuTpHSXKHoZuUXWeazwTm8FHQGe4txTrlGy27esd9+KTXpD3r24ozGHRKkHfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFJzf+3K; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e0e08c70f7so1765781a34.2;
        Mon, 22 Jan 2024 22:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991336; x=1706596136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=mFJzf+3KnEAv/+g/MAc60hlKdZumJJsyBtSWx8HK/0PkJR9EVDymGZ68trXRSfX56g
         RwA//hWMlttaaZ9xkA4tJRF1iCx8MUejz+jMGB/nhWHLIpmxcaaM0SY4gIFJBUsXj3Dg
         QwSK/JmiqsUmT/jgNXhLRAgc1jaWGEIonAnphGHDcl0TrfepDWk/rLSHSP2jXPHbJNmX
         pB0ZY0xqpy/CLvWTuGjsCNEmPecDa79fXY+HQVtqS3vOkyYSL/RZjlSRNeoZos3wUvS5
         gZ+KpJdNtuUIYIy5qMDrfS68v+HSGQkVxfvE0dyUP19JKGoVYcSn1EjkvBzj8DVs6N32
         zqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991336; x=1706596136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=MwvM9CH09vLdMQJB/20jvFDRXbHHrzzExO8jRm2RgKLrcESqkoMhzkeefsoDm7PLbR
         psATLJjP4Iq9od9+hNeB1YtewMaimXeWiUclWkZK/UF4rMigdiLisVap8YzZkLWvi0Eq
         EasqxQX+chKJuZ2//itgVF05plWciMQtwdYGcp3XvykhsOFtZNXMa9UTq3xvVvgFMLNe
         QQpAx9j9cC1BqyxazqqxwIqu2ki6G8MV9T/9c22yIUpdut2hTiVoJQRO1erRKE6JsKWF
         AwJ1Wx18meUBVMcgWQ/9Tkt3R12P2TXgLzxQPV83iyfOy8GGrsY8slfjHKQEaqSIpBln
         R3yQ==
X-Gm-Message-State: AOJu0YzHW6AiATwRT0evh7a7MDsYxKVFfYtfXej1SrMORG08MPeKC29T
	RbIzvU8yu3GyK5ebJGOpCHWvpnxTDCQYMfrnJ1TJVMjQ/sjDSQJQ
X-Google-Smtp-Source: AGHT+IGYVQvxgZhufIcsLG5iNmWtFCC7IxLJuT0FVJuLwUAJgu3V8YMsmY4uuFbwAHw/Jc6gmJgSNA==
X-Received: by 2002:a05:6358:880d:b0:176:277d:347d with SMTP id hv13-20020a056358880d00b00176277d347dmr2664486rwb.17.1705991335932;
        Mon, 22 Jan 2024 22:28:55 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:28:55 -0800 (PST)
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
Subject: [PATCH V14 06/21] mmc: core: Add New function to re-factoring the code
Date: Tue, 23 Jan 2024 14:28:12 +0800
Message-Id: <20240123062827.8525-7-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
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


