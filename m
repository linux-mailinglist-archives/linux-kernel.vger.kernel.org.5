Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA27EF1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbjKQLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbjKQLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:32:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F0A6;
        Fri, 17 Nov 2023 03:32:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1422392b3a.1;
        Fri, 17 Nov 2023 03:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220726; x=1700825526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=LK6uE59tdfxtWfxQmHWwKp15ADL9TsjXVEEGyWpd52ikUNiknzv07KrS302JpppYrP
         BT471MDgiu3P2fEcXzUeM4eHoiBJ0r3hmsITBIdV+RXKxVs96fPNOKRBX2OM8H11Wdno
         AnPfKSu4gG9ErG+45xFOMWhrz7aAjbDtpKZv71/Dq9pi1K2xXqko/HDcYzrxqxCu/5Z5
         IiEWkc899CfXh8bJkBO8K73bVIjwYFXa1DxMvNv/HLlPg36rMRaY/zLpFAurQTYYNOSe
         /9+PjGereW01vqhXz1G+QQimGrAkNHu0IMdG4DJHgRzqCg+nowQOUbEnzGWQA0EDBcdP
         29uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220726; x=1700825526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=RJ8svrldcOLFGp+9bXnWnWpermpiXUGzYy20xjirjyI/Kp/tHbCs7bDJ0lwIgi5ugl
         6N8aLJjnNTROHz9mleYvz3cMl6qBPj5bI+5g+RN4iMlF06fgipGkVO8XCTl5MwHfrMUY
         gIxV5vDUiGF1u7DIl85WPwhXIGKKPZWKeSt/kgoKKlr2F8c8H9KnfAcYmxflhvIGlODV
         N7/EmXzRaq+ihBkctCuRsOXH7elxofjd4xiT7yBDrk7GsOlLVRII2CrQPzOM6CnfFSsZ
         qAHIRo/qknpDxh2vreztVCW8Ed2qiNgksYzoA05PKWZNPNYsv3cY7rlhg3d2n3N25cxU
         32MQ==
X-Gm-Message-State: AOJu0YxJ4zkfL/GxLsH4MxrRrLQeOA3Qd2II/3gNIsiOVQM3rg9Mvvm0
        YMdCmiEQmmzBTPz9SkOCayU=
X-Google-Smtp-Source: AGHT+IFx4/lqsr2bjqZd6HEhk//QVJlXqLJnDHPnM5yktXeUVtYRmFOpqp/9oLtjg6kYz6hn0EGyJw==
X-Received: by 2002:a05:6a20:8e08:b0:187:a884:ec45 with SMTP id y8-20020a056a208e0800b00187a884ec45mr6940188pzj.21.1700220726243;
        Fri, 17 Nov 2023 03:32:06 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:32:06 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V13 03/21] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri, 17 Nov 2023 19:31:31 +0800
Message-Id: <20231117113149.9069-4-victorshihgli@gmail.com>
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

