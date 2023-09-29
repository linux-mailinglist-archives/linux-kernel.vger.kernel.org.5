Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7645D7B3575
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjI2Ocy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjI2OcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86498CCB;
        Fri, 29 Sep 2023 07:32:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a645e54806so1851066466b.0;
        Fri, 29 Sep 2023 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997927; x=1696602727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joW/9QyjDlkWvegamdHCGKd/54h9KZHWwQxT23h72Lg=;
        b=YfpXYnbYjAdDZ1oP95tcnA0Lz2vZlBIWOy3+AuWbqhYSTBmp0452TK8fF90FMpqkK5
         dRADwDVE16FRHsaYXrH0ooDTj5a8CAjC6rAeB2cnyfEwGYx9JPtdEZZAvX825kNM5tEs
         4u+bd+SSdL1H7rACkOsQKf/lb4nu7TXdvjZFqy297z6tqCi8PWXtLC7/HT4hqT61q5Ky
         Gu6RtXE4B9JV+pgM7ciDsK4NWDW+hagQLRk1xbq6P4VUzLdWj9/awZq/w9tKfJH6+6gw
         48xb9oaG/fe7cjISpbbM8HdU6gdAmHIWsphT7NmriQp3udN0pBuxoFFm6FBoF5rWDSBj
         EOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997927; x=1696602727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joW/9QyjDlkWvegamdHCGKd/54h9KZHWwQxT23h72Lg=;
        b=TYRUXNwY5GxJjgPpYjLosGDpcyix/7AWfcOCnCxfPxVwAzT9GlyWVuyOId8JWKMuJ/
         rC/eT1dQmlOenWlajk95avFhNSlO/aNJGImSO4FpNtbWYBOihX6oCGlaC/dkw9kBcLdn
         xupEAvJi4qbv+qrJ3bCIfrZN+lmQuYx0696ggIzoSMOu72dn+g1oe7cKFbII9XWXweH6
         dzIP89FC24gbczaeLbUOynHgkKHCn5pFuArFPRsXfjlRUaGILa1Y7TdWcFXaGReRE/90
         hL/Lj0UI444TiDWCpOpl5cgeDyKpNESzX7gXkPGsaxKf8lq71P6fMBwLIX3I7E+5dYWI
         w/jA==
X-Gm-Message-State: AOJu0YzOgxSlzPZwCvwnFxEBzW05kj4Npb3ascc3JUIM/LDisRoeJHvp
        UjbRyn3U+nAJZtPaLp2sWbk=
X-Google-Smtp-Source: AGHT+IF3z1hh0ymZIoUwE2pKHQIhYEsl+sfty8Z0bNTIGRw/XyA65vxgTNxlveCM695MvfMHOuPJGQ==
X-Received: by 2002:a17:906:454d:b0:9ae:4f64:6db with SMTP id s13-20020a170906454d00b009ae4f6406dbmr3950928ejq.55.1695997926631;
        Fri, 29 Sep 2023 07:32:06 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:06 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 06/14] USB: typec: tps6598x: Clear dead battery flag
Date:   Fri, 29 Sep 2023 10:30:47 -0400
Message-Id: <20230929143055.31360-7-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

