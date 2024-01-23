Return-Path: <linux-kernel+bounces-34771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36D838755
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74408B23F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DF51024;
	Tue, 23 Jan 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIp6Vl48"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87415025F;
	Tue, 23 Jan 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991321; cv=none; b=S3vkPG/aC/ruuhL4wNQFmspEiBJSk4aHmvm4iedSnqEPrCyn/VZqa6VqjH6EckbSvE7nARgXIwo0dxnPcuVuplGrK+nGkqHw6qLT45qQgkSTeuyK92igdmIwXOL/bvP5iO2z3gHp6aWoeesdpTyKWg/bmG1MNzhjtsorfj+8KAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991321; c=relaxed/simple;
	bh=oAVEsYXyN3V6RMWtSWmjVUs5rIWuwcPr+DP8utHxQ8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCkEqSBg+antU3KkWqaYWqI9T8+Af10wVhdluuIH5Aiu/Rjq9i563arvUmGG5j31JqwfFbzq1Jiix6OKtXH7MdVBpQuDZAJTFH4qMUFDirgkzZmut/JjMoinq1kKwZNriLV5qUy/aCULl5ioIk1e9LLRTuc39ZmUG3bb7CsrNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIp6Vl48; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbb003be79so3460757b3a.0;
        Mon, 22 Jan 2024 22:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991319; x=1706596119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUyhKz0IZnGv/kDPhh0zvtC7NPuBSxGKLGuzvFl9j+w=;
        b=XIp6Vl486cJlKnas8ln+RLpioXlAI3Kas/ztDi8b9Cw1suj60NExcPCctN0xb1RzOq
         LjrHtyx43n/QPbYvl25UsITXOPcmObNrp9EnuPjHfyNPBgWtTzc3ViuPp+TDGRRU70iX
         IGDYbYbuv45Gb8qesuiSf5dmI6Lkria1NqcYVkBbqeY4UCuN+3hKSObQsim/T9p1gmLI
         sRGpxwstm8V+6A6Ts3mpmWtLB1iD0q4jDkLSpoL9ciTiyPJ5wpWvwkRk1iKbzuRtIOsn
         4kgkUJHaqMkrKv3s7B4jsuT0AoRJMUH42OGGiwDca2hmG8rjgpXejOHh1LxmderhUoNI
         /0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991319; x=1706596119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUyhKz0IZnGv/kDPhh0zvtC7NPuBSxGKLGuzvFl9j+w=;
        b=mwznOTuLDqzvq98V1kmc673lXE8ko/g0+C001GVXoiL44BVeHuMQZF1YhPwc2rW+Fz
         jo/cSQ5BY+etLrC2BxxkhFTHz1DAz9qfd0yftpJNz1DJjEtxW+I0X4CFZgsw28HZV9zc
         DGlXjgpH3c0vBdhzAjPf+rgdcSoSWEREHcPpzUov7JmC7w+HWvxFj+xQAPIuAeb9nBB2
         arqYamd0oUQYlA9TO0ILxKkpq1O3z6Dd+uKRy3DU7r5dbQvbT4KV4PYIxXmWFfpr2Kaz
         qtaAkoZQhSB4GiMPu+jEmbySVii74QAcOvYtha0jMmUqxmA+rammpwYOZBYpcOwFRfP8
         tbzw==
X-Gm-Message-State: AOJu0YxI3sOsXtJk3jE6NV/fDRNElj9btv409iNl2Shad6Kvu8T5fsss
	MFz+g4yeerTLk3YZsq/uQ+vlxGKSWFmm+wsy3ONKbt/rHMzOp34o
X-Google-Smtp-Source: AGHT+IGSk5jafq3qeOAXHV7vCwUIS8gUwaMXQCTWJhAv18k9cQrM/TikCnKNO3s2am2p/flNF180Yg==
X-Received: by 2002:a05:6a21:6801:b0:19b:7d67:5b35 with SMTP id wr1-20020a056a21680100b0019b7d675b35mr5999507pzb.36.1705991318908;
        Mon, 22 Jan 2024 22:28:38 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:28:38 -0800 (PST)
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
Subject: [PATCH V14 01/21] mmc: core: Cleanup printing of speed mode at card insertion
Date: Tue, 23 Jan 2024 14:28:07 +0800
Message-Id: <20240123062827.8525-2-victorshihgli@gmail.com>
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

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0af96548e7da..bd761e2858f1 100644
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


