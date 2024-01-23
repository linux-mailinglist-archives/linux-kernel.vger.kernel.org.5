Return-Path: <linux-kernel+bounces-36053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B08839AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C31C22280
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7C39848;
	Tue, 23 Jan 2024 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="VhEfb8xu"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD231A27A;
	Tue, 23 Jan 2024 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043876; cv=none; b=aUR/XuvdNC7sevQv7OWXd25eV5wMI6GPWmIpbxDEC4wi+NAXgxR4hoatvtWexr+X68zaMZMj2+Xf7TfDNh+g6aX3EGvbFgCE4lGAdXN6TLSFOZOlzbkXt2oI7bdhAs0IGC5uqS3D3hgePWXWTZX3eq80XwOpX/VQf2ko+/Vov/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043876; c=relaxed/simple;
	bh=iUZ9ff9Sy/VGyfLsHpEtkeYzZrimjw/PLUyxTEaxB+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loWzWMLJ+hh6vpKC2OYiCB1/VXpOK3G67ZFMOojgPYhprTvogiG6oDRcUYl1DcCy3rUR6W+e8B2secijNPCWH/0mDZzGiTov31ymfyPcI8TBFWji1Nk3XplEebJJvRBGsxd5wumUUvBSO1irt1+HKnbVaw24oRBpoYg2hZTLR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=VhEfb8xu; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706043867; bh=iUZ9ff9Sy/VGyfLsHpEtkeYzZrimjw/PLUyxTEaxB+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VhEfb8xuK6Z+e0ASbBsRCW8WXFX3p/aLRwG3yVVu1N6eWhIG0/9JKrS7F1NBQBOxC
	 IeWZ+v1tqDX4Yiw2SYzJj1Ez8aN/464YRdXYpfU2meZAZsSV8T15puoTzCdaYuX+2z
	 zMqQnTjKY5NwCjIHsV9DCYzc0S4o9CYCvokFNr3w=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 23 Jan 2024 22:03:57 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: msm8953: add reset for display
 subsystem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-msm8953-mdss-reset-v1-3-bb8c6d3ce897@z3ntu.xyz>
References: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
In-Reply-To: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=2eGHbPBMdO+UgME/Y6wGkZ+t0vRvxXHXtjw6rDrXCQA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlsCnY8IywGYM0+ByxpNlLjwe0KF31yb0R24nKo
 3uRQqntBqiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbAp2AAKCRBy2EO4nU3X
 VkT4D/wPDY9u4kI772wMuV+JU85Ok3ODvWBeV65f2Aj5mic3HAOfGFQzvBnED3RY5v68/T5t0iN
 hpHpxQvletMss+auTI4T/PXBF8JsFCfoQY3mn+eGFJQil2NrXrqfhQjeRNGT4b0X1aBtFQ+EQDY
 HU82Mfq2R5GophhKMW0oa0RhCX2w1D2LVcTAg8hU2/ygTKCQ6zK34kkgyJMZAVBmhBocTFu1F49
 IUU2js0Irq4RN2gN1TDiOqDo9uOGLkAh0jLCoSve4YsnmPx67PB8WpkIJS0RGVxOwPtAM7lD2yc
 0j+0Z8CPikioyLaogYNma9RHo1FliEADpTsmVMDeKCp5fh4ddE4ZO5GAKgCr7ecDWHUb+z+OWNg
 xWVzaq5WiRYo1LFM8BNjlN4+Ko8uQ1MiMG0/N0zEYlvd942mAuD5t9rARfbPbMgXL5WRQuFVb7a
 wjlKLpaduvTnNpyz0KUb4425j3IAj5AL+Eo5dhginLcKUMeaC60S6wVVljPN/nqV1RJgtti5W1A
 2xc2pEp1E4RYZlpJZ2hAHpH3TRhba0zzoWDpnQXCWA9vIHO1bPQdXJZx/7wT2sM5e25HCF+YQcb
 hXQXRl1Bzr8PaqnxkhUf7I49TnAuis8Kfp6VnyKucUqfiupwurZXgYt1O4AooMO7ZQnmTMuTd+n
 dsEgawnrk5b2QCA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

With this reset we can avoid situations like IRQ storms from DSI host
before it even started probing (because boot-loader left DSI IRQs on).

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
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


