Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D757693C5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGaKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGaKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:54:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72C11B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso2384571e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800761; x=1691405561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FqN2Sq9j6IVseScqHZxUGnTrukPTjl33EKA90GBaFU=;
        b=bIrsaeqmGxlLHJQ0qOj5thnWh7zkl2dgFLCF8lFlwZ34b1X/yhR8D/u9QWyzrb8S3N
         IOK/gCX0sIaVtyqF+zEd5Nc3SW7JROdzAdJ8hKNTr2Uf2EC1lUNgOkfVa16IyNalNh9F
         iGJy5kdzbePOlpc5as9fcI+YGhsbZQ1cn7tSpej9zTYMM7fLNoVsPI51st+5RCVBY7NW
         Mdb0xjCeHsNgvhcoD8uWEwR+/KL45a+Luo5/g2WsSAbEATFPeyQFXofVwXxZwkQEqS9q
         yiGs/8Qh1u/8czrD3jWU3hdAB+Ad3Q1I3nHYanSivn+nBeOIHaPj0hMNvIc8Qu2J3BQ8
         Qj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800761; x=1691405561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FqN2Sq9j6IVseScqHZxUGnTrukPTjl33EKA90GBaFU=;
        b=JBjuE2ElZeZ/JcBb2oV32HubxC8mvM8ZA5nbwYLcPsjcloHw0elVqn0og8nS26SbbE
         VdU32j4ZNcmTl7XeUp9nrIcRTVgI8iu4y/dwG/GqU13K/kPJFVaUM0awPpWp85ItfRuZ
         KRkkv+/LqixIrGrfumzla1E6E8BCB0t8kmtSFzsbYscxRWI2j+g2/V5qTFRa92FtQYKG
         JWDaEbprcikMRCIz0XgQM6CLNSMUzdQ4ICktMVBTYyS9JJiGuHMfu17WP0kNVpUzatrx
         AbVmCrJPVVCrOu4SA8Pa6KOn0RH5VouWuzPy9pu/7voh3RVPcFR6AfIBiYaV/apmj2Lk
         CfaQ==
X-Gm-Message-State: ABy/qLZfvUhhvUfi+KFJFwdsLaCVXrTixgVMX8Qus5U1K8DDnF+bLWsC
        i5G3LmmpXIw/QhnBpQVo5qSoiA==
X-Google-Smtp-Source: APBJJlGNqAck40ArIkEfVSurVlBTz5pEiR+I3OLQCGw83YhsJ2u0FJ0aLXbUjHuQoEFeA8Gu73OnqA==
X-Received: by 2002:ac2:5e71:0:b0:4f9:5196:5ed0 with SMTP id a17-20020ac25e71000000b004f951965ed0mr5305098lfr.7.1690800761484;
        Mon, 31 Jul 2023 03:52:41 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:23 +0200
Subject: [PATCH v2 07/10] interconnect: qcom: qcm2290: Update EBI channel
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-7-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=1320;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+JCeGo0Q7sjfDzWjkGg+7ykqgtb42uWuVVMLb5STXRI=;
 b=FT8g2Z24YTH9ram1lAQ32U39iPRNChujTfSUnblLa4qA+wh81N2TAJaP2r/aWuA9PD/KCdEiJ
 T8J8APb5P+4Dvy+3uIPMG2KkXDCUOcZ2fveFpGXZFrLl7vhTtADavQd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCM2290 can support two memory configurations: single-channel, 32-bit
wide LPDDR3 @ up to 933MHz (bus clock) or dual-channel, 16-bit wide
LPDDR4X @ up to 1804 MHz. The interconnect driver in its current form
seems to gravitate towards the first one, however there are no LPDDR3-
equipped boards upstream and we still don't have a great way to discern
the DDR generations on the kernel side.

To make DDR scaling possible on the only currently-supported 2290
board, stick with the LPDDR4X config by default. The side effect on any
potential LPDDR3 board would be that the requested bus clock rate is
too high (but still capped to the firmware-configured FMAX).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 42fa01c66e73..3bd7ad67c569 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -678,7 +678,8 @@ static struct qcom_icc_node mas_gfx3d = {
 static struct qcom_icc_node slv_ebi1 = {
 	.name = "slv_ebi1",
 	.id = QCM2290_SLAVE_EBI1,
-	.buswidth = 8,
+	.buswidth = 4,
+	.channels = 2,
 	.mas_rpm_id = -1,
 	.slv_rpm_id = 0,
 };

-- 
2.41.0

