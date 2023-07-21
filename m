Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5C75C445
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjGUKPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGUKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:14:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDAD2D45;
        Fri, 21 Jul 2023 03:14:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6687096c6ddso1203063b3a.0;
        Fri, 21 Jul 2023 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934459; x=1690539259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ8DcJM/gQcNcmge5eNzfgTQuzYieEw8t1k7Fnf/hL0=;
        b=eIXIAWI/0V2HFJmAXjWQNxaYVBql75dBqdASBbo7yBuPkDSb2dw8+v7VqflmFFvzx7
         j4qvvwVH0/Ql1HpTK2Fq8tr2KHpLDc8GU/qWua4FFtkJzNExFJHqIjhhqL006lhJbEkn
         gFcEvjrPmbvflP9AOnUMCQ5Jkm8Jz8ep3RsuBy5IKN9z8Ncgwlkz+ptDPNDfe1iJt/7F
         N2QHfRi7mqeInFCL28CIrkD5hqjF+ec1YUVX48o1sFxC2rK+iisaPDoIFlJM5Tru/Hvx
         uQElFvKGFNz1pTT/v0RUPEpVu0cJzd8uOGbqQ+nvABgTMArL6eJ9UWpGBE6NORPfEbL2
         xyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934459; x=1690539259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ8DcJM/gQcNcmge5eNzfgTQuzYieEw8t1k7Fnf/hL0=;
        b=KxgqvjOpTZG40W1rapmbOxlNt3WdTqM2KFBDDOKN3OQNodXVcmcIkuj1FcIqPLztFx
         P+9zW7NE2yDOmAQnEW9lpqXZ74JZv8C+G4nSlTv5gXNO0t5ULfGQ1lPDlfHaSRhJGb05
         UvJBdmDm5oYZdAVVVxUYlE+cxfOdATpl8dLLsnDuc5X2MZ6SufI7u+ywDnkXLT9crx4m
         ASbKQ4g5fUEGZKp8hOMAkmvPocfM6JyO5HAzSaui03MmSZj27wlvllFHiZ+CZXeuhL0k
         iK4T5fjrREPCaBQV2t/0bRP6JrrzMwW5xEzV+pOfe0lZ3WoG3GMuz5l+61NjEKlSNSCm
         O4WQ==
X-Gm-Message-State: ABy/qLaw6eq0Emvr+p0/QRLrTEA1x6b4rncrRhFIf1DI7sZyT92ddIs8
        +kgQmzx9qRgvf6MUnVQjzrk=
X-Google-Smtp-Source: APBJJlFZ0QJRKR90tXm8Cu50fFXM9OVaKgzUpdIV4sM7c0LcZzuSVjwjI3k7G8EBNcopkBKb4dJ9CA==
X-Received: by 2002:a05:6a20:96d3:b0:133:b0d5:b3fc with SMTP id hq19-20020a056a2096d300b00133b0d5b3fcmr1130751pzc.7.1689934459212;
        Fri, 21 Jul 2023 03:14:19 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:14:18 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V9 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri, 21 Jul 2023 18:13:29 +0800
Message-Id: <20230721101349.12387-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721101349.12387-1-victorshihgli@gmail.com>
References: <20230721101349.12387-1-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Update in previous version:
To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

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
index cf32cf135781..d9a3b3d38d8b 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
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

