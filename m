Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0567F12EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjKTMNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjKTMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:13:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B07E9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:13:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so6183090a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700482388; x=1701087188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4obJbFuX32a51CPgRwasEGqIWFeGs2SFetYjrfd9IY=;
        b=BR/P1bMiVUDoKw1BoecSGM4mIDLORYLlo7RbXSocFuXCQ1vmatjqkTtF6tc2iReXpT
         r5nkkdBIF3RwqdtcP1BGb4TlVMTgbdZT7mW/ttw47RtlAXI8lREjm7SYfWPPFCJPLbY0
         Hr5oiNlsR0aUcsWjfVE/ZjtOCHXkjef3gTGHf7wRF34m+pBtC+g2SVtAreugOqaoMIJq
         nRExJfiPRZUp5I3GjbyxlWV5MXaTPTklBRuRUCTFxKqGFkjStPTqgj2Kluq0pW80hK0b
         XHGCpzLqmv9OiIESmafW96cu8K3LWoLmDX7a48l9a1m00MEhNUAaoAwZ+gRcF8sls/x4
         xalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700482388; x=1701087188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4obJbFuX32a51CPgRwasEGqIWFeGs2SFetYjrfd9IY=;
        b=rURX4dcCb/KqTzoEDmX3Dam6jmMJRCiemsdT5NTJRsdetysRB3xoMDb1zzNQus7ymP
         Hspdsa5OgIE4FuLTGNzxhFkeXxfWf0zy//e4QOqKmYmsWzhEH+N47aAle2F6lqLozNQd
         i62ogvoZ/UaI9NRw6E8cSOAv+RYSShTkeKtL6KXf92E01gpMDZ0TsPXDrMZInnM6cv3C
         JoJKXSVUxvwL5VWZYVbdOqI+VELhIdIctYzZOklMZkBr1R7NMjoWSjyzLm2AdVSUEA0g
         9BXwmGAM1AyZIK2Z/KAM4kNQA/ol4aNwAP/+0vUYUqSUBD6hIBWo70OwUW1Jf0vQlBTd
         UG2Q==
X-Gm-Message-State: AOJu0Yyxjx0+8ECoUu4y8pn7JrvAiGrfWciBs7ZgGgEkAf6UrsBnyCYl
        6v5SvRZ3Tznp9LwqvCMsqPqySQ==
X-Google-Smtp-Source: AGHT+IHvqKMeMD59wsOARYBHIOOtmh9DOb0vYqoILiQ4tuG247ufeLMp7wMGy+ZaKH140knr325lBg==
X-Received: by 2002:a50:d7d4:0:b0:53f:2128:ff4f with SMTP id m20-20020a50d7d4000000b0053f2128ff4fmr4619581edj.17.1700482388356;
        Mon, 20 Nov 2023 04:13:08 -0800 (PST)
Received: from [10.167.154.1] (178235187204.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.204])
        by smtp.gmail.com with ESMTPSA id i22-20020aa7c716000000b00548ac80f90csm1324584edq.40.2023.11.20.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 04:13:08 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 20 Nov 2023 13:12:52 +0100
Subject: [PATCH v2 1/4] arm64: dts: qcom: sc7280: Add ZAP shader support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-topic-a643-v2-1-06fa3d899c0a@linaro.org>
References: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
In-Reply-To: <20230926-topic-a643-v2-0-06fa3d899c0a@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700482383; l=1670;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FO3D/4Lb+LmHq1IGkCnu/dhJPyd8/ht4WBGb18ODAj4=;
 b=GDIoeoFFvlB60e66DCtoCtdYcFDJbtJgGMbZGN5KrIZ1iWjzao4lxLmmp21pEUKM97CcEFTle
 lF26xtdb/VUC4IGtZsC0gvQrUiKc+np3MWMmV6N9bzHMdNmiX96otsu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-Chrome SC7280-family platforms ship a ZAP shader with the Adreno GPU.
Describe that and make sure it doesn't interfere with Chrome devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 5d462ae14ba1..88fc67c3646e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -17,6 +17,8 @@
  * required by the setup for Chrome boards.
  */
 
+/delete-node/ &gpu_zap_mem;
+/delete-node/ &gpu_zap_shader;
 /delete-node/ &hyp_mem;
 /delete-node/ &xbl_mem;
 /delete-node/ &reserved_xbl_uefi_log;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..58563f8fdc16 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -152,6 +152,11 @@ ipa_fw_mem: memory@8b700000 {
 			no-map;
 		};
 
+		gpu_zap_mem: zap@8b71a000 {
+			reg = <0 0x8b71a000 0 0x2000>;
+			no-map;
+		};
+
 		rmtfs_mem: memory@9c900000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0x9c900000 0x0 0x280000>;
@@ -2613,6 +2618,10 @@ gpu: gpu@3d00000 {
 			nvmem-cells = <&gpu_speed_bin>;
 			nvmem-cell-names = "speed_bin";
 
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_zap_mem>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 

-- 
2.42.1

