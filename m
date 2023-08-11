Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27869779B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjHKXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjHKXUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:20:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0715E73
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe4762173bso4045291e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796050; x=1692400850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz6R0a2lDWgownlpflckA3+OeKw2fDdHaI0SCf0yt7A=;
        b=Ivn2Ql+gAKUDsNpbBUixamgvMM3ZmKLiLTK9QIaHJ9GY+X6dAgQEJ8QPID7BD+EU9W
         M+00l6G/K+7NWDq7Ae8cuZwdGRSNPTpBMSTnJJ9ZrF4QwPEbmP8uZaOy8y+akLi7zl7q
         J7FFQCQntpxE+nm8WRK1IEzdqYRTEf3rDR3Yjtomp6ZMZOM4BZHhJZ9bWtA8gLaUWq7j
         ZTq8mf39vlwl5PL3xy0FDpi95boxH2PQcCGb17hkLmymV2b2e+1FuQN8cJctlTTi82f5
         Tk425blHtT3/7yWvCyeqyOCFj3cfFBbkZp4j52afKmFW/ZTAGX3YYLCPkzp/Q60dCvgn
         F5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796050; x=1692400850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz6R0a2lDWgownlpflckA3+OeKw2fDdHaI0SCf0yt7A=;
        b=eprSdkdqX0dHnZgrz5kS86oTqPfLdMBhvf5hspC7p0rfcYA2oZtOu9Tu2L16heSsWF
         m8V5r7PHE5nG6JRU12rmR9X9ULP7U/OkRp6Lq20Z9Z4xlbRiD1NjFGVfYzTGdYWL8fdx
         YjMGNgfMaUWUm7Kl5UOiUbVZ28FRnKryZt+2aWBBZNjwmRJv+6aLEokKB37LjEOf5LyB
         hj9sIphJG12W6yu2KB17KaZX4T/+ZYxhr0/OllkWYdvDyNJBxME4VANs2SDjfCWzY0CK
         CQ5e1CVy2o6tBZ1Ya32sjI3HxgxKh2+qEFP3G6iQyCCm+SJX4mAC5Y6hhdFa28qiqfQL
         bNWg==
X-Gm-Message-State: AOJu0YyiNACu/iK7NNuUr1Fv1dWYSEVLtysB3oiToSboH0hmUNmhXkZu
        EBXbWb+H+4jfKjvSAnhDGgBB+A==
X-Google-Smtp-Source: AGHT+IFI2V0FzzMJZScLp6RFJYVvQYRffGx82vXI1TVqYSyOjmx9Zrhyz3fSCY2mYxEL4tLxqMST8Q==
X-Received: by 2002:a2e:9cd8:0:b0:2b9:e53f:e201 with SMTP id g24-20020a2e9cd8000000b002b9e53fe201mr2580611ljj.31.1691796050234;
        Fri, 11 Aug 2023 16:20:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:44 +0200
Subject: [PATCH v2 01/11] interconnect: qcom: qdu1000: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-1-765ad70e539a@linaro.org>
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
 bh=eAYIAGKGkyPgXqB6Szfdp1AcvaqJfI9568TWcLfILiU=;
 b=obg4LadaGTfUwgN07bevr7gtSMgt5nvJ0SohwpWwR9GzL6KNCTBwBq+U+4P6dldgzvB7vl4LO
 UoerQT3/5fuCWe04QDxWk3HdsfLnW5RvSUKkhwVOU4B+haucm773nuv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 1f51339f7dd0 ("interconnect: qcom: Add QDU1000/QRU1000 interconnect driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qdu1000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index bf800dd7d4ba..a7392eb73d4a 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -769,6 +769,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };

-- 
2.41.0

