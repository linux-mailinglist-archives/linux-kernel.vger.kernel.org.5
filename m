Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3217EF1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbjKQLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjKQLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:32:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BFD130;
        Fri, 17 Nov 2023 03:32:00 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6cd09f51fe0so1127503a34.1;
        Fri, 17 Nov 2023 03:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220720; x=1700825520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUyhKz0IZnGv/kDPhh0zvtC7NPuBSxGKLGuzvFl9j+w=;
        b=EoQx9SN79BuiZsY+bMqP0ZL3ubaOsEDn8ZKVY/t9JHLaIFtP+azgAJlvvTariYsdWq
         eWoGh5RNhOua1/1KsDqtCKlgkRk2Aiqu/hUzkHVEcwCbWeehSM/WawwuLDD8DP3pbT7e
         Uiutxdm7oS6XSbInRFutknAS2QQYe200KH1M7N6DBnTA1BtE/obNrQo8yC3lGAeXkqQe
         wzA9s5pYyThtHgCGb9XuRJy5tay/fwMbyawngdw1jPjnoRRHjmtgFzgs64kLqA8w5VhI
         AppGPdpWxXXBn1KoCA4aY5WTAngMloVmV+cKENQEmH2zN4QN9FSUKhG0Su83g6DKRPHa
         Y0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220720; x=1700825520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUyhKz0IZnGv/kDPhh0zvtC7NPuBSxGKLGuzvFl9j+w=;
        b=o65zasPsP0Rm9cyCJIs4oGyqTrGsu7e5ijomFUe1/bY97gl1tWIhffMMGwggfhUMcI
         GwA9uqoOVRSG50gq0a7zqvcnOhTUZig1dCO3ymIo6Ptn/EgdT3obEAyej61Juxk6aG/z
         m1Ndx67ws4ihYpuvcGk1B5b+0ygnGOxqp8/hot6Z4KLKVwwktG/r++b5uA+E3owpVmlf
         3x5nyj8Tb2KQfPW8qhtlDHXVHI1RsAeSJgdddTQg1zrt7Sfo8p8cb8gUlAPfx/Fa4Qzh
         LCVtrkotBQBGPCga0pV8wnjDcrCHCPDefy5PzOaCGd4yuTQxn+DnIDyfpXJFHVj3Ve/R
         +0hg==
X-Gm-Message-State: AOJu0YxooUS+8e+NpY3J7ax8BULT4nYRQLTvd5RQ3Nna1WRAzOY1kn9J
        GRqnkShHauMUXro9YjMaxxo=
X-Google-Smtp-Source: AGHT+IFhXbu1jRa1eUH6LMz92cFYwsrkrVPSFwCJg4h8TsNz6WZ4vrh4U2+8lkf61NIA3SLU1tRZhw==
X-Received: by 2002:a9d:6283:0:b0:6b8:f588:2c79 with SMTP id x3-20020a9d6283000000b006b8f5882c79mr10994191otk.1.1700220720180;
        Fri, 17 Nov 2023 03:32:00 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:31:59 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V13 01/21] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Fri, 17 Nov 2023 19:31:29 +0800
Message-Id: <20231117113149.9069-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

