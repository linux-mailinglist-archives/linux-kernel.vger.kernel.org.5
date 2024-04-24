Return-Path: <linux-kernel+bounces-157307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F08B0F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893781C24316
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AF161B7C;
	Wed, 24 Apr 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="i8rvFTW+"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64ED161314;
	Wed, 24 Apr 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975874; cv=none; b=I4fDQb95A+ZT256hTfDRqpkmFVwgmd7nU2tfo+oEdNJgQgLAtFhazveBTn2MMX/kqUsnqJntrZMtgz3tqAxZzbyFVpd17T4XQ+amcrlpkX297saLOPPi0rEvkh6G5QPqTkOLqEzRnw0V+LnXfcJ0YLHgJC8d0qRz5lMW7cBJ3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975874; c=relaxed/simple;
	bh=VF5IKVYD1Jky+tckvrVMe82GoXHAOuk4n3wijFv2Qoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gDFWYkeDZ3VPhXh7Jqw/TdfZmNlSBSoYbmbMmQPN37LpPIuWbLpzLI81Iur4pOGs4d3lI+knCgUI42ys0ESxFh5L6HDzFtg05dxI2rIxCArXhVXEpAqeBlfFm68R/h1/4uuR9CeZV9dyi1dHV8DQz7J1R8LlAbdlCe7e29Nnjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=i8rvFTW+; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975865; bh=VF5IKVYD1Jky+tckvrVMe82GoXHAOuk4n3wijFv2Qoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i8rvFTW+jf2yLB6sigAWhUhByu0z/hBT4OvBKx9HTmlPFxyjHuECqbF8QObVcN8qy
	 Fs0Wu9PgiTlqqbcOtoYao9LpbtQ+sdgKAIWt6j8VTlxKK5EUoE2cO2OnZxKXoQ6r2P
	 6L76hoTmTA3nc9NxSP7dP7vriBg1HJTx2YN9l5d4=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:23:59 +0200
Subject: [PATCH 6/7] arm64: dts: qcom: msm8976: Use mboxes properties for
 APCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-6-6556c47cb501@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=VF5IKVYD1Jky+tckvrVMe82GoXHAOuk4n3wijFv2Qoo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTI1sGwYu5apSYgnnIwAzRat1FrEffAKvKfnk
 NixfBEVgE2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyNQAKCRBy2EO4nU3X
 VjJ2D/0TzkFQY8jBf1QIJN/2SgS9IBOLpvUPkbBAbCUih5X0hAioEtEsfzCHvZPCTWhPIXIW26R
 PMI/ujVCMPHvUMAMYgiWdRqkfZtH1WqDCfTWwPy3e0cuNxf9hFetBqRd9ND2Z7Fb1JAi79VENID
 GmBNNK+uMEB4EO4ZS3ccFvJ7X+Uy38N0nD7H8a+l7KrmtirdJf9mQel6kWM5RE7c5Hhdnq2TnqB
 XIv3QWM6HSigmRiPclYzXlveNvbyJglUiNWFltTFJrJ35uO9WEeYbISuRI/6/HurGkm9oWUsm7L
 pAdS+6pCZtwIBFvm816r34NzNJMev5QIMF8u6bzijEJSq2lTGuZpSWLX3MYY4YIdrUfTT5GD/BV
 ymRD+Jo/C0XHSoiWX5O1RfBHYiqbS+cvdybpe4ocgdxQ797KYShg2AvuxcbmM990hegyc4Yg9oo
 yfVCtp1xIBrQAvnZVAhIloXa2uDmgIvaverkA1acya9IFkxg+t/M8CjsZyi+tBgPpsCu1kqUrmH
 Fz9vFs9WbyzKjHYbqV9ITaO+ewWOXLYnMEZSlP1COVGtej3yZ+fpEU4xx455obztFPaw5c0UqcO
 ecKE0zQesDOsOQIk7JT00P+NmqT7ADW/QztPfrWnpLRugHGlkizG84fIXMTxLoc0CpzqOTnmvLr
 U29WxEbs+vra5Mw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Instead of passing the syscon to the various nodes, use the mbox
interface using the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index d2bb1ada361a..9ca0867e45ba 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -237,7 +237,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
+			mboxes = <&apcs 0>;
 			qcom,smd-edge = <15>;
 
 			rpm_requests: rpm-requests {
@@ -361,7 +361,7 @@ tz-apps@8dd00000 {
 	smp2p-hexagon {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 10>;
+		mboxes = <&apcs 10>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <2>;
@@ -384,7 +384,7 @@ adsp_smp2p_in: slave-kernel {
 	smp2p-modem {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 14>;
+		mboxes = <&apcs 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;
@@ -407,7 +407,7 @@ modem_smp2p_in: slave-kernel {
 	smp2p-wcnss {
 		compatible = "qcom,smp2p";
 		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
-		qcom,ipc = <&apcs 8 18>;
+		mboxes = <&apcs 18>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <4>;

-- 
2.44.0


