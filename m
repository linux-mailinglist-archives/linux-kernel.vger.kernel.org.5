Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEC376E22E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHCHz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHCHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:54:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2058A7D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso322783a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048600; x=1691653400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrPeOXoKc2hUZA03cIawOYELY2pxQM3mW6RdAg6oP4Q=;
        b=B64w8cCq99lVMCbkJggf/D7Dt6lLV5K5zg7oC1ThIFLNH3t5f1k3gSs8+jSLNo/ka8
         7PcdgmMrzsxU8npBb4uQYX9e7OPVdfd6aJDYBa6wJ8Z1u0I3jU5/6hkQVS71dHVk4JrU
         iDZQJbm63agTlZLMmk5l7hGyemkE7pqJogmMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048600; x=1691653400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrPeOXoKc2hUZA03cIawOYELY2pxQM3mW6RdAg6oP4Q=;
        b=FH/2xER6hodDxtv3OrYCqKDm0VbwKBjy1hqMQBjurgmx7iP75jgajfKR1FXVw/rCT6
         y+VaJt+2+vpUIMMVddrZXy01eGJuDyZL3SjIVEbwEBnnKAyDKHbOtzc+0KYOvAkxy6hK
         IwS4QTKlpKU6rmwKHa4WJaWAAratzUCXHzP8breqTWsajNXj43DOj3apOnjOptCOX4mt
         3Q0WY1ut4YgXj9n205L2Jb198kmpeGok/WhjDlkOTytyIMLhFrWmOiNKhk4sUzgd9YFE
         HbDZUuRvOVoC5lk4NPndQ87RPkHlANdOz1ckCLnWR1WwsiLNij2PMqbShpP+PlilS1TN
         OUwA==
X-Gm-Message-State: ABy/qLa4u7iFAG0lLN6T9T78bRajLvE8W4C8cI4PFSQRn2lXmvSwIWod
        rl3YmGrHvLWdwUN0HMNwDkftww==
X-Google-Smtp-Source: APBJJlFurYNnQLVV4RTU7su1Ey1Aj+eNI2+WPiuqHQ1LmYf3d/bpTlfIF23QfhrRuirChqwjNcAVsA==
X-Received: by 2002:a17:90a:d78d:b0:268:1f64:cefc with SMTP id z13-20020a17090ad78d00b002681f64cefcmr13321482pju.49.1691048600567;
        Thu, 03 Aug 2023 00:43:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:43:20 -0700 (PDT)
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
Subject: [PATCH 9/9] soc: mediatek: pwrap: add support for MT6366 PMIC
Date:   Thu,  3 Aug 2023 15:42:47 +0800
Message-ID: <20230803074249.3065586-10-wenst@chromium.org>
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

The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
a different set of regulators. Specifically, it lacks the camera related
VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.

Add a separate compatible for the MT6366 PMIC.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 11095b8de71a..e3c0e767033b 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2257,6 +2257,8 @@ static const struct of_device_id of_slave_match_tbl[] = {
 	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
 	{ .compatible = "mediatek,mt6358", .data = &pmic_mt6358 },
 	{ .compatible = "mediatek,mt6359", .data = &pmic_mt6359 },
+	/* MT6366 is mostly compatible with MT6358, except for slightly different regulators. */
+	{ .compatible = "mediatek,mt6366", .data = &pmic_mt6358 },
 
 	/* The MT6380 PMIC only implements a regulator, so we bind it
 	 * directly instead of using a MFD.
-- 
2.41.0.585.gd2178a4bd4-goog

