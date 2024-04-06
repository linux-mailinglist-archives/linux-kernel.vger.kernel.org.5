Return-Path: <linux-kernel+bounces-133905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348F89AA91
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58131F21BB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D43364A9;
	Sat,  6 Apr 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uURzRbvM"
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9E2C1A9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712402107; cv=none; b=ZeDt3HOSb0aS6b1fGRy3M+87ImHEZpalk1s1T5sjnB5u1D+yCdkOD+IHkCeN7mlMqhGWyvGko1YioUJyDF4PWKPZDrim69kfcLsQgeJDOtHEffAur6G22A2/gVzqFnmlK7rDn8vbZKoFuEbyxY/B4r16nuQnxqQ/gihG5uRfWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712402107; c=relaxed/simple;
	bh=Cz/8wfNWWTObsZ/skhto2RRyF2E/E7d1UqsZee0Hmw8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aydc7M/QKT3v8sFOZhvfn+AYILqbljF8bhJuPmyRo47F0Ql1ex9BKkDi5miZXCodiLnI/I/gfHleJwpGYGEmDuQvllZhb92vn5+WT9tPs/4sgKRezpZEMLMpBQsdrl4DtgY9VB6fSC55/MnSG6zfWGhYME67OTNQ8hlCaXBsz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uURzRbvM; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712402103; x=1712661303;
	bh=jU5NtiO4Jmo6N6XEhJDq51V29uokcFWXuJa7qaP4spc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uURzRbvMm7jxWJYHA/fwrgulAd0/wo5n1txiHo53L8o8zyghV9o4hzPSDJISrraA7
	 pcxlLzWf6+oh5CvUyMr6m/mEhc5pS6oJ0FvJma8gDyEkl9X5VJThcFpic26u7PT/ic
	 Tnl/5eo4q8cF5I7jWIPwlUFj/wUGMgEgNAgKCLaGeqarlMh8Lj19ArB7f4nve6N7Cv
	 bLHrgLF+JB36m/ZIIEqRJrpbSfoB5n6z1ukwe7Tig7H+vHUzuM8+2MpDUzDZCMrbXd
	 UwHi7yK5WSSpPDy8O93QfHiKDJ5fwzShO8MXYwSsUSp3yWToLg6OTVVNOwb94ZfPi1
	 eAxtehsX4ok+A==
Date: Sat, 06 Apr 2024 11:15:00 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8916-samsung-rossa: Add LIS2HH12 accelerometer
Message-ID: <20240406111348.14358-4-raymondhackley@protonmail.com>
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

Core Prime LTE uses ST LIS2HH12 accelerometer. Add support for it.

[Stephen: Use common &st_accel definition from common dtsi]
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 .../arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
index b438fa81886c..db95bdbb9f32 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
@@ -26,3 +26,11 @@ &clk_pwm {
 &clk_pwm_backlight {
 =09status =3D "disabled";
 };
+
+&st_accel {
+=09compatible =3D "st,lis2hh12";
+=09mount-matrix =3D "1",  "0", "0",
+=09=09       "0", "-1", "0",
+=09=09       "0",  "0", "1";
+=09status =3D "okay";
+};
--=20
2.39.2



