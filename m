Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF57768EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHITjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjHITjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:39:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770DF10EC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:39:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so2841951fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691609951; x=1692214751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZH5r6HM3EYDwBhEb2o8W4vo+HLiDTKfIHnYWGsrXi4=;
        b=inSmMhplBZ1gKK1uL2aKws3Bbw8nkUZQlUJdB/uSuwQQYNr1lxbdEZrKNoKzvAhq2Z
         2NRh1CXEFfqbbaDv7mUKmLooT8W38a5qYQyulJOkKTSFczymga2bj/4ZrlwioXheY86a
         aJ5Pq7IWosLBX5086bxErY2Xqv9WvQ6zUWeIWMSpyI8ssogA3EmbyC0WduubSciL0WqN
         bxqIT0jpNp75D9jovYLXxeodL0b7jajkNih+SGBPrkGJVmbLVM0H+wddYrRFVHAyX6AL
         MBL8e7UbEhcZ5FTOuQzFEfR5D53pAoENxom+kHQMueGgAN78OP+8MtJn1bz3a/KMzIyn
         gzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609951; x=1692214751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZH5r6HM3EYDwBhEb2o8W4vo+HLiDTKfIHnYWGsrXi4=;
        b=KBTkd2bfy3/2yzt9D2mw7RAfQ7eBF8+w63SLKoEF4F3atw00zZia8AVwxTZ4UOe4qL
         Xq2oukVTaSWGzh6O7Qaumb5SwXTEdbJOm3SLxADkqSvnD6OToqz5O0Sgkly1sUQtgT6D
         i9UCT8IHqcScurNjIjm96fB8jC96UE69HEFmoxLzEOibDhFVpWAhW1Hw4EcpiH+xbxJJ
         O6YBMgO2HQYy29X8Rd2t/8ALD7utnVx3mMqO2W4i77/iOEOpBb5CmFXo1jYzBvD1lM4z
         Os67HfeMtJEuQ2vSfBueJzVKH9uakyw0kE4RxwW1px/7UNddPqPkPCaGJHY5rSoEiieo
         A/Vg==
X-Gm-Message-State: AOJu0Yw0QsU6guH/phXF3OoU1YlhUMZo+TnSWKHGrzndHuAKFCIy6gcV
        hwZMUbx+jJLdHFpYTe0H9vqZ7g==
X-Google-Smtp-Source: AGHT+IHLhFFkfeMBMM8H6CUvPoaxABPouQaKxyUND6YP2qc7RQGC++ACyLpADLZgW9wrq8vz0l2Edw==
X-Received: by 2002:a2e:800b:0:b0:2b6:ee99:fffc with SMTP id j11-20020a2e800b000000b002b6ee99fffcmr117312ljg.36.1691609950750;
        Wed, 09 Aug 2023 12:39:10 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e9c86000000b002b9fe77d00dsm2885287lji.93.2023.08.09.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:39:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 21:38:55 +0200
Subject: [PATCH 2/5] pinctrl: qcom: msm8996: Add MPM pin mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-mpm_mappings-v1-2-5e17dd76b3c8@linaro.org>
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
In-Reply-To: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691609947; l=1982;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=eXELqUbYWkn05tL5Nv5++G9RQagHZuWO/8CJtyHMRPg=;
 b=ioMbfv1KCwupI22zHn4/VvXqRKWdAxpBz8yxkSBgDrywWU87gGBBethwQHMSYv0MZbkn7fRCn
 RGvqEnbSmANCSBc9Ak83mJBezNJYBHifIocVfYFItIuCHSWieYkke8Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm8996.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8996.c b/drivers/pinctrl/qcom/pinctrl-msm8996.c
index 46cc0b49dbab..a3f7e8ed9112 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8996.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8996.c
@@ -1880,6 +1880,19 @@ static const struct msm_pingroup msm8996_groups[] = {
 	SDC_QDSD_PINGROUP(sdc1_rclk, 0x12c000, 15, 0),
 };
 
+static const struct msm_gpio_wakeirq_map msm8996_mpm_map[] = {
+	{ 3, 1 }, { 4, 5 }, { 5, 9 }, { 6, 11 }, { 7, 66 }, { 8, 22 }, { 9, 24 }, { 10, 26 },
+	{ 11, 34 }, { 12, 36 }, { 13, 37 }, { 14, 38 }, { 15, 40 }, { 16, 42 }, { 17, 46 },
+	{ 18, 50 }, { 19, 53 }, { 20, 54 }, { 21, 56 }, { 22, 57 }, { 23, 58 }, { 24, 59 },
+	{ 25, 60 }, { 26, 61 }, { 27, 62 }, { 28, 63 }, { 29, 64 }, { 30, 71 }, { 31, 73 },
+	{ 32, 77 }, { 33, 78 }, { 34, 79 }, { 35, 80 }, { 36, 82 }, { 37, 86 }, { 38, 91 },
+	{ 39, 92 }, { 40, 95 }, { 41, 97 }, { 42, 101 }, { 43, 104 }, { 44, 106 }, { 45, 108 },
+	{ 46, 112 }, { 47, 113 }, { 48, 110 }, { 50, 127 }, { 51, 115 }, { 54, 116 },
+	{ 55, 117 }, { 56, 118 }, { 57, 119 }, { 58, 120 }, { 59, 121 }, { 60, 122 },
+	{ 61, 123 }, { 62, 124 }, { 63, 125 }, { 64, 126 }, { 65, 129 }, { 66, 131 },
+	{ 67, 132 }, { 68, 133 }, { 69, 145 },
+};
+
 static const struct msm_pinctrl_soc_data msm8996_pinctrl = {
 	.pins = msm8996_pins,
 	.npins = ARRAY_SIZE(msm8996_pins),
@@ -1888,6 +1901,8 @@ static const struct msm_pinctrl_soc_data msm8996_pinctrl = {
 	.groups = msm8996_groups,
 	.ngroups = ARRAY_SIZE(msm8996_groups),
 	.ngpios = 150,
+	.wakeirq_map = msm8996_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(msm8996_mpm_map),
 };
 
 static int msm8996_pinctrl_probe(struct platform_device *pdev)

-- 
2.41.0

