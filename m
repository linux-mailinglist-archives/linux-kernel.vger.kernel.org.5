Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D717A1AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjIOJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjIOJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776072718;
        Fri, 15 Sep 2023 02:44:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-577fb90bbebso1303034a12.1;
        Fri, 15 Sep 2023 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771046; x=1695375846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=ltD7CjS1kOSzv1ZOhEspopb4H18jqRlAoBTv49xmlYorR9usWhMA+mzMfBK7smM0r4
         0l5Jilqa2hlytdHgqTX8yt94DnIaz1/fhZberge379pwCDOGmmk9a1WqJNurkMEgOqq5
         qZjIKdMrmr3L+E6ohA5zB2Trr5bLke8lcj/ka7DVtZZCGccxi9BMeKzC7O0qjJagu45w
         Vb8J183Bswlw3C16ZW1TdwfD7E51vRoUDiAvGv9oQFonIqB4Rsn5teC0PuAYZE1CoT8M
         wL1ItNa30i4eShYR7W+4VxRoCZKbG+pVm0eHdJ73qoVr21CVzL19AsbYPLsi2cqg+kh/
         e3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771046; x=1695375846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KWK94KLa+RXOTyZSYZJIvaS/n+OcRc5XJNe1k7WdNQ=;
        b=GHxhSw+mWskbvEkPbQ3M0ADZXhUeDrBiQCnAJbD2zASCLDpEmkeysG5QqmzYMzkMrU
         NUhu13y2Jg8DP1fkH4BZUf2nAsg6ZeylE0ImNlsaaQT7+ZFRZ2+/qUS05yibvD/BIE2Y
         bhYVjBqmSFP/nGOVgIJ9PTi928U2yz0S34G9EbYvdulnO4AKuZv5S5mmCaeCBbCqrum7
         N046Q//NbBogot2gO/KrieosdTF7WPIgYLwwQjbtc8Bpy1Quou323z3vCdHxISipWPe+
         Mu183G/Ho2bndg0ntWbst+0nbtZQ630j97bGRZ9Ug5s8JlSncHkVx68CoIGznMP5XLQl
         ZdYw==
X-Gm-Message-State: AOJu0YxiW5iTz0YlJgXdQqQZGAMRcxG8HySLqdDz01+snpq5JAUEiLF8
        MpDxM3CuU760+lZcIwWmrEA=
X-Google-Smtp-Source: AGHT+IE7XW96sqCsp75PcAWX51QFT3jvbVi6Ju38m7sHzss/OIetAnKnDuzqyrRCvkqbaubccNln8g==
X-Received: by 2002:a05:6a20:5b1a:b0:155:2359:21a2 with SMTP id kl26-20020a056a205b1a00b00155235921a2mr988158pzb.41.1694771045906;
        Fri, 15 Sep 2023 02:44:05 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:05 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>
Subject: [PATCH V12 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri, 15 Sep 2023 17:43:31 +0800
Message-Id: <20230915094351.11120-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915094351.11120-1-victorshihgli@gmail.com>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
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

