Return-Path: <linux-kernel+bounces-109979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F788587D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD371F227ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB37A58ACE;
	Thu, 21 Mar 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojX7rSwP"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74358129
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021338; cv=none; b=kINA5+Y/5H7tP3ApokVubtebwmljGhl5XOv/ks8CDRZFnwA/hDzCSxcPw9/aU+/Iw8Fc04d+BEMh5CHpPqbaSatB8/2IegLVSG0g/OAsptbey8g/S9CsoyM6b+LD5QSmAHVgF6PDsJyXkzIaoevyKWUtvMU9Bi2bY8uogNTC3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021338; c=relaxed/simple;
	bh=xm+jWg3BgMqQCkkC5ZHr8tW7UJ1z5Sx/tGZleR1ATvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2xM2IUw+4ka0XMZ/Z2uwD5NQW4pgdIhNxjlGRpYc3ng/skqLONm5U/4CvrbhBgkOg+UYRzMG5uWYx/TNV7Uvhb/oj4DZgxcJcnar/502oi+rs9R4OtI3I9OlxFI6ogvxRbdsOIUyPn35+Xr9sUM9e4UfUu5cJZIda2jj6H57ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojX7rSwP; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a47cecb98bso511666eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711021336; x=1711626136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQs2ciOH27/qJex0Nmnn+loYNUnMaA6AX6ZBILiraFg=;
        b=ojX7rSwPlpxPfQSANKEEWqRr8xKTlIBCtAEdapUXgwufEa5EE4JeL45q0xqGuaK4cX
         C39De+oAy52K7sb1i5TEdzAc9ltGpGDSF5X2AU25i8UaNQcFVHvxkV7+eW3QajlNrnd7
         Ahr21K08q91OmCy1tyXOrsTvkgUrII+KkBCkjVf3cFxwPHDa6gt8p3/UwMYsnLQBm3uo
         7FjXOhOfM5HDvvfTx5czJqSGzoiMmbpxLcrwm+r5d2fRvrowJNYQwBlFET2p4BHqOExs
         2/RtyIscLFz7i6dRPxpCtglEe69FuzN8OAkL7D1FLO7URgcS9Ynrt4yU1XDuG+GQ8QGT
         15Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711021336; x=1711626136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQs2ciOH27/qJex0Nmnn+loYNUnMaA6AX6ZBILiraFg=;
        b=AGrQiX+kp3xgyNrNnvuPv1KblAeThBqJIRjvkW4JtskvrMZt/wX4tMo/Xz8Gna9aoL
         KS6vA3yj5bCGzcl8NC7NIbZAwBJ33Q92T3lZ/5t0n+o/WTn/2BIyB+I+w87BjJiI5dAR
         qhObCGi0xtMeI8X1aSTR4RUkWC+cu/+dxDnROcBll1WdKoJKh2Mje5Vyh9WOAjrLMtml
         yvqE3q6rN7jvUNt2vmG4iXTfyxiWndgtzjtfpgih9r1QEQNTGFrjevYqvL4vy2Dfem02
         Wf+B2mEMLwo89Ikp2V1K4TnABs7rR2B6vap53Zn2e9SfkRLkwvP84wKd2+6bFNMb1i9Z
         RJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXhKbTvX928T/CcmZINHpsADbRcx0R6QifVXc2kNmNcFMY8kA9/09MQUI2DtQye8iOFTM12Zrcf5giAWuOODgWpV21xeFp3AySIoPUl
X-Gm-Message-State: AOJu0Yx5eaDNx+T+k/ALX3aL+/OzZR2sO2qDP81bAe/AEDexP2zUM24R
	7i+qxHUOeqexPxg4idxcZoO7QqjJ11tiDBKNaRQ/cjk83hc4eciggIQSGVbOOxhp1fIVN+qlp4M
	=
X-Google-Smtp-Source: AGHT+IHd9bOVmfAL6GhnFMkXfn/qEq/L4zTHm4jeKk1ql8LKHfn+bVeVVgkcnjMPV5Ys2JjlLUFbiw==
X-Received: by 2002:a05:6a20:3d23:b0:1a3:8793:8840 with SMTP id y35-20020a056a203d2300b001a387938840mr4450005pzi.33.1711019836249;
        Thu, 21 Mar 2024 04:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:29 +0530
Subject: [PATCH v2 09/21] arm64: dts: qcom: sc8280xp: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-9-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xm+jWg3BgMqQCkkC5ZHr8tW7UJ1z5Sx/tGZleR1ATvE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcL1+Vnkfwh+YBo40ZqpcGU2fjgvQ30/12dm
 asb8ZOvofKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCwAKCRBVnxHm/pHO
 9TY1B/9WeLAXW+OaaT824XlTb276fkWKMEenfw0+X+0fmDRWIkEq8FN3zl2VsT4L0pc/Z+F4jPY
 HwNobpUhR20Vd/QsgCjO2LEMgosGWAQ3mNkraRpH64xuxh+a+EL8+GilybSRWRlds9nYBqQ4pH8
 kVMAe3ozmVc8g8B/bcusILRnPMcjkQche0EV3EBlwLOaV/Z+NmZO+P3w9boTyaZl9xzrLY/s1QV
 M+VRQpWGdXCj/fc11xeVhPOhqVA6Rec6Ay8aU0QtUD1ImCof8C7t1Mmz2+7JnTfqJxpF627+/Z6
 jxzUGCkZukPcEi+bI83OomX+XP49wxM9qD75hWNmBAE/nqoM
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

While at it, let's remove the bridge properties from board dts as they are
now redundant.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 20 +++------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 50 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 15ae94c1602d..caf7dff446a6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -731,22 +731,14 @@ &pcie4 {
 	pinctrl-0 = <&pcie4_default>;
 
 	status = "okay";
+};
 
-	pcie@0 {
-		device_type = "pci";
-		reg = <0x0 0x0 0x0 0x0 0x0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		ranges;
-
-		bus-range = <0x01 0xff>;
-
-		wifi@0 {
-			compatible = "pci17cb,1103";
-			reg = <0x10000 0x0 0x0 0x0 0x0>;
+&pcie4_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
 
-			qcom,ath11k-calibration-variant = "LE_X13S";
-		};
+		qcom,ath11k-calibration-variant = "LE_X13S";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a5b194813079..c7feebcb28b9 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1779,6 +1779,16 @@ pcie4: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie4_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie4_phy: phy@1c06000 {
@@ -1877,6 +1887,16 @@ pcie3b: pcie@1c08000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie3b_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie3b_phy: phy@1c0e000 {
@@ -1975,6 +1995,16 @@ pcie3a: pcie@1c10000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie3a_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie3a_phy: phy@1c14000 {
@@ -2076,6 +2106,16 @@ pcie2b: pcie@1c18000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie2b_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie2b_phy: phy@1c1e000 {
@@ -2174,6 +2214,16 @@ pcie2a: pcie@1c20000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie2a_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie2a_phy: phy@1c24000 {

-- 
2.25.1


