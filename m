Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E57F8B95
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjKYOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjKYOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:18:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1FD193
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:18:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a049d19b63bso390931466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921893; x=1701526693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YptWvF1sLLHvvXfICRwlDYacILHWf1Qs1ovKRND9MmY=;
        b=P76PbfWa9SxbzUBQSdu+ni9PJL6e/0b+4CXLCXyPGaH0RUA0cvfOBIaVmOA0lfaDBJ
         vVG2/5kZhA983v0CN13nRwiR1lq8agjh1HSgnzVb/VIbrP/5GQbVa27uI8HSOThTVyP7
         e/A9l0fEtdilOG0KCMT5j6wFgkE9gRiaAwTkZXzBT3LvYiElodFbITp0MV9evITnQIly
         LPbk/X4/J3y53bhOYF7d/8MiPtcuSpySnItVSgBDPd1OHSCXIfT3ABsVCX9z8v0Cyx+1
         ERWJjqOVHixwvkG2Gs8aODyTlTIKQCzRZtM3ZljMZ3D/vVNROeLGCC+OpQnm3bTVEmoY
         5yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921893; x=1701526693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YptWvF1sLLHvvXfICRwlDYacILHWf1Qs1ovKRND9MmY=;
        b=Sp6EUAnCDRAzClsLl7tZet62g7WYYhImcQbsRGNPnmq26zq560I4MLe+0YX6nxnFN+
         9h7MsaXu4j2XK+uiEMjOWEBpw3q8IsDaCglIAAYZm7PTn93w7mGnvCptw7UDlBBomQcy
         bsPCtKke0Zb//yE1zGK5lZRC46at0ZfItbVGrtRyHV+J0pxwmpMDOwOzHSHOusRgLxQG
         GT8AWAfxZGetLpD54xIQn2JB7R90RqVOxFRGRBykR4nDA5YA5rggBUZofGZAIeoXm1NZ
         t9oAadeOF9s/+8alHChqI9wgc1v7A6EO8ih9BNJ8mKENZKLTHGBg6sQACqQdjvT7QHTZ
         NDAg==
X-Gm-Message-State: AOJu0YyHHv9cp3We60LyjexrjYJazIyBICNGExyYQOt9ctFxKm0CbVPY
        /FgfcwZwRzKU9UaVkNE70XB5RA==
X-Google-Smtp-Source: AGHT+IEveIKy8lS1XIRID2ri9B1I/5i3oOMUuCvPc3WfqFNEUFa6T6wVRX6iLxNL8g8XxcnkIOK5Vw==
X-Received: by 2002:a17:906:5195:b0:a03:9a89:5aaf with SMTP id y21-20020a170906519500b00a039a895aafmr4262215ejk.6.1700921893233;
        Sat, 25 Nov 2023 06:18:13 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:18:12 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 25 Nov 2023 15:17:39 +0100
Subject: [PATCH 11/12] arm64: dts: qcom: qrb2210-rb1: Enable CAN bus
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-11-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=1186;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JMbrDi2bxn7DXN0vpomcpuwaGp6goPBlt7d60Jxny0w=;
 b=Ow4Ll9242Yv5Y/KsoduODHlhgumTpa99uBnKCbAyWQYNOkJS+/6FFM3xsPWfMjhds1Cgj/BkR
 MwrWiH7RB7lDoCaSaSob+BAKLUxzTFGSFHjKebDh3bFYbzY/x1JMPJx
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

Enable the Microchip mcp2518fd hosted on the SPI5 bus.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index ac6584164058..ac597eb3fe9d 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -23,6 +23,14 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		clk40M: can-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <40000000>;
+			#clock-cells = <0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -449,6 +457,20 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&spi5 {
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp2518fd";
+		reg = <0>;
+		interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk40M>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&vdc_5v>;
+		xceiver-supply = <&vdc_5v>;
+	};
+};
+
 &tlmm {
 	lt9611_rst_pin: lt9611-rst-state {
 		pins = "gpio41";

-- 
2.43.0

