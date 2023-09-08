Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89179850C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjIHJxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbjIHJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:53:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11A1BCD;
        Fri,  8 Sep 2023 02:53:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565334377d0so1560933a12.2;
        Fri, 08 Sep 2023 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694166826; x=1694771626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=IOjXN/65vl/jTfjTl7kzwwYPJogMRO8XJ/M14vN9KSF+9GYecnK8FxdICWi2usAEwF
         uY8wqOP/VvrDya3T1LCsv9MT2clhxAHhWxU1euFR9qTRLbOV3dUhNaZ8LRrcA5z7pOY6
         IaTjcUEpd0o7Qt8LbHEgVGatSiBli+gr5IUtr12sNhDTkqvBrOUTVSx7QeRR2zjh28bH
         67yEfIG3oCCY3rUHKXv+Y/27f/SF+GgDEiQ6ZJ3wXnCMUXHk5fVyazh0kmd9Z2+yTWtW
         662cY8u/tpXe3zjQ53FNSovUx86vNs3NfbWWi2PPriuzU93I17BMxtT+eYYSW9h2KYHR
         6zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694166826; x=1694771626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=BYQAkgBwMJ2LlHqEDKt/QNSblFCZV53ECWftFdeVTfsljSUTOJQqF9GqypAxaCgZG4
         ds1miU6LEpevx7+AVCW5EzZ/dkzfHvJmsdaFyYMgwDnb4f54DY4Vx2XI+HTHxpDE+VAw
         gUnl+jbGMyiIiL74fXlXquJh2r0+9JfuFu5aO9sL1klGi24stauvOBuVdfqU982/HYZN
         X8AFqI3wLtikMVMAgsmJMy0J3SGOuz04jJer7qPA9Ok7g8lYVpxUinXaCMjvcFYBtxC5
         86eOFS3mgQtirguaGfv4bNYjzoouhy5IC3XWMomdPszZWWTSc+wojOHv/JsvEGWv47sp
         M5sg==
X-Gm-Message-State: AOJu0YyHnrnF6eQSjTVfnjlyzy+eeDEVOXguF7WA5fi00t7U4g6Ua3Xk
        tzJux1yf1OgJGmHClQPtQ31YeOXjV4g=
X-Google-Smtp-Source: AGHT+IFjQoYJLO1SA3+SCAYVDhgbkldx6i/jM1eYYWJRO0Xl2lTc4pmywQg3jMY9nnXxg3p7IrCbyg==
X-Received: by 2002:a05:6a21:194:b0:13e:7d3:61d1 with SMTP id le20-20020a056a21019400b0013e07d361d1mr2666187pzb.12.1694166826018;
        Fri, 08 Sep 2023 02:53:46 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a1-00a4-a20b-46bc-ccec-3e79.emome-ip6.hinet.net. [2001:b400:e3a1:a4:a20b:46bc:ccec:3e79])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b892aac5c9sm1172178plg.298.2023.09.08.02.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 02:53:45 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V11 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri,  8 Sep 2023 17:53:10 +0800
Message-Id: <20230908095330.12075-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908095330.12075-1-victorshihgli@gmail.com>
References: <20230908095330.12075-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Updates in V10:
 - Modify the commit message.

Updates in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

---

 drivers/mmc/core/bus.c  | 4 +++-
 drivers/mmc/core/host.h | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

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
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..9f6e5e31dfea 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,12 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
 #endif
 
-- 
2.25.1

