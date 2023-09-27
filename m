Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263B7B0B78
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjI0R55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjI0R5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B441B3;
        Wed, 27 Sep 2023 10:57:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c136ee106so1469866866b.1;
        Wed, 27 Sep 2023 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837460; x=1696442260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt4gFv3KJ+4bysg0kbGW0jRlrPYOAsIxZD0k9Gm3Zgc=;
        b=L47+YMJgKNE7vZMeQNISLszmVacKHxgmMnHbxRig+cpmo6ZOyf4IOBXvWXHnd3vXTp
         xATiPzo3OG0e7ivLxrNoX43dQerUmtsmzv55OD42kmjpuqlnTTpEwrWv4QFvQ8lMOooU
         SBd9sCwh4ywlubrnpWv0TCSdfCznenhQIuoYh7rr+eJ8nBQ2VOqIsuduCm3iKRN+VT2V
         e1cH77QjV30SSOyNeYK9VJypU3SyKcmatLIFNhNHSvpoNHLA3+OfhNo3MpnrjqEKkLIW
         6bZU+Bnd32kKpRGZIYa60UAdtY06kTkVZALLu5CI9xptUe31n6BWDUIsU4/Fgesp3/g0
         6fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837460; x=1696442260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt4gFv3KJ+4bysg0kbGW0jRlrPYOAsIxZD0k9Gm3Zgc=;
        b=h2DlczQ8bx68JYAXyZsfvlC9ttm47rDKqihUEq0Vux6vpNUvvWBDukHAhlCZKgV5N4
         2TExnMGjFtbCZduwRVnr5+RX4V9jdR2JJKrsUy5tOw0h9fyzVGEOikitcyZNDO3A5LqC
         L78nFXuo1/kNK0Vt6C26HUek1BKTizIOVQPzdr+hR40rFFBbWCyA2UrmXio+/FQiVi7R
         qTy1qEwdMaBgFHV22X31vV8cFu5/MC1FnxUgOotV59Lo4A8G63HzY83XPXwa+JUbVrQP
         /tGGpD1fH4RnXrW7/n6bPvFhVCFE8/J6QS26Y6Dm+zYCyWBU1VGS4yT3+C80AVRf0/p0
         dHhQ==
X-Gm-Message-State: AOJu0Yw5+8YRK/EhPuCIZvvwTw/AMFoLqJQ2MeVp8z14525k73XokABI
        J1tG015VCPELdrLGXZu6Hpo=
X-Google-Smtp-Source: AGHT+IHTllher3zaAM/NriNC9uM5YzI+nvZTCe5tNnkPP3hm28vrggNMVHw9aJ5XCU30e2hl8G8hXQ==
X-Received: by 2002:a17:906:3187:b0:9a5:d657:47e1 with SMTP id 7-20020a170906318700b009a5d65747e1mr2600762ejy.43.1695837459952;
        Wed, 27 Sep 2023 10:57:39 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:39 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 06/14] USB: typec: tps6598x: Clear dead battery flag
Date:   Wed, 27 Sep 2023 13:53:40 -0400
Message-Id: <20230927175348.18041-7-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
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
index cd22635460d3..faeee2ffc99c 100644
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

