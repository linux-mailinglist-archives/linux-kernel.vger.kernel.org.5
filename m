Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA6788CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbjHYPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbjHYPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73778213C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ff9b389677so1576560e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977914; x=1693582714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azTsgBM86+GM9sSp42BUI1s8412oPMCgpH7RHDGWmLw=;
        b=i9hivS1oUlHEda/POH/lLTO9SB2ZhHbDNnbg9QGKhCuzidjynDn7kYqQQRBMaxOFFp
         44uWmeDTl6fjdqvRQ9gsaWdTm8XNWalwNkS9r4rg05ZYYC/jv9bU6H9K2HzYQjQQtJgS
         afRJ+OnwYDKKMAB6L4Z92+/O4+GjJGdSQ40ch6PnofT0m06GKweUPvO1VO8IReYIbzsw
         0tioSrBGuNjiiWIso/1D1wbkEtDRjD3l0rMBgt7mTGNZzUSMYi1mnpOIFsxMEyLTNYCG
         MIx526z7krjhugm6JNLDxJUWTrWLUFtuFnbAHEZR1imRge2DklUzNNPcfOKte0c1GuL0
         1aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977914; x=1693582714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azTsgBM86+GM9sSp42BUI1s8412oPMCgpH7RHDGWmLw=;
        b=Wui5Jg07e+RCpkRhGY9cHsHNkjwdPnVJgxZAwZGbSqk0MDsep5QN5cPUZeoozem62V
         et4g+FW7YWm8g3F/jTAExCVksbqzyIbnndWD6SNz2mqL3g2lqkteT+hsC9d0Ewk7/ywT
         hohRE66Z0hffRnEaDppZJa0x4BlLwqvB/DR4sFZDbC3A9/SlpsXE/3qasWGHIyzVfvc4
         GB/9EzzQ7iVp6CpSsqCkkRKDCeZyWlAotTLMNgwELbRExhh0QlHCPJ5Rvxq3DriKAsJX
         bgyK0jakYU3CVRSdhKeHXZ2yRNtxJkHLys33kNAzJZmMLtPW/ORNVQv16ed4ErjUer2N
         IA9A==
X-Gm-Message-State: AOJu0YyOSMzjqBgK6EfGTzaXibXEPZnjPJQO2DhL/8by1RjFYDJlRS9S
        klrP7aoHl8GhHLPfo4KAP1FuVQ==
X-Google-Smtp-Source: AGHT+IFpC7f2GKEeP17lWZafcyaLyk7hJMxrz3ESx1Rz4tEHInZrUawfmikVewSTSsESxFiozjT9kw==
X-Received: by 2002:a19:6d1c:0:b0:4fd:c83b:a093 with SMTP id i28-20020a196d1c000000b004fdc83ba093mr11919849lfc.1.1692977914620;
        Fri, 25 Aug 2023 08:38:34 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:29 +0200
Subject: [PATCH v4 07/10] interconnect: qcom: qcm2290: Update EBI channel
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-7-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=1320;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y3uMer9xOocejP5QFGPjFGimfPx5QRm0vyhaJFgmIts=;
 b=J8kGgkMIcFdUnllOtWiO18kvfFZhO5gtE0bKmGCVA2lUur90VBvqeYmMaLqgPp1SMjC6rXJ11
 XPwIZ5sMI2kDjabqVKuJ0Zql/RyizxHLEPqngv7zBQ1Mdg4FxI8tYEK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCM2290 can support two memory configurations: single-channel, 32-bit
wide LPDDR3 @ up to 933MHz (bus clock) or dual-channel, 16-bit wide
LPDDR4X @ up to 1804 MHz. The interconnect driver in its current form
seems to gravitate towards the first one, however there are no LPDDR3-
equipped boards upstream and we still don't have a great way to discern
the DDR generations on the kernel side.

To make DDR scaling possible on the only currently-supported 2290
board, stick with the LPDDR4X config by default. The side effect on any
potential LPDDR3 board would be that the requested bus clock rate is
too high (but still capped to the firmware-configured FMAX).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 7abc0c449220..b88cf9a022e0 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -678,7 +678,8 @@ static struct qcom_icc_node mas_gfx3d = {
 static struct qcom_icc_node slv_ebi1 = {
 	.name = "slv_ebi1",
 	.id = QCM2290_SLAVE_EBI1,
-	.buswidth = 8,
+	.buswidth = 4,
+	.channels = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 0,
 };

-- 
2.42.0

