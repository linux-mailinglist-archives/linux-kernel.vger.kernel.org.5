Return-Path: <linux-kernel+bounces-74913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B685DFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8431287ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E48005C;
	Wed, 21 Feb 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHvZB9tl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1747FBA7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526340; cv=none; b=sCWspvgssthw0V300G7Dd3cprc00aVrkXuj+xbZNT91QBr1xvEHk2BkZKB/qPJoS8x8WDIqE+DM+tM+IZOoNcpy7NILkIpd8Jej7q+ApjORTezZflIgTmR85rzRo//ijJD4SfJ5wUeyIquezWVDoeDvqJDAbRBls4M0PVAzsL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526340; c=relaxed/simple;
	bh=NlA2nnmOVbPlcAIMkxQ6yd/LLF/90SMDy3FXGM9Rq2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ro3S8VDveW82DD8CJ0V8QD7tFi491gAIMlTsHAAr3ssQVKxQQDOyg9z1Vh9ey7/8KKat6Q3dTq70Visdp261imhsI7vEggbOgwCkKkOScxR/BJqpE+ptsYXJ6bk2q8SKcfRO0uejCYJp0gvJV8SJAsQltth7U/3raO7acJl6agc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHvZB9tl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5650ac9a440so850909a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708526337; x=1709131137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChqtzXoflnjSOQf8FO0bBBVo5MMagHq+8wVhpUTc2NI=;
        b=yHvZB9tlCE+6XTijyf1ZG3QYugbY1t/rJ4J40nlNyzo9G1yeDsntotRa1RhAxZ1y9B
         uEYtnYiDyiEp66qDILnHtW8ib92RyV+VsYfFwexZ+Bzb+AKuJ4HsGHlqTL4T9YOxE4Xd
         7cVRTWvjO2T4PaWurEJV9Bf1xw3pC+k5nB0npQf7HB1nJ/Tqz65FHQwPb2+/HuUnfQXJ
         rmOs1SdMJuloLtuBG363lmtAvkVwR3PaJkl+aBiyvmxvfxv7stetzJKhK1b0xkmX/nbS
         IfrpWJH2z5nexCWn8ruC1KLXS/vARD2NVOt7oJ9Jv92KkZjxsk7o0fCuImezGEWj73KS
         GGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526337; x=1709131137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChqtzXoflnjSOQf8FO0bBBVo5MMagHq+8wVhpUTc2NI=;
        b=bQMw4By7Dl2Q0Y5gmhn+zAMxdAlDoEClAxy5mEvQYUAXYXTWjLNXX/JPXeffCKjI8F
         h/g1AAKXpiEDQwajiRMYvbGO4CGPlr963dfiM/pGE7LLQSO2i2PMyfEpca9QE+lz+hN5
         4kEYqpyboc1qt0rLZqkkYbb5w4g/vteIND2qx1QAvHBeNQU8P7+1gbq1sIXx9O7Y4ur+
         tcrkddjLYH77A5Y77/7fq0qhCxv4yOnzKmEBBUGhPVdNHH/m01Ln4bjyegI9ff4FFQ1Q
         KRf6lQQ8KEMvY6iVIdbQ74pIqhcepnde33vUc7AIm4tjV8Fy0prUaQRt9YL6VaAtOoF7
         1keg==
X-Forwarded-Encrypted: i=1; AJvYcCWdgEvh4lzsEryrp0XfhmwTQyVHiT411BxgEMVJVouwOO6TAHcYcnopKmYuQqKlN8g16GY709P+hNEJ1848rOPdfLitcm13CkBwv57f
X-Gm-Message-State: AOJu0Yy3fG8xnIIc623hCyd0GWXS5DevI7vRF9t5IE7sR0UB4PNCakyQ
	Cy4giXPfTgsLmjLsDApLowWZDKizeOcj47VPpN+RMDCTVExy3OjIweTYUkofCR0=
X-Google-Smtp-Source: AGHT+IHFsJ+x4ZZ/VEbpNzQPHDi/IAbmF+hl6qgClF73kviJl+s9nTcc7wTjxp7e2SD5wqqVUiRfsA==
X-Received: by 2002:a17:906:7141:b0:a3d:48d0:d518 with SMTP id z1-20020a170906714100b00a3d48d0d518mr11820641ejj.53.1708526337552;
        Wed, 21 Feb 2024 06:38:57 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id wp12-20020a170907060c00b00a3eb953335esm2653970ejb.44.2024.02.21.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:38:57 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Feb 2024 16:38:32 +0200
Subject: [PATCH v2 2/4] arm64: dts: qcom: Add SMB2360 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-x1e80100-dts-smb2360-v2-2-037d183cc021@linaro.org>
References: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
In-Reply-To: <20240221-x1e80100-dts-smb2360-v2-0-037d183cc021@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=NlA2nnmOVbPlcAIMkxQ6yd/LLF/90SMDy3FXGM9Rq2A=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1gr6OIhfPbr2ZmqxWjYe8TtVkljkEuyvIZHMx
 3IF1Hio2U2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdYK+gAKCRAbX0TJAJUV
 VsdbD/9xQT/efkyflNYaNVKhueMHUzBRnQ8Pj2KBLomyjNMneXR3qJ/D/7IKDrwonNh6pVPj4ru
 zCsmisKZlJTlH9JPTkiJv4l8zRtlgooljnS65f5EPw1LJXstjB3jDq13yUuK9S/P0z0OEz8xsiP
 MOS/EB7fPkXsf3Qnb8TasETLeHuMZZmvevI/InPEZcSWnz54oTS+Cnri7p3/OmcbXcZlFYFZB2z
 DiltMEdo/Bc7/bKs5QYazYdnzTZc2bVxuf1dUEdnWN8u14MZPTsiUFG8poBKkMdbLaU6ivLyfQ0
 qhjvqM0uIcN/qAO+0hOXTZJL4d++REwOLeAMs7NllE2HwJ2fzb+yR1zHY3yS3iZ0T4gkfLuoKmj
 P0XQV8VLBWt5jY92hnN/0yvfZZj7xbl1iBOOqopeK8B3JwLWghKAgSCmk6FSGwTuxAqfRh56o6V
 0+g/VyWbqKHlIbcwTNRgs6WubwGyyThASp5nOjo6FC/NhS0BS08gno0TDRcNU3+RwV8TiHwrznQ
 X7Zxpr1w5w0SOpjs4uB3IEqv7YAYlfIFn+ybsv4+qT/bpMQPzsibLNc1vuJoqEaxsfjFH4zXIAN
 b/gBJyI3jH9l3WiDCM1Kkm2b4W7r45EaFqeUBSxZhoty8i+zX4+3A2QPxNFBZyQ2m1I/rQhXS3f
 z3fn+gK1ixH7vAg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add nodes for SMB2360 with the eUSB2 repeater nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/smb2360.dtsi | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/smb2360.dtsi b/arch/arm64/boot/dts/qcom/smb2360.dtsi
new file mode 100644
index 000000000000..8d7bdb56e6fe
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/smb2360.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+};
+
+&spmi_bus1 {
+	smb2360h: pmic@7 {
+		compatible = "qcom,smb2360", "qcom,spmi-pmic";
+		reg = <0x7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2360_1_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2360-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+
+	smb2360k: pmic@a {
+		compatible = "qcom,smb2360", "qcom,spmi-pmic";
+		reg = <0xa SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2360_2_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2360-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+
+	smb2360l: pmic@b {
+		compatible = "qcom,smb2360", "qcom,spmi-pmic";
+		reg = <0xb SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2360_3_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2360-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+};

-- 
2.34.1


