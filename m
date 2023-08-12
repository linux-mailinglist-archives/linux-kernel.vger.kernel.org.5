Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE76779FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjHLL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjHLL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414A10C0;
        Sat, 12 Aug 2023 04:27:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso4445154e87.1;
        Sat, 12 Aug 2023 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839634; x=1692444434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwpHu9R8DTJVzd3jTz3cmmUlW5j7I+iDCE8b7S1GNgo=;
        b=ZterrhBvNTcbo5vTgsIEPHluVgQxI93Cr4AZLx7ZQplXYIRvrP14XM/TOQCSmAizqq
         E3SNAxm5dqa+2odyUSjNgYxWGsakdKGxnZOICtkL75pa/lfBLIjWShkLdkVtLXmLkeDy
         OUNAEUxAQxAav6PawTckG5+z7UXdSvVihX39KGLGgn3C3Wb1U4GMrxrjKboQPN4LhXnM
         qgbbsai2oXu7TzwVOHrGb2d4o+Q4cSBFuUyLTHQDKBmSjIqdJU/vl5MUTQCtZB6bui3+
         63HpPw5uDrUQpKTNjV5UedRqAyZtQ1C0XEgx90C+mbadnhAeAt4JAFYUXrwNj6K8bWXz
         X7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839634; x=1692444434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwpHu9R8DTJVzd3jTz3cmmUlW5j7I+iDCE8b7S1GNgo=;
        b=QDz52MWFoO29qUbKRdiztM2TD1g84/FFq4EOYzYQNxwxwI/agD7LG2tZ84y7y21aVQ
         RkHKwg5PrAXThbbNhCQfjN7KmPMshxcNcp6+22xSY+zYX2DFevz0hE+yafv3VWiWNJmC
         XDaR3tIro0j1QkV1EJ4CzHS8atZmrBPIJpxdQ5F6g3ktu092evTJHlo8YexZsp2OZgLE
         vRn+sF/0hOAHsV1r7QnWQJgraLfCjhsjMr39EXGl89snMXOTxGvAx+XpIqdUi2avzxdk
         YadVqMCdnnu+F5eCXG359/rTsjgUlUlhiO8P7r1F8sch83hVSrZw2HW2Me8ldJoQyJjX
         D62w==
X-Gm-Message-State: AOJu0Yzqu7IDPI9GQBV8eIHQPnN8AlQ3nCcptlg8duDugf831iqUdUjK
        5UWG5z70qoxEbIpXNscSS2+ZGR7qVXiDgQ==
X-Google-Smtp-Source: AGHT+IFW2prPcvUi/dV2CJcXU+kHq+qoCzniPey8w8UpYeRI+lSV2klVsceDKTYQfoCV3Dkx0eClqA==
X-Received: by 2002:a05:6512:3d03:b0:4fd:c844:6a43 with SMTP id d3-20020a0565123d0300b004fdc8446a43mr3702600lfv.43.1691839633946;
        Sat, 12 Aug 2023 04:27:13 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:13 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v3 5/7] clk: qcom: hfpll: Add MSM8976 PLL data
Date:   Sat, 12 Aug 2023 13:24:48 +0200
Message-Id: <20230812112534.8610-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812112534.8610-1-a39.skl@gmail.com>
References: <20230812112534.8610-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 47325eb17f07..dac27e31ef60 100644
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
+	.max_rate = 2016000000UL,
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
 	{ .compatible = "qcom,hfpll", .data = &hdata },
+	{ .compatible = "qcom,msm8976-hfpll-a53", .data = &msm8976_a53 },
+	{ .compatible = "qcom,msm8976-hfpll-a72", .data = &msm8976_a72 },
+	{ .compatible = "qcom,msm8976-hfpll-cci", .data = &msm8976_cci },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
-- 
2.41.0

