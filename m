Return-Path: <linux-kernel+bounces-29187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2257830A79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480F71F274B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AC2263A;
	Wed, 17 Jan 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tMKIvYwo"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A8224C9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507713; cv=none; b=V2SKOOZq3bzgXNgsxtTu0zlEMErJ2pPg4CbqsoORZ5MpLZxp20aeT1GjIJ7eU5Ht7hgoeIE881S/T9fHGZeCqda75S9y4nXAAgFHHwAqsCCpi73M4sTf92zd3nvbPMC6bRmMZSE517wdM4Ghh+7l522AsTBtcl5cRYgxbmYG6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507713; c=relaxed/simple;
	bh=q/5JvxXT/ttZHOPaBaK+hkdqKMYeEJovznnWmWlfS1s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=KJik4KF3rfJwefYU55FjI+IApX8MGa37CHg2ooe7Ls60WKmmr7TMVWRxcgS/IkUc3uU6+joylF7BFrrA12ieHRLf7nMRZ7EuhQoPW5QluVf7OR/yHjizP5vx+K0uC7FC4FowdjptT/6058rWbhv11HaD/0ucGCXzShvxFZ77dgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tMKIvYwo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so9832310f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705507710; x=1706112510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro38Lp7JNlLkoqTkPC0jSkCRLb9P/XpaGuu5BBfa8bA=;
        b=tMKIvYwoBDlYwUE0dJrwY09I80JN04KijzsGqod4oS88tUwpVoWcGHibY8ldR+Zky/
         10RiHIpzFB6sx5PSvCAVx28yXyVPOzB+AFgS6/5s64R29277oOYsx3hXPirCwRIo7ERJ
         2t8tTCMLjSwMtkHk+hk9jkixAysLs3+hJx541tbRWW0RjqvniITxpi0Ri1fS/eoX6amo
         3/umARPWQRIMIHHARrLwSSYm387/jlhGrVbt45XZa3+AADmPvTxaLr0uDCwR1p6Etr/t
         w9Ow1rk3+wmcPdaPzWhqma99WTN0GmfRMzvuvKV4q5Er0vo2ETSID/DnrdV9fMXl2s/P
         GwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507710; x=1706112510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro38Lp7JNlLkoqTkPC0jSkCRLb9P/XpaGuu5BBfa8bA=;
        b=Yvv6Dt6ezn+Fe5tvhwpBzbYrDgKHxrs7NsX+Y2omYE1cLFzkLjIITALx2WjAkmZvjM
         Jnsvfp5WFp0Ao3ABAY4a39yNS/wu396R1jLm2QFPb2HejYgHXGzxDE9VhOeIYnX4L0Qc
         M3r8S5saDyhpjs3z4ZIezoN5IvYLVi4rA3xc2ogPA3O85hptLb9EUBJcPqrLPH5fyE/e
         ecbyZZZ21FpsEduTOCtag2jVEZQwSA3Dv7riVPp3vq96K1x3cYlk4mjTMUunsdBW8i6l
         IhBq1alRHAefd/5RhKn0WMxF0Ij7INaUQppdyVVOjk8bNh6k22JUdwm+EHxogCcpRySK
         hd9Q==
X-Gm-Message-State: AOJu0YxUM4ORPaGpH2Dte1RRaIgXh1iV+T7CL6TcP9BE6FyDZ5jdOlEo
	bfJySjXhM1uiTDYxm3Ubrk2klvYRRw2cmA==
X-Google-Smtp-Source: AGHT+IG2cSHLZyBy+LfnWZmmWmZ9clofYKmi0CdUV8SqFi2L1ljutoUNe61FdvAk4xWK60ztTQIGPA==
X-Received: by 2002:a5d:65c6:0:b0:337:8d89:7364 with SMTP id e6-20020a5d65c6000000b003378d897364mr6008069wrw.50.1705507709990;
        Wed, 17 Jan 2024 08:08:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0b5:43ec:48:baad])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1972092wrw.57.2024.01.17.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:08:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/9] arm64: dts: qcom: sm8550-qrd: add Wifi nodes
Date: Wed, 17 Jan 2024 17:07:41 +0100
Message-Id: <20240117160748.37682-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
References: <20240117160748.37682-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bartosz:
  - move the pcieport0 node into the .dtsi
  - make regulator naming consistent with existing DT code
  - add commit message]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 37 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 10 +++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index d401d63e5c4d..c07e2ea1c95c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -813,6 +813,25 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
+
+		enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_l15b_1p8>;
+		vdd-supply = <&vreg_s5g_0p85>;
+		vddaon-supply = <&vreg_s2g_0p85>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa1-supply = <&vreg_s6g_1p86>;
+		vddrfa2-supply = <&vreg_s4g_1p25>;
+	};
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1e_0p88>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
@@ -900,6 +919,17 @@ &pcie_1_phy_aux_clk {
 	clock-frequency = <1000>;
 };
 
+&pmk8550_gpios {
+	pmk8550_sleep_clk: sleep-clk-state {
+		pins = "gpio3";
+		function = "func1";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -1035,6 +1065,13 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio80";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart7 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc..1f2dd4262eb9 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1754,6 +1754,16 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


