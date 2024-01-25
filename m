Return-Path: <linux-kernel+bounces-39323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300A483CEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B06B24874
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22313B7A3;
	Thu, 25 Jan 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="8HxHjOLF"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5D1386DF;
	Thu, 25 Jan 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218542; cv=none; b=Hb1Z6f7qoRG7jru+4VPp9lNL1vEKJe9LEfVdyvBomX+z3EYjsM6Tm8rs2NA/4ohqBqUnfEOy+R1T2oG2lgWPf/Nazo55gclwxlD1YRNIeNXjFkF8NZzCtVoar1lt/0Nx0j/XgaJb1qLiDjg+CoDDp5CVwdFFD1hL5NuUonabszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218542; c=relaxed/simple;
	bh=yU5QrcQggwQQZ+kfNFxdDHxu5MXwpTUge718BD6qWsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhjek9Z/1EUyKOBo4i1B8wCOn+XwkVthPCHdY6wGruLNEStK8lSIcd+CRYD0slVyi2RoTjgy58whKGfCX8nyR+PzreD/Zoa1prdVNTHJXT9LYUTU+zTk+5xYeXKgMc82x+w7XSSI2WrFxrKl1Oe/fR4zjJn8JU0kfb6eeaD1ARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=8HxHjOLF; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706218539; bh=yU5QrcQggwQQZ+kfNFxdDHxu5MXwpTUge718BD6qWsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=8HxHjOLF+iUIlmdJpb+yOEnAOc73gJ70iQl3IEieRVCRQBRZkpfENOBnc0vIdKrhm
	 FXYR2/mVAIz9uHQs/owmqJQqFdW/Q3u04NI46mXKpRkOGBketnm3BFgs9ULiC8rIzI
	 N8fsDFDKGquBYwTD6euXWUiGU/qgo+JkkF/k+CBY=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Jan 2024 22:35:14 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8953: add reset for display
 subsystem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-msm8953-mdss-reset-v2-3-fd7824559426@z3ntu.xyz>
References: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
In-Reply-To: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=PzUs+5/iYFOXD5TPEPyAZhq1wFpo0mlo1sKi+auOvx0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlstQoUguZBfVZalKZvT/s2F/nZ2v3tWppxGDNu
 tWud5Pl8XGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbLUKAAKCRBy2EO4nU3X
 VoMYEACbrmNAcNRKzZvwmfCgVFNyTCg1I1Z2ILz9rZou8AdDvxucvfn6vRdhtimmK9FrTm2PETT
 sioLaWn6Z4sQyHTqQzlypeWR45Ip/9rc4DCGob51xftVJQU0RGaNdiyDMq4m0IQXgIZVK9Er6bm
 +C1FdGzc9+Tzx8NpNX7hFViGOiqhwxSLeCyYQSCDda73uQbntRtqtOMggHyQinLEXx4HJOJsiod
 cJeUcq/7F6vb0SbQI64bddmjwUbq9cu3m+FcgSgabmCEYqenq8jhjJ/hIf26195ons2CcPxFQWF
 spj+75YQBK2NFdISJnjdg6OpJyB60gJnghou8p23Vd2rU8kIZib9X1tzG7BUxLgcNq/pTqzbFCm
 yVf7KHFfABIkx3PqccOVNVGUPfNekEpz2Bv7yVvXkRWavxTN0gYF7InjuiXWmpII2JKnhbdoLIo
 OMjOe2g4IC7+P6FobM7aVW7WyeRPV1HpIhR2Lp6Y+dk2lYitHIqStFUUle6H0iyD+Y6kwBEcT0f
 QvrhfBkX2TT4lPbs7+InXcFstxgmu6GQyLSe00atj5+mjIhpcLTD2eI0nrnEqiAZUPnFQ+XGMNc
 ynjS38vRZm+saU8xa0MEgUro0MWpGiTtdZ7+2jq9oyKtfAKFGfgt8a6Tct6nYSVYCyTMSobnFLu
 +RAuiMrvgrw2epg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

With this reset we can avoid situations like IRQ storms from DSI host
before it even started probing (because boot-loader left DSI IRQs on).

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index ad2f8cf9c966..dcb5c98b793c 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -859,6 +859,8 @@ mdss: display-subsystem@1a00000 {
 				      "vsync",
 				      "core";
 
+			resets = <&gcc GCC_MDSS_BCR>;
+
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;

-- 
2.43.0


