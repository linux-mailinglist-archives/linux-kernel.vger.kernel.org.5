Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2076E227
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHCHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjHCHxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:53:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9055A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bca88c3487so602079a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048590; x=1691653390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttTbR1j+/xUSVj1m9QYTEHinFwJXH5eiMkSTOV5Zx9Q=;
        b=O0Fg8jGSOQxNurX5K/cocwWzhhmGlP+SoZ9j2TkdWpOjkJQ940tPxY7WFkw1Vz3TQ8
         LIf08kB7uu2YQBNTCnx1JbC0QxaFUIoWGWc4cE/VRXZWVPXJIazlH/CDtHIopaQykjSe
         QB9cyp3tYHO0i+eX191Lm8RwrQmUuqWIYgmQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048590; x=1691653390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttTbR1j+/xUSVj1m9QYTEHinFwJXH5eiMkSTOV5Zx9Q=;
        b=loYF8f1ffNqQd1Ct2w7rKNGeWtm4Y47fijsjZ3xoFL1BX+sOW4M0d/oMCj6atH8Ihg
         l3KvDCWKQu6FhtL9wTU2eSW7NuFu9lCaTg5B37OqD5rUfjmdQiGSyvYcscq8Hj6TS52h
         m8SA/0EMp7Wp8wR0erhIiXrx7K4bH6tB7uX+a0ZLRIlLJ4dVZF9jlr5u8PplknV6cySz
         QMvMKQhGEIHH8mU+s2AGOTIzmqaXLG+9y9XJAnaTj743KJMoelrLveXB4/ODHoBYp4b4
         H8mOhtP971AGAmj1Vv/7q/AoWFPc3kBSy/ZVFRUwK3qISsyPgCGEL4cVS5dNbOxowjaz
         AbDw==
X-Gm-Message-State: ABy/qLbQ8gMHcw4MRyrWBDWXbhifxGj/QwQdK7XYt7SIsdqOlAvNi+rM
        WTmW8rowhunuS2gYJ3UbB8S4dQ==
X-Google-Smtp-Source: APBJJlH6h7AHwx9O6A3lMvf0B0FHj+xANqujVBGZZyfDjDg28uxf/qLAru3swZsFmXvK70w+22Zhlw==
X-Received: by 2002:a05:6870:4211:b0:19f:6711:8e0a with SMTP id u17-20020a056870421100b0019f67118e0amr18641255oac.32.1691048590537;
        Thu, 03 Aug 2023 00:43:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:10 -0700 (PDT)
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
Subject: [PATCH 5/9] regulator: mt6358: fix and drop type prefix in MT6366 regulator node names
Date:   Thu,  3 Aug 2023 15:42:43 +0800
Message-ID: <20230803074249.3065586-6-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230803074249.3065586-1-wenst@chromium.org>
References: <20230803074249.3065586-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new MT6366 binding does away with the type prefix ("buck_", "ldo_")
in the regulator node names. This better matches the PMIC pin names.
Remaining underscores in names are also replaced with hyphens.

Drop the type prefixes and replace remaining underscores to match the
MT6366 binding.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 70 ++++++++++++++--------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 3cb2e6768e25..5a43a84c7a3e 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -536,68 +536,68 @@ static const struct mt6358_regulator_info mt6358_regulators[] = {
 
 /* The array is indexed by id(MT6366_ID_XXX) */
 static const struct mt6358_regulator_info mt6366_regulators[] = {
-	MT6366_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
+	MT6366_BUCK("vdram1", VDRAM1, 500000, 2087500, 12500,
 		    0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f, MT6358_VDRAM1_ANA_CON0, 8),
-	MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
+	MT6366_BUCK("vcore", VCORE, 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 1),
-	MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
+	MT6366_BUCK("vpa", VPA, 500000, 3650000, 50000,
 		    0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, MT6358_VPA_ANA_CON0, 3),
-	MT6366_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
+	MT6366_BUCK("vproc11", VPROC11, 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 1),
-	MT6366_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
+	MT6366_BUCK("vproc12", VPROC12, 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 2),
-	MT6366_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
+	MT6366_BUCK("vgpu", VGPU, 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 2),
-	MT6366_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
+	MT6366_BUCK("vs2", VS2, 500000, 2087500, 12500,
 		    0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, MT6358_VS2_ANA_CON0, 8),
-	MT6366_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
+	MT6366_BUCK("vmodem", VMODEM, 500000, 1293750, 6250,
 		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
-	MT6366_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
+	MT6366_BUCK("vs1", VS1, 1000000, 2587500, 12500,
 		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
-	MT6366_REG_FIXED("ldo_vrf12", VRF12,
+	MT6366_REG_FIXED("vrf12", VRF12,
 			 MT6358_LDO_VRF12_CON0, 0, 1200000),
-	MT6366_REG_FIXED("ldo_vio18", VIO18,
+	MT6366_REG_FIXED("vio18", VIO18,
 			 MT6358_LDO_VIO18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("ldo_vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("ldo_vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("ldo_vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("ldo_vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
-	MT6366_REG_FIXED("ldo_vaux18", VAUX18,
+	MT6366_REG_FIXED("vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
+	MT6366_REG_FIXED("vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
+	MT6366_REG_FIXED("vaux18", VAUX18,
 			 MT6358_LDO_VAUX18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("ldo_vbif28", VBIF28,
+	MT6366_REG_FIXED("vbif28", VBIF28,
 			 MT6358_LDO_VBIF28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("ldo_vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
-	MT6366_REG_FIXED("ldo_va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
-	MT6366_REG_FIXED("ldo_vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
-	MT6366_REG_FIXED("ldo_vaud28", VAUD28,
+	MT6366_REG_FIXED("vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
+	MT6366_REG_FIXED("va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
+	MT6366_REG_FIXED("vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
+	MT6366_REG_FIXED("vaud28", VAUD28,
 			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
-	MT6366_LDO("ldo_vdram2", VDRAM2, vdram2,
+	MT6366_LDO("vdram2", VDRAM2, vdram2,
 		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0x10),
-	MT6366_LDO("ldo_vsim1", VSIM1, vsim,
+	MT6366_LDO("vsim1", VSIM1, vsim,
 		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vibr", VIBR, vibr,
+	MT6366_LDO("vibr", VIBR, vibr,
 		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vusb", VUSB, vusb,
+	MT6366_LDO("vusb", VUSB, vusb,
 		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vefuse", VEFUSE, vefuse,
+	MT6366_LDO("vefuse", VEFUSE, vefuse,
 		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vmch", VMCH, vmch_vemc,
+	MT6366_LDO("vmch", VMCH, vmch_vemc,
 		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vemc", VEMC, vmch_vemc,
+	MT6366_LDO("vemc", VEMC, vmch_vemc,
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vcn33", VCN33, vcn33,
+	MT6366_LDO("vcn33", VCN33, vcn33,
 		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6366_LDO("ldo_vmc", VMC, vmc,
+	MT6366_LDO("vmc", VMC, vmc,
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
-	MT6366_LDO("ldo_vsim2", VSIM2, vsim,
+	MT6366_LDO("vsim2", VSIM2, vsim,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
-	MT6366_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
-	MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-others", VSRAM_OTHERS, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
-	MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-gpu", VSRAM_GPU, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
-	MT6366_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
+	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, 500000, 1293750, 6250,
 		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
 };
 
-- 
2.41.0.585.gd2178a4bd4-goog

