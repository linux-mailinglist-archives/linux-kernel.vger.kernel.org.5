Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB3779F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbjHLL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjHLL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:27:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E126E10E4;
        Sat, 12 Aug 2023 04:27:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so4214968e87.3;
        Sat, 12 Aug 2023 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691839630; x=1692444430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSflrOPWbQDLwB1emYA5yoJ0n0sp2w9jvzs5T1YlFPQ=;
        b=ibpP2nY80Mj8Fs5HldBjw2e4+YbIgy4wq4kIOkM+Z7B82b/WW4vQLUQsZMLUvR5AyB
         GY9CfK2hK4QeMK4I5A8W2WVCBLSgc5YlHSJhYwiYGNZyVUA4MJvNViKjIjc8K7iws/Wl
         JB2NhM0x3hRTLmCs/N92Z0gQ8T9IBlGyvF51ZeoL33RfUAIlyi1QIztbEFVsrWDEA6lP
         knnIxdwS2+JV+pCFdm26onOVlaYdnY5oPb2WztzKvzgzca5xqHZ/vZvlIzbufsxKUEG0
         moJV4l1tvUNOQ2XbdHr1kTQQr/CTU2646mIoSttux9Ebp4PLWK2Qo9LYbgipOqMqp/9V
         uOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691839630; x=1692444430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSflrOPWbQDLwB1emYA5yoJ0n0sp2w9jvzs5T1YlFPQ=;
        b=ibH77IfIDlclyA4w+nQfkxWPzSj33Gnk+Irw8UoC7u/brbJliW9kqMRU5ApXYO1EyZ
         RHUzupe10BH80QVB/FSSxyH/mgHb0mvbtxGUnO8wY88ixx0azasPZjDY4awKSCsxGVYU
         eN/hm0D+7EucYOyk9dlCS+VLeHsqjTcqw6BjU8tYS4cXaTH1WYD9zgz4qvtMvo7s8ZjT
         fQtgVq5BgESQ8oSDATcnCkkwOb1VY7tK6ZrZMroGzeaFJjon0Gt+wyMkvIGFn/jVi8/t
         5694uGg50zZYgfn3oP56CaQ91LZQgUZmrXAwXr2gH89TvebK6BKJXcKKMhwKn/q0YQXy
         sKLg==
X-Gm-Message-State: AOJu0Yy0kAQO3kgYzWn+rK29M4gzlDnotUTLTt6YCxdewDBC8onZgilJ
        S/48vbR1fTR1I7VQprw2k24b7XSdbXb1ng==
X-Google-Smtp-Source: AGHT+IH5w7/g9Ql+h8mmo6R8jOGUlk0TY+KU1oxp0GrTSv2IVZwPo1cTh/dV8ZuXM/w2i5FlVolHMg==
X-Received: by 2002:ac2:4343:0:b0:4fe:f2e:6cfd with SMTP id o3-20020ac24343000000b004fe0f2e6cfdmr2850849lfl.62.1691839630075;
        Sat, 12 Aug 2023 04:27:10 -0700 (PDT)
Received: from localhost.localdomain (bzd150.neoplus.adsl.tpnet.pl. [83.30.49.150])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe2f085d5csm1087289lfl.299.2023.08.12.04.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 04:27:09 -0700 (PDT)
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
Subject: [PATCH v3 3/7] clk: qcom: hfpll: Allow matching pdata
Date:   Sat, 12 Aug 2023 13:24:46 +0200
Message-Id: <20230812112534.8610-4-a39.skl@gmail.com>
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

HFPLL driver can be used to drive PLLs also on different SoCs like MSM8976
On MSM8976 each PLL gets it own different configuration,
add matching pdata to driver to support multiple configurations.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/hfpll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index f4d78003d189..47325eb17f07 100644
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
+	{ .compatible = "qcom,hfpll", .data = &hdata },
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

