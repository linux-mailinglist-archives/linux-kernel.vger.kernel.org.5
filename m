Return-Path: <linux-kernel+bounces-157309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8328B0FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D3EB23AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F416C437;
	Wed, 24 Apr 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="YDK5LxJn"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A415EFD6;
	Wed, 24 Apr 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975875; cv=none; b=EBawF0FmbG6ZFwrgbE+GNKt3t5fJaBpL1ZpD9/56C1NNqjh7TiOC2+oPpcYvpqK7pEBGaCWTmGc6+fYn0pHlO0HPjBybqQMP0iTap6m++PxNeK8SwGJUZllzdM2dCJqNa/uv7ljNpQp4UFbxatAGFV/nTW7MO82XhYJpDl8xQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975875; c=relaxed/simple;
	bh=JUbWmHCb3T8yAcfb7RyjaJZbwwO7FX02lWGqRfiyVjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cywogibpLb809xXDkbDXkKHf+BLoY2Tw3edPiPPRjGfwFiI4gpNK5hoCD3rKkAo/DXkKPmqVkKBroHYz0Zu5BPA/i9rk4nxmlKGMWgo8QXP3FOnVSRUEv6lxowZ9q0Tq88trRHWTiomwwYssGdTy/iV3YUtgOyCH5moKMvlFQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=YDK5LxJn; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975865; bh=JUbWmHCb3T8yAcfb7RyjaJZbwwO7FX02lWGqRfiyVjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YDK5LxJnXBBoPpxKs7uvgcUNCts+ONzAhWhTHU8xA3PnLYgvO1sedTV+oAqGoKIBG
	 6/bJ9AvI0RaKFO8eMC611uqFTqc39Qgq9w4TFd5X5kdAwfACshbAY4SlCcM5d00FWX
	 5QZA48N55xhak71234M+9bvGTGLIj6uJVRnxhOd4=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:23:58 +0200
Subject: [PATCH 5/7] arm64: dts: qcom: msm8953: Use mboxes properties for
 APCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-5-6556c47cb501@z3ntu.xyz>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
In-Reply-To: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=JUbWmHCb3T8yAcfb7RyjaJZbwwO7FX02lWGqRfiyVjA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTI0Y/jMRq3mMIsHqHHAQytZXu+YvdQ2Gu627
 rlO70/NOA+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyNAAKCRBy2EO4nU3X
 VpBJD/wNe5X40OAsGLaI63X5nBWbFcAv+qQ/OAWs0Gdy9ypN39JJtYkTujY3kOLk6DDbJtqWuB6
 qoO1Qs+fqbyHCX6guzbYCpGJFLgJ+OD27aYWcGe3ljvkA0KydQ1rDSX/49c41z3Zz5dKkSZnswA
 mAmK7CSUxfa8uadmoIZ/3P0KycO7x+LWWGLuTVpabH7um/KOlmlYO0faX5m8s8g/PcrtzEP//fJ
 aQfS6P4A1D8H1F/dw2xX697a9oBh1rbTnLJJRWgwpLb5NVKlYkr13GEseIT+0XOpZubSpzGjg+/
 GW19dUt09NWCbSZ4KDUF49LRTlNvFXSiwB+ytP+W5ICf9xwIE3hSeCCnTCD5UO9VaolrR+ukNc7
 NJtene0LCDJ9qBUDWJeT6nFoFI6I9OYmNfK49pABA2G9b8nGDQ4FHvZMTdL9uCGKec5A7N1DHT+
 G6GI40q6ySc9lw/iuFXuHum+Ayp2rIvB9hvcaUeO37hsgUvmTYqxD0NhghJqX0KB0+B0e7KSsLF
 HvhveBnQDXVK90Dfxbm2Xt2YN4F863rxeJxfu8fETWSfaau9ygCmq+SyI0t1z4XdG4uU8+zxZCH
 5d3Knet+w6jKp1Ede6kwx7MlbXrolXrvbGNiIFJ9HOZ+Q8MounaaFvjjcMg0CJ6u8Ag06g4eUmh
 FCYFh5gE9L1TVtw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Instead of passing the syscon to the various nodes, use the mbox
interface using the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index f1011bb641c6..650ad75923f8 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -195,7 +195,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
+			mboxes = <&apcs 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {
@@ -361,7 +361,7 @@ smp2p-modem {
 
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 14>;
+		mboxes = <&apcs 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -386,7 +386,7 @@ smp2p-wcnss {
 
 		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 18>;
+		mboxes = <&apcs 18>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <4>;
@@ -1267,7 +1267,7 @@ smd-edge {
 				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
 
 				qcom,smd-edge = <0>;
-				qcom,ipc = <&apcs 8 12>;
+				mboxes = <&apcs 12>;
 				qcom,remote-pid = <1>;
 
 				label = "modem";
@@ -1734,7 +1734,7 @@ wcnss_iris: iris {
 			smd-edge {
 				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
 
-				qcom,ipc = <&apcs 8 17>;
+				mboxes = <&apcs 17>;
 				qcom,smd-edge = <6>;
 				qcom,remote-pid = <4>;
 

-- 
2.44.0


