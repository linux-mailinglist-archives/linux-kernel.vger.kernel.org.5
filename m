Return-Path: <linux-kernel+bounces-72124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9885AFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50035B21563
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311D58135;
	Mon, 19 Feb 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="bLdO6L6Z"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559E55E74;
	Mon, 19 Feb 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384310; cv=none; b=Y7XlomcfHvSCvH+yaXMNw3L2l7uV1UCRA4cCTf/Qv1jVWURj4hZZCMm0Sp+4QKc2DupN8To7gz8SyxYJ5Ue39rYUn/n/CQECwogD/G2fFHRlNP7lhYPF8tFp3soLOxUey8A7Uf0pZzbrBLesHspnyxr2+o9q6QzrfS03uzV1OR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384310; c=relaxed/simple;
	bh=ni9Hk46J16/FHSxaH5CWtQXBguOqf3wPvo6zQuh0j5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcS0yHS2tzjJ2tDd/3hAS32uSv4Jgl+9v512KiL1mCm+xIZprTG/LDZPH/O4CXJ4Ka3TMOruD1cdSAmwdXsaL3plsCWiHQnb9M3FIy2RWP7i6kYUHC4u15N7t07K7VYtB3DFBUG57PqDVENLzQxNydw38mWxJg92SsxvUFutPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=bLdO6L6Z; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708384301; bh=ni9Hk46J16/FHSxaH5CWtQXBguOqf3wPvo6zQuh0j5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bLdO6L6ZOMuCpGRuBzoCbFIj6Ne9M2++W6hJNKuHY4J/H4Wke2M63dMmBuUr2NAFZ
	 wPsuUdezeIIR+iDXVMJiu67OwpMGyEE/dfGAbV+L7ivphIc/s86+/8KuEn47/5gTK+
	 cGaagGby6KD2aQoEeXFSUNK5CDXlH9SCmVHU08/E=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 20 Feb 2024 00:11:22 +0100
Subject: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Hook up backlight
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-lm3630a-fixups-v1-4-9ca62f7e4a33@z3ntu.xyz>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
In-Reply-To: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "G.Shark Jeong" <gshark.jeong@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maximilian Weigand <mweigand@mweigand.net>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=ni9Hk46J16/FHSxaH5CWtQXBguOqf3wPvo6zQuh0j5I=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0+Ap06xVVfOjf7jo2py8gyWN6Lc4io9S0g2Uy
 UAt+awT6YOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdPgKQAKCRBy2EO4nU3X
 VsSCD/42xL9+QTj0aHPyGIPTtH/EKXNhf6ghXkZmndDoIPhAm7thYII1LR1oCs7HUJ5omau9+th
 9lJaTndXPqbbXnZ+a/RIBnSyVdt/eXQKDxa7WIlXGro+gUYgVyt9cPQZ4E0d+8DnHeuX803yhOX
 YDNPkHa5UwzwkojTUIu9KHf82KbQxbQb9UygKLcsx5RKGdTE4Z2N480ygzvaiskAueFtPxlVYS8
 ijqBTGzGz5sp6hK8C0oNNXJHphROVnwEZKAvJLeBrmcJgBI51rd+2BcMKCHqA717ibE3wd9nYTV
 bgH0KCzC1Fb5SqswvEv//ePLT5M4s2OfU7kWQ9Zo8e6Ko0NZFqhrYIw8c5XwOmv8YucDls8MtmO
 HugR0Km3hPqOUSAfuEGWVSNFfWzPuwcykI/EcVjsUSYKWQevqLqGZexTFAL4i+YRITNspjlbnKR
 AtJL2pcNro0SWEtcUrW2hN5ak6AUbIfemzRo3/j96n96BaoBCImRCHcduFKCdlSaeIpZYtu2H4f
 TXr9UMAh7c80tzAfjSY2vvcTb1lwO3S3loeXvqQ1WcWl4HtXC5vsyJX2pun4s6QST96xKYH5h8B
 5QMlXneIVb8+DyGPQZiOkP3MhbPIXKw3D4nLlLd1FT1KSFE7XOH7TFHJa+K/70i+NkhGJpCyewJ
 cU9CaRARJQ9Ihqw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Connect the panel with the backlight nodes so that the backlight can be
turned off when the display is blanked.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
index 4aaae8537a3f..8eaa5b162815 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -182,7 +182,7 @@ &blsp2_i2c5 {
 	status = "okay";
 	clock-frequency = <355000>;
 
-	led-controller@38 {
+	backlight: led-controller@38 {
 		compatible = "ti,lm3630a";
 		status = "okay";
 		reg = <0x38>;
@@ -272,6 +272,8 @@ panel: panel@0 {
 		reg = <0>;
 		compatible = "lg,acx467akm-7";
 
+		backlight = <&backlight>;
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&panel_pin>;
 

-- 
2.43.2


