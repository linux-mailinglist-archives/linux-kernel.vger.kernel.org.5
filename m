Return-Path: <linux-kernel+bounces-34773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA4838759
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5FAB21359
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068252F8F;
	Tue, 23 Jan 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhnT7vNb"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C0524D3;
	Tue, 23 Jan 2024 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991328; cv=none; b=KoD92KFs0pLXVqnfJNb/pssEPuS+OpWlmoQYByLED6mXuFW3tEAMT3o4yRRVdfYqK1NiYmFYOFtOnY9+oAAFkkc1Zpwcy58kZk7G0YRXNSkYQALuMk1Q9SGyqm8y/V2SSxa37D7/49ounUM8emaUkHQ5lljx/P4kCbEjBWVg6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991328; c=relaxed/simple;
	bh=2L1FBjomAIYyHNuSbprNvVKUa/51AhWHZeEFiiPbv8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6KXJyaTGBI5Gzt0PLDUWpG56x5cAzD2iXkew6Y26FjopXGO98/B2fUpehSC6ZqH3YhkZyXcEk24SEsKxNWif0GKEU08ggu5afMOAUGkJTiSave8SyeOjzIFf/hOdtBwW0v7f1dDL8SCCnVlh6yyBQeHmvY57a/OwuoKSP46GSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhnT7vNb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6daf694b439so2629320b3a.1;
        Mon, 22 Jan 2024 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991326; x=1706596126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaxhiiEQNRXI1JPMokIcCaOTdk2DezKQIAmQf5gbVHw=;
        b=KhnT7vNbyOHaUlnY4WbD+NAjL4Wu2PikHcxsLtx2NFOKNsvfvNXyvQaPgN2zdKNdoX
         zSFD8DwMSN7qCCPU1H1jbMw88CfUS2j19XEGcR6GEWL6SUvnVbTtNo5Nn15J59xOoa/f
         OXrP1pzApe0snpizHdQ3GU0Awz0K7aG4Cp+ObsqT0wa5oZVxcZYCpg1iuZQknJkri4vM
         AwAmR4lz1YCmEkAO3niWAkqa8dU+315HAs8YflplVM3dC4Js84WRnrvZP4J7lccCoxfJ
         GBtW9eilt06kfIi6P0SKRYJYRiHZLOPFFuwsOJm4jVB9Ot/YCUpKeMzwTK28ZuofXGXB
         kMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991326; x=1706596126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaxhiiEQNRXI1JPMokIcCaOTdk2DezKQIAmQf5gbVHw=;
        b=tXFTOh0Rh08qXkYKgcMSf044jMRccUFQo/0pRbbAFLa9cusfXhLARwSt2aMR0uQ4yi
         qPS+zUPB6sKist5oVDiffq4au9a4h3VOwxaJcFZKeLv6nDimJs1tM9CM6TO3ec/lj9Ei
         e5Cyvru5+AAZ7rf8kqSlzQoR4p12mjymDJgV+JTvLFLn526M0eqlW0Hjfdo559pn/ajM
         WPT936jyba6FShPb1RXIPRgO8H/LvihbAZ32K3sZv0N5Xqh3CpR5C6l8aWhJ55KxErwt
         T/OaSl0hIBj+B69yDwF7mf+13zHv3+OIYyz5o7TugGcQ/n9v2AMNPzPBmUACVY5qHFXm
         M28g==
X-Gm-Message-State: AOJu0YztfVM8P3+EFWQf64D+7bwrGcmEdCJO3yUuu45LlQ9SexVlSMB1
	FXQatyeLOQ6wWIrcOG7sk/PBlNxz5BnrWfIWJjKtDzsxIJKdbuAK
X-Google-Smtp-Source: AGHT+IEKW2HNXF6ZuP6Lbxj2KRllCSfOCRgUcOxw0h8fJmw3sThlEuUqPksadmKi1vCcEdBSxMwwFA==
X-Received: by 2002:a05:6a00:460e:b0:6db:786a:fcce with SMTP id ko14-20020a056a00460e00b006db786afccemr3435539pfb.44.1705991325567;
        Mon, 22 Jan 2024 22:28:45 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:28:45 -0800 (PST)
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
Subject: [PATCH V14 03/21] mmc: core: Announce successful insertion of an SD UHS-II card
Date: Tue, 23 Jan 2024 14:28:09 +0800
Message-Id: <20240123062827.8525-4-victorshihgli@gmail.com>
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

From: Ulf Hansson <ulf.hansson@linaro.org>

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Updates in V14:
 - Move mmc_card_uhs2() to include/linux/mmc/host.h, so that
   mmc_card_uhs2() can be available for host drivers.

Updates in V10:
 - Modify the commit message.

Updates in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

---

 drivers/mmc/core/bus.c   | 4 +++-
 include/linux/mmc/host.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index bd761e2858f1..e1760fc66d1e 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -344,7 +344,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9d7c6b575303..7e017d6177d5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -661,6 +661,14 @@ static inline int mmc_card_uhs(struct mmc_card *card)
 		card->host->ios.timing <= MMC_TIMING_UHS_DDR50;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
+
 void mmc_retune_timer_stop(struct mmc_host *host);
 
 static inline void mmc_retune_needed(struct mmc_host *host)
-- 
2.25.1


