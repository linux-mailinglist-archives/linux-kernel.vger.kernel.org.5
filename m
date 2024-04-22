Return-Path: <linux-kernel+bounces-153199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8D8ACAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D081F21170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408F145B20;
	Mon, 22 Apr 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVTbHHKQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D81448C7;
	Mon, 22 Apr 2024 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782280; cv=none; b=q4wQwjWLEC8+5V/t7rxSmbqTnpoThPKrmsiG4ecCFyVIGCJVdCFTtoBjF6EGAV2VWE6XhqpPN3qnbBIOvgS0w9X/xMqznZiNicz20ti6CHe9piRVt6yw+lLmBT71EAqcxksN7JR7pGfSmnhxdxjKmxZWIyzoOYUQAyc/bSjNE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782280; c=relaxed/simple;
	bh=IQAZUlNPZoWpHJGkIKUhv6elpxjgoL6OEDDw8Puqvbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXDqTXXGemSKO3MhzSKDO8kB5ruXYqu3A87d8u/mRlemeQjVBaDgx2p1in0zsSPpmdOqVNlF9s/uDL90c9FqKer6v+5zG0OnYQt3o+6hLQF6+mrQVYj9sZ32HXyX4rM/iSeY50CSRisbvsZF6eMDlz5WARP1Tkp+YHQV0HO0moU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVTbHHKQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e834159f40so29746165ad.2;
        Mon, 22 Apr 2024 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782279; x=1714387079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=iVTbHHKQQb+U9a1pwDlDzUqe4XkBOV+Ps5DyTUdk4fKni11uPKhHHntXxXBdG9zlqi
         U42Kif4m1U0lSjQx2J4ziBOUjmj9ueM8Z8Yoc5nKTykSb7SCx9jLWhVbxAxD4Rf7c08a
         n8wPDkYTz2+OdMDIb9eN1JI5x6HMnTldZp3fBHbWsh74wRq73dz34cjTMf+UcYHODLpz
         bBgPUzE478WsINnjvrJj3YH0JD6vKs828GTa5XH05ELxjPlpkT21qLlF/HXTmDM9V+8h
         2aRYUF/TErnyjUR7D9nsBnx8syvdhtAzsO6iDq02iWLxLZKF9DTSbZe56P91hoIsEGC2
         nqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782279; x=1714387079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21XTRS6Hwv0Mc2USbIbApfyvP84+Xjin/dyUCVlMQQw=;
        b=ZGvM5lCwFiOEZ3De8YJ8F58OTiR63SEBV1XHcGt26oaGtH/E4zObqvFj4fdTY1Oq8y
         sUV1jJH9TvSYfTlzh2oRoW2awQr0cjF0NntQMAUJpFngAuGgn4wP4yIeXoM1dPfVTWmm
         7VA3JhvRrFTzPcTNOmI4QBuaE/utlY6fRtkq1fX4To4RDRO6UKAtFryp5CkAJq9Aqu/s
         hYAqcDrLBbuLXEpbvRM8EmMQbHWzOUjJ9qD3TSCRbXIl+35xnlF8gAy2TD8Apd15XRQz
         KX2uRBgg6OlcVWmbtWQjLMDB2MmSLeGzJKVag8JvQDIdoa6NC3Y9OU7B45cOx+QrYrBS
         8bwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW85RGN3y0Y3wmdkChwz3dQzZZXCSLx8s+4mViiEE24+LwmIxH2zbhKXUVnn8aPKqQ96GTsuiFYeAnMQ1BttmE2DTNq7UQZRNeM9YfB
X-Gm-Message-State: AOJu0YyRQEFH2euSsCgh+SaH7rFjyaZ+EXT9WsLn2ZupY5gzKq7g1JFP
	+5AHM1f2hQXmNMvHaEztDN2MrzqYe4RZWT5UlV4qx0Ul59ELhVaN
X-Google-Smtp-Source: AGHT+IFCb01rpKWk5CM+KGSyxt98rT9W1zOm7N1z8STWRzc9/2GrdoJu4wSjnrcOuhOZfAo1EYnjKA==
X-Received: by 2002:a17:903:230c:b0:1e2:6b5d:5b18 with SMTP id d12-20020a170903230c00b001e26b5d5b18mr10394883plh.51.1713782278672;
        Mon, 22 Apr 2024 03:37:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:37:58 -0700 (PDT)
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
	Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V15 01/22] mmc: core: Cleanup printing of speed mode at card insertion
Date: Mon, 22 Apr 2024 18:37:24 +0800
Message-Id: <20240422103745.14725-2-victorshihgli@gmail.com>
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

From: Ulf Hansson <ulf.hansson@linaro.org>

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0ddaee0eae54..6731b46e855f 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -340,27 +341,30 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_card_hs(card))
+		speed_mode = "high speed ";
+	else if (mmc_card_uhs(card))
+		speed_mode = "ultra high speed ";
+	else if	(mmc_card_ddr52(card))
+		speed_mode = "high speed DDR ";
+	else if (mmc_card_hs200(card))
+		speed_mode = "HS200 ";
+	else if (mmc_card_hs400es(card))
+		speed_mode = "HS400 Enhanced strobe ";
+	else if (mmc_card_hs400(card))
+		speed_mode = "HS400 ";
+
 	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
-	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
-			mmc_hostname(card->host),
-			mmc_card_hs(card) ? "high speed " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
-	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
-			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
-			mmc_card_hs400(card) ? "HS400 " :
-			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
+	if (mmc_host_is_spi(card->host))
+		pr_info("%s: new %s%s card on SPI\n",
+			mmc_hostname(card->host), speed_mode, type);
+	else
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
-	}
 
 	mmc_add_card_debugfs(card);
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
-- 
2.25.1


