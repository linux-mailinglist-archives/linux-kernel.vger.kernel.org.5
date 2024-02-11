Return-Path: <linux-kernel+bounces-60634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A78507C4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F121C223B9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 04:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCD171D8;
	Sun, 11 Feb 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOnI5HGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B817D5;
	Sun, 11 Feb 2024 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707626253; cv=none; b=csqDVk8ULuYZfSEZGAPng229arhgPOlOKrGj62b+vuGjiAoBC86mVhYCMmuTl/PyVcFtbrceqVfk7Bq299uQie3MSsKAelbZZF+VHGYKGz9wLdv0q7bezUTIux/7JlK2G/i5Gjgf9n9W8xzmTQcF2bxjA1RdqbKHk3ZINdFeQYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707626253; c=relaxed/simple;
	bh=7Tgpfgy2gZK7gG0Vu57dji3vdBwL3zjCkXajRYIQiEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mx/Y8fPnULeXjYGulR4DtkxZCfV8VLrFG3wBrlNOYrh2Bh5Ds57opyn974Smvzz+w51tIb++b2wKFIK15FCD51hWjuqyKCe7vdmzlB3uejaQaePX+NFwavYV4M8JyV0kqZArxnNW/afUR1vUW4h/H330kGaflPkkolIc3AAO7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOnI5HGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE828C43394;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707626252;
	bh=7Tgpfgy2gZK7gG0Vu57dji3vdBwL3zjCkXajRYIQiEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pOnI5HGUNJoLJtuXDQKaPUAiwdcrwlWOMsba7NMOE560N96lOOB4oVSXhgoNiN+l5
	 WKi23x933LfRp/IRX+8urCfqBjcv7D6lmUpHAlDIfoUkKMrBDRrfkzLo3gEQ6d5TvY
	 RW/wSRMb1h0RtvTKqMxZ3Ym48oOk15fFe5y7hJ20Vr3dduZmWJzehZHnrWyitrbJbU
	 cvMsxrVUFNmfxGV/oTxYM/XsCxetaKihxufvNIePOugBRxMAS69dz8WhjNIlxlrODe
	 OjiR8qmWNq8NfkYacnMuCygwWhWRlW6QngkeLMWTEejzistOmBkxwm1nl/irPKWEkZ
	 hI4OOXnyODthQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3CBC4829F;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
From:
 Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>
Date: Sat, 10 Feb 2024 20:42:00 -0800
Subject: [PATCH 2/2] arm64: dts: qcom: sc8280xp-pmics: Define adc for
 temp-alarms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-sc8280xp-pmic-thermal-v1-2-a1c215a17d10@quicinc.com>
References: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
In-Reply-To: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=K7rQywm19ZMJOEqTCjhdaKmYaGUNjH5+Bg7BEu/x3tU=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBlyFAXylL8zK5qj0ajAD7+jN8JFAwl72hjdDBAR
 evaltzZSm6JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZchQFxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUwFhAAp6X19C1/915JgP6bSfzLi13eAGiI3IFxPXxGKP1
 Cg91LS/4pyv0OygvGP8BrhXm9R5fNyMIxjbhRAjazIfkWdPriIGdMEUUTBco+2BFrB4vEGkiXH+
 98DDKC4UErvnb3c0rodDZkvycqsbMKhKeo/8y/GeisD58oMWSqMV8nCv0lifkO2tD2IYak7MOcZ
 SZH9xN1q6p2YSYi5kerWUWrgjf1Q7OjRtYavFmBWn9+nPnvItCRNd2GW8/H72WOvtEHKHgjYT60
 1gTRNGZnk3L4sciH+5DRceJpD0GmA8uCJmWf2HPbc5KYai+ThNu2ieRcwGVMZ9rASSH7BOVkd9c
 VVkQCfHmq2aj7WtRcG4m9bRutSI9A7TyFIAEcJojJXP+E2esmq7xGRhnN7MjMnFEVVYc4C1G+5g
 +0naX0Myh24lJLzA7EcJK9D1BiW3Xwm1Hr7/UhFMccptwfZ2HJdZ9aFjcIeCM+HXlkSVsp8QCIh
 ZEQVCKJRrKdr3GKyhCmO3+3LlqJ1KkwWvTBZKIimsRrmI2hxIt9Qlk8aF9X+Kf4zc/YXQEsDJId
 7ZjtCI9mWgcIlOxY0NsWr8bhv8/rZyJRnnKBtf3I03q68HWiMqgQD1DFPDt85Uzl26X762jHzik
 jmEe1WS8LdIxgSvxVL5YpBKbgdEtK8gcnsbTalMyWtMs=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Endpoint-Received:
 by B4 Relay for quic_bjorande@quicinc.com/default with auth_id=118
X-Original-From: Bjorn Andersson <quic_bjorande@quicinc.com>
Reply-To: <quic_bjorande@quicinc.com>

From: Bjorn Andersson <quic_bjorande@quicinc.com>

sc8280xp-pmics define the two thermal zones "pm8280-1-thermal" and
"pm8280-2-thermal", but the related temp-alarm instances are not tied to
any adc channels, and as such continuously report the bogus temperature
of 37C.

After previously defining these adc channels across all boards using
sc8280xp-pmics.dtsi, we can now add these references.

This does however mean that we have a non-disabled node referencing
default-disabled nodes, requiring each board to enable the pmk8280_vadc.
Avoid this by marking pmk8280_vadc okay.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 --
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi               | 5 ++++-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 22f10813aa3c..ffc4406422ae 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -604,10 +604,6 @@ rtc_offset: rtc-offset@bc {
 	};
 };
 
-&pmk8280_vadc {
-	status = "okay";
-};
-
 &qup0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index ce2564a6c26e..ad42966c94e5 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -851,8 +851,6 @@ rtc_offset: rtc-offset@bc {
 };
 
 &pmk8280_vadc {
-	status = "okay";
-
 	channel@144 {
 		reg = <PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time = <200>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 58fea376f0e2..945de77911de 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -87,7 +87,6 @@ pmk8280_vadc: adc@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			status = "disabled";
 
 			channel@3 {
 				reg = <PMK8350_ADC7_DIE_TEMP>;
@@ -160,6 +159,8 @@ pm8280_1_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
 			interrupts-extended = <&spmi_bus 0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pmk8280_vadc PM8350_ADC7_DIE_TEMP(1)>;
+			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
 		};
 
@@ -212,6 +213,8 @@ pm8280_2_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
 			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&pmk8280_vadc PM8350_ADC7_DIE_TEMP(3)>;
+			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
 		};
 

-- 
2.43.0


