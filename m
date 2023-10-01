Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B367B4607
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjJAIPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjJAIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145CFE;
        Sun,  1 Oct 2023 01:15:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso2073155666b.1;
        Sun, 01 Oct 2023 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148128; x=1696752928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ObRy5c8YFdrnW2Ux3zmbr7cSFwdsAqt7EeK0em6AeQ=;
        b=BFAqTOp7EC8UDxEhRwQiBk/VQy5h07n3WTHzZgbqm49BL3XcVbYsqBL5SAhskToELR
         Jx6YFE0IQ1uW3EwSruTS74qiPS0rcjuqYvoMHWwxIseB0DMWvGYT/BbvHpdsbVwMKarO
         AXIYnL8tpC04nB7Xo28ZtPutU95eKxV35gq2toMkHfUOQeaR/LqtlrlWUL5tLKNn3swy
         heYnA8OZL8KbNDZVSh+BEjHCMY8lpANzWAWi4hi+reOY0/zhJYMko55swTgYnz+4QNmX
         fdwAOO+POSMKVjwtN4WdH6t3V0Ouvz1XumWUeMh4AO4cnmEk1F5Tz4NpugbDslkuxyMe
         4jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148128; x=1696752928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ObRy5c8YFdrnW2Ux3zmbr7cSFwdsAqt7EeK0em6AeQ=;
        b=DbxX+jVURZorp4+Zh1WgZDq6dxdBndOBI+BE1pyysbiL9yWO9la+fQFdDz/15f7SjA
         9YjtPdn2iCVS6Su3YfC0k0DwVTrDc/u9twyixnSb09/xkxS2R4j1In2RxnOYgNt3xiw1
         WOxPex6NuexHcj4CyC430aXAg1kfTDoM5QT7BxEwTpttqsz39XtKmq9F0DPDGHpnuOMe
         Fx20chhTYzCAPffeRV6Gp3f7pQQ6koMPKMZUXWzzRF+9s/fhc2LE9fynmXGDcQ9ISvLv
         H7uwKhRtZwKPonK7f8+5OwCRefGJyVyqqXVdL5NkhfKnMnWRIxnwvUU+/O6PDax+gnBA
         +FKw==
X-Gm-Message-State: AOJu0YzbNI74xidBIfWQGNKLNDPkiDq4ykm1lKD+mCzEk/ICss5g5YFn
        qpUUmjXwTYD9fXriRec4tKc=
X-Google-Smtp-Source: AGHT+IGzL1bPDrm+Mt/CiekFtTeoO6RM4JiIn+0YRTc3jxZ60arUh3rL4CCfqkMGBdTWSXPLe5OUvQ==
X-Received: by 2002:a17:906:209e:b0:9a2:120a:5779 with SMTP id 30-20020a170906209e00b009a2120a5779mr8944577ejq.60.1696148128017;
        Sun, 01 Oct 2023 01:15:28 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:27 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 06/14] USB: typec: tps6598x: Clear dead battery flag
Date:   Sun,  1 Oct 2023 04:11:26 -0400
Message-Id: <20231001081134.37101-7-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

Dead battery flag must be cleared after switching tps25750 to APP mode
so the PD controller becomes fully functional.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v9:
  - No changes
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - No changes
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 16 ++++++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 21b0ea2c9627..2598433a69cf 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -946,6 +946,22 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 
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

