Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88586768F02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGaHg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGaHgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:36:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E8184;
        Mon, 31 Jul 2023 00:36:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so3832445e87.3;
        Mon, 31 Jul 2023 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690789004; x=1691393804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEyRUtIvngdn2xYibH+4khtHK+n4dlGEHPyQwJGcHe4=;
        b=PO8oxGNHcTtgWi1NRPLGFfe54ktB+onMq+Xc77bm6mdLBo8mK9Eru0NyCXckzENbp9
         VCLGcQmqHlSLmR99JjKdfJnjwkzhnUVBlMIjp4jecVwYWyR18NmCAuuueSdH1O8OvgfP
         zRxnTz409xJQ15OStMNHTjGb3rlO0gfPKWr2fM0rFTQZcciehI+LV8bvCuF1jjtVUNib
         RxSaMoV3GsoIHFdtvienaEt/idkwukYtYTIGYrr8yckrPneKWQy9Pv6KmtQGQqGLmQrw
         Ugb8uBONDZkjv9n0J36PrbAXjEsxELSsNpxlfOLw2+qX4eoESQzIDEVkKreZ4+5fLjRc
         YuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789004; x=1691393804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEyRUtIvngdn2xYibH+4khtHK+n4dlGEHPyQwJGcHe4=;
        b=AANWoNE/59OAoNhLJQU3fdHelAyZiSmdXM6hZwf0dkSYsY8Qu0jeEKDyZhWcrZhVsI
         berkNVBw9cCnOKVIlV/9AqAewctUXVWPtp6zkhq3sRgMA3jEz1C0Tn0gPmt24z1Nd4el
         bWxUTUZ7k+r8xQnYGUkvH/Ws6jDu5MgrvWCWjvAI0lGz1JDli34/BN4nXuSRfFJVp2bF
         cEGuduEeCzqMBn4+95IrnK3hLhJFqAmT0FsyMjxHMPaX3lcl2EuiA6QCPsfm5tTNCSto
         hjyKKBUjndLCVPZIcsCEYJyodi3ySpWAWmQENDO0K8MwFHYMgPEmWPsdNHLZ4V/C198b
         bTuw==
X-Gm-Message-State: ABy/qLZx+ttxioYR9Frxl3VmmVhFg5z9NAme/VsED4A+5Aj/1bLyXqmB
        lbVYx+OIGCzmSvWLblX9cLA=
X-Google-Smtp-Source: APBJJlGqFr6olxwW2pbc4pXOiXk6HLrOaBLUtvvbLXUPKKAC5Q9V7stexBXQklm5KlDjQVRFDcN61w==
X-Received: by 2002:ac2:58c9:0:b0:4fd:cae7:2393 with SMTP id u9-20020ac258c9000000b004fdcae72393mr4853658lfo.2.1690789003805;
        Mon, 31 Jul 2023 00:36:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512014e00b004fe3229e584sm586898lfo.270.2023.07.31.00.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:36:43 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 2/4] power: max17040: pass status property from supplier
Date:   Mon, 31 Jul 2023 10:36:11 +0300
Message-Id: <20230731073613.10394-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731073613.10394-1-clamor95@gmail.com>
References: <20230731073613.10394-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally pass status property from supplier if has support
for it. If cell is online assume it is present as well.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d1075959dd46..3301e8a4b16c 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -389,6 +389,7 @@ static int max17040_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = max17040_get_online(chip);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -400,6 +401,9 @@ static int max17040_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
 		val->intval = chip->low_soc_alert;
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		power_supply_get_property_from_supplier(psy, psp, val);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -415,9 +419,11 @@ static const struct regmap_config max17040_regmap = {
 
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static const struct power_supply_desc max17040_battery_desc = {
-- 
2.39.2

