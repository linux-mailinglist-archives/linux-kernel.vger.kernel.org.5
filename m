Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA30C77902E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjHKNEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjHKNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428D270F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so3159352e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759065; x=1692363865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFW+0OVLDHSVoFKDpvHGp2u8ggdig13FIJDbYeyWCAw=;
        b=oFAoSUWdWKRqRVDG6m6My9JjVNPWAM1yKUAP4rjkGEqynFG3e4F8YsG3j6cGIlF0ie
         y/EqbDoLTC9+7HnVV+xfdmtplBVD54ny02tnEGQeOuOvuKTbIPSDJYHoL8kyIyCnA6Yg
         b9lR2YOg1CjLdn0kqg1odvRIrAXONU8qgJpjiVWajnqBLJCKhnGcDL/5srodHzN8vY/I
         KgO6tfXgZdYgazW7I+zEq7KPqwo9cpPVWyiIkGSf5y7QQVaP5LOBS9MsbuTOlmjzHYgA
         +q8JwaFCYeU954RqCB+n29hrj6ODypFT9Q/8N06hiUa0YDctPeChpqgdt+c9m5kxVOXk
         w2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759065; x=1692363865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFW+0OVLDHSVoFKDpvHGp2u8ggdig13FIJDbYeyWCAw=;
        b=cd5AqhgF8Fn3oFIsuY9B3+zZOBzu9tZ+mVfPaQi3NxNtRhL7LCzOpZ2MwFjVJcUndV
         UIO/AHN5kOj2dg4f22PyiqioZISQtfD6HL1K5HgVNyRUug/2s4qd8v7N6GiGjgK0hegQ
         XM3i6+IMH6fTs6Q2dHv/xOrLm2UHgmuLvUe3unD4PwI20RL22WtKQpvj3sRMFxGrAw+2
         byORibn7pe9vQn+P2p0Kis/6IECyzHIbThZzD6g+Ggm30+4YcRBy0iMtjEYv++i6sHQD
         nj3fG3/orqPCXjM6YiD0FPym6Jg5n2wL02qsrI2q6plkap6Vu+qpOb3qSXF6hO0F79Qg
         5D+Q==
X-Gm-Message-State: AOJu0Ywckk6CJie+UEAPxFw6Xju7cgPTahqeP6y05gIz4ZiotFvIUqZD
        wiwK/uy44wOThKXWM+Bgu81uaUzqpqSYESka+RY=
X-Google-Smtp-Source: AGHT+IFwo4O4lKQxY7pGeWHPQ85hqbEYFgiCNRFPs6kyN+AYmZPXhJ5uc6oHD6R3VTAe10/7lOcQWQ==
X-Received: by 2002:a05:6512:2249:b0:4fb:8eec:ce49 with SMTP id i9-20020a056512224900b004fb8eecce49mr1646216lfu.31.1691759065369;
        Fri, 11 Aug 2023 06:04:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:13 +0200
Subject: [PATCH 06/11] interconnect: qcom: sdm670: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-6-a85b6e94f46d@linaro.org>
References: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
In-Reply-To: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=737;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3zOoF/qKKvzghOrtw+/fLDqCujsJyyG9J9gptHZsib0=;
 b=fTwVQ+CqPCYKgblnZGu2p+/e+uPdd6oj5Xk1ltBBF4uNWXTfDUv867aaB04i9L7cKTRL2WluU
 LTAoeWsAimfCPlaYnsBVu5Q+l/Puyvn6PAsxw9uhL4R90+7Kvm/ug0B
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
index 540a2108b77c..af2801c38854 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -1047,6 +1047,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

