Return-Path: <linux-kernel+bounces-32166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5C835790
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82827281608
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD038DE5;
	Sun, 21 Jan 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCAkknDc"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665943839C;
	Sun, 21 Jan 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866375; cv=none; b=d2aF7IkVSAGD8PUeEbqp7U+G/+cG8uY30772vywZ+g/F0W1/fI/OMyxq31xn1zbuxOF2g0rrh4GcSHtYjDm3oMouEUYGXPJAVnsg0C4sdhm6m/t79eA2ay0S3bnquoSK1LYb+Xoo92ZDpP5QPBoX74O+2Obf73lgf3RSj/cfS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866375; c=relaxed/simple;
	bh=mY0yEkT4eOoaKnUzvRZoUQaqOeo6owK2//1DcB/Gzy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0Q2yKL8Cxt1yZ9NuDCLAUgRhHrF1ifYbhYifWMBIzbN7GUegQP6lhfe3E5BF9G4WjAfYx8sLh4lnEuTNLIb/3uXjJ1Q/OJEF2KHos989IH5Qlm1gm9e6jmIQHcYVBcsBXKnhkkkoxXHh2gKcWbRpN93N5kyaEHfg3BScTKNiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCAkknDc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so227006566b.1;
        Sun, 21 Jan 2024 11:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866371; x=1706471171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIbwgBu5HG4I26IeAw1uHQMEc/j1tlj9MtLw6eJ7dsE=;
        b=lCAkknDcEzqGPcslQSFyv12hMRkfWOI+pnikHdM2SAfDpPrDw176ID4sY/7CaCvgsw
         3gH4mhZZWEkJ17F/fT05QklUfsnH9dokeARnHHBiwHxdt4rsUqiWjye2iRYGSXELO9uv
         bSoxS9LwSEjQzaxN0ssZs2pYBdCmHb0cqtKC9EH+53xJBhOAiUC595+1ZoClZzzsrI1L
         S5GdKcuZzmA9xRF2JEW8idtiN4O0ai+r6tt2wZ6lYlbWz8O1DQJvLi945tVLGWIrTvuR
         BHtNg12bCMN4suMv2l3ItN6S164hmWReneVoPhC8/7k32OmA4KpAwh6C1VNGBmVqvjN5
         6gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866371; x=1706471171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIbwgBu5HG4I26IeAw1uHQMEc/j1tlj9MtLw6eJ7dsE=;
        b=PDqXMOQjIRDj9ROwxzkmcGIg1B/lABBv1q2WQbd63ABsHHaRzNHHR8Krmah6Dr/nd/
         GGoovzq6arag8fV1lx1aJ6fxrM/8s6uTNSIvhFEzBMmZ7/6cirtN9HGHoESAaoixMgew
         M5wEW1U4c0KGgU70AdIUMfAlRUdTv7RQ6yBGhvyjMCJYnPQW2P/0dA9I7x/dHVpV+BAl
         eZir55UNGMlDq8HSprOoKF7j/D8u2GiHAvBuqPgoAShqK7JfcuB9HBAnalIhxyefSJSY
         TELPEHERgrfIcTBNCksxQMs2TK8kQmJs5NZsM8fjr343pcJbutlhzoE1QokaI21xVZcO
         6Qog==
X-Gm-Message-State: AOJu0YzI5+t9B1yYwSf5wVvWSuxCCyWLQ2nXF5ZcQww+skNtee1yWqBT
	ccoLIMKXQEGKqo/Aa9ro1TZiK79WAlgu7YQ6RU2TelBqfZPi8g7JHUVdH2PXGrI=
X-Google-Smtp-Source: AGHT+IE5ujiGSqVQzqNM3XibibseuNu6KZEHiDALmPAeQC298EmYbl9MQ4jAzSGOH0WWJZ3a6ouivQ==
X-Received: by 2002:a17:906:b88c:b0:a2c:cdd7:bdee with SMTP id hb12-20020a170906b88c00b00a2ccdd7bdeemr1569221ejb.132.1705866371577;
        Sun, 21 Jan 2024 11:46:11 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:46:11 -0800 (PST)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: qcom: msm8976: Add WCNSS node
Date: Sun, 21 Jan 2024 20:41:06 +0100
Message-Id: <20240121194221.13513-9-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121194221.13513-1-a39.skl@gmail.com>
References: <20240121194221.13513-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add node describing wireless connectivity subsystem.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 5a7be93a0115..73ddfaecd3ad 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -861,6 +861,36 @@ data-pins {
 					bias-pull-up;
 				};
 			};
+
+			wcss_wlan_default: wcss-wlan-default-state  {
+				wcss_wlan2-pins {
+					pins = "gpio40";
+					function = "wcss_wlan2";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss_wlan1-pins {
+					pins = "gpio41";
+					function = "wcss_wlan1";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss_wlan0-pins {
+					pins = "gpio42";
+					function = "wcss_wlan0";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss_wlan-pins {
+					pins = "gpio43", "gpio44";
+					function = "wcss_wlan";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -1540,6 +1570,72 @@ blsp2_i2c4: i2c@7af8000 {
 			status = "disabled";
 		};
 
+		wcnss: remoteproc@a204000 {
+			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
+			reg = <0xa204000 0x2000>, <0xa202000 0x1000>, <0xa21b000 0x3000>;
+			reg-names = "ccu", "dxe", "pmu";
+
+			memory-region = <&wcnss_fw_mem>;
+
+			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			power-domains = <&rpmpd MSM8976_VDDCX>,
+					<&rpmpd MSM8976_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,smem-states = <&wcnss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wcss_wlan_default>;
+
+			status = "disabled";
+
+			wcnss_iris: iris {
+				/* Separate chip, compatible is board-specific */
+				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
+				clock-names = "xo";
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 17>;
+				qcom,smd-edge = <6>;
+				qcom,remote-pid = <4>;
+
+				label = "pronto";
+
+				wcnss_ctrl: wcnss {
+					compatible = "qcom,wcnss";
+					qcom,smd-channels = "WCNSS_CTRL";
+
+					qcom,mmio = <&wcnss>;
+
+					wcnss_bt: bluetooth {
+						compatible = "qcom,wcnss-bt";
+					};
+
+					wcnss_wifi: wifi {
+						compatible = "qcom,wcnss-wlan";
+
+						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+						interrupt-names = "tx", "rx";
+
+						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+						qcom,smem-state-names = "tx-enable",
+									"tx-rings-empty";
+					};
+				};
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
-- 
2.43.0


