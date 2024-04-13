Return-Path: <linux-kernel+bounces-143823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3E8A3DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B15282164
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B455C3E;
	Sat, 13 Apr 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbHuOOb0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925954747;
	Sat, 13 Apr 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027817; cv=none; b=TX0woOOt04XGjBEOUKe1zaDgQd7fzMfzAiOMYap9NzF1RzUHDgdTJilrPpFVkXmh0eB6YyAngubIQ55IuYPymqv8BVQyKLehnxj/t4Z9K39BJ/mXX6ngfgLFfNaOjaN2tVLd0JjNUSzypLpDt827xOigzudy827SY3WEAgbN+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027817; c=relaxed/simple;
	bh=qKY4A4MmWbKmYderFf+W1OfvpAN7c9I5RnDNG3KSuSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCD1YOfDz4gPWJGMlMtWcVb/uaLAoYsZup+kgRBXNKpjR3h7aKj4rpMaBbzz/GJ2/H9lhBX7LLmmVS7Uh+3QNMLck8mtMUht1yipuEI3mvnkaWVIp+mPa9zDGKK5oLxr0crcMFVR7afSsEXxHFWezzndzXTmGRpnDGlg+MJAU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbHuOOb0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516db2214e6so2275846e87.1;
        Sat, 13 Apr 2024 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713027813; x=1713632613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Z2iulFR3flOHDKo+G5rFGTvDxuUMRIV7oTixgtJK2M=;
        b=BbHuOOb0oQJcMHV5QihhdaZEJS9Hv4PZy8F9I4MfRiWvH7PpuAZzduXB+ZPM66OVwU
         8BeKoDUiWqSUljVPHHsJIntvaIX6ZTHQ3/7RVOlaAnTRPbBuAxM8o2gUv3yaDeKPoEWT
         VXGApMbG8A9alaRdguar6L6/k9hpGvzm1fQ4EJ8NUY5H7dm0XJieWQPJKUtxCnIk8CuH
         iCNK2QRU2J95CZhden3444bFGqwho44di45eB6zD+aABxwbasTU2Qzlo+589/Gnm6Sia
         besbhqLUfFVh/JBkf7f49FTy1SMvYBx5H3AAqk5Z/XMy1IJTdx4CtJq92aKkHhSPrhoJ
         E4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713027813; x=1713632613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z2iulFR3flOHDKo+G5rFGTvDxuUMRIV7oTixgtJK2M=;
        b=V7D2LyKFFIG3U7uckYrlsWBngiC2gAdfHIX/WD0vT6gnXG6eCzDTJ+ICmjirbB/Xpd
         IWMYvN3/GemvlmEq9OybFc2RK3ujEMX4XgBGDJ08kd9oaJiDvCzZLm2Nb9v/k9DyMAbN
         3BjhCyzMnn18VtI8bLfB2sfMEV04ckdD942STJrv7aQPNykTQrnLlXKI/E0/vqBXDRSL
         0voOaC1xK+oa72NTSmRUL0wNY8DmWwcUzCi9cG0oa3eZc31CaYItjUFiI7oC8qTlAJ8F
         UhtggRBRRk5NmihODdPTzPpdbRYEmTjeHFDo+jiLbTLhkDRCDtWV9KXD0x2dHwKUoFOI
         RxQA==
X-Forwarded-Encrypted: i=1; AJvYcCX9LD/uVlG3Bt9EuET1Ks3xjQltsF2jlMeSEZWKpqzMnXse3Sv3kRPwd9CrucK2u9LjC2xE+MVIIAApy8QoZ/r6NsZR/6ZkMEoa1afZhQ92VH3zhwtY6ANzOYNuEbSFpn/bEfkNwlWv3p1lLIL8es5gqfpBl0LwPzmlFeZ8Nud0yE1g3It0H6o=
X-Gm-Message-State: AOJu0YyQfo6gGxAqSL6fHMcX0gIFKxQGfxNjv6VyphaBPg6MgWLl9tP4
	CHNg6rp7OKH6Iz/WlNZlikjssMdRwvMWWSzSUqeBID6EsTQghZlUO7U2YQ==
X-Google-Smtp-Source: AGHT+IGO20C0Q7eiwJ/Kcud3wC9muonu94i5qY2q7hwpVsFLafkKskiVVj7mg6O3OuIExcHXnGUw7w==
X-Received: by 2002:a05:6512:b91:b0:518:a66e:aad2 with SMTP id b17-20020a0565120b9100b00518a66eaad2mr1628387lfv.63.1713027812986;
        Sat, 13 Apr 2024 10:03:32 -0700 (PDT)
Received: from localhost.localdomain (ccu225.neoplus.adsl.tpnet.pl. [83.30.144.225])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3195967ejc.76.2024.04.13.10.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:03:32 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: qcom: msm8976: Add WCNSS node
Date: Sat, 13 Apr 2024 19:03:17 +0200
Message-Id: <20240413170317.34553-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240413170317.34553-1-a39.skl@gmail.com>
References: <20240413170317.34553-1-a39.skl@gmail.com>
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index acb6331999bd..1e492bcc56f0 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -771,6 +771,36 @@ blsp2_i2c4_sleep: blsp2-i2c4-sleep-state {
 				drive-strength = <2>;
 				bias-disable;
 			};
+
+			wcss_wlan_default: wcss-wlan-default-state  {
+				wcss-wlan2-pins {
+					pins = "gpio40";
+					function = "wcss_wlan2";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss-wlan1-pins {
+					pins = "gpio41";
+					function = "wcss_wlan1";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss-wlan0-pins {
+					pins = "gpio42";
+					function = "wcss_wlan0";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+
+				wcss-wlan-pins {
+					pins = "gpio43", "gpio44";
+					function = "wcss_wlan";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -1458,6 +1488,80 @@ blsp2_i2c4: i2c@7af8000 {
 			status = "disabled";
 		};
 
+		wcnss: remoteproc@a204000 {
+			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
+			reg = <0x0a204000 0x2000>,
+			      <0x0a202000 0x1000>,
+			      <0x0a21b000 0x3000>;
+			reg-names = "ccu",
+				    "dxe",
+				    "pmu";
+
+			memory-region = <&wcnss_fw_mem>;
+
+			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			power-domains = <&rpmpd MSM8976_VDDCX>,
+					<&rpmpd MSM8976_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,smem-states = <&wcnss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			pinctrl-0 = <&wcss_wlan_default>;
+			pinctrl-names = "default";
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
2.44.0


