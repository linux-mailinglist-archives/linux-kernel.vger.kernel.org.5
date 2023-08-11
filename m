Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7799B779B47
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjHKXVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjHKXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:21:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A51BF7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe45da0a89so4169689e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796058; x=1692400858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5axgJbJiNP+7Xev6gzugs4dDF4Yhl5tmymsOp40gv8=;
        b=MxtJGo0go49VzPI76lj2hcZ1a9surzSrw0yv3Gr+zk31j6euSNM8EeLCAzQIwfmGnm
         UZj+SpHs1WZQKqN5xtNwPQ3MnIjYNyJvPw+lKDtNYCZWvLukl7WaaarZPu/taYdhY69O
         2VDatN3ZaeJLNnmRjZP5huESCdrQAlVuSmsFuAhqfmnyhS61fhG48fSBeFUBl07dT38H
         kggeacQSLs/SII+M4tDcCmajTINfBTnt7S2jqbHWP/p+5eri3+MIgMdpd6gxAg9sdiIt
         J0ynuxFLgnI8G2s9NQW9g3q2+5BytvnSE+hlZlT/aI5/ZyMDbAm1TuAoL6K8JFqtkTNR
         sZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796058; x=1692400858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5axgJbJiNP+7Xev6gzugs4dDF4Yhl5tmymsOp40gv8=;
        b=AAZ91Fu57eS1QtUzgq2kv5lS/KeiG/py0rkddzBNaz/qA2m0MeUZk4mkWIL9pG18Xx
         4rqUiNFuYvYBfzmH2DBQsWwli9lpWjwdd7q1wDRyfVCtYgPMjFvpj7NrDisEerHA91ou
         SRAbnrpNpMggoiho4ztFQ5Xy1NQ8Ep9vZYmBMR8c+r/GlDtImW9VeKH4a6eiil7knzOJ
         mSc2baHOPL1FUDtWbN9RdTXa1pPoGi+6LViVYYD8EUm2peoj9KC7p8sqfEHKWFtK+2vo
         2mrPbR69KlYP8/W69Q8/JS0fwDgG7PqaPBT9DIYyWwjGqSnbj6q+eCGqRI8djTBfSQ5N
         Od+Q==
X-Gm-Message-State: AOJu0YzA2+gHG7hOT3lls0ZYJOIIesbUbHbRmFk/cWevn14C/Sm473we
        JMWteBF7ca1/3GaXViyZ/QVoWA==
X-Google-Smtp-Source: AGHT+IHTQgNT/nCI34Y8J0idGr5UwAWbexqNlfPNZTdGDytuMBDTK16++kJQnGms3bKv2NfxYxzCAQ==
X-Received: by 2002:a05:6512:220d:b0:4fd:fac4:2137 with SMTP id h13-20020a056512220d00b004fdfac42137mr2166954lfu.30.1691796057928;
        Fri, 11 Aug 2023 16:20:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:49 +0200
Subject: [PATCH v2 06/11] interconnect: qcom: sdm670: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-6-765ad70e539a@linaro.org>
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=731;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Rcq8x2fW5JGS3wAsW3cAumgdnqmJ9mRXwqTZhVWkyoQ=;
 b=FNTuwtvtnVql3Jw1mg73iwbvFJjd/CRxj5Fu43kXo9o1BM9bAWfRGTh+xLYwgTUyTM4O/5iux
 elAmQhIq5LZDG/PN3KSZtYZA7d7CN6+2zLRCzha+ky6SmxNbjPMjs/J
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

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 7e438e18874e ("interconnect: qcom: add sdm670 interconnects")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index 540a2108b77c..907e1ff4ff81 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -1047,6 +1047,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

