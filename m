Return-Path: <linux-kernel+bounces-2668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAE816032
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEDF28199A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95446537;
	Sun, 17 Dec 2023 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="4BYvUY06"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966C44C8A;
	Sun, 17 Dec 2023 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1702826610; bh=U4O59YmzzkaM+IwRrSwfwaATM9KrO7ydMyjrM5tHghw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=4BYvUY06lpy8QKSYTk8QtcbsuGpWfmcWZVh/a6kl3r8L0X2YbRj7NlfuIUXGk4m27
	 Ffg7lYB3F79DHAH4rQcpk+mxsUVF2Gb9n5kgBJKygWUWASPKeh1tNbtFX0ZDVasZRU
	 0C5lbB5htIM91im09in+49fc3KlSTkABeYesv9oQ=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 17 Dec 2023 16:22:53 +0100
Subject: [PATCH 1/3] ARM: dts: qcom: msm8974-klte: Remove unused property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-msm8974-misc-v1-1-bece1ba2667d@z3ntu.xyz>
References: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
In-Reply-To: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Pascua <pascua.samuel.14@gmail.com>, Iskren Chernev <me@iskren.info>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=aucsrlJ4PTIT5voU1HDppqMa8ZN5XwYsMHWrI4VbcJo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlfxJvV8Hv9xjx03afxu1anN0JbZz1D/OGNWKr3
 Qagnuj3emqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZX8SbwAKCRBy2EO4nU3X
 VrcDEACSzDi/wwu5f4Sf0K6hRhZDXUq3Uq882Vjvw8uNSGObjYqav1orK9ZWTfk01aOROxYnDjp
 VdVEyhUesBiDlZFkCpwuKvVwvDHkd4tTn4RHi+YMOh6JcsOkfuaurrq/PkU5GliNc0mHHo1KAdO
 av78tiwyWU3TdGxdAhZGaCXUR5Ovx8rgsaeH9lWQVnmmEJd0NFF6/LsUGA9/l9DgZ5WkiRFrBuV
 mT+a3A1+kC5a+7Snagwk1AxXud8o5wKBQxnJMJA9hbWrUl37pJ47LZHAkFFWhKRW4f37T8wS+c0
 5mj0BIqTLDPdCuDjgumvyYf2sNN2hmU8KX2A08FvQoQWHcwjGVIMYBf7+tXQ30KHqaxfySl2XZB
 HkaoQv8Hs23oPrb39+crQ5dIpH+X+UsJmsWRJdyGCRTg947c9h3OWXWA4OFnv/4QBCBLMx+VpI/
 54gPbtT96O9Rq5c5b3Je3Y6Od3GPanX4gW/oZoeVU0Ufi4/CdZl3mleTc4Bb05UUPrHNFEGKyG8
 PJFOMboLuGA+5AwMVmywqiv2v9LL2xB65uq5vWJRUaBHFCWcKUiJr+xse3cWCOxS3Id1TEOFlJz
 b5iZgboLdsJHQuNHaUb28fqzH8WN61bG5GkJNcjjW7v3CfjTPX7yiAg/jbiG8iWH9E7/vmtGAgI
 r0HFiG/K9zybLnA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Alexey Minnekhanov <alexeymin@postmarketos.org>

Panel driver samsung,s6e3fa2 does not use te-gpios. The pin is already
configured properly through pinctrl.

Fixes: 3657b677d20d ("ARM: dts: qcom: msm8974-klte: add support for display")
Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
[luca: adjust commit message, add Fixes tag]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
index ca3aa16b4b10..b93539e2b87e 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
@@ -363,7 +363,6 @@ panel: panel@0 {
 		vddr-supply = <&vreg_panel>;
 
 		reset-gpios = <&pma8084_gpios 17 GPIO_ACTIVE_LOW>;
-		te-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
 
 		port {
 			panel_in: endpoint {

-- 
2.43.0


