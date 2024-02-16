Return-Path: <linux-kernel+bounces-68593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872C857CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E195F2817C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A712883D;
	Fri, 16 Feb 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mx/s39uU"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1658203;
	Fri, 16 Feb 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087650; cv=none; b=WEYhv5ZS1xfA8oV9JUGza+RZZu8C/rGJoMwHBqIII8W1Of84r1ZOLOCxCG8bKZpg1mSmNQxCkteUv/Q5VYA5/LkE3zTzCeCRdzOYgbjFNN62Xh5qQ//vBkxbI0tefrWPZxtQLzOK7vA5wVu16mp09W2+6JhOHbosnbZoNvQdaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087650; c=relaxed/simple;
	bh=iusSZqsywZoAGHlkNH4CuV+VDegpKTa3oydf2OYat8Q=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u8fEJC0J9lOKz4N5wSVCs6smFEXatLDha4kVkjHdtxuSBQdcKdX6fXD4r61qeqceTehRT6rs+nxTUV7n/HoJctxqDEQAFCg2pmXlxGgfiH8cCCDrFBwIJQ8Js13O2O0XZzjHXhFiUM3QDcTvB9uWlNQBWAfn0gw/6T4S/wVs120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mx/s39uU; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1708087630; x=1708346830;
	bh=VfZEdqnF7VP+FLhYp67kYP6gCOw5onHI/KrjQrTFpjQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mx/s39uUE4x3KNJKHQYVx93vDx7BuzrnqYlkGSeIqAhU/mABfzA+kaRoaciiCtOEc
	 1xFU1vGbnP7zAT20U1f6dyWK9FEkWHMt60l2+T7KhioCz3dJdgOZdYMT6VLIr1ONe2
	 lqD+bM8FO5xE/fQ9P5h8FkzT1EQWsEJjHputN4lMobGc/ZM/HdhtfhsiocegseITWp
	 rOM9xV5IFeQLLjgcQNmpR+hy8M26Ak/1Q78llNCPFi7San5ub411p+lY8YdXYuuLEO
	 2RkjBk/GuU0Zml1kMo8vd39qIafxqA7cD+h+dPSEJtzOGJkO2LJUFK0WovXi7HpoLf
	 9O5puOSpiZvcw==
Date: Fri, 16 Feb 2024 12:46:50 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Joe Mason <buddyjojo06@outlook.com>
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add fuel gauge
Message-ID: <20240216124639.24689-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Joe Mason <buddyjojo06@outlook.com>

Like the Samsung Galaxy A3/A5, the Grand Prime/Core Prime uses a
Richtek RT5033 PMIC as battery fuel gauge, charger, flash LED and for some
regulators.
For now, only add the fuel gauge/battery device to the device tree, so we
can check the remaining battery percentage.

The other RT5033 drivers need some more work first before they can be used
properly.

Signed-off-by: Joe Mason <buddyjojo06@outlook.com>
[Raymond: Move to fortuna-common. Use interrupts-extended]
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index 052024073f54..c2800ad2dd5b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -80,6 +80,20 @@ muic: extcon@25 {
 =09};
 };
=20
+&blsp_i2c4 {
+=09status =3D "okay";
+
+=09fuel-gauge@35 {
+=09=09compatible =3D "richtek,rt5033-battery";
+=09=09reg =3D <0x35>;
+
+=09=09interrupts-extended =3D <&tlmm 121 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09pinctrl-0 =3D <&fg_alert_default>;
+=09=09pinctrl-names =3D "default";
+=09};
+};
+
 &blsp_uart2 {
 =09status =3D "okay";
 };
@@ -152,6 +166,13 @@ &wcnss_mem {
 };
=20
 &tlmm {
+=09fg_alert_default: fg-alert-default-state {
+=09=09pins =3D "gpio121";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
 =09gpio_keys_default: gpio-keys-default-state {
 =09=09pins =3D "gpio107", "gpio109";
 =09=09function =3D "gpio";
--=20
2.39.2



