Return-Path: <linux-kernel+bounces-45870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96D843756
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5ADB258B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4E6E2A0;
	Wed, 31 Jan 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrHul90q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8076DCEB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684959; cv=none; b=XQSXKxCfzuF8kJnv291gMKADShwuVinO3WcGWv9/AXLUIfCCnq/i3qSyygh1paSAzfnpRSiYLSWq0ZfAuZaX4khTDiUGhglewpb/mOQpPBZP42sJwNattDrDSfvSQXwBRfKLZN8qvS3UYvHVntubS6oB3ar9ONdfI4OP+sujH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684959; c=relaxed/simple;
	bh=+uA0ICclxyNQoMTIPw/NYV/AOQhPA9mP9Yay/uAxdvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1d4gSdBq+/Fx6y7RrSssDAE7aceRLoHucoItsMcEXFiZmitrP8pnl+/QvfXUTr2STB9q/X//cVZr+8IbqKZqDCF3rkxRU3k9wfzAkpsGfgkQTsUmRz6kI+MoL6zBZpWs97l4ZwNMoQuwd9S6/ymjqwdY4b1B8kS1O5T4sydQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xrHul90q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da202aa138so2921356b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706684957; x=1707289757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXvWYDciMOY4RFBmZYkXJRb47tc6Feb9pDaNaINQNA4=;
        b=xrHul90qJUWVRyF7kRrLhHblpaECPEyf54WXJ6dNlVmgyuRsFI17Vxa3BVAtyinc1u
         CMdR8eS9YRhXMLlbCVYpTx6G4XSqOmNKNfOKjXI6+viiISzDaUsl5jk53t4P1akOl0qC
         PUnQuKCrHwISnyX82wTVKNkntpvXocmAjTCsrHcUPqBVEsrO7l3VsIdQKjngeHmkzdz3
         Chg9TNB4DYd/1ITVKHxXGBSK/g06Vin6Q1nL9WgQSr6HqJCcfm9esId1CMBbzBrz6HnD
         m6L9RfsRv/RVeQw54ucdzjmnqPxppbgYQUulJXkCGV6wSTFnXk93Cq9aYfdMdhoBKeAU
         OStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706684957; x=1707289757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXvWYDciMOY4RFBmZYkXJRb47tc6Feb9pDaNaINQNA4=;
        b=c21K0Wp118XFsDT1qyhZgPteHNzQn5ukPkiHUuZJP/44MjBw1680pnlzqWhaO7ygaY
         76Y6FNPUhsK3NrkYjSlu5ckbL5w9dP0CnJqJq9FQ3p0rQrMrkchLY8aqZcTXu/yjJsyv
         RqvrOGmE+tC9+QglXhiraEy6JH4yDk9OMqNhIXFHDsNA2wjfyKAi7eeP/vVEOo1XKANK
         OVyGBF4OhA+z+HX7DdsbkhliUuK4iXu3Ap6ftm7Iy7gdt8eWY7//xS9llPW1Kywcwh49
         7p/xNUm4zhzGqlHV80B/lh6HZ+0p9I5kBz6PPwB7ZwgiJnC9NClEl8xIBm2M6WxfU4xl
         0OoA==
X-Gm-Message-State: AOJu0YyEvZ2yyZVTR7YTQFghCAgxi4U3DTJIIr3KAJzCXDwV7BKddxZH
	HKkx6NCq2Ky4ODkCB3F60d16n9YNhL2hbisvl2RCPruTf1omaZyA3z9SLSE9gw==
X-Google-Smtp-Source: AGHT+IEVPzCNoMnveqltP3ZttWQXYdAYe+FPNnANo+hdr8IASxt60PmKsM2hrunKdFuBv1b1C86esg==
X-Received: by 2002:a05:6a20:89a7:b0:19c:aaee:bb1b with SMTP id h39-20020a056a2089a700b0019caaeebb1bmr704131pzg.7.1706684957453;
        Tue, 30 Jan 2024 23:09:17 -0800 (PST)
Received: from [127.0.1.1] ([103.28.246.26])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm9087956pfb.46.2024.01.30.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:09:17 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 31 Jan 2024 12:37:37 +0530
Subject: [PATCH v3 14/17] arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-ufs-phy-clock-v3-14-58a49d2f4605@linaro.org>
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
In-Reply-To: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, quic_cang@quicinc.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=+uA0ICclxyNQoMTIPw/NYV/AOQhPA9mP9Yay/uAxdvs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlufG+JtXbb/oLcjGyEGlV5zggvhfd2orCgOPT2
 E4gwiw28ISJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbnxvgAKCRBVnxHm/pHO
 9RxcCACnrAXKT3pWO9VQgwGHhAPqzYAjib68/qm2Xb/iurYhjDTbqix3qINBxErabXUIi9A6rSW
 mEDUQeQAd0PZbm+o614zzrwx1I9cJKlNWZbFrJvXefuM/2R2ARZNk+m4chfdiIGStcqM5/EaFXv
 pzJEdDZYBv1xIlLzzcJmFREBIu7DRd3WXxuYztnNjlxTjh/59VJKVZKQAUGkj9IPPc+pONXh9jt
 7LDkYKyRUkum6LIdoUXkSo1W+qVDwiqF8okewnnourjHvSM0vaD1kC1NSRhMfZQGQdiox7pgsJm
 lJNgxU/Bf23AKqzpS4X+EzXJVLmTeGnv/Lzo0a7grTTl2116
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

QMP PHY used in SC8280XP requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index febf28356ff8..bb0786ab2864 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2257,9 +2257,12 @@ ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
 			reg = <0 0x01d87000 0 0x1000>;
 
-			clocks = <&gcc GCC_UFS_CARD_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_CARD_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			power-domains = <&gcc UFS_PHY_GDSC>;
 
@@ -2319,9 +2322,12 @@ ufs_card_phy: phy@1da7000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
 			reg = <0 0x01da7000 0 0x1000>;
 
-			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
-				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_1_CARD_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			power-domains = <&gcc UFS_CARD_GDSC>;
 

-- 
2.25.1


