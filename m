Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002078F47F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbjHaVVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347551AbjHaVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:21:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54910E79
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:21:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500cd6261fdso2468915e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693516888; x=1694121688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0bWHTXL+4QRcQrRHlmD0fTfqFT8JCeDR4CO9AOQbuY=;
        b=PBfnTGM1/q4hlFEOvLKd0hHDPfQsE9eUCUsXJWKzZmKuox20BGoFndI0m/BSrTR0X4
         dGTT/LMp1JgvXWzcu+3sAXSDnBS8VXo7XGx7LQDDqyUGjKxV7KCK48bT+8Q+Puain3NX
         HzA45GqKsrTCGq/CTdKi3+vMyaZgU7GAXSWYTHE0/fbws7/61Q7Nbik40plnIp3eZ+fO
         USYV8bWbh5swh47AXYRIKN21Pch//9wxKK9ahZbvHvDY3xRqbgs5olr8cGlaKMowdF5U
         13DJzh0aoABnInr43zKnshoKYi+iWqf6BU3sPcjeTmNdEOa5iYCByBmIAoapszceknOc
         gvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516888; x=1694121688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0bWHTXL+4QRcQrRHlmD0fTfqFT8JCeDR4CO9AOQbuY=;
        b=R3bHRFrngbP6etWUnLBlO3SAwGJTQ2VoZUY8YYslwiOzTmGEBnsgqJi4FcCoMbXNtT
         l9FSfp+If2ASmLj/NKKime16MFPujjxO1mkkhpAngvpIIDeKK74B7f+dtJpHbQUkjd2E
         /JU/CJnwbm0lYXihliLea+tlaosbKaCjfHVE04hB0PwqztGpRhBMnOSiYH1lYBR/nOlM
         DVBi08YrQnixFVGKWeGc4Fo0YTV14gWrncfs7UVwBuppmk7QrzLfgYeEI1XnzSi+Avh5
         Apl/TYZHsK+BUm5t29Cxyf9C5goA+Nu2ePEVHI0mMO0188lsOevFkHj/YYO13wPcQi/6
         5b5A==
X-Gm-Message-State: AOJu0YyI0a/1UbVRpUamJ/Xj6aY3BJsEVy14ST5Q3HSreruXTmRk5U0k
        gzcVhwN9lh2zhUzN26UnSJ4m0g==
X-Google-Smtp-Source: AGHT+IHVSiQiM85q3IbETcBSXQoqctNfDNEC15ZmC2yBAk8NkeOeNGQnVR56hsAkmTGlp7ja7v/W/g==
X-Received: by 2002:ac2:4d92:0:b0:4fe:49d:6ae2 with SMTP id g18-20020ac24d92000000b004fe049d6ae2mr288528lfe.0.1693516888668;
        Thu, 31 Aug 2023 14:21:28 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id eo4-20020a056512480400b004fbc0c7218bsm414866lfb.118.2023.08.31.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:21:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 31 Aug 2023 23:21:24 +0200
Subject: [PATCH v2 3/4] pinctrl: qcom: sm6125: Add MPM pin mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-mpm_mappings-v2-3-4c2b4495e654@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693516884; l=1958;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=O9Ab/UwGaIALgE5LA4+UIkYrc1yECgLTNAXWCWFygtw=;
 b=XptMR6ma9JNxOeUZstKaARQ/0TgGa/9j5sGBTzesLceaT/Bt8gcBLRiynSto6aMR0yDjUreqt
 OEXn2zsrLr1AmhWjcz6odYJW0oetqHzBa0cRqp6oCipyBy9etJWLWJl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm6125.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm6125.c b/drivers/pinctrl/qcom/pinctrl-sm6125.c
index d5e2b896954c..c188842047aa 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm6125.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm6125.c
@@ -1221,6 +1221,21 @@ static const struct msm_pingroup sm6125_groups[] = {
 	[140] = SDC_QDSD_PINGROUP(sdc2_data, SOUTH, 0x58b000, 9, 0),
 };
 
+static const struct msm_gpio_wakeirq_map sm6125_mpm_map[] = {
+	{ 1, 14 }, { 3, 15 }, { 4, 16 }, { 9, 17 }, { 13, 18 }, { 14, 23 },
+	{ 15, 19 }, { 17, 20 }, { 19, 21 }, { 21, 22 }, { 22, 84 }, { 25, 24 },
+	{ 26, 25 }, { 27, 26 }, { 29, 27 }, { 33, 28 }, { 36, 29 }, { 42, 30 },
+	{ 43, 5 }, { 44, 31 }, { 45, 6 }, { 47, 32 }, { 50, 33 }, { 59, 7 },
+	{ 70, 34 }, { 72, 8 }, { 75, 35 }, { 79, 36 }, { 80, 37 }, { 81, 38 },
+	{ 82, 39 }, { 83, 9 }, { 85, 40 }, { 86, 41 }, { 88, 42 }, { 89, 43 },
+	{ 91, 44 }, { 92, 45 }, { 93, 46 }, { 94, 47 }, { 95, 48 }, { 96, 49 },
+	{ 97, 70 }, { 98, 50 }, { 99, 51 }, { 100, 64 }, { 101, 52 },
+	{ 102, 53 }, { 105, 54 }, { 107, 55 }, { 110, 56 }, { 111, 57 },
+	{ 112, 58 }, { 118, 59 }, { 120, 71 }, { 122, 60 }, { 123, 61 },
+	{ 124, 13 }, { 126, 62 }, { 128, 63 }, { 130, 65 },  { 131, 66 },
+	{ 132, 67 },
+};
+
 static const struct msm_pinctrl_soc_data sm6125_tlmm = {
 	.pins = sm6125_pins,
 	.npins = ARRAY_SIZE(sm6125_pins),
@@ -1231,6 +1246,8 @@ static const struct msm_pinctrl_soc_data sm6125_tlmm = {
 	.ngpios = 134,
 	.tiles = sm6125_tiles,
 	.ntiles = ARRAY_SIZE(sm6125_tiles),
+	.wakeirq_map = sm6125_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(sm6125_mpm_map),
 };
 
 static int sm6125_tlmm_probe(struct platform_device *pdev)

-- 
2.42.0

