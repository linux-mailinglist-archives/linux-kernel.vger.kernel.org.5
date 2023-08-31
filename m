Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5173178F476
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347541AbjHaVVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbjHaVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:21:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E362CC5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:21:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500cfb168c6so2326802e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693516886; x=1694121686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0OzPy7KKMoqMhNMJWRq7SaDsIGmS+NZYE/XfvpI7LI=;
        b=ujySdFgiGjnSDQQhTsS8WYSgEFYaikdr0h8QMyhuNEAzlt0xaZ21ht/pxLlvq3QjNq
         JVKi1EAwUM1B8QYbiLVOdsVjXr4o4ceRkcYacaBUOAO+lAcfTCID3USxrYxXdpdGwtWC
         zjo4X+BF2z/arEzYeriLeffWGm4bsRpWRv+twWuyD+aDNCs0vyzJh/qjLcWztcsGugZ+
         yFb/rnyjCpPBott5YS6IOxrUDtPYBcfmylN+f7dWW7EQEAdPagrGx11dAjDUsWW9t2v5
         Q7EKZRmbEg6l5rjZUc7nGKzuBJl4sukhyA4lV/o671B5UQPjuhM9KEa0Cx/E0ATtKI+A
         94tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516886; x=1694121686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0OzPy7KKMoqMhNMJWRq7SaDsIGmS+NZYE/XfvpI7LI=;
        b=DYnNV4/vk0K767y/NnsLyBKwQQVOrZSVVaCVvvLcITduRV7hzssMVPNHydWyvtX8eV
         KrFkQjAToTDF88DWsTelkFjSexFnzsRqAFeYxMMsbBGuGXJg4bKzf51zZnInnckvbuDS
         5SY6+UUFd+Gu4X7VujqfgqMaJ9UpoI+dyGRN6Kpk71EhGHn4NesXMNbAEKMW0EVkiAVF
         UW21sSZ1JuY+WIShDhOx9wAXO3NoqBBaozZvAaJkWAHZXFqquRgJJx/gBSXTsJyPSG7/
         DtErs22+fDm5Ae9W+L+f8OXzwGq9Twj1NHHtPDpEUxxUyx5RXTiLSqnl9xPXGWqtc/Eb
         feGA==
X-Gm-Message-State: AOJu0YxbqBMxQJKsMLhosiVuZqQb5/OmE0GkTr2B5CMz3mRveH2vey2P
        +VfhJKUQOyIuw/66FgXkuT6uNg==
X-Google-Smtp-Source: AGHT+IFFz02rQw2ty8kyHs10Ue+NvQj62FxymrVwT63vS223FUbAVT51OAf/BjB4OXgRXDz4dvwjHw==
X-Received: by 2002:ac2:5383:0:b0:500:ac3:dd77 with SMTP id g3-20020ac25383000000b005000ac3dd77mr300192lfh.10.1693516886409;
        Thu, 31 Aug 2023 14:21:26 -0700 (PDT)
Received: from [192.168.1.101] (abxh154.neoplus.adsl.tpnet.pl. [83.9.1.154])
        by smtp.gmail.com with ESMTPSA id eo4-20020a056512480400b004fbc0c7218bsm414866lfb.118.2023.08.31.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:21:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 31 Aug 2023 23:21:22 +0200
Subject: [PATCH v2 1/4] pinctrl: qcom: msm8996: Add MPM pin mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-mpm_mappings-v2-1-4c2b4495e654@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693516884; l=1978;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=y+HxWBisjasmptzHCoZUfO307q4p8IY/42ufI9xwDHE=;
 b=iApaShKJu5gKXLEYLvOKO2GrNWHSHVvqAWTwja+PzdG1FnIgqF3v5BOy9ZUud8wxM+Bxjsd9Y
 b5GhTfDRsIcC5h7daPtaSyxEr/FK83itlvYKbf81KXRewPlb751cDSs
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
 drivers/pinctrl/qcom/pinctrl-msm8996.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8996.c b/drivers/pinctrl/qcom/pinctrl-msm8996.c
index 46cc0b49dbab..1b5d80eaab83 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8996.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8996.c
@@ -1880,6 +1880,18 @@ static const struct msm_pingroup msm8996_groups[] = {
 	SDC_QDSD_PINGROUP(sdc1_rclk, 0x12c000, 15, 0),
 };
 
+static const struct msm_gpio_wakeirq_map msm8996_mpm_map[] = {
+	{ 1, 3 }, { 5, 4 }, { 9, 5 }, { 11, 6 }, { 66, 7 }, { 22, 8 }, { 24, 9 }, { 26, 10 },
+	{ 34, 11 }, { 36, 12 }, { 37, 13 }, { 38, 14 }, { 40, 15 }, { 42, 16 }, { 46, 17 },
+	{ 50, 18 }, { 53, 19 }, { 54, 20 }, { 56, 21 }, { 57, 22 }, { 58, 23 }, { 59, 24 },
+	{ 60, 25 }, { 61, 26 }, { 62, 27 }, { 63, 28 }, { 64, 29 }, { 71, 30 }, { 73, 31 },
+	{ 77, 32 }, { 78, 33 }, { 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 }, { 91, 38 },
+	{ 92, 39 }, { 95, 40 }, { 97, 41 }, { 101, 42 }, { 104, 43 }, { 106, 44 }, { 108, 45 },
+	{ 112, 46 }, { 113, 47 }, { 110, 48 }, { 127, 50 }, { 115, 51 }, { 116, 54 }, { 117, 55 },
+	{ 118, 56 }, { 119, 57 }, { 120, 58 }, { 121, 59 }, { 122, 60 }, { 123, 61 }, { 124, 62 },
+	{ 125, 63 }, { 126, 64 }, { 129, 65 }, { 131, 66 }, { 132, 67 }, { 133, 68 }, { 145, 69 },
+};
+
 static const struct msm_pinctrl_soc_data msm8996_pinctrl = {
 	.pins = msm8996_pins,
 	.npins = ARRAY_SIZE(msm8996_pins),
@@ -1888,6 +1900,8 @@ static const struct msm_pinctrl_soc_data msm8996_pinctrl = {
 	.groups = msm8996_groups,
 	.ngroups = ARRAY_SIZE(msm8996_groups),
 	.ngpios = 150,
+	.wakeirq_map = msm8996_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(msm8996_mpm_map),
 };
 
 static int msm8996_pinctrl_probe(struct platform_device *pdev)

-- 
2.42.0

