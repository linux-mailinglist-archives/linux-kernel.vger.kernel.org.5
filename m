Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3D376E229
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjHCHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjHCHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:54:00 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C88A6D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:36 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56c884e1d74so425651eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048593; x=1691653393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PS0ssiIqsOqxPlpp2oSfbt7ntbtXB4pivkxkQJXtwM=;
        b=jZNiROXV1Y8OAEvmMlJLmEDbubZTXUi1T2+J6xGMw0OsiLZ15TB0HeZWqjYU46/CPe
         Teqr2XwZ/lAv6OY3i3Jv9wng9jqRbKm1aJXfstf/p8iTD5zQGvBWlfT7POHUxIzVoNWe
         0q/NWoCYElzBGTk+rxrPiwwo8g72n8oUwfl7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048593; x=1691653393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PS0ssiIqsOqxPlpp2oSfbt7ntbtXB4pivkxkQJXtwM=;
        b=l/UZ2gvNbsXPGjYiS9qrBvpyFjckMUoExV9QSukTn7DbUkJ0d6ZOYkiQTrF/OghNeo
         bhR64udW3XN2NcW/MLGOIpZjKchGrECwIEYEw9PXl3EsMlYGYztq6MgW4fmLw+4z84EP
         j2CAqff/dkrv/KFEBvqXTGpUygeosVi0GNbgtkwm63D95xDl7LTyWCPBmwiRCN03f7ag
         AYsYgaPihdFIMc5Zlu3DcDHYb4frLwfy7e1XK5wbARPJ6IOBTcp0GRZvGQipmZqRoa5k
         AuDdLaM1Q864SMS2H5HJJMnG/QHrpQjfCs4e9DSF8ZlwBYPsOR47ve4dMMKLoaeNoDu8
         AYWQ==
X-Gm-Message-State: ABy/qLb7DCMasI48j3DmxH0wbJzD+VGEpat6KYMxbz5tdGtZ4E0LM8rI
        XZ+JhxvCVI8L5GoLcnAPrSg7Eg==
X-Google-Smtp-Source: APBJJlE6IfyO/d4f2Lyl/G/W5Sw2/2IqJiJ69cq+4LFRNpfCQclGstrDp6B/OrjWe6ZsXFSIcgnCEA==
X-Received: by 2002:a05:6870:420d:b0:1bb:e381:e1f1 with SMTP id u13-20020a056870420d00b001bbe381e1f1mr20111422oac.9.1691048593034;
        Thu, 03 Aug 2023 00:43:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:12 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 6/9] regulator: mt6358: Make MT6366 vcn18 LDO configurable
Date:   Thu,  3 Aug 2023 15:42:44 +0800
Message-ID: <20230803074249.3065586-7-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803074249.3065586-1-wenst@chromium.org>
References: <20230803074249.3065586-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VCN18 regulator on the MT6366 (only) actually has a wide
configurable range of voltages, even though its name suggests a fixed
output voltage.

Convert it from a fixed LDO to a configurable LDO. Its range of settings
is the same as the VM18 regulator, which is missing and will be added in
a subsequent patch.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 5a43a84c7a3e..f8cdfa992c23 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -324,6 +324,27 @@ static const struct linear_range vldo28_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 11, 21, 10000),
 };
 
+static const unsigned int mt6366_vcn18_vm18_selectors[] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
+static const struct linear_range mt6366_vcn18_vm18_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 11, 21, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 22, 32, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 33, 43, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 44, 54, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 55, 65, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 66, 76, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 77, 87, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 88, 98, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 99, 109, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 110, 120, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 121, 131, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 132, 142, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 143, 153, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 154, 164, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 165, 175, 10000),
+};
+
 static unsigned int mt6358_map_mode(unsigned int mode)
 {
 	return mode == MT6358_BUCK_MODE_AUTO ?
@@ -558,7 +579,6 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 			 MT6358_LDO_VRF12_CON0, 0, 1200000),
 	MT6366_REG_FIXED("vio18", VIO18,
 			 MT6358_LDO_VIO18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
 	MT6366_REG_FIXED("vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
 	MT6366_REG_FIXED("vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
 	MT6366_REG_FIXED("vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
@@ -591,6 +611,8 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
 	MT6366_LDO("vsim2", VSIM2, vsim,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
+	MT6366_LDO("vcn18", VCN18, mt6366_vcn18_vm18,
+		   MT6358_LDO_VCN18_CON0, 0, MT6358_VCN18_ANA_CON0, 0xf00),
 	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
 	MT6366_LDO1("vsram-others", VSRAM_OTHERS, 500000, 1293750, 6250,
-- 
2.41.0.585.gd2178a4bd4-goog

