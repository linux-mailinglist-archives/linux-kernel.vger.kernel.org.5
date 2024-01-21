Return-Path: <linux-kernel+bounces-32134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E18356F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BED1F22081
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2630D39AFB;
	Sun, 21 Jan 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEjBdGnW"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597738FAD;
	Sun, 21 Jan 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705856366; cv=none; b=QXvtVmpLbb6uGfJyIodyXXHWx9iN6a+Ew+uWemGPpSxpHipz25kE29QSxpzh2cY+05w2TYkDXdFc+Pe5Xvviz/rT4sn5L1hTsmVQxgSaQleEO2V+5Ae4MNfyg7isiHOD5ZNfrNGubQ6oHwJWX5gZ5uNJA1IpG67GTJJEfuvUcHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705856366; c=relaxed/simple;
	bh=xv5DuB+dFYXgw1+FADV5/OpZCBDgeiH0Y6c1qxss8As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twMzgdTdbKvJXKfQQvSuSUR5xzrpgAiEkLY3WxESY81lLNnfiSIXJ1+XPTfLTlt3eYd41wZ1HrdEQuH6lwRmU3/jtlllvHlZc1ZIAXW2DBRZl3KtkJbI8cD9cbE3aYu3WU8yeUGP2rLFECw5c/+EV6iORWPy4vZCJC0zEQHXKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEjBdGnW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so31168145e9.3;
        Sun, 21 Jan 2024 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705856363; x=1706461163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWXdYhdeM492EXe3mdG5BAPOk6bpMY/Q05UvJ8a8hgU=;
        b=dEjBdGnWlXt6CQ/1vGLCIg3zHkk4Zw0nmIut05DUSC7G0EQo5+GMPV4MgABpDO5VTM
         tj4tRfFVpYk1ewyvpsG+Ey/lWEEcpNZl0Y0+2xvypBZXkSfoVt2kLP9x5DeY2BjjU0TI
         h4JnYiCGn3xW7TNKTQ5IYLUf6EvBVkImqnmBMZSL9vk009wDkKe5p6+Lvvh3NXuzNiSQ
         4j3HiMErxMePlF9nlp34xmCpJDjlr7datPzkDK51tZsa6WfxboaBadbInMRd4n9r30bZ
         PJnkMZQNite8Fhi7tAipAVgzVNUPESuTDgudUvFEIC4aTdnhDrFk7co1wCnW5TjD7imj
         N6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705856363; x=1706461163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWXdYhdeM492EXe3mdG5BAPOk6bpMY/Q05UvJ8a8hgU=;
        b=lZ2QwZlt91/Npy2KpN8a1KeTn2/Xyh+SJshIIdsMZwWYUvcsep3DSBNc5LJLpEKHsC
         eMaKFtjqP1RpkqMVhi7de10Vc95Ip/odyY2JtkP1dobFfqG8jA5XgULPl25/b0nwHOCh
         361mwQSXQZjeV2yzFk21LMjW7VzE6ozluh3lT7HEx16Zx6+O+vlhseao6Gas+wUtdacy
         vNd6P7hHJQT1mDhqN3UKK1sgl3Sb2O3sYogFSpYOznPv+xWhcdEcldN24dNUVItmfmTp
         afBswgv5O6Q6d07MSWnStwbEoEB8ZiIvk3EG81izMqVmg/Bjn3x90pHN9WhJww9JBpGm
         qsRQ==
X-Gm-Message-State: AOJu0Yyp7W0AvxoC3aiyuwCL8ANKRmZxHGeD2jJPcEvQ4i2SBzHmAT1O
	7jaf8oM/4oHkLXs69Z8geXLKCvH0JUsNraIQChbsfoxDOsaQs/jb
X-Google-Smtp-Source: AGHT+IHxblpBc5ydNxrV8gNG0jMJ56WKb64d6KgnFvJyMgC1NT1hN0GhKgpeiOtFdvC1wyC9HJqJBg==
X-Received: by 2002:a1c:7502:0:b0:40e:640c:3b67 with SMTP id o2-20020a1c7502000000b0040e640c3b67mr1741516wmc.138.1705856362906;
        Sun, 21 Jan 2024 08:59:22 -0800 (PST)
Received: from david-ryuzu.localdomain ([178.26.111.181])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm6541115wro.85.2024.01.21.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:59:22 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
Date: Sun, 21 Jan 2024 17:57:47 +0100
Subject: [PATCH v4 7/8] arm64: dts: qcom: sm7125-xiaomi-common: Add UFS
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-sm7125-upstream-v4-7-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, David Wronek <davidwronek@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705856354; l=2422;
 i=davidwronek@gmail.com; s=20240121; h=from:subject:message-id;
 bh=xv5DuB+dFYXgw1+FADV5/OpZCBDgeiH0Y6c1qxss8As=;
 b=8R85c/gQGHlKCMx88LuJo6ZhaKx+azi6UuwSBfVZlz1HDcR8Na+GCx16PdZigtCCgmXDrL7Bu
 b0COK7AHLphB+mtTm3TrrzJXUdEab6W/DbNmz3BO4KjsfPq4+YvyIpl
X-Developer-Key: i=davidwronek@gmail.com; a=ed25519;
 pk=PJIYyFK3VrK6x+9W6ih8IGSJ5dxRXHiYay+gG1qQzqs=

Enable the UFS found on the SM7125 Xiaomi smartphones.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi | 28 ++++++++++++++++++++++
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


