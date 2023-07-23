Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F175E37C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGWQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGWQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:10:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F110C9;
        Sun, 23 Jul 2023 09:10:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992f15c36fcso624286666b.3;
        Sun, 23 Jul 2023 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128571; x=1690733371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIn1Fh/0oKESaebDcUmATFcdpQekuLbCyP5ZseHv9+Q=;
        b=rIcWg797VMNVP1FP4eVrq5u54X+X58gg8XWijgGoWE41Hiqnedwhw50G0vNPSSOB5l
         vPG34DnQoSFxznE/u4El2wb3f78WUhhFfm7mojCntda2JhUIXYtAsJaqxm6dHbOdLSvd
         3erNXuLdrWMJvjgR+dh2mCYL1x5BocPw+UQW9ZJqnaMxZ6TsDomcnipJhJ7Gadzt/eBU
         +77ShAmwyZQ1pTpBwHUzlsBjiQeK7GgKOxufIJV4/qDK/FAmkn3o13ulsTZSsL4qr3mE
         XE83zVlj1zJFB/TIBZSy6Y0XffD9uDIOePpDjYCh2QyHKhgdXukc+/Ay2xNa1YuC+FdE
         5yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128571; x=1690733371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIn1Fh/0oKESaebDcUmATFcdpQekuLbCyP5ZseHv9+Q=;
        b=SgBffkWLiUm1OEiAdxxwVte0VZ3Xs/WF3swap4q9vYAvWGonH43AgUbpEzURAO8YFn
         jkDxAY1T3F9OSZ7qGo6LktyOxWanvbQD0x1ZBk9ixYJXQvBnlEtzCY2ILq9sBFyyzKL+
         7o1jBhk5L0RVgWfTqcdwKvh9cR4ekQbB/JA1hFvwwpe2GiDNY/xGxYpcS1n3JouXQBNk
         DriLNocRgDTCZqt9DSg9PqfiRftxAGCqo0mHdMSKkqjiwVmBwpgw+uqvqnQZT6mPhZ05
         mBO1rG8XpB/ntUinfLmsX0Exoq50afjj+iGLc9oj23xZK8MUaYuvZWi5SzJSdBfdI++j
         uiVA==
X-Gm-Message-State: ABy/qLY0SAeZ26sGG7LEgsxVdm+uX/ZJ8joUZPHwtk29pX4tQNnglduZ
        70kqP6M23c7Nf0Vmrlwkvvb81zpf3LY=
X-Google-Smtp-Source: APBJJlEyptAQQvr5BRCsqNNtS9WlrFXYd9nqi/ashFRNqhpw88rt+yHRDupPuDkKwooNIPi3Tnvpzw==
X-Received: by 2002:a17:906:8451:b0:994:1fd2:cf96 with SMTP id e17-20020a170906845100b009941fd2cf96mr8015297ejy.0.1690128570913;
        Sun, 23 Jul 2023 09:09:30 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:30 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] clk: qcom: hfpll: Add MSM8976 PLL data
Date:   Sun, 23 Jul 2023 18:08:24 +0200
Message-Id: <20230723160827.22660-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723160827.22660-1-a39.skl@gmail.com>
References: <20230723160827.22660-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PLL configuration for MSM8976 SoC, this SoC offers 3 HFPLL.
Small cluster offers two presets for 652-902Mhz range and 902Mhz-1.47Ghz.
For simplicity only add second range as smaller frequencies can be obtained
via apcs divider or safe parent this also saves us
a hassle of reconfiguring VCO bit and config_val.
A72 and CCI cluster only use single frequency range with their
outputs/post_dividers/vco_bits being static.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/hfpll.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index ec18bc8f0089..7a67b1457605 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -32,8 +32,62 @@ static const struct hfpll_data hdata = {
 	.max_rate = 2900000000UL,
 };
 
+static const struct hfpll_data msm8976_a53 = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x341600,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.l_val = 0x35,
+	.user_val = 0x109,
+	.min_rate = 902400000UL,
+	.max_rate = 1478400000UL,
+};
+
+static const struct hfpll_data msm8976_a72 = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x4e0405d,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.l_val = 0x3e,
+	.user_val = 0x100109,
+	.min_rate = 940800000UL,
+	.max_rate = 1843200000UL,
+};
+
+static const struct hfpll_data msm8976_cci = {
+	.mode_reg = 0x00,
+	.l_reg = 0x04,
+	.m_reg = 0x08,
+	.n_reg = 0x0c,
+	.user_reg = 0x10,
+	.config_reg = 0x14,
+	.config_val = 0x141400,
+	.status_reg = 0x1c,
+	.lock_bit = 16,
+
+	.l_val = 0x20,
+	.user_val = 0x100109,
+	.min_rate = 556800000UL,
+	.max_rate = 902400000UL,
+};
+
 static const struct of_device_id qcom_hfpll_match_table[] = {
 	{ .compatible = "qcom,hfpll", &hdata },
+	{ .compatible = "qcom,msm8976-hfpll-a53", &msm8976_a53 },
+	{ .compatible = "qcom,msm8976-hfpll-a72", &msm8976_a72 },
+	{ .compatible = "qcom,msm8976-hfpll-cci", &msm8976_cci },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
-- 
2.25.1

