Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731F175E374
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGWQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGWQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:10:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF1710C3;
        Sun, 23 Jul 2023 09:09:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9928abc11deso610254666b.1;
        Sun, 23 Jul 2023 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128566; x=1690733366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BAq+BvflNUovD5dCGAVp95A2FMW4EGnXenei4TqxpM=;
        b=F9YirHYibwKQRJ/fLH6boCpDDKcMrFRjJ+S67loArQM84l/YlfKptUoKi/lKCK555X
         tD65ffNO/M6UjtGarnXEr37ZXTs6YFMIBKRYzUpcoRpKXRuwBqwqShvY96G/bt3oDpJx
         T5wcC85U8zZYCJ7hqoVzb9wd2CzyrZupAxcUjviNM3CqGA6tWKwzSURyca1vl7ep9gmE
         NefZu3Wv34JcUiKQV6QUALc1JpO48ago1iV70xVmxaykZMGAxrPCI8mRHKE1N8bZ47Sd
         QXSf3C1M71u/kLUUF85qthi1aUA4dLmujTElVDdy5N+r22DKvLh3w4ThdicOEPPb52Wu
         hvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128566; x=1690733366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BAq+BvflNUovD5dCGAVp95A2FMW4EGnXenei4TqxpM=;
        b=P0+YsNRWegKRHTSgYN8jwE6g1obc36qOZ5y7C71cm5HUUaIt7G/AKXwCUutg6e/neC
         yNJRjAqO9ndcS8KkUHt4J5BNRl4NGAh4W2v8h9TNWXk5aNZ4Zc4pj5Vcxl12Qq/ly163
         CzTshPHREM8eIivQRFTSDW6PfFELnle7d9uZ1Zu2iN4k2Wsvi4uyzQkzVnVpUflSwerm
         PZi1U3Ik3RzKS7awylZt1XlWlhYF2WUNGBgi1wZt56YBOMEMC5aqvxrhOG3FJEjC+53j
         N6fspcTnXvC8IdueQeVkto1CPcDvdyNdIygOIR1bmsGsvvKOUhRRFmBK0VLpoO21I1zs
         2wAg==
X-Gm-Message-State: ABy/qLbyaumEitE9KdXwQmCt1KXs76hSUAic75ryOEhSfqnsRMKQeFe6
        rF0LlU08Uj16hNE9YNagKs0fQAtB95w=
X-Google-Smtp-Source: APBJJlH0Br/r3TdPtSz1DJYVwJV3flYxLwICHZw7L+YE75DppMrcvEJGODGCJT5UmZmZ0STQXyteiQ==
X-Received: by 2002:a17:907:7810:b0:993:f2b4:13c9 with SMTP id la16-20020a170907781000b00993f2b413c9mr8325480ejc.21.1690128566738;
        Sun, 23 Jul 2023 09:09:26 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:26 -0700 (PDT)
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
Subject: [PATCH v2 3/7] clk: qcom: hfpll: Allow matching pdata
Date:   Sun, 23 Jul 2023 18:08:22 +0200
Message-Id: <20230723160827.22660-4-a39.skl@gmail.com>
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
2.25.1

