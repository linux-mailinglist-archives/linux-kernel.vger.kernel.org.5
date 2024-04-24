Return-Path: <linux-kernel+bounces-157331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4B8B0FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B11F22BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007AE16D323;
	Wed, 24 Apr 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="8G/ghwxu"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCD16C84F;
	Wed, 24 Apr 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976464; cv=none; b=XmWIIlbqrztx+KQ7ylot8ZLuCCQCzpigksA3HUCkBW3/eCxe7wNebZvr5pGzX23alo3EKFPKLwOmD0JCAnQEHu1g70TNpjOIUIUptIthlTN6WyKaBBlay+kub6hSxcR+ASgjihfo1O0gJazeJTBC+mGv4e7TgblQ4Jb1L1KpnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976464; c=relaxed/simple;
	bh=IDBt5vHgqYpgIEZTqspSr+mLLR+HWHE8TJ/PpluCFfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqywv5zc0gFxgEtbN92DE/lGIJee2BgusuTPPtjkDXX3ofwBwGjWPSSz6FyiJ/SrOmD7FIJ+YYIcecO1Wd8bww23G7IgqHYkNn0wpdeNYN6wheFfDvRbdbFBBfyGo/ftK6jOFJh+f7ZOFCTneYIFtzar3D7cG7+AHx/l6+upLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=8G/ghwxu; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975864; bh=IDBt5vHgqYpgIEZTqspSr+mLLR+HWHE8TJ/PpluCFfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=8G/ghwxumS352eOhK1gr9Nnd3K00bjD/KBKfDSiP3txrS+JjWqd+D+x5kNgMezux/
	 O3JagZNSJfRodUKGJwRUbjSkTAL03L/lVgsPoGIRymVnDTZOC0b4E5OPmntD6UtVbK
	 HkqDKuicKf1RRRd4ODplj/D9AtuLSonZyHjWwctM=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:23:56 +0200
Subject: [PATCH 3/7] arm64: dts: qcom: msm8916: Use mboxes properties for
 APCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-3-6556c47cb501@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=IDBt5vHgqYpgIEZTqspSr+mLLR+HWHE8TJ/PpluCFfo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTIyHa29KSABFJSlT7LBcuwPT9whJfontd75z
 uMIxo7mTW+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyMgAKCRBy2EO4nU3X
 VgG7EACATNO/wLs0GXJihe3epk8vvBXvSeZw4JZV1qm/zi5ySjssnfvSS3CSy0oXvFrabbpg6vO
 X/FGhhbaFN2A4ABSmOHkFzy5U2huxGdlAydX+FvX2mbtAk4W+k+38MKU9i39E4nLckhCWdA6woZ
 frIRt0nP/Qfk8U8PrZkAjSI9+XIXFo3nwgf8hDbTGSat4R825jBp295Xl5nkFdUlJLbwsghYbMZ
 BMZaLyfnal1gGrA7PZ6mFCmXyDuTdg39CwhjyeZhsP+W1fiwtqctkhuvfap4fgBCVEZuynjpZxJ
 JZ9ESSzpxmsu1AVYClXfmoMI5w6GF74wUhXpKGU6vWy+7jZBXMPGUBM70wvItD6fIyuKupgQCVK
 22dr+Qm0aF+73g2pLW4sYMz89W/dbBTXJqlTLQAC7y70ITiuhRWoB5lahUfxSF32QEz+YfW0MEn
 cBBOmPFySOqBTGPRKPingwwh6syIdYPCUqwJect36oAjorEqn77PvKQ4y7kJtf5QZHvSmQ2tcZY
 t4b30zaTdeZ/HRgFiw7Mj6fJIElWPxEHjov7qeDeoQUz8HIpOY3NsbvkEBeG+8FwjlKEPIgxAuX
 KTkGaBCvO2GFITN1ARMqfaT9dAKXDkRmWT/Vor98cbHKK9Kl8CixOzZsCUQV1E5JmhqpdGWDoTB
 sb4BrbSAoVyx3tA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Instead of passing the syscon to the various nodes, use the mbox
interface using the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index cedff4166bfb..46bb322ae133 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -308,7 +308,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
+			mboxes = <&apcs 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {
@@ -360,7 +360,7 @@ smp2p-hexagon {
 
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 14>;
+		mboxes = <&apcs 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -385,7 +385,7 @@ smp2p-wcnss {
 
 		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 18>;
+		mboxes = <&apcs 18>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <4>;
@@ -1978,7 +1978,7 @@ smd-edge {
 				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
 
 				qcom,smd-edge = <0>;
-				qcom,ipc = <&apcs 8 12>;
+				mboxes = <&apcs 12>;
 				qcom,remote-pid = <1>;
 
 				label = "hexagon";
@@ -2459,7 +2459,7 @@ wcnss_iris: iris {
 			smd-edge {
 				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
 
-				qcom,ipc = <&apcs 8 17>;
+				mboxes = <&apcs 17>;
 				qcom,smd-edge = <6>;
 				qcom,remote-pid = <4>;
 

-- 
2.44.0


