Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83273763C64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjGZQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjGZQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:25:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B19269A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so10963155e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690388754; x=1690993554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kHqku5aNQeOxuldOBfASzBzbj6SzACN6ErkOb1f60g=;
        b=F8wR/OPNTELiTI/jFK2rOQwmDvyvhHjc5hVtNFt079Ia2Ih6YDf5QS7Ebngx3hQl60
         KUyDZzq9Qxn1ucRI5w4K9+V5FlxcsDAP7BT9QrUcMhVen9MUbyPguv7cuyZ3cjo6cAa8
         IyuWv8CVjVyBQ+eRYnd7NQWWu6Slok5QYjnelLrIEhyYCgx/x/DpC0+Bchz8Vn5bK5s9
         PLi42pGzq3Zz3PLimCJ7rj/72mcNllW687zNpxP8UAz0Y5KQUAKP37G+dihw00Csx0hy
         0zr7zkA65rZ47n6OcFbuiXvywvk4PgLBPOyJ0LnKd+viJfBS7lcQx3McGi+SGz2zmQm3
         86eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388754; x=1690993554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kHqku5aNQeOxuldOBfASzBzbj6SzACN6ErkOb1f60g=;
        b=JQdEQ69WeHKQeCPkFuAkhVX0z929TldHJzCh3AKyIefFMjbwKqLrXJmI1Bej6qmoBf
         xSLvtN9PbELtaVSZUUhWdOfUJSgXslHYkN/37jhdCilua8ywVOtz8Xcow/ZCuKEjX1Rl
         WAzhLchkYAuNiiOJXVYdS8W2sV95jlzRLFnlcubvIjFag7YxWa53r3UbMsHjE58U6+6/
         fPrFOhn+94Dom1gecop8AtdUVKieygIjAvSoj2flwhnKHlHKeJxQVeY2+40yJ3GFgpBP
         Mu5QCD/fzOCpWX0Svy+Ic0KE3B/+E2WBvPTvFozqdnlMiodrqAAZr+x25l6+APkibpDr
         dmHA==
X-Gm-Message-State: ABy/qLYNjON+DflEF2wtFkUYZianOVRa10S3bh1q/vmNJbL951N4NIGD
        MXhemxioYprONlGdX6kAz6Ph3g==
X-Google-Smtp-Source: APBJJlHuKggQDB2ovgqHgCPkyjHAAmZHbLpbQLy2mdBr4cT7QGRK/KXm70jTydFRJaOCkxHL/fj6GQ==
X-Received: by 2002:a05:6512:b97:b0:4fb:7b2a:78de with SMTP id b23-20020a0565120b9700b004fb7b2a78demr2629017lfv.45.1690388754550;
        Wed, 26 Jul 2023 09:25:54 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b004fba5c20ab1sm3336299lfs.167.2023.07.26.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:25:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 26 Jul 2023 18:25:46 +0200
Subject: [PATCH 4/4] interconnect: qcom: msm8996: Set AB/IB coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v1-4-31616960818c@linaro.org>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690388749; l=1692;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=I9w13v27Aktl2g4cGZ4p21IhyuK82Ydc8kkNnjHFsco=;
 b=WruiJaJP7hlv2UhaxaXdLLtdz+JP25qA4MCyDJxiNOx6zBdH09zVzQ6VBM2nr37TViPtC3vg3
 Q1OwksZty/gA+5z+Sb3szlLVKP17JoNNIxi8BVokl6gtwohvt/rZ245
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses and nodes need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 88683dfa468f..dec38cd42df4 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -448,6 +448,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.name = "mas_mdp_p0",
 	.id = MSM8996_MASTER_MDP_PORT0,
 	.buswidth = 32,
+	.ib_percent = 400,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -463,6 +464,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.name = "mas_mdp_p1",
 	.id = MSM8996_MASTER_MDP_PORT1,
 	.buswidth = 32,
+	.ib_percent = 400,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -1889,7 +1891,8 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.nodes = bimc_nodes,
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
-	.regmap_cfg = &msm8996_bimc_regmap_config
+	.regmap_cfg = &msm8996_bimc_regmap_config,
+	.ab_percent = 154,
 };
 
 static struct qcom_icc_node * const cnoc_nodes[] = {
@@ -2004,7 +2007,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
-	.regmap_cfg = &msm8996_mnoc_regmap_config
+	.regmap_cfg = &msm8996_mnoc_regmap_config,
+	.ab_percent = 154,
 };
 
 static struct qcom_icc_node * const pnoc_nodes[] = {

-- 
2.41.0

