Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240B6788CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjHYPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343918AbjHYPiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9692680
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff88239785so1688531e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977915; x=1693582715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTsJupvOxpa/fLz2jUo4zGYaUoVq8SU+eirkqgzntY0=;
        b=JxKRFQr5rwgjz3y2OlZPJDLs3znQsFi3JjJ2VGH2LRvqthq0oSB1fTuE/dWZvQnp45
         3nvhJoqptG2xSfH92KEcvneRXMY2YmwShhJwW4zr3DEp8Tdkq0Q3chF1kPxxA2DkStrY
         lIXpQVf1ZjypJERrcU7plMnt6hlT6mtp9sdg2X2/O3DxMX756FShU1vRGSQKEVfCjyK8
         2akYLrJJgfy1xFh2f15j7M2BLm/ueSPxiZicUUKU/fCOjsjxo221Fu04mK6ThLA3tuvM
         zqMFolHG4LlY/jQFPqwcg//sf5oR6ywR+soy1d34CA2sd1O+U0XioY5EDvitei6h4Iqw
         WZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977915; x=1693582715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTsJupvOxpa/fLz2jUo4zGYaUoVq8SU+eirkqgzntY0=;
        b=Wod/bv6trE99l0XPEwOWu82NdWnPU2wmI6n7pu3vxDsFGw7kI3sSKRJ7Icb6ZYyRED
         8MGEAfc1GXGw3wDdR88cYuNhDhhHfNLahev5Jpev0srWgOcnrIgyz4EptkbBLOvkUEYq
         1tOsB6XzDd5EddfcxvPLX54Xibi7vhnM43IIta0UYx5+YXkinz7hFxC6dBqBkfoyjGIc
         W655aZ/tTsiMjVZ9+UvWVSJPn2alN4xbSQuQYM7k7gYjDUJiakT70cCj86bWi+EdD3tf
         nu+SLbEkc+hfig+xgRxhogtx/GZt2xlc70vaK+oHCPWK5q8t3tv7fkm2kXyntHGV4qEg
         Ysuw==
X-Gm-Message-State: AOJu0Yxs4W2PAIIaNM1rEPZ9TcpVn4Ai/W0nHEIoa/N+bNCj8vg56uaz
        cysaS2Xhvdc83H4Nn4Isg9NOxw==
X-Google-Smtp-Source: AGHT+IG+gm97orJLlW4xUxKCU9QvvOPMQ8WhucMASc4t7eCwYPa11tM1zcKrousEw5P/dQj6MXSLAw==
X-Received: by 2002:ac2:4e95:0:b0:500:7dcc:621 with SMTP id o21-20020ac24e95000000b005007dcc0621mr9931027lfr.31.1692977915744;
        Fri, 25 Aug 2023 08:38:35 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:35 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:30 +0200
Subject: [PATCH v4 08/10] interconnect: qcom: sdm660: Set AB/IB
 coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-8-c04b60caa467@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=1519;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=k/Cm9gmYXz5bp/vBXbZFWoKJc7XFdBGSN+LYtJyOew0=;
 b=Ii8HGcg6M0stWaaKslOhXJsc+X1cpC/nf/E53SdNuEDOoB50xUzQYYLhysV9fSLTzDrdo4eM+
 9uabXi/Xcp3D20BAK4H7hTV4T2mh8GCJJKnsQfy1kpQ9O8mryY+/16b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0

