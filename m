Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9D77449D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjHHSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjHHSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:24:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE32272E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:36:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdf08860dso19391166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691516179; x=1692120979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5cHR9R1zj6+fWN0kfJbhPUfhYqf7kqDHOcaH9ExP6c=;
        b=Nfnx+IZdw+3GEAy2sWkFszWMwvtpQ6WQBQHLJpV6spV/Y6cuMajuTxkjjV25HwD4pI
         gJI1Of/bQtLVJAThNsG1mBHxxg6FMJgvnFP9LLun9aL4WaxrOMRNDDO/jTnCI6nOZEOT
         FWLBbqMC7fHqYRBqFNEAknxme92YwghhA9doS72Ft81uFZaaZxG3TQyaZEm6etEfpQtw
         gdwqqWiyFKvBOie/BWJAAQ4wFiHijUAhlyEcM/Tr6MEqRgS+n8vjcpjzGBppo2xxg9Be
         8aDsN1O1cLMOoPjmCm2oeaHeQFK17vny6/7zkXz2wj7WVF0yjC7juZFpKxP4aia4gl7l
         K2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516179; x=1692120979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5cHR9R1zj6+fWN0kfJbhPUfhYqf7kqDHOcaH9ExP6c=;
        b=ag+JURN4sKl6plaq9G16xGoZG8u4nG2kN5Uo0BpmIHpTw2YgCnGmNzHpnud5v+0q9K
         sc1f0Ir8fIrptx6nNoVdKyefxqQN5fq4JA+RqPhbZc/ZwvKC1/oZz0Pt5RB0Y7LkuwwP
         lY6pTWHCm1fn5SRgOCi+2XHUCqT1/bsKW6ylYJ2n4Gc+r+ZivNrHOdWIqWEHSRZVn8RI
         G6JlWwXQPwn4Vqfyoj4OSdYRt6BQfuCLATXKdLKOdaruRw2kdqaqr6iiNqmHGNuFaJvJ
         EqJ27sxcdBReFJk3Rlbp4dNPmue0eJvQ1JNkjrFGKQC09chEfdNAVI8LlLeeLulA9Mts
         KHkQ==
X-Gm-Message-State: AOJu0Yzoib/bmXMol5JLHlWA0t9VdpLEtEJKtywXqRaahqj/Iz0vdyoU
        YPVLOxeSg0M7k9pt2MyELGm/CFtrAvhqiH6Nprw=
X-Google-Smtp-Source: AGHT+IFa8hs7gdLp6TteRabPqqDMtp2xucJzNgO9gR2weT3XgRWhGg1PX/JaOpY6/dejTFD0ACc/DA==
X-Received: by 2002:a05:6512:32a4:b0:4fb:fdf1:8b25 with SMTP id q4-20020a05651232a400b004fbfdf18b25mr3031231lfe.24.1691495025312;
        Tue, 08 Aug 2023 04:43:45 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 13:43:39 +0200
Subject: [PATCH v3 08/10] interconnect: qcom: sdm660: Set AB/IB
 coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v3-8-dee684d6cdd2@linaro.org>
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=1519;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EjLG3n/q4YI8bbEqplfHVOwV0syrmI4lAF1qcHGTJvw=;
 b=EnNVF/Cr9uzLzEU4BBg3kNfteX8HGav2OxqYe3b702ezBcqQnBiKJXPeKjEEqpkCP0IXg0ZPZ
 0Il6GgQVQ25CyjPK0/MyGHqxPxzBT36JDWPV8X6rvNGRMAfLmNFuhLu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses and nodes need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 36962f7bd7bb..7392bebba334 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -602,6 +602,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.name = "mas_mdp_p0",
 	.id = SDM660_MASTER_MDP_P0,
 	.buswidth = 16,
+	.ib_coeff = 50,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -621,6 +622,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.name = "mas_mdp_p1",
 	.id = SDM660_MASTER_MDP_P1,
 	.buswidth = 16,
+	.ib_coeff = 50,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -1540,6 +1542,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const sdm660_cnoc_nodes[] = {
@@ -1659,6 +1662,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const sdm660_snoc_nodes[] = {

-- 
2.41.0

