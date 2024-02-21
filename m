Return-Path: <linux-kernel+bounces-74014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F485CEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DF01C22041
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A293AC26;
	Wed, 21 Feb 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMe917S/"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC03A8DD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486938; cv=none; b=iqD9mWZGSdPKEg4Otxpw0d4p+SsJTmPaO6TBDnwL51am1dU9rEL1/94CkD0PxL7sGvak6CtQkvwlch4wt3dpbV8BSuS3Q/v5i+/n5yuTTyOcm20JpvH1GBygYvzqnneN7KXA2AW61bjwyrVKKK6B1weGaQ2lXN1yt6EnvPc++7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486938; c=relaxed/simple;
	bh=O5og4OchozAQWq8Cp+6rFJKQ0XxsxNLCk+2059Ri2hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyqJRSWq59BCx3Vu7kCLPlVQUdbjT0E+CO4T0oP+lrOKLgb5XyY3jgY/4x8WvxVnMtkG3NUM9lhQmUJPAyIVgUwLTZc9R3AKQpZ1N6OaTRUeF0b+Ie4LfCY+qeeUVYHE6qP0PNOVk/1l2ZejE1AWg42s7cit47DEjBDqlq23MnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMe917S/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a8b9b327aso42638eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708486935; x=1709091735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhFwmGfAyp+KPgy1YNp5dgOHOitxxPzL4bzjbrdh2qo=;
        b=zMe917S/CM62eKt3aNxF07cnUppXFgC/C+B0w29/psv4CdWSFy5p27jdBUw4MoTYfi
         RWtcgFcpK0qxMRxo6mopJQY6khWMopFnTCKjQwLm0sS1143b+YUJvoLgZqFPIjwa/IzN
         uNOy+GgZ7wuPJuf9FvoX1zMfWvd2HWsemw0VxkqvTjwheHDcv6Zbmn7TvW5JHpFPPZpy
         lcKGuimLRNCIzGesoNKiFBAwlMbfj3b2djtDT3EB/CfOGzCYIvaTyqWvppjwnsmLflNg
         vafdNtqC5NEftPhn8sMK1X/UT5J2AOQ+TmUQv1PZk5iSZnJhN3lLXveoJhowSz3KesGn
         ylzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486935; x=1709091735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhFwmGfAyp+KPgy1YNp5dgOHOitxxPzL4bzjbrdh2qo=;
        b=gJ1CMfy6BnEApXoWVKz1+ZTXyplxoOzdYc3qv8HyClMImAbedQAk6uCkdgF5tzABeB
         6+2W32q/BZ+CBkmcQSpgWCZrK+cl8aQ6XQ1OTf06y4+yssN9NHDoKGuv3+bWzqMV4ocK
         gzS16peHW6GKH7oC/HBg3X7R4VB8Iqo2bogECoYyDqxYEYM9Qw0rUwe+Hz3SkXGK0e8d
         8PEwjzZL4Lj8wXIZarVryk+jGNxlrcEqbdrBJHfj2n3p7qTl35ol/CxWvlS1ugAVrTWB
         ltOoFafbZqoPVCTO9WzF9SIr/gF/nXqS5lTedFmLSeobx/Yz+yBzaQLJ31QkjchUrczT
         9gRw==
X-Forwarded-Encrypted: i=1; AJvYcCVXO0Xgn5G0+po58zrKzlhJ6bpRgf84ArhWCuHoqy1AMP2Ne4a9yJVMeo1k123B9N2HRs1/ItCnZrKsjRkpNn21pD/RvT2to/k2zBBp
X-Gm-Message-State: AOJu0YyHeCW9BqiDbV+oCwbD+KnfJx4Z2IstsFkjkYcfFRI0YHdOE8Ww
	vIXAfS7njdEVJotCTjd3qTuuo8RB9uvoVK17x+JucOCQQ7+DtvlRbCUtMugry9JqhvJPXd5qpzs
	=
X-Google-Smtp-Source: AGHT+IFSKx6GZ4yxulHPpTju/HaIehaHxCGHrqoUPm0YfYGbYPjQYdJI6R94uzZ5myHGjPluz6NN8g==
X-Received: by 2002:a05:6358:e4a5:b0:17a:cfb0:828a with SMTP id by37-20020a056358e4a500b0017acfb0828amr20251290rwb.19.1708486935010;
        Tue, 20 Feb 2024 19:42:15 -0800 (PST)
Received: from [127.0.1.1] ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm4436231pfv.132.2024.02.20.19.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 19:42:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 21 Feb 2024 09:11:48 +0530
Subject: [PATCH 02/21] arm64: dts: qcom: sdm845: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-pcie-qcom-bridge-dts-v1-2-6c6df0f9450d@linaro.org>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
In-Reply-To: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=O5og4OchozAQWq8Cp+6rFJKQ0XxsxNLCk+2059Ri2hQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl1XEFB56RCU+KeRm0TqjjtZdY2xuOfLd0HbpOI
 eg3yrsgWzOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdVxBQAKCRBVnxHm/pHO
 9Vp5B/0Xvnk+89DL2B2kXhbUkU17AS0b/4yteiC/i/vFI2Fj70O/IwPyIHJ782fqMaBMSuThV2Z
 5mf23v05A15lNpMTpXNCVDMdoHGv+fyBn8gyCTMXgQtTz3a8Smdbg+L7RiL85V/OxL+inb8NNYU
 0P0AaagGlL0t8kVKSc7Adv3NIWQYgBBniVtJqGBU7ArtnpVMyacm9/7SVJgTCuNvAJ44TMTVvJW
 mHlB5gLPuq7MH7hQde7tahQ3nb0mOLCh1NMccD5PsQlPXd80aJApI+gtN7r2KzK8ce5ry5MObgE
 IRG30t0ALKjO96Iy1wXDkgUe8OiP4l7mM5F7iz67oKqsy4Vq
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c2244824355a..9a6e3bcdc5e4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2375,6 +2375,16 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -2479,6 +2489,16 @@ pcie1: pcie@1c08000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_phy: phy@1c0a000 {

-- 
2.25.1


