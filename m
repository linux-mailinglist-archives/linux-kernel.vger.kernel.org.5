Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291FA780984
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359654AbjHRKEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347047AbjHRKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:03:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6673E3C27;
        Fri, 18 Aug 2023 03:03:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68934672e7bso607219b3a.2;
        Fri, 18 Aug 2023 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352955; x=1692957755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUyhKz0IZnGv/kDPhh0zvtC7NPuBSxGKLGuzvFl9j+w=;
        b=IelzaaJE7vJ6RnO/2gpusnircgVPLUAwDk2H9pxAhvtX6vHNPC5q3K2nWKfSL5MSsD
         cNzK/j5PnHKlHGIZU9PNDFnGYkncrH7A2sRNk058oAeqw1rA98quRhfCYzniwNmsx79C
         6TrIWF5+BTFgr0YVE8mU22+GmU4t4Z5eq+5Te3oYuWkL5ipyYVWmU8HvbpaUU0zEtcUB
         W/Am4w3Stt3dAaLjEmWcjGl/eK6YK2I1P4Izjy7eE7qRfMPKvDohxLIBZ3fS0bEs3+CT
         EP5Kp8wIhFYpF+hR3wQ0qyJhE8ug0X3xEiZ+NyePdPVeaPRZ4YwrsDsgUMQguheMdE4q
         4DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352955; x=1692957755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUyhKz0IZnGv/kDPhh0zvtC7NPuBSxGKLGuzvFl9j+w=;
        b=SG98E6BZN2AGlVhbIjkt+DEFnoSqAz83iFCNc+A/bL1zjIQx9qJnS0GtK3AFS049Wl
         GVUAvE+MrFBoDbEblgX9Ny5ycmLA2gyMAbHs75oOWJPuDXOcfi0CNmvti4J4XkdEfhkU
         C1NTLk27dhx94cm1P35pRWp04HowC07n1jH249jQoJsRGWzmhGgeOI9CSUC1b5tZlA8N
         WTWidaB46SroTnrZxbf212v6pY+WL50O0igXQ7NhQbMmxUCY6ud6hQW1V+sTyzewiYhv
         Poso0VPH9lLGm9TKLMjAz0tyLVxshTJQmBfJ1p4MPhrhlV5m3SL7aeQXO35emmeyIGAQ
         uT2A==
X-Gm-Message-State: AOJu0Yz2sE4UE+zZtvZAXO4cKTXtQfAAuoYwKJUNsug8Ld+ibZVEby9+
        TjRD24o9le9hpYIvLHdHFaF3atb4nRc=
X-Google-Smtp-Source: AGHT+IG+29LqSuT7gZtvIz84+UBITJIy6qUxDKcml+Z4roygZN3OEXwqjMqpDeDKQxsDLCycILDgVg==
X-Received: by 2002:a05:6a00:1a54:b0:687:4fcf:8fcd with SMTP id h20-20020a056a001a5400b006874fcf8fcdmr2108965pfv.18.1692352953449;
        Fri, 18 Aug 2023 03:02:33 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:02:32 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V10 01/23] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Fri, 18 Aug 2023 18:01:55 +0800
Message-Id: <20230818100217.12725-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

