Return-Path: <linux-kernel+bounces-39941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94D83D7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E222293895
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349ED6A00C;
	Fri, 26 Jan 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXiC517D"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671F67E73
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261937; cv=none; b=cu+DRD8CmqPKIULt98FU7JiQhsTfN3AX/JGEpiCeS7V5nBxx42KIE6+20+fml8l0HjGKJY34qrB/UQJADn8QUC8USCvQp4lhLqkQTu8wXHBlpOB62kDzn/lj+hHgjPWTbnCXazLq/nN5N/5wvi5yh/y2GNeCdncAu0jP7/q2kgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261937; c=relaxed/simple;
	bh=nQauooNszPqyoOEzr4ZhxIxb76HgfibvoZ0QLd8mhA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/L4X3MjwoF45XPvpWqdK53PQZOwQGxvnPkTqO7zCrGkZIwplS1B/RnSJLuPEIdxFAKcwqk5t5opZhNDzvbETWxuN7sBXkIcTyd3yWI56MeoiyYO61MqCWHbpWKl5I2z/gf8YBhLNNjVGSHHtPBPuMMMox70TBbRHnR6n4Mg6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lXiC517D; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ed28f8666so2467895e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706261934; x=1706866734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTfvoetsxB4izWqxVfPVkINLcASVeBfA1M4tEFaPm+E=;
        b=lXiC517D/rhoK+yrm5YQ9jX+TtrtX6f31UPwQ/DAPCLTHBdcHAXVUocz+oiyuJPBz7
         0Xzr0S8/VO5zuOxDmJtEbyqIt3Ot5E6xVDnnEj2QN4hD6pFCYMqwJeGX+hKk4kyknjER
         hX+hQlXhYnYLH05JghYl4MaYfBeDEaGCFq27YldOcxPe5maJqHNql00oHMKVU8kJ/N/5
         D1PJosZIlx3aT/Rit5blTyEapnTWDCTz/BPzk4/y03FHKSjdEugMd2QY1wkz8mQB6qor
         fieepjKbdOIAp1Mm3U/BKGLogj5u5hvvpJm2CNauKaUilfkSgJhld68J6Yxl7C2a0dZW
         KwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706261934; x=1706866734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTfvoetsxB4izWqxVfPVkINLcASVeBfA1M4tEFaPm+E=;
        b=Tu6YGpHM/YZ4AXhWzKHgnfRYCr16B7XgcGCpcnW6S0Nqy2G15qWi5uIJ5DPKtO4O2a
         21E/DfrOtfqEFYNaF1qm6CWupy49HM8ji4t+XbWiwKtXO9EsoUK6DS4tprR1SMbb+n6i
         RTlyxqUmTdKEGJlE7PDZAkZkMYjl518q2Q0J5oGTlOBdVLtXo7GkSwH+BBXR9RUc0TNC
         UOBmKdx3H16hDU+WIgGiid/PKLkM1Z6RgjhC38WKJRS583njid1uafIw04ZzHKLTrQ2i
         /6Qg+flueSslPhIoHlrAgtbTCaKGNOnpEC3RNkcI5ABHsTXi+Ms19z/z/jPTx5BxFBbY
         g0jg==
X-Gm-Message-State: AOJu0YzstbTzQ6koTosyTEy4yufvwE445JGqL/I9/1yYJy/vpeFcITVN
	oWhqaE8x2looXdFlgnVatHqGZEwT2rZayrCGk6l9u/r5QzWk7R5EnVumRgjkEGKZd7BCRPw6YNF
	u
X-Google-Smtp-Source: AGHT+IHU/z3D4W06U6n/VuLJxAd6TPywr1NjcWdnWvlfsxjMufKrmVX5TEMTCFwxTic2zQPgeDrnOA==
X-Received: by 2002:a05:600c:1f0e:b0:40e:67c2:65a5 with SMTP id bd14-20020a05600c1f0e00b0040e67c265a5mr602762wmb.141.1706261934288;
        Fri, 26 Jan 2024 01:38:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id se27-20020a170906ce5b00b00a349318ea10sm426768ejb.199.2024.01.26.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:38:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 10:38:36 +0100
Subject: [PATCH v2 7/7] arm64: dts: qcom: split PCIe interrupt-names
 entries per lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-7-0bb067f73adb@linaro.org>
References: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
In-Reply-To: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nQauooNszPqyoOEzr4ZhxIxb76HgfibvoZ0QLd8mhA8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls32grRZQoWYTB0A3dCFzDsC1rtwP2mpxbfZxW
 JAl9k5vWEuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbN9oAAKCRDBN2bmhouD
 18ahD/9mgbiUUmRvdztNj3QfsOT1DPTAZF7LKo84G4+PNpF/Q9G9HzTU2yZAX6WZLDvq9JEMpZr
 2AB+FSgi3zyUdJ3abjSbgwsf6jkpnR4L1Ae0XWRwEgkFLc8BprGvKvCq6tLQz0HMaroB30Fp5HZ
 KKXlYrOgK4/8Qwzc+KrXhWVbWEyHSVT/OPbcEjsiRP25Tmjw81flvQ1CUUTo8T86we9DzsvNhYL
 TB9ucoiKOQR6KNZMv/kHr95JRfNpg1U3BCD1c67Zru52boqDtLgW/pYTR3au7a00sv1jU+nCnQo
 45ngq74AsuHSsPoxbermFxnEYu84cDNNMhk9kbcw4XuzOd6xv3JQzY44BBfOOX/XYFCPFIhhygY
 N7iTJcDlFfEUfc1INOObYJ0rOZcQzQE8MufN5onIcY3iuoRjOY4msWLoqHrS3N1lxsm8gJCWc+H
 4CgX70l4QvaQe4lPIoZDJtWp+6JxnweMLEvpQtAg4GaKF6/t/lZ0geZL/GkuDSf0B9P9gZVLvZX
 a7vhE25LeD6T534++xDYXn16j3h9fEcJWzl+e/6u5gfA9u0OZ8X/AnvnOvB5U/NP9rK5QW5eEsC
 t2yZulU+8VRnBDLaBXrGuAbEQV5NiicMehpDcaXO1CcdzC/M7tZdqTA3MAmkECzVggfI8rhIciO
 v6mBDthoQbQnD3Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Other PCIe nodes in SM8250 and SM8350 have one interrupt name per
line, so adjust PCIe0 to match the style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 10 ++++++++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index decb2e5794ee..99fad4f1ad2e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2152,8 +2152,14 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi0", "msi1", "msi2", "msi3",
-					  "msi4", "msi5", "msi6", "msi7";
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ad65f6b48e25..340147582f0f 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1526,8 +1526,14 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi0", "msi1", "msi2", "msi3",
-					  "msi4", "msi5", "msi6", "msi7";
+			interrupt-names = "msi0",
+					  "msi1",
+					  "msi2",
+					  "msi3",
+					  "msi4",
+					  "msi5",
+					  "msi6",
+					  "msi7";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.34.1


