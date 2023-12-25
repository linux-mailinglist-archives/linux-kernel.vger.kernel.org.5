Return-Path: <linux-kernel+bounces-11034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D926081E05C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C7B20C29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1754BC2;
	Mon, 25 Dec 2023 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blGEOr/w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604653E1D;
	Mon, 25 Dec 2023 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso45430805e9.0;
        Mon, 25 Dec 2023 04:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505823; x=1704110623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap57/3CQ6Rq0XA5XYF0Gcs8lH49YqU+xtkO3NhsJdGU=;
        b=blGEOr/w9CILlsvbV8iTf27NZVCskAoaQXQUIL9D6Eqn/hfZjaifhOqr/aYA7X/fBz
         ePnj5gTv0efO/T9v7gq4ZeN6Yhtot76D4umxzmB8DUz6Px84HC+9gcUJzuGQIFLfHkTf
         M14jK61KuoOYuQKfvyu9T2hb8nvrtjS7gAMFYzdjlywKE0xkTwk+MLRSI8+iTs+dDJXI
         rtQqmHMAXQc5ZJX36KtyXfD8FqdBUyLVWst1Lh3pwzZ55vXlq4P+Aqiw2ZyVE0/8IMB4
         ME+e61AJsoMpjjxpZFTgKgAr4I6iqoI1UBqFsvn6ECRtKvBdKVVbmYNLl9GhHNpKpuzC
         pOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505823; x=1704110623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap57/3CQ6Rq0XA5XYF0Gcs8lH49YqU+xtkO3NhsJdGU=;
        b=pEtgH4MsluvcGgC4y7bbPS1R89WSJMoDjxzvORhTuQa3PmlXQmh0xw0UkWluk6SRYQ
         25pRv5Inb2ifuIvlgBKSx24EU1jWG6qhl7h/ortLnjsxqoVWxwQSYpxEMlvg07FDeJvt
         fjWT4BRHkKGjEFzEMLyW64vAZOKL2sh9KtZXQq1uJkt+c3RN+kVekJlfMtjaz7aScHEH
         h2AHoPENM9BqIpIpSap4j/nXDX8PJSIjU+OsFfCTLTxPuVHaDsj+dIe3Ek6TGMF7ASS3
         ZsWGlKe4SttZinHBtecoW4LPNVFm2VFLewvhWPodxQZ4tUrbGK6XBMY83kv1zY29VzST
         NO8Q==
X-Gm-Message-State: AOJu0Yx4zZBsOuruHlfjjijWadUIe4QNLixd0MVvW0QxKpD2sGzplVue
	kbsExMWcelsVse5pcnXUlQMAXgBQSbJ0cw==
X-Google-Smtp-Source: AGHT+IHNo+uIxQESjDWG1YaCbWAi/OVD30KSQAb5sf0nPgZJVnJNgsaCqvmkOlSnG9mc7G1e9GWB7w==
X-Received: by 2002:a05:600c:4f89:b0:40b:5e21:d357 with SMTP id n9-20020a05600c4f8900b0040b5e21d357mr3317750wmq.96.1703505822769;
        Mon, 25 Dec 2023 04:03:42 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:42 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 7/8] arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes
Date: Mon, 25 Dec 2023 13:00:00 +0100
Message-ID: <20231225120327.166160-8-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the UFS found on the SM7125 Xiaomi smartphones.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 .../boot/dts/qcom/sm7125-xiaomi-common.dtsi   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
index e55cd83c19b8..0dfd1e3730e9 100644
--- a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
@@ -152,6 +152,9 @@ vreg_l4a_0p88: ldo4 {
 			regulator-min-microvolt = <824000>;
 			regulator-max-microvolt = <928000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l5a_2p7: ldo5 {
@@ -188,6 +191,9 @@ vreg_l12a_1p8: ldo12 {
 			regulator-min-microvolt = <1696000>;
 			regulator-max-microvolt = <1952000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13a_1p8: ldo13 {
@@ -230,6 +236,9 @@ vreg_l19a_3p0: ldo19 {
 			regulator-min-microvolt = <2696000>;
 			regulator-max-microvolt = <3304000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
 
@@ -258,6 +267,9 @@ vreg_l3c_1p23: ldo3 {
 			regulator-min-microvolt = <1144000>;
 			regulator-max-microvolt = <1304000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l4c_1p8: ldo4 {
@@ -398,6 +410,22 @@ sd-cd-pins {
 	};
 };
 
+&ufs_mem_hc {
+	vcc-supply = <&vreg_l19a_3p0>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&vreg_l12a_1p8>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a_0p88>;
+	vdda-pll-supply = <&vreg_l3c_1p23>;
+	vdda-phy-max-microamp = <62900>;
+	vdda-pll-max-microamp = <18300>;
+	status = "okay";
+};
+
 &usb_1 {
 	qcom,select-utmi-as-pipe-clk;
 	status = "okay";
-- 
2.43.0


