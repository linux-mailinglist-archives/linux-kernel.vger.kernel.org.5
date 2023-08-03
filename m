Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688C476E226
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjHCHyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjHCHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:53:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B155A6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26830595676so369948a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048585; x=1691653385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qupwZObmmk0/sdY9oZ6qJIIOW7j+/1bq8fINDZIIlo=;
        b=iuw6BH7uxiaSd8Em4i2OVoxw9xOQqLbcZoPiSw5kiOmF8T+bhab7wAMcmOxJJ7Hmpi
         MNKPP/N4/aFleUK4RWH5+LhgCg5aL9Wt5DNlukiGWxm5GtOn8OEE1JXNQSmyJCIXyS8c
         tUXmKwYpnBorP0BECIRrJ9/KO1SX5Ir0MwtFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048585; x=1691653385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qupwZObmmk0/sdY9oZ6qJIIOW7j+/1bq8fINDZIIlo=;
        b=D/HULacjYq2Ef+VDaNADFc675wDKwQcl+0SopFC1EX3P1ctCZvuxKDwV4xYaaW2cMI
         zk1q2asTHjLYEUE7niG0NA+Y7iGYgMHk3fPEswspErulQdPS4sH1cGUMnvHftxHlq+Qn
         fS2w4hwdjCwQ0o7YJL/9bOkAEwJHCxMUWucnXr8YPeepuhBZ9LqbCkQOp9q0ydlvjirz
         OEjypEpEUaIJdbGSx3DuAyRBq3FiTbyYbZ+Ai3BOnhqgh388kGxMUHAPh9f6I6kHrCsg
         U2bHIiHfCYXM5OXfCWwpgrwJeW56EYML7beVugVOJDxfK0kVOHfJVSeywvVVRoXPfE28
         Da7A==
X-Gm-Message-State: ABy/qLZyboZ8SxxIdwVFaUmVv1Z9iv1PWTwBOpoPlY8iiM4H5RiUY5Gd
        sIXXUjKTCSby8YSHDStA/Djr1A==
X-Google-Smtp-Source: APBJJlG87/Ro7nZXzml9fmHTU6Ab8cH9lat6x4i0wjt2yZq9zHMRteYWrxBWgji+jke4gg8BS4lUxQ==
X-Received: by 2002:a17:90a:7f8d:b0:263:72fe:3ef7 with SMTP id m13-20020a17090a7f8d00b0026372fe3ef7mr15974468pjl.42.1691048585544;
        Thu, 03 Aug 2023 00:43:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:05 -0700 (PDT)
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
Subject: [PATCH 3/9] mfd: mt6397: Split MediaTek MT6366 PMIC out of MT6358
Date:   Thu,  3 Aug 2023 15:42:41 +0800
Message-ID: <20230803074249.3065586-4-wenst@chromium.org>
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

The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
a different set of regulators. Specifically, it lacks the camera related
VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.

Add a separate compatible for the MT6366 PMIC. The regulator cell for
this new entry uses a new compatible string matching MT6366.

Fixes: c47383f84909 ("mfd: Add support for the MediaTek MT6366 PMIC")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/mfd/mt6397-core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index f6c1f80f94a4..3f8dfe60a59b 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -206,6 +206,26 @@ static const struct mfd_cell mt6359_devs[] = {
 	},
 };
 
+static const struct mfd_cell mt6366_devs[] = {
+	{
+		.name = "mt6358-regulator",
+		.of_compatible = "mediatek,mt6366-regulator"
+	}, {
+		.name = "mt6358-rtc",
+		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
+		.resources = mt6358_rtc_resources,
+		.of_compatible = "mediatek,mt6358-rtc",
+	}, {
+		.name = "mt6358-sound",
+		.of_compatible = "mediatek,mt6358-sound"
+	}, {
+		.name = "mt6358-keys",
+		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
+		.resources = mt6358_keys_resources,
+		.of_compatible = "mediatek,mt6358-keys"
+	},
+};
+
 static const struct mfd_cell mt6397_devs[] = {
 	{
 		.name = "mt6397-rtc",
@@ -280,6 +300,14 @@ static const struct chip_data mt6359_core = {
 	.irq_init = mt6358_irq_init,
 };
 
+static const struct chip_data mt6366_core = {
+	.cid_addr = MT6358_SWCID,
+	.cid_shift = 8,
+	.cells = mt6366_devs,
+	.cell_size = ARRAY_SIZE(mt6366_devs),
+	.irq_init = mt6358_irq_init,
+};
+
 static const struct chip_data mt6397_core = {
 	.cid_addr = MT6397_CID,
 	.cid_shift = 0,
@@ -358,6 +386,9 @@ static const struct of_device_id mt6397_of_match[] = {
 	}, {
 		.compatible = "mediatek,mt6359",
 		.data = &mt6359_core,
+	}, {
+		.compatible = "mediatek,mt6366",
+		.data = &mt6366_core,
 	}, {
 		.compatible = "mediatek,mt6397",
 		.data = &mt6397_core,
-- 
2.41.0.585.gd2178a4bd4-goog

