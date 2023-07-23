Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6524175E25F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGWOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGWOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:07:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5412B;
        Sun, 23 Jul 2023 07:07:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fdea55743eso1748981e87.2;
        Sun, 23 Jul 2023 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690121256; x=1690726056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbzLqkw+cLCwQqgo454Wn6uAOpeUYqFhQ3CvlGtdRfI=;
        b=RA+BP8ET9n0oq8n+eMJGNDFwFhweaRrkyVtbu7I+MAACqWoveNCnYyOnyLAa6XympY
         +I2w+kHX8+19giIOxvuFNIs1SY8z886YnghAUpWDesYI4ECWDQ2WNHuN8nSGv/+KQ18I
         PHo81XFWWL3EqDQ+BAt/DzHMzcQHUQ8nWcaj/iKNCASctrJknGpwSJ5/r3YPtcM3Lynp
         sgaXb5b6Ee/MyrDtjrXnihmmAIY6jg9eHnWNV+rPvNTrQ5QE6dqgOt2E4ok5hKlZiB5/
         cjT1BMOLI/gkMLyizaXtiXYLjnZEJRmgYh9Ie7drmBReXvRCeCYgju9g8Dei4YnL4/h3
         XC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121256; x=1690726056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbzLqkw+cLCwQqgo454Wn6uAOpeUYqFhQ3CvlGtdRfI=;
        b=UbGUhn4KQpKEkxMZzDmSH19fnu1LyMdXsFOwCukCqcRyMpb8necOX9xgQE0o6FA+PQ
         mqGaukmLPjvl5WCDHsHbaPS/qXGQqJdagylzXQmor9yrOfcSGoZz3/1e/vxTx8kortwu
         qG4gCXXJ4rRPxILjFEg51dEei4y761qbkQMMQLlD4N1oxPDcRtiONHKep+DPt3fmCEcx
         rKSQZruPGkHksLxmc18mttPaPSw4g5OWqmVHW5lZx/s5ZNFVMUloUVZZFgEjuC9mws7b
         n2hxJCaLq1QWQiOZvOnmTIHN+B8WiSrExP83BrsStgMkSLlvLB51VBW3bEj7rrL7eYMZ
         4yrQ==
X-Gm-Message-State: ABy/qLZ2npHu2Ie1Tk5iAIvvrL4BhqtGknmXZGfNaF3eSeYWimnqo5eq
        34YWeqRdKTfG+vk61wo4XfPfQpzmA6nx5g==
X-Google-Smtp-Source: APBJJlHUOgtrmkrrr4RExMg3FG+ubiSOTIz4+VQiejicK1zkHbYULwp1ymsS+m21GY6e1utQeb8lRg==
X-Received: by 2002:ac2:4846:0:b0:4fb:7cea:882a with SMTP id 6-20020ac24846000000b004fb7cea882amr3234673lfy.3.1690121256287;
        Sun, 23 Jul 2023 07:07:36 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id o2-20020a05651238a200b004fbcd542888sm1688366lft.60.2023.07.23.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:07:36 -0700 (PDT)
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
Subject: [PATCH 3/7] clk: qcom: hfpll: Allow matching pdata
Date:   Sun, 23 Jul 2023 16:06:50 +0200
Message-Id: <20230723140712.9438-4-a39.skl@gmail.com>
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

HFPLL driver can be used to drive PLLs also on different SoCs like MSM8976
On MSM8976 each PLL gets it own different configuration,
add matching pdata to driver to support multiple configurations.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/hfpll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index f4d78003d189..ec18bc8f0089 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
@@ -32,7 +33,7 @@ static const struct hfpll_data hdata = {
 };
 
 static const struct of_device_id qcom_hfpll_match_table[] = {
-	{ .compatible = "qcom,hfpll" },
+	{ .compatible = "qcom,hfpll", &hdata },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_hfpll_match_table);
@@ -83,7 +84,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 
 	init.parent_data = &pdata;
 
-	h->d = &hdata;
+	h->d = of_device_get_match_data(&pdev->dev);
 	h->clkr.hw.init = &init;
 	spin_lock_init(&h->lock);
 
-- 
2.41.0

