Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466237FA62A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjK0QU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjK0QUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:20:21 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B81AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:20 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso54851481fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102019; x=1701706819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWgyzigPoAR+4Ex1d/u4hf1QcdRIIjXWN2uqL4LI7/Q=;
        b=sXgLgt0Tt2utyLG259t5GhGEzPL7cbmpSLdnHckF33cweMUA365Q/KTFlu4GcT2QWs
         /F7A9Gq40E5+BIYKf4fgdFyNmziWi8vcSmOIhGU/LE9/bJuQgL2X5J1F/L1POTN6sRc4
         qGHizMMqRDFHMTFNZsYUAb229OrCAp9LGDGC4fHv64Gv26EaFAlHxWTVoIFnaBt0eV/7
         bLOK1mBrR/UlRXn8SZFC4ofj/jxrPEH+ilU1NOkyoJPjlC8UA1kCPeyp/BTQa44ZsvLV
         K3Y8FaAMM3jMrexCYPGA7fiwSwUhSGIVyxylx88zT5h6Z9W4BM3ST7PRYT60jHympZ2+
         ka0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102019; x=1701706819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWgyzigPoAR+4Ex1d/u4hf1QcdRIIjXWN2uqL4LI7/Q=;
        b=luwYVwgjYBU2uswFJKHlmsLWnrpO6mF9qY6eNPx8WerM3lw8AKPwbaz4iVHr1SaNdk
         q+5TbpTgwI44smbt6VtdDND/EFXjAUzdEk0rv21KxEHb72Jm9HoK1d45OtGHMPoHj0sm
         BRxlHZ3X69TZEZUreizRN2T5F9gIUIjE4TyVzU5gF2uEj4HF5lwk3vmCxa88ycs/K53v
         YEub5Z30i7QyVQslgIxrJTl4TYc+6gW097sYBgFN57HnvPYWYQE20EKRMRjw+UZD9S1y
         RvxrW+Qvizfb2xtVXOA7rhJjgZ3lmJYhKZpEUTUduuC/vkoInszMuRY8dTGjVCCkh2aJ
         Tw0g==
X-Gm-Message-State: AOJu0YyiMa1VyepLcC9QpFiNLYG2FBDqSiYZA7JaP9+REsdDwas2urLh
        uWullrllZ29kse5xD8NKEm5CFsU64qou2zZehuA=
X-Google-Smtp-Source: AGHT+IGw6vE+zL9Gh3AlVvTWxBmVd6/TxfPV1VqdSfmuraUROfoqa4jJjxDQMuwiJbHnGCOXV3K0hw==
X-Received: by 2002:a05:6512:10c6:b0:50b:b504:996e with SMTP id k6-20020a05651210c600b0050bb504996emr1650818lfg.31.1701102018884;
        Mon, 27 Nov 2023 08:20:18 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 27 Nov 2023 17:20:06 +0100
Subject: [PATCH 4/6] arm64: dts: qcom: sm8550-qrd: Enable the A740 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-4-a228b8122ebf@linaro.org>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=737;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WLJjkmxb1cqo6pbyXNVnfs/XlxQsP2z9isMMjjm728Q=;
 b=wL/heSXr/KYsRGVKMJh1kN+9cq9XComDpTkZuwSoUDRT8ZsOM9auMBIyT/xns5wFL6PAzP39X
 1A+nIrskDvcDYWvIhBLe1YI+d5KvvBVn0Q2oWYv8VOh9s/r5sTCzt4o
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

Enable the GPU and provide a path for the ZAP blob.

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

