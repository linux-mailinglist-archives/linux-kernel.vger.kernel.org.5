Return-Path: <linux-kernel+bounces-36562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C583A31A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956491F2598E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D2C17BB2;
	Wed, 24 Jan 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xL8LYXcP"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713817BC6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081847; cv=none; b=hb7WRU/eqw2qf1LgbqrsgYKyOwXrDut1tLFkZYkNQnbsN/bX4rZv4FvUW+DqvwPpY83sBz+1RaA5DGTCfflo7dz8snfrQnJ7XsV7CwXo2hOmY1cxHelv/krfe42LzJtbyQWRVbaGUyieJ/vJb6fOV3lzLFjR+gtixxWN2tjaYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081847; c=relaxed/simple;
	bh=xQGmJ609x5rY5WnQZu2UiuYBmCFSMa/qh9a8EVqrblk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzdZoCml8sg6KNvw9zLag196NSf69XLP7bHQXOjuVM0AcMR/FL5I05W6vDx3dKve8Ln4YIXvM44eQTIVzJeQOeIlFz9RyVlow4y7mtikOQLpg0UtujRt32FqHI19T+TsMTWDHC9Sd0Rv/eSNcvrPRhwV/0uC9IA1SD3UKVBDx5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xL8LYXcP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d70b0e521eso37482125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706081845; x=1706686645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXDDfi064rCtRThZJZGkVDjzRTpEFvKlRw59+OoT04Y=;
        b=xL8LYXcPThBZjEpIdgbUzrJaGjMucTd0ujeTI93aWpzfhKLoTh/B2HW7q9OKdGfGeD
         bqvBxTPe8ZZYNA2eQTBMxqD0BhB5VS9Fd2UiO5ziUPz4u+MFdEd8r+exHenLSrKvlQs7
         IM0LBclemzguteRIyb7wdbu8i07w3410ZifYwp78tkfusX8L60t99cax50g2zHDH2MeW
         2OTcZkjg+1LWwPsJ59wrn2EmqMldLYDl0w9rkNpmnTRHoYmBRNhmlM4zN9Ph9FKHKhfT
         Qrj1grLqlGk89S/haO3JNb0jcPVXzodhwY3xxB2iDTtsCGw++X9ySVOcJjUnKyEKVQu4
         jc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081845; x=1706686645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXDDfi064rCtRThZJZGkVDjzRTpEFvKlRw59+OoT04Y=;
        b=WAAk6uaBjopZYlsa/v+0h6dXr5VIW4cf3l934uekhCgycvlNfrGmf20mLe+kLHvjWc
         T5yuvGhxB/z5yhnAOhCS2IjCT9KNyC+iSj4ixpAlEFu5OTh2W+6Gr5OfrnXakyZvn1Bt
         ZuB4xfnyRZSHBtJBWq/MwEjZ6iP1sTc9F/ZraXzvuznPnTQaq3WBvcDkzBe/Nbeeh1rn
         jAY2mwPHwh6iQoVbWPFIM85a1DXUeA9MDvqn1uU3l2zJv9BzmzkAQ6fcFaPbr/t6tnbc
         K0psfbFHhpLFYxoiUX662f0+6Gr9l+Eaiqq7saKEohSWU9JxNCrkPHJiaApwByLyX01A
         h4Gw==
X-Gm-Message-State: AOJu0YxxH5nBRjnyfFDlz0si+GHRbOsO3N9Chz9Z0jD0trgn3ClCd8S7
	Ttvo8zzKNbyMSE9+G5pw/ceZeKZW8LVJDk/2T5XTv2XWcVW4/WWSdMJyg8LjOA==
X-Google-Smtp-Source: AGHT+IF99KK54fuqFFMfmzqMybtJrANjExFeTmDyL1Qt8Q4Zi7bMzYpz82W5D68CZj4gDoCyRGD5yA==
X-Received: by 2002:a17:903:1206:b0:1d7:5b9a:c121 with SMTP id l6-20020a170903120600b001d75b9ac121mr632265plh.20.1706081845404;
        Tue, 23 Jan 2024 23:37:25 -0800 (PST)
Received: from [127.0.1.1] ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm7386982plr.196.2024.01.23.23.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:37:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 24 Jan 2024 13:06:36 +0530
Subject: [PATCH 08/14] arm64: dts: qcom: sc7280: Drop PCIE_AUX_CLK from
 pcie_phy node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-pcie-aux-clk-fix-v1-8-d8a4852b6ba6@linaro.org>
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xQGmJ609x5rY5WnQZu2UiuYBmCFSMa/qh9a8EVqrblk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlsL4E35ElitvKxvgn52B7cnJz0JUaxM9PnNc0A
 YZLT3RUs1+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbC+BAAKCRBVnxHm/pHO
 9WzEB/9AWVJHzHB6yiYRzLzH5QMJyCI3Uey/WEyC9zrlInlCFP8ttR0TRYGIqNPMtlsudajr4Gh
 RwpC8CAwS3A4Jf0oosP/6RXE1zNUfu2UjlcdqwOOxHs8AHMNKKM3toEfV0hFTdMklLboKyoEpgW
 sj2l+ax0lyo1k2+nMyO9dzjY/ydeqp96BnCqc+N/TRwcJ3md0oC/ZejQjOYqewn84720yaqyduf
 kstWJuleC/arnJeAq0oQL/W/vG4KnHN0bm+4Do+Ab2t+dKkViydZvkDALc8juNUZ0jUrVUJ5ndh
 KHNGEK7XglGMRE/SqBmQdOXjH9s7XvhAlHttDhKii90je4kW
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
only required by the PCIe controller. Hence drop it from pcie_phy node.

This also warrants a new compatible as the clocks differ between SC7280 and
SM8250.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 83b5b76ba179..00fa14777417 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2238,15 +2238,13 @@ pcie1: pcie@1c08000 {
 		};
 
 		pcie1_phy: phy@1c0e000 {
-			compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy";
+			compatible = "qcom,sc7280-qmp-pcie-phy";
 			reg = <0 0x01c0e000 0 0x1000>;
-			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
-				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+			clocks = <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_CLKREF_EN>,
 				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK>;
-			clock-names = "aux",
-				      "cfg_ahb",
+			clock-names = "cfg_ahb",
 				      "ref",
 				      "refgen",
 				      "pipe";

-- 
2.25.1


