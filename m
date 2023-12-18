Return-Path: <linux-kernel+bounces-3888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796098174CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9126E1C21D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2D3A1AC;
	Mon, 18 Dec 2023 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gd5wLgBY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577037888
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a233a60f8feso195130866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702912024; x=1703516824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkc4Ff/LayCiLAJgh7FDZFX9VLQFTvw2kDwbU3Y6F7M=;
        b=gd5wLgBYb9c19Iw20yckWFPibgBYs7xyMKdgGFmF9+UZG8fSl12CQbnxHGJliyO2/R
         7cZ3eyIcXHug2Wg5IfOHvulTi0NDgPN4qo1almRW+/HvYypm3Wl3HlHb8dlYlWCkY1wp
         c2kK6OT09i6XSczNcxjQgQrE2ed5hu1och5XitsPKqjqZUJ80AKqEfz7yLPemUSIO/5F
         gzU7FT17K0nICWClk+XLvkvLc+KCnNBe3nbjHDgC4E1iVNhS6v2cNJZTsmA6lAzb/+75
         Ob6JNIPWFFlH5ddCUCEv6gAqJIAI11Izs7jLEBW0e4Lp3hMdtZgp/LylN97gjZYMnG3K
         jj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912024; x=1703516824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkc4Ff/LayCiLAJgh7FDZFX9VLQFTvw2kDwbU3Y6F7M=;
        b=oRQYEQ4hnsrAvRgrj3dslo52FHrb6AHmk7dyvrft8b/6siwfeILkMI7AL2lVdBk8RO
         W4DUeP2HvYSFGnTvk/kZI0XxX7jsRarD3/TQrzPZEzcy8gxEiNbkxqaZjf4CiI06Svk2
         Bt8ww7eUTqPCzAcLb56Op80sJAWSJvpVWMzbbaB8gc4/QG/Q+c9Qsgx2VfmJrQDj31iZ
         X2nVl5dVdTAnxgYUhF7tdN6Dc8esovpUO9k0EDpnW+3asZfIwQQXhlOEGSmnDuM7yfJJ
         +G/9BzIqQInh3i9x6kjnb4VbOjNsZpxdRQllqpo8AQ8NKaoMqAPcadhwoaySS6GPWkCN
         ErAg==
X-Gm-Message-State: AOJu0YylFm5XsGIjZBqGEimvFPVmus2a3ec935v3dFcSasi0YPql0cNK
	GCE++dau+bFOqlULAVLb0I9jyw==
X-Google-Smtp-Source: AGHT+IFP4l7LAGqipYCXtHUHpcRDPDviV+eIXhBVGBVoasjFy0JStfokYP9kTh/dNx+AnYH6aYNqgw==
X-Received: by 2002:a17:906:fa1b:b0:a23:6248:e987 with SMTP id lo27-20020a170906fa1b00b00a236248e987mr595559ejb.42.1702912024252;
        Mon, 18 Dec 2023 07:07:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a17090617d900b00a2328f844d2sm2823925eje.85.2023.12.18.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:07:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: x1e80100: align mem timer size cells with bindings
Date: Mon, 18 Dec 2023 16:06:56 +0100
Message-Id: <20231218150656.72892-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARMv7 memory mapped architected timer bindings expect MMIO sizes up
to 32-bit.  Keep 64-bit addressing but change the size of memory mapping
to 32-bit (size-cells=1) and adjust the ranges to match this.

This fixes dtbs_check warnings like:

  x1e80100-qcp.dtb: timer@17800000: #size-cells:0:0: 1 was expected

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index fd09fbc7d8e7..be1285d9919e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3417,12 +3417,12 @@ timer@17800000 {
 			reg = <0 0x17800000 0 0x1000>;
 
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 
 			frame@17801000 {
-				reg = <0 0x17801000 0 0x1000>,
-				      <0 0x17802000 0 0x1000>;
+				reg = <0 0x17801000 0x1000>,
+				      <0 0x17802000 0x1000>;
 
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -3431,7 +3431,7 @@ frame@17801000 {
 			};
 
 			frame@17803000 {
-				reg = <0 0x17803000 0 0x1000>;
+				reg = <0 0x17803000 0x1000>;
 
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -3441,7 +3441,7 @@ frame@17803000 {
 			};
 
 			frame@17805000 {
-				reg = <0 0x17805000 0 0x1000>;
+				reg = <0 0x17805000 0x1000>;
 
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -3451,7 +3451,7 @@ frame@17805000 {
 			};
 
 			frame@17807000 {
-				reg = <0 0x17807000 0 0x1000>;
+				reg = <0 0x17807000 0x1000>;
 
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -3461,7 +3461,7 @@ frame@17807000 {
 			};
 
 			frame@17809000 {
-				reg = <0 0x17809000 0 0x1000>;
+				reg = <0 0x17809000 0x1000>;
 
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -3471,7 +3471,7 @@ frame@17809000 {
 			};
 
 			frame@1780b000 {
-				reg = <0 0x1780b000 0 0x1000>;
+				reg = <0 0x1780b000 0x1000>;
 
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -3481,7 +3481,7 @@ frame@1780b000 {
 			};
 
 			frame@1780d000 {
-				reg = <0 0x1780d000 0 0x1000>;
+				reg = <0 0x1780d000 0x1000>;
 
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.34.1


