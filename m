Return-Path: <linux-kernel+bounces-109937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68128857F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88BF1C21670
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151E58AD7;
	Thu, 21 Mar 2024 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOKV6P1A"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F058AC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019821; cv=none; b=Np00pITvZsIb5TAhVVmnf5ucGtIOi7kEKTN2gqL6mhRjh0ZjHZzUwaAlbRDp4++yAyBiGZ1KvXq2wnv52sSQnihHlZowX4OCyKYe1gdC7Df/UIGLerHaeZzcpKu3GGrnBwylPKAldbxj1YemzAUkDjXIDYjp46NAtxT3GKZh9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019821; c=relaxed/simple;
	bh=BP3xpp0v4tnL/9I1fNzpSMYSMwKKsX1sNJSehWncIwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjEK26cgh30ma1WHIqjRC832mR0zO9JIKrpgE6AT0Wa5+b7u+FaK76Er+IkX4AsI9Nmt/GkO6zRedqaQ+kE4EP1i2a2VPmhg2eZQxA2qMCqR8aAR9ATsgL7FkrKzPzur5+Zvm8BZ0W+hUCa5mcQvGaX8KEzuuyy+MkIo2rhelXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOKV6P1A; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-229bd1776dcso325625fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019818; x=1711624618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbXW3RaKwYBp6feCRJ6SHji9fzUu9q/UmL+nhOiS4FQ=;
        b=ZOKV6P1ADFO+w760S3HlmG3fg8+wV8/kUVZoneR8QYGRashxG78KEO07Qll6Se7plX
         beaXMqZsHMIlvsaOjI5hou8pw07RukyigRgIXXFlsxOVyeVd8LDyraHTdpocSiiz8ntL
         94sj6gXMO5Eiluf8TweVv1/HADRLch0aRl7y5fGKoNqyYplFz9BWUJ6Bh2zfkMuK3109
         OBoLvY9XD9s+OpWsfolSleobnweo4svTYrC2uBklT3f0XgOty5VxDHCZNLX1oT/Yiu2c
         kh/yFLX/boqwm60IcodIT5FiHjVENFIrvaG1uW53dYhq/zmr/Z1yrwro3NsP44odK75V
         t/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019818; x=1711624618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbXW3RaKwYBp6feCRJ6SHji9fzUu9q/UmL+nhOiS4FQ=;
        b=diwoKjBV3mkjB2qs7bKkc8D40y8VLu2ZnVJJp8nr+zocC5Eenv6Z+mfcOEZ4eCH4py
         1E70qavrLfI81gKC7Ew4EUt7Ym4OFVIMYTEj3PLp1pu51IqiZZuxhNZjjrNmhzAz4kZe
         +URYhhBUn5ejWbQoRXqoBUHnMPJC28Kbj4fG/P1DPJkMkvKWyDpklSnZIEbAtgG8cM7l
         ru0fHzbbcPpVSbUcm9sMyK1H8EemKox9pPpNld1NQ0w4a6z1Y1RnR2UWsxtr9DdBQWGX
         ZAcxvx2kLckcL4Y2fIjfpmbaP40DyGqPXsIEJU5rTSs5k5We+PCI8DGl36p/dz4je60c
         abyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwnGLubRJmsdFsdvtunQVc1IKIjP1xiw5AAZQF3hv0FsLHSHCcdYfFmobWP4ZikNux7heaeSad8DRUFlcdkj9KprjoagUknvpbC0mk
X-Gm-Message-State: AOJu0Yxd/FShQJF7nov5Y/vkVzFramXVsKzarwh1YPHKSgxmoKhnjrcg
	a0ZPOHUeqmUbsoRkuTtCUi7mNIvHavQ3znjO54KH2UICXIEJBCrEBzO5UCFMmw==
X-Google-Smtp-Source: AGHT+IF++ZVZYYPVj13qtkbvQ/jjXA/B/TJc8cBoHr01s2heCYHkAjFEzkHuO7+FP21txd8x9icTUA==
X-Received: by 2002:a05:6870:f728:b0:229:9307:5ae7 with SMTP id ej40-20020a056870f72800b0022993075ae7mr6686086oab.2.1711019818506;
        Thu, 21 Mar 2024 04:16:58 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:16:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:25 +0530
Subject: [PATCH v2 05/21] arm64: dts: qcom: sm8450: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-5-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=BP3xpp0v4tnL/9I1fNzpSMYSMwKKsX1sNJSehWncIwY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcK+PRb1g48X4N+HBsPz98fCwxJJpV1gchQM
 N4EuzgM896JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCgAKCRBVnxHm/pHO
 9X7eB/0Q5ajmD9X1C3Z5xChBXdgcY4QYTzjaKHXD8Mww9L3OyaWYeMLGuHnJimU7PsyNAhXUwqi
 XMvyMdDPOWM2IT2VavorgIH4oRYQPdUt8Cs4LmyTMynXsBxkdzepsltBY4fSndcYWqZYeg+RPIO
 wuzrxoM6YEYndf+CRDtcaL8xdSDoUCQUJPPeKOgIaPwbTucjLNPizf9EHgFaJA6ek4hYs+QbOz/
 Pm7ar/l1DjdHZ1d2tfbYE3bWwYgowOVZLcBXsmxvrlm3WnbijQCpHuCfwamU/uPl3BSpdAtxqIR
 V3QkibGvMF06jH1RFezsZXo/gW5DZ5yiiFhxXnAA0vHcCuK5
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b86be34a912b..b42e44b922de 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1850,6 +1850,16 @@ pcie0: pcie@1c00000 {
 			pinctrl-0 = <&pcie0_default_state>;
 
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
@@ -1971,6 +1981,16 @@ pcie1: pcie@1c08000 {
 			pinctrl-0 = <&pcie1_default_state>;
 
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
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.25.1


