Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2143E7686B9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjG3R1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG3R1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:27:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4B10FE;
        Sun, 30 Jul 2023 10:27:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f954d7309fso4654922e87.1;
        Sun, 30 Jul 2023 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690738034; x=1691342834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEyRUtIvngdn2xYibH+4khtHK+n4dlGEHPyQwJGcHe4=;
        b=MHPsXj5q7Idb/kmmujI2ZV/2M4sHrPu9zJOx6PwCeT7eaqPcQHn+SPHcBq5/yRfSIe
         3OtRAhFMbcy5gNQ2T7NfvgDCuILi4bWmd4RylFN1Y0sfguKKRhG5DR52hiH+OzpAnzke
         uZaEKQw5ARL+zn82kODJwP7+99KVGByZfYozGG/ucOUgaE6xj8RXxB/QmrLNNJNZDiuA
         /lHaWuPSK4d0PCi20t08FaP819doG4qixUBaPq+tEB7tsSGr2bk3UJJXQkNP0tmzZO1m
         p7pnPcytzY892KOP5F8fLmr/4Q15xYUV45GV+6D6vA274kg8AjYSyPsRoizlrBlbupwZ
         joOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690738034; x=1691342834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEyRUtIvngdn2xYibH+4khtHK+n4dlGEHPyQwJGcHe4=;
        b=kIj3Eyg89lDmuPpaM2Of05RRT9WmNhjaBNBcg7TE5P2X4L95r7GSEo0yp+ACG1Mxfg
         49Ds+3swO1b12rK6yvply1VOqMzAW7NRnzlKgoBXfva9hfJ4Vv/xjPqfK77tNj0rsA4y
         vRq6J2cpoDDhPxnbkXRcWFlgE/Vp5/SY1Ebt4D3OqR6shRa8iOdHJaHekAp0/wQyJbsW
         HfDXi4AAeOs84jtHnQOMU7ZflEyS+sY2XX0NBjQuDevyCjsStVbIzX8ocB1HwTJkO4k1
         0m22zJIy1xRQxymKvORSjvpOHo7kf/rexRWb23Or+e+S4WX6q5+1wk2nmUsEnHcLWb7b
         Qgqw==
X-Gm-Message-State: ABy/qLawD6sqyvNQSqWoEYiV1EZxCnf3Bqz42MJHPv3ZeMRowpmnugpP
        +GNEXP2A/Wba5rBhElQn9vE=
X-Google-Smtp-Source: APBJJlGoSoF/V1O0mMalA/Kjcg/J0e+9pGJR7SeEkHqC1u3WRbuCSbLv6Gc7DzFa7GV7SfFAaUSe0Q==
X-Received: by 2002:a05:6512:ac8:b0:4fe:2b39:f3d6 with SMTP id n8-20020a0565120ac800b004fe2b39f3d6mr1070244lfu.34.1690738033849;
        Sun, 30 Jul 2023 10:27:13 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b004f8555f7aa1sm1737117lfc.52.2023.07.30.10.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 10:27:13 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] power: max17040: pass status property from supplier
Date:   Sun, 30 Jul 2023 20:26:47 +0300
Message-Id: <20230730172648.71578-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730172648.71578-1-clamor95@gmail.com>
References: <20230730172648.71578-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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

