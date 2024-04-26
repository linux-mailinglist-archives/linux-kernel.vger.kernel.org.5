Return-Path: <linux-kernel+bounces-159831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16D8B34E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CD2B229DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A11144D16;
	Fri, 26 Apr 2024 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ppy8FGCy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2F143899
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125796; cv=none; b=WZ+P812gsxxWk6mxMBScicgIbwJxtRPe44tkO5MOdWdjtR/Ok9cgTKKK07odZxrxstUvaDuw61vt2Rf5J3nUQvdFfVnuwqACwh10OJGoHJdZmBW8N+nfsRjVYUwiEXULlgI2Alzds47OnalLEJIeJTLZxMo2SgSDRCezw4V1pco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125796; c=relaxed/simple;
	bh=c4GAR/VHXiSuWKUBHE7VoIKB62u9XWyDx4j4aLii5Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEJCv8b77/7WP8/hR/t78PQL57q1XO7IiushQiNOi82Lb9lbRO/Jx39CtIS4oPk6QR5sVl3T+fSI/6n2M5HwlEhwlsBYaezPYLTgS3Vgv5MiPKbnOaRQcJ4Ko1gTh+pifEpX80Y9+lU4QsoidMcCKTKQmOiq31syQQjh0LTzJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ppy8FGCy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a559b919303so255542966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714125788; x=1714730588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DZKoeYKhsS0t9QVM1EShX7SrXXkb1dkzX7KrV4eN3Y=;
        b=ppy8FGCy2CRtcwTwqpxscK70U91NVI9WG6HsTGjN31sDPiEAsyoudReEw/zOL3bBEt
         ZpLpAg5P+qRUWHRFNbC7rIKEoY6JnZeTbYHkSvmckt7mLU2mcOP91Blc3UJkL42bYGEQ
         V9aUwJU07vyjyVwaAgpa7gB6ntHgOILOdjPrw7031l5jFVp6L/VRxh5L4md0f6YXPOEa
         0WR9G6gkD2+6GuBmugjEbT5CTMKaI1Z1N1dxphrjEEK2J6N4N7OuXHS+rQCQ9/D7/aWh
         XtQvsPvy7I0eQS67KPtaxjuNN+cE0ken9An7Nh07fkC5NKZzequFHFkV2HqZOsAP8y+k
         KcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714125788; x=1714730588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DZKoeYKhsS0t9QVM1EShX7SrXXkb1dkzX7KrV4eN3Y=;
        b=Mom8u3dtheLE0DtXGMrhjsIKLJF88gzyzjEAptyrSzRgqiFIbzt3kBja+fzqJamWLk
         SZcKpOF2OOFNoDrsyQLCp8Nfy9JfHsyd/PPAbCJ6UW48XjkrZE6ONgSiPUVxWnq67Zh5
         2/cB52fO2IKdaIySN0WEcObHnWFX6JbRUDQX5Wg/KovrjuP3EVNrei6vZf2TYdLDp6y0
         zCmhIgm7/WzBIcCeZ1juNq9h6D/G5ilWq/vaVEzVmli8iotEKdomS0gAIrsc/xJ78MAG
         XaOE8uPCw4SbMJV9Pz3duv3ueVKycBoRLYvoSShgLFEz4y4Vm6u3IoHqPnWFbWckZKwh
         Xxbg==
X-Forwarded-Encrypted: i=1; AJvYcCV1RhOGUG6GKM7vHRl34GJBYkokTOxw1qpwmYgRAjiu375vKhR5yVw4hpKmdfsx+BTT6qQblPKIWYUSdzfsBhVbweoFgyiyGxryTSTD
X-Gm-Message-State: AOJu0YyjUjyiPIPvc37QcfG1vQXMjA6rE0yN+7tNBHOPSt9ILghhPSIa
	dV12RHClHB41KYlbbUBViK9hUMC2uOTGGoKpSMYZoSpxrUq7v7KCnWynKjg31Gw=
X-Google-Smtp-Source: AGHT+IF8yC+P3Xjtk6lhWRIE+HMMTo1r+6sopk+vF5M8rRyByCwt/vcu3QmI793r4Uhlx7cGlfzr6w==
X-Received: by 2002:a17:906:c451:b0:a58:c54f:83fc with SMTP id ck17-20020a170906c45100b00a58c54f83fcmr1674104ejb.9.1714125788406;
        Fri, 26 Apr 2024 03:03:08 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm10417289ejj.218.2024.04.26.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:03:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 26 Apr 2024 11:03:06 +0100
Subject: [PATCH v2 3/5] arm64: dts: exynos: gs101: enable cmu-hsi2 clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-hsi0-gs101-v2-3-2157da8b63e3@linaro.org>
References: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
In-Reply-To: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

From: Peter Griffin <peter.griffin@linaro.org>

Enable the cmu_hsi2 clock management unit. It feeds some of
the high speed interfaces such as PCIe and UFS.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 9755a0bb70a1..52be951ef4fe 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1267,6 +1267,18 @@ pinctrl_hsi1: pinctrl@11840000 {
 			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		cmu_hsi2: clock-controller@14400000 {
+			compatible = "google,gs101-cmu-hsi2";
+			reg = <0x14400000 0x4000>;
+			#clock-cells = <1>;
+			clocks = <&ext_24_5m>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_BUS>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_PCIE>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD>,
+				 <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD>;
+			clock-names = "oscclk", "bus", "pcie", "ufs_embd", "mmc_card";
+		};
+
 		pinctrl_hsi2: pinctrl@14440000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x14440000 0x00001000>;

-- 
2.44.0.769.g3c40516874-goog


