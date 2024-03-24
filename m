Return-Path: <linux-kernel+bounces-116258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F34889693
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B782DB26820
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9293C66CD;
	Mon, 25 Mar 2024 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm5St4VO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEF1448C3;
	Sun, 24 Mar 2024 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324049; cv=none; b=mRoemQ2Sm6QoatjT3tOT+ohevBb5RV6POFRAqBBlsVYCBFK9w3sccHEsDiJAKip2Q8fFwJjcg6LcTFZCMZchVPLMpp5FwEZ+Vi2ztYAI7mq69fbex984rs55fZE3ZBxO5r9u9RiTQCdn88QzixpmBqEG/HUcE3fjiltZjqq3uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324049; c=relaxed/simple;
	bh=0ZFE6rldCefp0YbHux493Yl25byG2FGE9Ywou34Xt10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGWVJbD0pweXQCY8zi+Z3q6KDMwhXVsbR/lgZMgNCuvfSWbHanjckHUMdaHPCZ/0RlVCCWk60huKcLOwvI/vKrllG89cEXTwv/Gzb9ZpjHKRSsCBQj9wrrPF/VKl0zVB6+P+fvm+hUlbHFxyExXTR64d890/uyIma4iGk2ugvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm5St4VO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C32C433B1;
	Sun, 24 Mar 2024 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324048;
	bh=0ZFE6rldCefp0YbHux493Yl25byG2FGE9Ywou34Xt10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mm5St4VOlFaBMaEJjwlpeOkkBU8Asz3Lc7GQ6l0YP0OhakSlkUtpHHLggdc6ddtRD
	 m9mdRJlkW8+NFM57x27Zo9tncoBndA7WwC949klr53/Jq68Q+Ng1hNLAZ9Hw2xDRlf
	 m37CWbcPe/V0KPr5zQgrdKOMXTVixcw88TI9pxqpA/YuUkOfNeAr8zTwKX2XYIUIGU
	 MZs5scYidf/+iLbG9wQeDjX3sUeoNWd0Tv9zEQM3pNUM/ar+6nrOyyh4lx0pEirYCi
	 GpCgaz33GM1utHyaJFcowWX21IFrlPGyUmOZVO4/KTqWuVpk8fZQBiZhYAYVqMinV2
	 fcq2thLFMxnKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/183] arm64: dts: qcom: db820c: Move non-soc entries out of /soc
Date: Sun, 24 Mar 2024 19:44:22 -0400
Message-ID: <20240324234638.1355609-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit f978d45b4aaba6c8e9ad2406147be67f8f733c42 ]

The USB id pins and wlan regulator are not platform devices, so move
them out of /soc

Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 68c4c20848d7 ("arm64: dts: qcom: msm8996: Define UFS UniPro clock limits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 58 ++++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index dba3488492f1b..da2f01eb3be2c 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -399,13 +399,6 @@ dwc3@6a00000 {
 			};
 		};
 
-		usb3_id: usb3-id {
-			compatible = "linux,extcon-usb-gpio";
-			id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb3_vbus_det_gpio>;
-		};
-
 		usb@76f8800 {
 			status = "okay";
 			extcon = <&usb2_id>;
@@ -417,28 +410,6 @@ dwc3@7600000 {
 			};
 		};
 
-		usb2_id: usb2-id {
-			compatible = "linux,extcon-usb-gpio";
-			id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb2_vbus_det_gpio>;
-		};
-
-		wlan_en: wlan-en-1-8v {
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_en_gpios>;
-			compatible = "regulator-fixed";
-			regulator-name = "wlan-en-regulator";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-
-			gpio = <&pm8994_gpios 8 0>;
-
-			/* WLAN card specific delay */
-			startup-delay-us = <70000>;
-			enable-active-high;
-		};
-
 		agnoc@0 {
 			pcie@600000 {
 				status = "okay";
@@ -667,6 +638,35 @@ l32 {
 			};
 		};
 	};
+
+	usb2_id: usb2-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_det_gpio>;
+	};
+
+	usb3_id: usb3-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_det_gpio>;
+	};
+
+	wlan_en: wlan-en-1-8v {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_gpios>;
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8994_gpios 8 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &spmi_bus {
-- 
2.43.0


