Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8784280341A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjLDNMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjLDMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:55:41 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE9113
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:55:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1a0bc1e415so362913066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694544; x=1702299344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QF1YIXWEgPxBBuUeInrydPVHlwVtxwvmFaOgA3MM5Cg=;
        b=Lif6SYGrAzi9cM1Bgc9FyBptt9DwOw/R/pq+LCDTzybitf+k8pNa74XyMq8cKiLaym
         jsCxr4QJFEUzWQKm1XezNyPp5Ad42VEmqvwZvGtAXcd/KR7Chl5X2D9peSRAonISBUr4
         5vcE/7CRtwKUahQ5y+FiQvHfHkP3W/XZ6+YHTkHTxYp4tqZCzrN9nwVTfSh2RS6PP0ag
         77TQoloUHInbEPVegpcH6YFa/7IEnQcGI3B6qkcecUjBwMCVI2fvuyygrp/KV/EmGUi3
         /TvV2gau7Hb9tSQbvVc5vcFRoQgZxNJwhWIjG795C8C836ComV4PZh8vgdlxx3ftyhra
         FkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694544; x=1702299344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF1YIXWEgPxBBuUeInrydPVHlwVtxwvmFaOgA3MM5Cg=;
        b=Gs1QPHa6SWuULB4uaRZiwKDojQOS4mTwER6S22DkEmWaH2Z9ZuvYKVBGZI7VZdPMbd
         UkYOYkxSKoiMtq7tQSPOVtQAkEdqHJRM7vxcdWUkjWLKfyoeuBIRrpQzqTEN/G4Epy7P
         j9g0x8Z/pqdxG2w/BxW9cmhS+mFQ5ionSDxBKlmPdp0UMn4X4G4aDtdiQn1vyZyI8cEb
         t4rpwZ+88Ph92p+gb6rpiG9y2EbsWePF97jFo/qA/yH+VAZPl9h+oR6dixIUW3mr8J6c
         il8Zsl7p5lUpCxaIxTOU2JHJuzyPGow1uhXW9YnYxaikP1fuWxmQcKDW8LHnXVCWV3c2
         x2XQ==
X-Gm-Message-State: AOJu0Yx7Gunma9khnf/jWU9jfuFCIyZTcqWSbBkoHMHsJcfPqBsVHfDC
        3YlfqFJtkD1iHuVBIIPSGexY0Q==
X-Google-Smtp-Source: AGHT+IFeIYz1iO3KsYQ3qcBtBpS+Vd4YXm0h7XwncIOh9jeVwFbwFlOur3jXmcXfiTKrzIuS0d+soA==
X-Received: by 2002:a17:906:748c:b0:a1a:4813:e833 with SMTP id e12-20020a170906748c00b00a1a4813e833mr3118246ejl.67.1701694544222;
        Mon, 04 Dec 2023 04:55:44 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 04 Dec 2023 13:55:23 +0100
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-4-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=794;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ijt3beGGSYLGoF3RtudvbmIRYSlskid0fUlPyla+S1o=;
 b=P8Y1u7ibWzTnMEQ9WLFkXk3Kn7plZq3rCoAPCAWZDO5x0/PeBqpACFWtPPlp84QwwtRGPBU0A
 7DzHQ4qB8fDA9YJfk7dZm7zWziRoe9UMMtcZqfPkUhEnKIhNS8b4onq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GPU and provide a path for the ZAP blob.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index eef811def39b..9fe51d308675 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -596,6 +596,14 @@ &gcc {
 		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm8550/a740_zap.mbn";
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio17";

-- 
2.43.0

