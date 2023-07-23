Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E675E25B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGWOHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGWOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5748C12B;
        Sun, 23 Jul 2023 07:07:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b702319893so49832651fa.3;
        Sun, 23 Jul 2023 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121254; x=1690726054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e37AKpgfP+e3Di/jLJSpwPHf9AXaevgDCuq32UDQMM=;
        b=FcY390jOKSaNXZwkPSv+wO1hS+/Tp7MxfdUOeciW1O3PaLj7RfzR8HbrijWzUb5r8m
         FiPj8WkL59dDDDAPii0Zn6ifbR0kZox7/GF4e42M+VaUPumxOtxRYXqzcYQg0GPofVba
         AbA+KWxQiolUOOdRPSe1DYqHCvTTdvNoq1pNa4lRvUq9ECy7jQDRJF29w/094QsTImFT
         nOZlTJH2An9kXFA7s7omCodoF9lWNFNpMiaspZ5RINq/6DJiWWHyfJyW2nBd591LXbB2
         w3eMOUVx1ZzLIj5aTNDlj7AtcWQ2LLVu1Mcm4KRRFCV8CaJYxbHTmBueD2iWRgloVjyW
         gp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121254; x=1690726054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e37AKpgfP+e3Di/jLJSpwPHf9AXaevgDCuq32UDQMM=;
        b=UcihShg5lY7x+1T53OFpwVKr5IFp1vTj2i4F6+IBULATZx6NImAC6QBEvtnApzZGGS
         mDaZ1rBIleemrM3bE5isD3vy9a8khrjPvxIyTxHDIxcUNQMnKbe9hJrfaASzzTcfPyLc
         kruEqzveAFJttUkzpjzuNjkFdxkIDcJHbnydBh/JD7bz07dW9dcixsdEkrDNJvttLOkU
         pva8D1oVDtet+sYAg/tIk5ynd9bSyL5j2xZBCwveVFHeO3KirrD2CoMfdAPVVHiX6jGl
         4prGe0+RrVk2ZroihQWcojANOGz0CeQqb04XN6a27onUwj17QCRhxA2m/eKfesrPSiNG
         1Z/w==
X-Gm-Message-State: ABy/qLar74mn+I52UoeW0FSMQXhSTqCfG3ZO4s6RqpZVZjyX2eYPeEyY
        vSbPUos/cswiL1+GMYlWyQzP+Mqyq/sZ4A==
X-Google-Smtp-Source: APBJJlHerg5IKyx/Lu59KC3K59oQGSyuPInnsgujv5/4msaMJQYOc8LKvHnbMrhnXNXu+1t5nI1Pew==
X-Received: by 2002:a05:6512:3b8a:b0:4fd:cdc6:3519 with SMTP id g10-20020a0565123b8a00b004fdcdc63519mr4108459lfv.44.1690121254508;
        Sun, 23 Jul 2023 07:07:34 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:34 -0700 (PDT)
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clk: qcom: clk-hfpll: Configure l_val in init when required
Date:   Sun, 23 Jul 2023 16:06:49 +0200
Message-Id: <20230723140712.9438-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723140712.9438-1-a39.skl@gmail.com>
References: <20230723140712.9438-1-a39.skl@gmail.com>
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

Add support for pre-configuring default frequency multiplier,
this appears to be required on some platforms like MSM8976.
Without configuring L_VAL device reboots when trying to bring PLL up.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 4 ++++
 drivers/clk/qcom/clk-hfpll.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index 86f728dc69e5..a93b1493c882 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -44,6 +44,10 @@ static void __clk_hfpll_init_once(struct clk_hw *hw)
 		regmap_write(regmap, hd->user_reg, regval);
 	}
 
+	/* Write L_VAL from conf if it exist */
+	if (hd->l_val)
+		regmap_write(regmap, hd->l_reg, hd->l_val);
+
 	if (hd->droop_reg)
 		regmap_write(regmap, hd->droop_reg, hd->droop_val);
 
diff --git a/drivers/clk/qcom/clk-hfpll.h b/drivers/clk/qcom/clk-hfpll.h
index 2a57b2fb2f2f..27b9effcb3fd 100644
--- a/drivers/clk/qcom/clk-hfpll.h
+++ b/drivers/clk/qcom/clk-hfpll.h
@@ -18,6 +18,7 @@ struct hfpll_data {
 	u32 status_reg;
 	u8  lock_bit;
 
+	u32 l_val;
 	u32 droop_val;
 	u32 config_val;
 	u32 user_val;
-- 
2.41.0

