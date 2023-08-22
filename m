Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B6783C10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjHVIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjHVIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:46:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973FCE78
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a6cd7c6a6so420184b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693953; x=1693298753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJlvy9cp8YdYtNw+zjvbSQuMdmHyQIESMtjbg1P8AFk=;
        b=jslm9USmn7dRFDz6w4G2MzfvBdGji0khaqZCw0xGX9816ntX5c1o/8RAnphAMa38Nt
         V6NkjQBDRKn4oEnwJ06G//CAQqUnkvvIdtbmIGnCcTerUS2xodD4hrg8WkG0Ls16v4GA
         DRx58JL7aAFmkyFRJJWni+65VRSDHWw6x2mF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693953; x=1693298753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJlvy9cp8YdYtNw+zjvbSQuMdmHyQIESMtjbg1P8AFk=;
        b=JxAqieI8HgsRFyM7QbJFOFp2Iq97KKZx5bk/eSOC9Y+L7j0+sQH7hy0kU5dLWccOGG
         RxO8nz88SiRme3PtIW8EDzuzJMsqyWs//3YQRztKd7xxIko156LwBNrF+o+VFlijEniz
         827Dll4tSftC5/tHwmUoYHFac8q0j3lmDVaH7huW5+D/k+F9oKmzRifG/VHiGHqTMyle
         ph2B4ffsuru0YZ/+eb6Avrz4rMFXhi5ntY4bKIBXQD+9QjCOpUes6WCNlVw3sTWY6iid
         oS+btWTmla4OMOa+TX3NNKdR23wmA92fXllskkSL0nmvPOHqZ8XEJWwuH2aLu5HihCQu
         wnQw==
X-Gm-Message-State: AOJu0YyvZPC6XL4kUqMmO6FR/1i411lBSjGwQJeSJ1aFJWNKMqzD38IA
        hvymEYqC6t2OHmv4OLwMnaDUCQ==
X-Google-Smtp-Source: AGHT+IGhAEeSd5MyI4wpWI/9j0yldPpTY8zN3LuQHYHKCR7QGaBsbvecfXQ+vwtFphVPcWXhbIrv+g==
X-Received: by 2002:a05:6a20:7d8e:b0:140:730b:4b3f with SMTP id v14-20020a056a207d8e00b00140730b4b3fmr8839855pzj.1.1692693952941;
        Tue, 22 Aug 2023 01:45:52 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:52 -0700 (PDT)
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
Subject: [PATCH v2 09/11] regulator: mt6358: Add missing regulators for MT6366
Date:   Tue, 22 Aug 2023 16:45:17 +0800
Message-ID: <20230822084520.564937-10-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822084520.564937-1-wenst@chromium.org>
References: <20230822084520.564937-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/regulator/mt6358-regulator.c       | 20 ++++++++++++++++++++
 include/linux/regulator/mt6358-regulator.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 587ee852c053..658c4dbf478f 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -326,6 +326,20 @@ static const struct linear_range vldo28_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 11, 21, 10000),
 };
 
+static const unsigned int mt6366_vmddr_selectors[] = { 0, 1, 2, 3, 4, 5, 6, 7, 9, 12 };
+static const struct linear_range mt6366_vmddr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 10, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 11, 21, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 22, 32, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 33, 43, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 44, 54, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 55, 65, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 66, 76, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 77, 87, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 88, 98, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 99, 109, 10000),
+};
+
 static const unsigned int mt6366_vcn18_vm18_selectors[] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };
 static const struct linear_range mt6366_vcn18_vm18_ranges[] = {
@@ -609,6 +623,10 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
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
@@ -617,6 +635,8 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
 	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
+	MT6366_LDO1("vsram-core", VSRAM_CORE, 500000, 1293750, 6250,
+		    MT6358_LDO_VSRAM_CORE_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON5, 0x7f),
 };
 
 static int mt6358_sync_vcn33_setting(struct device *dev)
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
2.42.0.rc1.204.g551eb34607-goog

