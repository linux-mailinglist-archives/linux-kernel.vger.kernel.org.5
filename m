Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C307B16DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjI1JKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjI1I40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:56:26 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302E1B6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77433e7a876so496479085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695891380; x=1696496180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1ysO43s7Il7U+jMzlGc1ao7ahn2IQqlVk/2MjJCLAQ=;
        b=ag7BT1sEAu9UIAgVGQVZwCvm6D/f5GRzsYX81dQ6plsMNsUwVZDLTX5EkyG/APqmDh
         2OXue5epVt8UOh6RviMnav9Ko3fWbyyqjXA1ofO1rn7GYEl/h3Xldq7v/S9Lt0Sq9W4E
         ZFsHpS4+zQ4K/S5kNaNYCU0UqpUgTQor5/h0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891380; x=1696496180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1ysO43s7Il7U+jMzlGc1ao7ahn2IQqlVk/2MjJCLAQ=;
        b=LSwfp12g6wQE7QnBh/xO3p/5HPo7J+aX2OTEtiM1KuIWaw4w+I2mc/gmfUe2GJRKrd
         4jlgigkrdog9bOS3qiYSp20WgFUKIFKKWNtqetnWU2MOxrrFOSD3DcMEWOovo9SfpKtB
         bsIUpNzNUcEURW5twpA9QLSKVfrXoFqZp6DvJ1Dcb6vEAyJMqkqEHpD2j4gyHlMl7GJG
         zbs/qgZCbaNZ4Jmomt0HM+KlIrC3B8CItxzRgP5DFJGRdEEv+7VIQ12G7vVciNpL8P0s
         DuLaBi6xn9qTQ8BuZbDTemSTXEjCcLSUaUXxF2PxqlKGsObfrxo0/ljkaMpCPnQfrix5
         3ryw==
X-Gm-Message-State: AOJu0YzNjxtyJSqGS9iiAZ/q0m7tfdLqbvCP2u28PCBV13y86Kgm1YzW
        Wk+22PgJCe9tnVlm9F8znRXYmw==
X-Google-Smtp-Source: AGHT+IHdGRzcQ+qBUJeM0+BjeTmyn/JEOqWxoDA/9cGUAzgTiR0JAVlEKcqVpHsjOcPeWdSwpV48Jw==
X-Received: by 2002:a05:620a:458b:b0:76f:f64:58bf with SMTP id bp11-20020a05620a458b00b0076f0f6458bfmr620884qkb.18.1695891379911;
        Thu, 28 Sep 2023 01:56:19 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm1754016pfm.26.2023.09.28.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:56:19 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 10/12] regulator: mt6358: Add missing regulators for MT6366
Date:   Thu, 28 Sep 2023 16:55:33 +0800
Message-ID: <20230928085537.3246669-11-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20230928085537.3246669-1-wenst@chromium.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When support for the MT6366 PMIC regulators was added, it was assumed
that it had the same functionality as MT6358. In reality there are
differences. A few regulators have different ranges, or were renamed
and repurposed, or removed altogether.

Add the 3 regulators that were missing from the original submission.
These are added for completeness. VSRAM_CORE is not used in existing
projects. VM18 and VMDDR feed DRAM related consumers, and are not used
in-kernel.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/mt6358-regulator.c       | 20 ++++++++++++++++++++
 include/linux/mfd/mt6358/registers.h       | 17 +++++++++++++++++
 include/linux/regulator/mt6358-regulator.h |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 946f62242718..5e23b2aa3486 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -325,6 +325,20 @@ static const struct linear_range vldo28_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0, 10, 10000),
 };
 
+static const unsigned int mt6366_vmddr_selectors[] = { 0, 1, 2, 3, 4, 5, 6, 7, 9, 12 };
+static const struct linear_range mt6366_vmddr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0, 10, 10000),
+};
+
 static const unsigned int mt6366_vcn18_vm18_selectors[] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
 static const struct linear_range mt6366_vcn18_vm18_ranges[] = {
@@ -614,6 +628,10 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
 	MT6366_LDO("vcn18", VCN18, mt6366_vcn18_vm18,
 		   MT6358_LDO_VCN18_CON0, 0, MT6358_VCN18_ANA_CON0, 0xf00),
+	MT6366_LDO("vm18", VM18, mt6366_vcn18_vm18,
+		   MT6358_LDO_VM18_CON0, 0, MT6358_VM18_ANA_CON0, 0xf00),
+	MT6366_LDO("vmddr", VMDDR, mt6366_vmddr,
+		   MT6358_LDO_VMDDR_CON0, 0, MT6358_VMDDR_ANA_CON0, 0xf00),
 	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
 	MT6366_LDO1("vsram-others", VSRAM_OTHERS, 500000, 1293750, 6250,
@@ -622,6 +640,8 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
 	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
+	MT6366_LDO1("vsram-core", VSRAM_CORE, 500000, 1293750, 6250,
+		    MT6358_LDO_VSRAM_CORE_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON5, 0x7f),
 };
 
 static int mt6358_sync_vcn33_setting(struct device *dev)
diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 5ea2590be710..d83e87298ac4 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -294,4 +294,21 @@
 #define MT6358_AUD_TOP_INT_CON0               0x2228
 #define MT6358_AUD_TOP_INT_STATUS0            0x2234
 
+/*
+ * MT6366 has no VCAM*, but has other regulators in its place. The names
+ * keep the MT6358 prefix for ease of use in the regulator driver.
+ */
+#define MT6358_LDO_VSRAM_CON5                 0x1bf8
+#define MT6358_LDO_VM18_CON0                  MT6358_LDO_VCAMA1_CON0
+#define MT6358_LDO_VM18_CON1                  MT6358_LDO_VCAMA1_CON1
+#define MT6358_LDO_VM18_CON2                  MT6358_LDO_VCAMA1_CON2
+#define MT6358_LDO_VMDDR_CON0                 MT6358_LDO_VCAMA2_CON0
+#define MT6358_LDO_VMDDR_CON1                 MT6358_LDO_VCAMA2_CON1
+#define MT6358_LDO_VMDDR_CON2                 MT6358_LDO_VCAMA2_CON2
+#define MT6358_LDO_VSRAM_CORE_CON0            MT6358_LDO_VCAMD_CON0
+#define MT6358_LDO_VSRAM_CORE_DBG0            0x1cb6
+#define MT6358_LDO_VSRAM_CORE_DBG1            0x1cb8
+#define MT6358_VM18_ANA_CON0                  MT6358_VCAMA1_ANA_CON0
+#define MT6358_VMDDR_ANA_CON0                 MT6358_VCAMD_ANA_CON0
+
 #endif /* __MFD_MT6358_REGISTERS_H__ */
diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux/regulator/mt6358-regulator.h
index c71a6a9fce7a..562386f9b80e 100644
--- a/include/linux/regulator/mt6358-regulator.h
+++ b/include/linux/regulator/mt6358-regulator.h
@@ -86,6 +86,9 @@ enum {
 	MT6366_ID_VMC,
 	MT6366_ID_VAUD28,
 	MT6366_ID_VSIM2,
+	MT6366_ID_VM18,
+	MT6366_ID_VMDDR,
+	MT6366_ID_VSRAM_CORE,
 	MT6366_ID_RG_MAX,
 };
 
-- 
2.42.0.582.g8ccd20d70d-goog

