Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0827475E45E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGWTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGWTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373BC1AB;
        Sun, 23 Jul 2023 12:08:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso34760525e9.1;
        Sun, 23 Jul 2023 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139283; x=1690744083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/M3a5j0snkGJL94r6ZU30PY9Mxj+amzifbo89H9YGU=;
        b=A2Hl2v1RIFNqEmPsL6eP7KVgZ8lOPJIAiUb65nx6ZiE7dQhdCi+3vbUtmdjIeGNNhy
         AagM9GcvRCQNS3Ks0gkQVNUSXY+ICRxyxKnb6P3AGZ2xX3AR7qxeiIFDg8eXKl9HkwF+
         izeO6QVw2PHRIiZGB23BHOTh8U6HtvnX1yv7wxTTHooD1BRJr+ONgaK9tg4rIMSko2/F
         vs3fdwl3gOml9ZzorckB9DqtiTJEwKcnif//K0l/FqtzNRllypuQKUZh8vB77Xg2/bpx
         /UvUxwWXi42ZCBqpv1O/fiLjCqlz5l/JZshCJ23ugCAePU2AesVs061BJv1DKLMVj+7W
         jsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139283; x=1690744083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/M3a5j0snkGJL94r6ZU30PY9Mxj+amzifbo89H9YGU=;
        b=ZYvDm3/AMDyOWelJIk/9As8iwiqB65wUdmxRw2LxX69j4c1K1gYB3KSTiI7j+gBs9y
         vR8kBo0ZM4Fvccn9OW0YJHpBTJdgaSvuBspGxAsU87XZgeue6pAgGAMdXlIxE94AB70s
         r7Os33s2pgswSMFYkhOBJfKqoVTEKTt8nazkin+w7eSX3S3s4zWFT+YT289q3y0Jc7dI
         OkoD3hrOH2A0hwbLeE+SlmtMAjylkcqeIF9HAqcO717Kcd0MTUEMqUdFci09jRbhITLA
         C5uG/1wu9HUkUZRgZZIO19JfSCY44K4hS+tBzlnapfZLs601rSp9EQbwWiWDMMO5VJzC
         w3OQ==
X-Gm-Message-State: ABy/qLb4tLM1QEmuvQdvsPNjmvfk8/yqcUz82LCCrv1EvT6r9q6XSMjr
        FB7XpsT3jkzUwayVWfp1oac=
X-Google-Smtp-Source: APBJJlG2PqlVybd3mlg7npTuOjVqFav7S8bfyz92itrYO+/3YER2rSvJ0v5l9ISmBDpDPSjF4f3zXg==
X-Received: by 2002:a05:600c:c3:b0:3fb:b67b:7f15 with SMTP id u3-20020a05600c00c300b003fbb67b7f15mr5961513wmm.21.1690139282393;
        Sun, 23 Jul 2023 12:08:02 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:02 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v4 1/7] clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
Date:   Sun, 23 Jul 2023 21:05:02 +0200
Message-ID: <20230723190725.1619193-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error.

Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: David Wronek <davidwronek@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index ede83c644716..a3406aadbd17 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -651,6 +651,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.41.0

