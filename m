Return-Path: <linux-kernel+bounces-2667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9C816031
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4621281B62
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8446530;
	Sun, 17 Dec 2023 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="T/Eu/vLU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EA44C85;
	Sun, 17 Dec 2023 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1702826611; bh=1i/L1PXG5NykuzFxVKL7eBHoLIl2repmEychdXUJYDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T/Eu/vLU4I7mMDUrdbSsCllWti3PDvOef4GPt40+nsMpKO/OzmczcckTpOC3FD0UX
	 6+767upfiW3vJZQPvN5h27Y0v/NsiMnO8f+UxNTrOiqHX1fTW+KJXzq4CzGs1Hevaf
	 32ZZsEmNz37sByefRLBdfGBlcfchDbRWJ6rFYaDY=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 17 Dec 2023 16:22:55 +0100
Subject: [PATCH 3/3] ARM: dts: qcom: msm8974*: Re-enable remoteprocs on
 various boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-msm8974-misc-v1-3-bece1ba2667d@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=1i/L1PXG5NykuzFxVKL7eBHoLIl2repmEychdXUJYDc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlfxJwFdc9rAEiEncvhaXtVdq86LYr4x2Sh8I2T
 0QO4ocCbLmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZX8ScAAKCRBy2EO4nU3X
 VpG5EAChoA0dcmNtKC2tmtCEHr3nXy0F+J1PwTATxcCy1AoQcQBVzDokvB/J9jWNvAF3oDYMLI+
 MDhT9lL5l35qfQzx9B/MM4VRHQ9dQrukRIEagMCDvE0OFCxQ4efS2YzsoBknLre7WekwlnUodBv
 ZAmN4f6ys2p5rSApZslUsrLK/rATIL4nWwqik/lJ9sgkGXr2GPjLccnH1dSwPQUi5XokRpwlCg6
 cDmePYWoFFfCRjVdqaPa7elS/B0mZUXJ5f0FQgE98aigymlaAd5GUmbMl9OsK/IWbuUl+eq72K0
 yQDyYgg6xltR0KCAw82LVMa0SK0KPWP/8gMLcMM51uL/5jZ21z6AaHzuSO/zvNFrSS8+uhX0JzQ
 N/Diz0+lX/gN5CBbr5/5GSp0/+sJP2AUVsxWsFJydaSmLBbtuPlsttV7EDVuMprLqz2TUEdw+Bn
 QYf6C9nRBlivBZQ0a8HofXb3yrZMTwTFYZTx8ve5oRPGfi/xUL1hKTdgk78Zm4F9vhPVld0r7Tf
 il9unK3Liv4hWp+hN9thAP6K0Cz3A9ZAW6hmpca9ZXb/Mf91oR5HvWTeJ3btJUJKlSovo4bEN6z
 N4JdTLXDRdddivniq2k+ljMs6gpgfccja/aqB1bIa6Pa+HroUSIGfLEuP6TePVzRUgM+veB6Y1W
 +/x/OF9+8B8KWgQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Even though a previous patch re-added the supplies to the adsp and modem
remoteprocs, due to timing differences in the meantime the remoteprocs
were disabled by default, but the commit re-adding the supplies didn't
enable them.

Enable them now to hopefully properly resolve the fallout now.

Fixes: 6d933c0ec171 ("ARM: dts: qcom: msm8974-*: re-add remoteproc supplies")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts         | 2 ++
 arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi            | 2 ++
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
index ca402b4a68bd..4aaae8537a3f 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -367,6 +367,7 @@ led@5 {
 
 &remoteproc_adsp {
 	cx-supply = <&pm8841_s2>;
+	status = "okay";
 };
 
 &remoteproc_mss {
@@ -374,6 +375,7 @@ &remoteproc_mss {
 	mss-supply = <&pm8841_s3>;
 	mx-supply = <&pm8841_s1>;
 	pll-supply = <&pm8941_l12>;
+	status = "okay";
 };
 
 &rpm_requests {
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
index 94cbad81379f..d34659ebac22 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -217,6 +217,7 @@ &pm8941_wled {
 
 &remoteproc_adsp {
 	cx-supply = <&pm8841_s2>;
+	status = "okay";
 };
 
 &remoteproc_mss {
@@ -224,6 +225,7 @@ &remoteproc_mss {
 	mss-supply = <&pm8841_s3>;
 	mx-supply = <&pm8841_s1>;
 	pll-supply = <&pm8941_l12>;
+	status = "okay";
 };
 
 &rpm_requests {
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 7c6fe442b559..ee94741a26ed 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -324,6 +324,7 @@ led@7 {
 
 &remoteproc_adsp {
 	cx-supply = <&pm8841_s2>;
+	status = "okay";
 };
 
 &remoteproc_mss {
@@ -331,6 +332,7 @@ &remoteproc_mss {
 	mss-supply = <&pm8841_s3>;
 	mx-supply = <&pm8841_s1>;
 	pll-supply = <&pm8941_l12>;
+	status = "okay";
 };
 
 &rpm_requests {

-- 
2.43.0


