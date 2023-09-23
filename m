Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205A7ABE7E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjIWHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjIWHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534EF197;
        Sat, 23 Sep 2023 00:40:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3226cc3e324so2346841f8f.3;
        Sat, 23 Sep 2023 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454845; x=1696059645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy1c6SWV4okikA6jkqxNc4OgW4Fmm23Pr1dAXWNFI9E=;
        b=jNQrPfgY4vFCE0BQd9JBqF7ha8MlHKXWHPDlEDvvhgA1JpM0szA1d1pM0SxqxxqbHF
         9BsOaE+rmzve/X2iWHOmnScJZ4GE+zeLgiAvg/4zn6tfIEOExe0pjmJXpLtGpLKquQEG
         LsJOiIi7FiltzjLjZcTxrl2SovCUZgyqZtFxwYNh2Vdx00M/ONlW0KJfJe7CFYwFiX4G
         oHx+7jVhP5QyCE3dF3Y7wabWFcVVI9AeUYibS8/ap92pgtCiqm6sFoaqcB95IO4tzgBy
         FA4mkKmP0VgxnirAPigYpQqA6ozk8KGNQ2noIJPXOvFJU5q06RTMeAacThnVgGZp9H2H
         gmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454845; x=1696059645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy1c6SWV4okikA6jkqxNc4OgW4Fmm23Pr1dAXWNFI9E=;
        b=cOwnfya6rnIAMm5XkqWzTN+LL8JMhN+rnjeQ1c8OOdPNhB4k6CbylND2VOG2nCfSJW
         tFyuaCqygVzJxjSe/bnxGaxYJgy/DBRpIkg1ptLFlQIibicYxc5T87oAGl3wDYvDETHZ
         8mAjVtj/b1h5JjAlVbMjzxwhkbbibZk777pR2C9UGF1qIIFdeZU8Il2MqoxHCKQB9cYl
         QM7ui5zHXWO7Jf938ebm7xQXH5CEaVtbF2yBWQXITGflPodOhVf282iFhPfvqzqTEasn
         LoQk50t1BoZbLjLoSpFg4p9ctJuVO6jvcayF/UGwTmlMlecqj+axIcVYNeh67qgXRP7r
         tCnQ==
X-Gm-Message-State: AOJu0YwE2AUnnFD0vItu6ao3p5t2/BJ7RTdWWkv3nIHlzH7BCEjFYuIP
        EbLdKtRgvWMLIDWjnynudzQ=
X-Google-Smtp-Source: AGHT+IEhJFhlpmFtZ5HfL7XUiO0XPA4/SeBq6zwKmBy5GniLtQFLT6qKRwSnHyyBYXejrn9uzgKwtA==
X-Received: by 2002:adf:fc0a:0:b0:317:6175:95fd with SMTP id i10-20020adffc0a000000b00317617595fdmr1563105wrr.43.1695454844484;
        Sat, 23 Sep 2023 00:40:44 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:44 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 06/14] USB: typec: Clear dead battery flag
Date:   Sat, 23 Sep 2023 03:39:51 -0400
Message-Id: <20230923073959.86660-7-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

Dead battery flag must be cleared after switching tps25750 to APP mode
so the PD controller becomes fully functional.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - No changes
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 16 ++++++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7c08669400a8..148b237d0df5 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -934,6 +934,22 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 
 	} while (ret != TPS_MODE_APP);
 
+	/*
+	 * The dead battery flag may be triggered when the controller
+	 * port is connected to a device that can source power and
+	 * attempts to power up both the controller and the board it is on.
+	 * To restore controller functionality, it is necessary to clear
+	 * this flag
+	 */
+	if (status & TPS_BOOT_STATUS_DEAD_BATTERY_FLAG) {
+		ret = tps6598x_exec_cmd(tps, "DBfg", 0, NULL, 0, NULL);
+		if (ret) {
+			dev_err(tps->dev,
+				"failed to clear dead battery %d\n", ret);
+			return ret;
+		}
+	}
+
 	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
 
 	return 0;
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index a80d0929f3ee..c000170f4547 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -200,6 +200,7 @@
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
 
 /* BOOT STATUS REG*/
+#define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
 #define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
 
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

