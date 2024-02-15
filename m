Return-Path: <linux-kernel+bounces-66888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B57856328
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235B21C20A46
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111112D74A;
	Thu, 15 Feb 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Gt/tu+Bm"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0E12C522;
	Thu, 15 Feb 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000143; cv=none; b=EfqdRWESZFUreUU0wUppXuWrTn/sg8JJU4nTlDfNkjUY70dlgd5PhR56NG3kNmSN4Uw7L6NhMRpMXMhYFzwwgTKEhzHp4a0VaETcoq4W0ojfPBOHBkQxvN+dgT2guHo3xAxG4d4yjxEHxRitysi+jLhF2xUZkMOIBLO2QFpBk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000143; c=relaxed/simple;
	bh=XWn/5rkeMC3EwrTcHX8+1KjZarDety7nInkfDIyao18=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H6cfbkRGJAjY6MeW2WBYf/H1DVQyFh6CV9+AErcpjKcBA+y8H7qMs7mVvYK30u0KglVvPkORYM6FZcfD5zEuJiD1MaT2plUUX6hxevAZl0OBjz6bV2RAHCJwUzCn1Ex5FibgIUlTy2LRk82Dz5afhmVo1Z62Bta1v1/5fd8HzEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Gt/tu+Bm; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1708000133; x=1708259333;
	bh=escI57YZz6EIQiDGXdanbLIoEKO4yLQ5pM7Z8MzCj/g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gt/tu+BmLBBCT1lDP0fOOJzrJdGZqeSkMa17oCr7ZNQLB81uxAsiPjuepcKA1Xrf8
	 MPRcYgMwK8TU5+CJG1oRhqUroP244Q1m2/dQcVOZ5EEeIIvCNPkB6RRd/FOaO715OL
	 PqTeI0GzhOL+0lrZjNg1x+fAKSbGPUN0NR1sMgPT4mMtB/Ordf61uFg+hBSn1V276G
	 gQnWoXHW9ZEyVPOEe2yHpcP47lrqW0TJAfNt5qIQCA2y5pNiKl0/aAXdzmpjKeofiw
	 N19IR+ZFG+Xeu2rqBgzZknN2QwplsGJPtyeeY7YNsYmAprEsnbWwB7NXCXYoE6RMZH
	 jQIt5ZaJ0t05g==
Date: Thu, 15 Feb 2024 12:26:17 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jakob Hauser <jahau@rocketmail.com>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 1/2] arm64: dts: qcom: msm8916/39-samsung-a2015: Add connector for MUIC
Message-ID: <20240215122605.3817-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add subnode usb_con: extcon for SM5502 / SM5504 MUIC, which will be used
for RT5033 charger.

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts            | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 2937495940ea..4bbbee80b5e4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -128,6 +128,12 @@ muic: extcon@25 {
=20
 =09=09=09pinctrl-names =3D "default";
 =09=09=09pinctrl-0 =3D <&muic_int_default>;
+
+=09=09=09usb_con: connector {
+=09=09=09=09compatible =3D "usb-b-connector";
+=09=09=09=09label =3D "micro-USB";
+=09=09=09=09type =3D "micro";
+=09=09=09};
 =09=09};
 =09};
=20
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index 3c49dac92d2d..c50f81a68897 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -23,6 +23,12 @@ muic: extcon@14 {
=20
 =09=09=09pinctrl-names =3D "default";
 =09=09=09pinctrl-0 =3D <&muic_int_default>;
+
+=09=09=09usb_con: connector {
+=09=09=09=09compatible =3D "usb-b-connector";
+=09=09=09=09label =3D "micro-USB";
+=09=09=09=09type =3D "micro";
+=09=09=09};
 =09=09};
 =09};
=20
diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/b=
oot/dts/qcom/msm8939-samsung-a7.dts
index aa6c39482a2f..0c599e71a464 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -286,6 +286,12 @@ muic: extcon@25 {
=20
 =09=09pinctrl-0 =3D <&muic_int_default>;
 =09=09pinctrl-names =3D "default";
+
+=09=09usb_con: connector {
+=09=09=09compatible =3D "usb-b-connector";
+=09=09=09label =3D "micro-USB";
+=09=09=09type =3D "micro";
+=09=09};
 =09};
 };
=20
--=20
2.39.2



