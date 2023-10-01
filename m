Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA87B4613
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjJAIQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJAIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAECDD;
        Sun,  1 Oct 2023 01:15:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso2218023666b.2;
        Sun, 01 Oct 2023 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148134; x=1696752934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvj2VqfHdRAjMHVY/xVfGLDkyqEBAlT4pBrTcr2LF1o=;
        b=YZ56d3HNVWpz4qOCftWZ2syVnbBWE/9YbY9gktX+WgJYmcUpi4KkK6A/aqSqshhAfh
         IupHoTQLCMaNAfpKGY1ckxwiaqlb/AcZPaVUPIiqAo03eai6UNYqFEAfONtmoZGtGmuV
         ZruY13fCKA1R+gytmVP1fPFrhce8VgqQWCeL2yNrH5Ej2hymUe1zUUUlu8kBNB4SEY03
         zXWEGlTQGoyCJcPRCaR+jh23TWj1LytLzcwNJ54Ny3xRemwaZqE5HaQnV0PZ4OOxYFCL
         NSRqXYRxB9X1OxPElrT/rdSheVeQAe5s+1zxosVbRDsbmKP1TYeiwcclMt7LLU5ZNNVi
         ZPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148134; x=1696752934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvj2VqfHdRAjMHVY/xVfGLDkyqEBAlT4pBrTcr2LF1o=;
        b=XExdTXm1V3oOyzFjYb5ADNw+tnJIhWbdE1miGEdo1WpZocyZypwWo1safFF31W9JB2
         2qepOypDmIYZ5g4F0V80aZRvRG5gZoQxUwplfpkjLh56uOjsANPJ2k3mc7KGfLMYi66E
         AGWArFXM6rvMxaWn+TGuuXpug0pcYdqk32sukuRar/PF+Feux4opNnZJvp0Ts7yxNoRh
         LlT22KFvRxYaxscqKvUOQIKFEuxfoTWQ5jIoeO/O1SMFy1oB0qihLwuL3T6aphck41+a
         bER/Q9glXy2kFQl3f7ZQjADjY6rhLYbGnhDToLzG1AGDzu77yDkJPPpqut057gPJ4gi8
         yJRw==
X-Gm-Message-State: AOJu0YzCpzGvrsffzEYedwBsfGJXk2t2of0UZLVdA3CX1+pmz4WFgmpN
        0BaUQbpYMCqjO1FYcuSgNp8=
X-Google-Smtp-Source: AGHT+IEFzdIU7tH+9zuEwWZbK0BQtICU1R4zQlywRdg1OPGduRN7wZ0LQM6UuPsCBTYIdt1nGyVclA==
X-Received: by 2002:a17:906:5dc1:b0:9ae:513d:47bd with SMTP id p1-20020a1709065dc100b009ae513d47bdmr7208484ejv.26.1696148133738;
        Sun, 01 Oct 2023 01:15:33 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:33 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 09/14] USB: typec: tps6598x: Refactor tps6598x port registration
Date:   Sun,  1 Oct 2023 04:11:29 -0400
Message-Id: <20231001081134.37101-10-alkuor@gmail.com>
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

tps6598x and cd321x use TPS_REG_SYSTEM_CONF to get dr/pr roles
where other similar devices don't have this register such as tps25750.

Move tps6598x port registration to its own function

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

 drivers/usb/typec/tipd/core.c | 99 +++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 52dc1cc16bed..0195eabd96bf 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1032,14 +1032,64 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int
+tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	int ret;
+	u32 conf;
+	struct typec_capability typec_cap = { };
+
+	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
+	if (ret)
+		return ret;
+
+	typec_cap.revision = USB_TYPEC_REV_1_2;
+	typec_cap.pd_revision = 0x200;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+
+	switch (TPS_SYSCONF_PORTINFO(conf)) {
+	case TPS_PORTINFO_SINK_ACCESSORY:
+	case TPS_PORTINFO_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_UFP_DRD:
+	case TPS_PORTINFO_DRP_DFP_DRD:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DRD;
+		break;
+	case TPS_PORTINFO_DRP_UFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_DFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	case TPS_PORTINFO_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	tps->port = typec_register_port(tps->dev, &typec_cap);
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
+
+	return 0;
+}
+
 static int tps6598x_probe(struct i2c_client *client)
 {
 	struct device_node *np = client->dev.of_node;
-	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
 	u32 status;
-	u32 conf;
 	u32 vid;
 	int ret;
 	u64 mask1;
@@ -1112,10 +1162,6 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_clear_mask;
 	trace_tps6598x_status(status);
 
-	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
-	if (ret < 0)
-		goto err_clear_mask;
-
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
 	 * struct device. Instead we simply parse it to read the properties.
@@ -1133,50 +1179,13 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_fwnode_put;
 	}
 
-	typec_cap.revision = USB_TYPEC_REV_1_2;
-	typec_cap.pd_revision = 0x200;
-	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
-	typec_cap.driver_data = tps;
-	typec_cap.ops = &tps6598x_ops;
-	typec_cap.fwnode = fwnode;
-
-	switch (TPS_SYSCONF_PORTINFO(conf)) {
-	case TPS_PORTINFO_SINK_ACCESSORY:
-	case TPS_PORTINFO_SINK:
-		typec_cap.type = TYPEC_PORT_SNK;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_UFP_DRD:
-	case TPS_PORTINFO_DRP_DFP_DRD:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DRD;
-		break;
-	case TPS_PORTINFO_DRP_UFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_DFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	case TPS_PORTINFO_SOURCE:
-		typec_cap.type = TYPEC_PORT_SRC;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	default:
-		ret = -ENODEV;
-		goto err_role_put;
-	}
-
 	ret = devm_tps6598_psy_register(tps);
 	if (ret)
 		goto err_role_put;
 
-	tps->port = typec_register_port(&client->dev, &typec_cap);
-	if (IS_ERR(tps->port)) {
-		ret = PTR_ERR(tps->port);
+	ret = tps6598x_register_port(tps, fwnode);
+	if (ret)
 		goto err_role_put;
-	}
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
-- 
2.34.1

