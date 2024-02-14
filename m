Return-Path: <linux-kernel+bounces-66005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BCD855524
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE131F29472
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7D141987;
	Wed, 14 Feb 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="ickAzGzd"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F513EFE8;
	Wed, 14 Feb 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947205; cv=none; b=hoHC6P9lWEhOj1m57xtplKyifsmmhytMIErsib5iMw24oJ9pxdQW/Y6/gjR5mKiyTuhHw+GqI4jk0IXO5DDjCB396VZvkCbNHdI8Cd6qrHkLxorbKwAwdvtOeh6MV8Ay5ye3VpHzk1wlwhxmepw/wyuM1dWScXi6+v6JwDCbNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947205; c=relaxed/simple;
	bh=mx18EcUr2MAGAIuQ1w2o6Jn1dgMRzRLoWNz5y/ansH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FVBLFap07V36uNsIH+6XB8p1mNqxI2zC/vp4UDJJqvbd0mMQBG3dIVjpIMQAFBmevuaaGVgTiu5TjoOGQeXGM15hM5xEPUMwixefcoMTwqMI0hBwqZjJ2X5dt6SgVPYJrs8lhxryBQiQy7H1Znu6qLQdhTynv76s2jP6fqsyJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=ickAzGzd; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707947195; bh=mx18EcUr2MAGAIuQ1w2o6Jn1dgMRzRLoWNz5y/ansH8=;
	h=From:Date:Subject:To:Cc;
	b=ickAzGzdjDmmrLVgLQd45xHj+Z2z1AoAgR9yh8zw06MJPPnHD3yK2h1TDtCPFhw0C
	 OvefBTBL/WHIkMTvsfdtiD4upnYNW/TCbbO+rqsNCHxfNC+ZAVM3yr3KID7A4i49fH
	 DIluQd08pNDpFqr3eXK0C5ZMPGH19qkCEfjRogHI=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 14 Feb 2024 22:46:28 +0100
Subject: [PATCH v2] ARM: dts: qcom: msm8226: Add watchdog node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-msm8226-msm8974-watchdog-v2-1-a6b2f27a7e28@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIALM0zWUC/42NTQ6DIBSEr2LeujTwpJV21Xs0Lig+lYVowFJ/4
 t1LOUFXk2+S+WaHQN5SgHuxg6dogx1dAjwVYHrtOmK2SQzIsRRcCDaEQSFec94qyT56Nn0zdkw
 rRfLSSkItIc0nT61dsvpZJ+5tmEe/5qcofu0f0igYZ2hkhUqo9mXosZVufp+XdYP6OI4vpI+A3
 8AAAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=d0RkSxDVWaD71ZNgKTWr7a55ePkgE3wWgDc8+5TsWCg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlzTS3PoN8ow/AciksTfluD16ACO7NfIKkp21Dp
 s6yddR15ROJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZc00twAKCRBy2EO4nU3X
 VqjfD/937OI5+gfJ7DyApuB8tB6pdzqxXS57qeMQsfvukLVz1AJzA1Oxocb3GzhFNWhhzuDOdH4
 6lwU52D3MsNGIL4rxk8h9bRNZlCqcJE+avG3slssQtf2YvJ1l6p60/RxtzwQ3DFrhLIt8Mo1DiQ
 VPRjCkJzWvl3gD8IbOdUveWF00Pz0lh8KhD0UxxPWPUZ6lcth9T++x7R+umXMwElQBU0cWuXWg+
 ESc/3j+xsStF6s/29Nzbyn5gl5mDq48aGFh7DwHtSmVMBkuOtzWC1UhUVrNN9QKq9QkFESih3UP
 w831egyytwKcWgWqRqoby1Qrf5Xcn+8asAxUHIBBeHY+eX8TACrrTNEJaGc+WbA89kPTZpz5YGJ
 98EyE+AoDJrpO3ZcJSSWPRuzB9+Y5rnL0XyKrIVTuPn2XpxPY5KbM4liwAjc7giEpY4yvELkbVi
 Do4/oOck4bJlE3AbMgW+qN6QZYi97I1FeLlyiVtOCkDz1YDgRhFjPlfeTBNTd4N4mLdi+iKaY8V
 SO1ltec8DAfqX6kg45Qn0CbNZi7OJJEpa1uqRGY+YjSlrTfq0KP3WKrgcOVtQlCyqZYs3GMly1/
 QPMffy6PQJi4AykgDCSwbLOkNdAGfnlZHShtyJMxWFhbBPyShBM7+erSxitX/Z4u/41lmeYCgGD
 7jKsAd39qF/GaUw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Add watchdog for MSM8226 platform.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Rebase on qcom for-next
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 8fae6058bf58..270973e85625 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -241,6 +241,14 @@ saw_l2: power-manager@f9012000 {
 			reg = <0xf9012000 0x1000>;
 		};
 
+		watchdog@f9017000 {
+			compatible = "qcom,apss-wdt-msm8226", "qcom,kpss-wdt";
+			reg = <0xf9017000 0x1000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@f9020000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0xf9020000 0x1000>;

---
base-commit: 2b3f57690f30a70ea87aab7169388956fd1932db
change-id: 20231011-msm8226-msm8974-watchdog-a88e45f4e2a4

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


