Return-Path: <linux-kernel+bounces-133903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860C89AA8B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D092F28291F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A162C85C;
	Sat,  6 Apr 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Bi96cy62"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CA2C1A6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712402094; cv=none; b=p4KcQWVZUyNY8/7v4hTu418/uMeHm8BLvzXeRZMnVQwX+XvJ1S+bbuMympE+mVmw/KZETn9KqClgqiOBfO1x9IMvGhBxfEreA4sm+ZzYODxGc0Rmp8cgRSzXgNSAxknkTtQ/rNS5UDG0GpkSrzTt19QxfPsqH0enAkQbdFiyFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712402094; c=relaxed/simple;
	bh=QPouy+txxaEadd0avJYA4wF5PBAXuT97/zgLOuEIY4c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3FmucIlviIJySDMkgt+xuhU1VYJU0+TTa84J+XIe4HsQXL4qhM+g0VxNtAzxr7apueGSQVf8IpVkk1wx6GH71wBtwv0ykKJyln3u4L9K5gzFqTsKg7Fs/PcUZ98YaskG9YENXmcRxUp5IGQTviXnG2ghzhG1jPKhGPSZjzUOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Bi96cy62; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712402090; x=1712661290;
	bh=LiT0RkSN1jYcw0F40PEh3I31dVargIaYKG8utpP8rWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bi96cy62m5/WXXOh2IMomjvLWA64PkESFO25kr95ZW5w5bEuD8S1iN1lVR79h5Gz/
	 n6Uzffs80bTYz7EAOl3IqsCnGBV1RL6azFWwNjYNIVXR2C17X3oaKgBZYUVz3BEYbw
	 UserCgYKKaQvmb2n57nDb9clXvXLuav6+vS3AXf1I88sFE/CbslbdQ17565Cf8/vE+
	 vmWY20kuUvcN5VwezBVgU592XrFAuaCK5TGfUGgzyEqt8wApKOHTXB4pqF0KdKj8T4
	 1Tmp5yVoqY3780Ux1bQMs4dfA7+ByElFCBakY7yJc56vo0NMOKtc7NLked95hkf2v9
	 2Cf6sq3XzBEJQ==
Date: Sat, 06 Apr 2024 11:14:45 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Siddharth Manthan <siddharth.manthan@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add LSM303C accelerometer/magnetometer
Message-ID: <20240406111348.14358-3-raymondhackley@protonmail.com>
In-Reply-To: <20240406111348.14358-1-raymondhackley@protonmail.com>
References: <20240406111348.14358-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Siddharth Manthan <siddharth.manthan@gmail.com>

Some Grand Prime use a ST LSM303C accelerometer/magnetometer combo.
Add support for it.

Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
[Stephan: Move sensors to common dtsi (disabled by default)]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
[Raymond: Use interrupts-extended]
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../dts/qcom/msm8216-samsung-fortuna3g.dts    |  8 +++++
 .../qcom/msm8916-samsung-fortuna-common.dtsi  | 33 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts b/arch/=
arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
index 366914be7d53..e7f6df229f9a 100644
--- a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
+++ b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
@@ -9,3 +9,11 @@ / {
 =09compatible =3D "samsung,fortuna3g", "qcom,msm8916";
 =09chassis-type =3D "handset";
 };
+
+&st_accel {
+=09status =3D "okay";
+};
+
+&st_magn {
+=09status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi b=
/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
index b6e1fe8b0056..17d21949dfec 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
@@ -152,6 +152,39 @@ bosch_magn: magnetometer@12 {
=20
 =09=09status =3D "disabled";
 =09};
+
+=09st_accel: accelerometer@1d {
+=09=09compatible =3D "st,lsm303c-accel";
+=09=09reg =3D <0x1d>;
+=09=09interrupts-extended =3D <&tlmm 115 IRQ_TYPE_LEVEL_HIGH>;
+
+=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09pinctrl-0 =3D <&accel_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09st,drdy-int-pin =3D <1>;
+=09=09mount-matrix =3D "0", "-1",  "0",
+=09=09=09       "1",  "0",  "0",
+=09=09=09       "0",  "0", "-1";
+
+=09=09status =3D "disabled";
+=09};
+
+=09st_magn: magnetometer@1e {
+=09=09compatible =3D "st,lsm303c-magn";
+=09=09reg =3D <0x1e>;
+
+=09=09vdd-supply =3D <&pm8916_l17>;
+=09=09vddio-supply =3D <&pm8916_l5>;
+
+=09=09mount-matrix =3D "0", "-1",  "0",
+=09=09=09       "1",  "0",  "0",
+=09=09=09       "0",  "0", "-1";
+
+=09=09status =3D "disabled";
+=09};
 };
=20
 &blsp_i2c4 {
--=20
2.39.2



