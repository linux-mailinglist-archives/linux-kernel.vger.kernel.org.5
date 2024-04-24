Return-Path: <linux-kernel+bounces-157124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782468B0D23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359A2288AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E00715ECEA;
	Wed, 24 Apr 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DVHkQQS2"
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C091E493
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970184; cv=none; b=e4Mp0uOpzEt+ZYTfjuRfD8ns/Tsrnq8CFIlCWWoX1fIINnrpKddAP8xHCNDSzt7gi+jBr948Y5hFPBNiDWOGYkscuQTqp3bz6Ni5K+cgY4eXMj6QxJSgp10nf4m/qr9fFqnnCMYDV6yMb2A6jFNCp8pEN/fH2TyQCJMiPa+Ht1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970184; c=relaxed/simple;
	bh=UhytsUo9VBh/+t1V3Z4MvovH2cCjum7PfSADfjigeko=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aTXN+fdya3Sq4wQHmX/ThqymjhvEd4WojE43XQCkYEk5yN6EyJlu0/LWtY8gbYzDVW6lgHzQxCdTkeCsU5UQ9yhclzuNpVqQTFu79RjOVJ3cg608+raQO36GwlqPtngto1v2WSnAlY/pM80ail5t//9Ka0IebSalsQrMU561cYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DVHkQQS2; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1713970180; x=1714229380;
	bh=VEe3pOZHo9UZJqzOb18loUkmy2Jdqv45LZK57Rv1two=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DVHkQQS2dADQ7U2fznF1wgeLqjuQnJ5yIN/6gfiEwV8ZU49B+w2TQ97qKmd63G4Cb
	 ybWNo4OeLgIQsa7qd0iVdNY2gIeuPLl/b7PhfXExDpbgAyQ90pcTyGKXPbnZn6ocG3
	 Lw5KRdGp+1Fu45udEdV3O0pgcIoCmwVOnCYvkDAvHaPQMY0pIvpKNf+PK/c1nTMylu
	 Ga8tca55g5H/BA4/9Uqlrv3HffbQ8AVTefqLwkrwKgyrhcj865TyQJqmWR1DPo/hSi
	 CsLkFCoOUtz4JtDBCxmE8k84GwVJN2z8PbFBU9lsD194t3O0E8JRHuVqKK7cfes4b0
	 RZkqSO3YvsVYQ==
Date: Wed, 24 Apr 2024 14:49:32 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jakob Hauser <jahau@rocketmail.com>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna/rossa: Add connector for MUIC
Message-ID: <20240424144922.28189-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: 839d0a29a0592432c5acf1cdf144271682f08d52
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
 .../arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index 5e933fb8b363..62864cca0cbb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -114,6 +114,12 @@ muic: extcon@25 {
 =09=09interrupts-extended =3D <&tlmm 12 IRQ_TYPE_EDGE_FALLING>;
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
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
index b438fa81886c..08485dcc20de 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -15,6 +15,12 @@ muic: extcon@14 {
 =09=09interrupts-extended =3D <&tlmm 12 IRQ_TYPE_EDGE_FALLING>;
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



