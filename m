Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9575C1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGUIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjGUI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:29:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CCF272E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6682909acadso1119434b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689928180; x=1690532980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBEBajXPeANrxdpiP5Fykz/Cq1TcahWs+MuTM0uJsmg=;
        b=J/Zn4wpP5VNVOXfKPjNJkboqjmqL/vgKtUn1Rqo40UtHQXp/5DPvJfJQvJWKuaVLGO
         nIpiJD0itnC2zu+V1pMCfFCMJ/MTotClIBDurcZK571aT9CCR2zsKksO4eZp+GUZbO3e
         4DmP3rBKaDaNyMT99ZXxzdrxHMEVTPe26OtPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928180; x=1690532980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBEBajXPeANrxdpiP5Fykz/Cq1TcahWs+MuTM0uJsmg=;
        b=MHZ89BDih4Bhe9+XvR+/ZqmZJPKPf0q9xdMItzVLrMNkqLtiUvyLuj4gC3IXmj7Y5z
         joMcZ5nF7kKWBHTucdY7RBRld2zgodioCGwFqPu6GnZS+5DspP5bIQQkS9/fTqSmFasY
         pPGa/fuMur7vb1K0+QLNyhCOxnPYu5eb34cslbtw7eod5cXjfZ3iipJMUSq482CHnUXP
         P+fSchFzxCDpR2IWHuuT+Ywv8cwG1bgIrMNqPg48Lm9xFUufycKi1qUjA10Hl/LMsGgb
         AefYSGQTU23k8eE+argnEhxpDpgvsqAK6KMP3Y8qTsJPPJqIajF2QS99s4wnSDwmXr0X
         xANw==
X-Gm-Message-State: ABy/qLbUWCsj8beP5C/+RH1XMNlKgWGl/tD1woU66R9XCBaZuKKbLLsn
        OUHqCLIA2V+cvGB92xWrXUT53BRUJGzuQFNhOQ4=
X-Google-Smtp-Source: APBJJlFDtfbR4C/I+qjjtDOEeJbaMFBrL4FhBuCmIiVzEhT72OEsSIEZNX/0gWIzVTcWcePM5JbR2A==
X-Received: by 2002:a05:6a20:b709:b0:132:d2c4:9cb9 with SMTP id fg9-20020a056a20b70900b00132d2c49cb9mr972256pzb.29.1689928180182;
        Fri, 21 Jul 2023 01:29:40 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0055fe64fd3f4sm2594382pge.9.2023.07.21.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:29:39 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 5/7] regulator: mt6358: Add output voltage fine tuning to fixed regulators
Date:   Fri, 21 Jul 2023 16:28:57 +0800
Message-ID: <20230721082903.2038975-6-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721082903.2038975-1-wenst@chromium.org>
References: <20230721082903.2038975-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fixed" LDO regulators found on the MT6358 and MT6366 PMICs have
either no voltage selection register, or only one valid setting.
However these do have a fine voltage calibration setting that can
slightly boost the output voltage from 0 mV to 100 mV, in 10 mV
increments.

Add support for this by changing these into linear range regulators.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/mt6358-regulator.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index a1eae45f5fee..b34ad85db771 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -123,10 +123,13 @@ struct mt6358_regulator_info {
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6358_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
-		.n_voltages = 1,	\
+		.n_voltages = 11,	\
+		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
+		.vsel_mask = GENMASK(3, 0),	\
 		.enable_reg = enreg,	\
 		.enable_mask = BIT(enbit),	\
 		.min_uV = volt,	\
+		.uV_step = 10000, \
 	},	\
 	.status_reg = MT6358_LDO_##vreg##_CON1,	\
 	.qi = BIT(15),							\
@@ -219,10 +222,13 @@ struct mt6358_regulator_info {
 		.type = REGULATOR_VOLTAGE,	\
 		.id = MT6366_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
-		.n_voltages = 1,	\
+		.n_voltages = 11,	\
+		.vsel_reg = MT6358_##vreg##_ANA_CON0,	\
+		.vsel_mask = GENMASK(3, 0),	\
 		.enable_reg = enreg,	\
 		.enable_mask = BIT(enbit),	\
 		.min_uV = volt,	\
+		.uV_step = 10000, \
 	},	\
 	.status_reg = MT6358_LDO_##vreg##_CON1,	\
 	.qi = BIT(15),							\
@@ -476,8 +482,13 @@ static const struct regulator_ops mt6358_volt_table_ops = {
 	.get_status = mt6358_get_status,
 };
 
+/* "Fixed" LDOs with output voltage calibration +0 ~ +10 mV */
 static const struct regulator_ops mt6358_volt_fixed_ops = {
 	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = mt6358_get_buck_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.41.0.487.g6d72f3e995-goog

