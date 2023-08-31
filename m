Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A407678F47E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347562AbjHaVVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347553AbjHaVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:21:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5401110C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:21:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5007c8308c3so2523560e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693516889; x=1694121689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f03J+hriVH4eEcJ1UVn8Kn+RGwYWltcYClmfj1VG8vM=;
        b=miKJzmuCkPok8wYbR2DhC+YScfgqoumFouwmasqcAmIT2H6pXWkagq6sCIdCVA3wIj
         1gkmApTIXhyJqRwn/ULjlCu0q3UDUD5fI7Vd4dtosCMZ8fRnK5+argcoHo0W7nvmjiBJ
         ojEYb9+9xp7qUoUP8V36KUMJB93rBGnbMTOQffuJpW9KcfZ9S0YP1qU5evudXbQG06Je
         mr59xipAbiV4deh3lVPA5Da4exQ0NaTVKdj8H02K4y1UQU6Ba05G563JA5HHGVYWueF+
         RQPE08vm/CXcGMeWqf5kL+HmwSZq7dnVGV4WYbzCtEM8p2sP8kl4BRzkQaSsWcemkecP
         cQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516889; x=1694121689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f03J+hriVH4eEcJ1UVn8Kn+RGwYWltcYClmfj1VG8vM=;
        b=S1bw53MncZFWpoXpVLgIGyWmYsoz7TQ/pjSXGqJYYqsDADqfJW1xhfqsTC1ciyOf7j
         aaHFkpnbqQ/cT+3WevxcmSSI3t0NZG78ul2p8X8pTOOZVMovvL794Fo/O/C60baLoP/b
         y5uBS8UMs4uJDHmb/II0rkhFOjvcYI4O1stXffHoMoJi4WQ2TvsGtn18ULOUqSOBgIn0
         XlB30WVpZunxNyArgRgaCghPk7u4jWzRHbQbBqdKFQpHH/RJzZooXQ+zPSdu3h5Gh8or
         uc12tol4zdFwjOjIkuhd0x/doWzYHmrNq9aj13u2fSLfOAlAUJYKrdTjqwvDwSuALvBF
         DGpg==
X-Gm-Message-State: AOJu0YyZtzqGbWgVqID0YhpCaX4bUMNf8jFfvJSI/vstpX3gTvNW9668
        2iQKATa+are5JzYK8GaF9Vv7sESxpio+pmIsBD/T9A==
X-Google-Smtp-Source: AGHT+IGLiBwba1zhQZ808r8i0aGzDCFmT5SLup/IPAolVReEDuDZMcU3o3+xo22GLWE5gK8pYzz1VQ==
X-Received: by 2002:a05:6512:110a:b0:500:979e:8d8b with SMTP id l10-20020a056512110a00b00500979e8d8bmr296161lfg.34.1693516889654;
        Thu, 31 Aug 2023 14:21:29 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id eo4-20020a056512480400b004fbc0c7218bsm414866lfb.118.2023.08.31.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:21:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 31 Aug 2023 23:21:25 +0200
Subject: [PATCH v2 4/4] pinctrl: qcom: sdm660: Add MPM pin mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-mpm_mappings-v2-4-4c2b4495e654@linaro.org>
References: <20230809-topic-mpm_mappings-v2-0-4c2b4495e654@linaro.org>
In-Reply-To: <20230809-topic-mpm_mappings-v2-0-4c2b4495e654@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693516884; l=1937;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=k5LKYIcpbh6ocaiq5muqaTuGlrYwN+Wr1d1SJTM+cGU=;
 b=izPENaTegqkgQKsWPGcUOFHHiUftUxiYjLI32q4BhTgrdwmYXA+ySOa3hhF3CECKfq/XX4Vt8
 dvZYcC+s97mALvZRxekocb0B4696lLWqLxuU0dfplSMid3dDh1en6vc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sdm660.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660.c b/drivers/pinctrl/qcom/pinctrl-sdm660.c
index c2e0d5c034ac..907e4ffca5e7 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm660.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
@@ -1399,6 +1399,18 @@ static const struct msm_pingroup sdm660_groups[] = {
 	SDC_QDSD_PINGROUP(sdc1_rclk, 0x9a000, 15, 0),
 };
 
+static const struct msm_gpio_wakeirq_map sdm660_mpm_map[] = {
+	{ 1, 3 }, { 5, 4 }, { 9, 5 }, { 10, 6 }, { 66, 7 }, { 22, 8 }, { 25, 9 }, { 28, 10 },
+	{ 58, 11 }, { 41, 13 }, { 43, 14 }, { 40, 15 }, { 42, 16 }, { 46, 17 }, { 50, 18 },
+	{ 44, 19 }, { 56, 21 }, { 45, 22 }, { 68, 23 }, { 69, 24 }, { 70, 25 }, { 71, 26 },
+	{ 72, 27 }, { 73, 28 }, { 64, 29 }, { 2, 30 }, { 13, 31 }, { 111, 32 }, { 74, 33 },
+	{ 75, 34 }, { 76, 35 }, { 82, 36 }, { 17, 37 }, { 77, 38 }, { 47, 39 }, { 54, 40 },
+	{ 48, 41 }, { 101, 42 }, { 49, 43 }, { 51, 44 }, { 86, 45 }, { 90, 46 }, { 91, 47 },
+	{ 52, 48 }, { 55, 50 }, { 6, 51 }, { 65, 53 }, { 67, 55 }, { 83, 56 }, { 84, 57 },
+	{ 85, 58 }, { 87, 59 }, { 21, 63 }, { 78, 64 }, { 113, 65 }, { 60, 66 }, { 98, 67 },
+	{ 30, 68 }, { 31, 70 }, { 29, 71 }, { 107, 76 }, { 109, 83 }, { 103, 84 }, { 105, 85 },
+};
+
 static const struct msm_pinctrl_soc_data sdm660_pinctrl = {
 	.pins = sdm660_pins,
 	.npins = ARRAY_SIZE(sdm660_pins),
@@ -1409,6 +1421,8 @@ static const struct msm_pinctrl_soc_data sdm660_pinctrl = {
 	.ngpios = 114,
 	.tiles = sdm660_tiles,
 	.ntiles = ARRAY_SIZE(sdm660_tiles),
+	.wakeirq_map = sdm660_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(sdm660_mpm_map),
 };
 
 static int sdm660_pinctrl_probe(struct platform_device *pdev)

-- 
2.42.0

