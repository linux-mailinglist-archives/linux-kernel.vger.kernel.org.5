Return-Path: <linux-kernel+bounces-126905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A542F89443A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA8F1F2419F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AD535B8;
	Mon,  1 Apr 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXnYthvW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7B051C52;
	Mon,  1 Apr 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992130; cv=none; b=nJ7lb4KrY1MyQy+YfA7JfqecIapkUZb6AgyMUHWN8r9GIylWKi1lEFM/J/eVp1bkdhxvW0Pr+ekxJm40nL/hA2SLHxgVJv8IKvz/SPgYfiBpQ6of6cecrCUSyJTNXBOgE5R3ekaMq6Rqtj47lA98MitTITXkXWHMJv9fBTx+1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992130; c=relaxed/simple;
	bh=QZgCgD+pDmfzTboyomfPDIaQwmmi1D2si8FkQh7TzwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLGxcyUdS4zW4A+YetmNr/Tc3L/iJSvyXvXcbd3NBAHPZRt6Yw3kVI3IfQgYgRWpRYaON4lcPAqUBLULItoWVmVOkfjgrJTqWf39CJxIHQRnljG6+fBclXX/I+lZ+LM42ZZ4HE2Nd2eCu5RxVaOzKJRxIxxREx4dMaeVcO7vSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXnYthvW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-515d515e28dso1789538e87.0;
        Mon, 01 Apr 2024 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992127; x=1712596927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew+Rv+h3xO004AjwxMfY/c/AUT9eZb4PNwe0Tj37/ak=;
        b=fXnYthvWMtq21oe0xWtC9/HG0geKV9jLtDaWC6fi+j5kX5eHwGJhGzHHWoczsTcgWy
         qPkOkglatDaXq/u1N8q6q+CS7g9hfdHRLkh8dZCaAJTgrNmkfOIrzlBg9s6fuTq6EfbZ
         NZTbD8fz4RBAX4UBzHZuvNSeRDI991JGSz9kUQcJH9bCtFAeMcFqsRrYUYjca51Qx+zO
         eUFow1vBzpESdIUcM1nFpl9/G6c94uqVIK40VAgTYiSFtdRDG8ZyPqr/LFtZxGWGUQEJ
         1ZSWrtd6vzQnLZ9hsnEj0sQrFTv+XNIJPNj8PrTfVmPAiwimCQAqx6n3HvPO43cbCxD0
         sENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992127; x=1712596927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew+Rv+h3xO004AjwxMfY/c/AUT9eZb4PNwe0Tj37/ak=;
        b=bMHG5U0vWUBLYBguLJXvB94ns1uI+aYEPDAEw1og3G5RaLJvlhzcQ3C69IT6QtYBwR
         JS+FkBEseHHVbcQ/a790zBBpcyJgpf5l+2k380pmApxT7AH7g33cNDMTU7OrV9XJgSx4
         OQg2BXdte4G3a2YffFnMXkrdyECTvWFvv1EpJmH4t+dXB60dg+98bK55Zuf9TRM9Bh5k
         mMkDuCyCuJC6VqZxbErv2G/58n/G/fHQLrC844uKe1gYR1U3wlP1KSqiTVZ3w3pcIEQS
         8FJ+56oJgQhog6X8ENwz7AM3c+AFOdd5HSGH0L69XaRJ6bIGAXesOEcN1QFNwsSEyeDo
         wt6w==
X-Forwarded-Encrypted: i=1; AJvYcCVZiDeMBJZg1H4l99o1y97P8lbTgFczCuzTvaznlqBK9iQEkqsfHQItEE4+RLMy6CM/Tg2Ao31BcFCYDys6vi4baztaHDVp/ycBy9HiqesKD8FXl/ACAGjKOqUmRc06DNR38/aATx3qCtvTZOYBUqhllWxaT3xbQgARMXEZ2cfMktFO5bEJbnM=
X-Gm-Message-State: AOJu0YySEhobYU5gdSnvO52BUsqcQ/Qr8eALD9pNK9KPm4CINscr0sUl
	k+jLElpVm8AR7in/eLGPuKbH1VjO57fXRJ4R8KWzwNwI7gqsJ7+TJFyzn+rGkZk=
X-Google-Smtp-Source: AGHT+IHD0PSqP84JkC+CvhhJ2s2SBxucZkTKCBPDRSoaA74HpBEd2Z1Ez/nUJqDtrwe5KK2+gEw0bQ==
X-Received: by 2002:ac2:5b4b:0:b0:516:a2fc:9099 with SMTP id i11-20020ac25b4b000000b00516a2fc9099mr3475138lfp.60.1711992126528;
        Mon, 01 Apr 2024 10:22:06 -0700 (PDT)
Received: from localhost.localdomain (ccu40.neoplus.adsl.tpnet.pl. [83.30.144.40])
        by smtp.gmail.com with ESMTPSA id xi7-20020a170906dac700b00a4e23486a5dsm5347949ejb.20.2024.04.01.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:22:06 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: msm8976: Add WCNSS node
Date: Mon,  1 Apr 2024 19:21:53 +0200
Message-Id: <20240401172153.9231-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401172153.9231-1-a39.skl@gmail.com>
References: <20240401172153.9231-1-a39.skl@gmail.com>
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
index 77670fce9b8f..41c748c78347 100644
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
@@ -1446,6 +1476,80 @@ blsp2_i2c4: i2c@7af8000 {
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


