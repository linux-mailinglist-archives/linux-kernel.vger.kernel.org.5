Return-Path: <linux-kernel+bounces-132953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60B899C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4FE1C20CEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455F16C848;
	Fri,  5 Apr 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DC854iDn"
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EF16C458
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318974; cv=none; b=gn1T8NZ+ET3a2CvrKt05Kq5r0gL/GZVCXuviHJRKoJwF2uI0xQhfIONhypP0gcVsbfvkf9Sl8H34b+nEQ3G1WkHhzb/+jByV19IMyd14HgIIUUVDkXcoPX2uzEEYCvF7+0zxorxgn4GNHfhkOQMhPB/MmPUlVs91mEiizKgMKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318974; c=relaxed/simple;
	bh=Cz/8wfNWWTObsZ/skhto2RRyF2E/E7d1UqsZee0Hmw8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbtVoYL2M6p5Cks+/FWdL6Si8gc/ghIwBkaO6XMAXKf91kWKigpNcCpfpWzpo++WYHzc1o7n/lzbTvnto9ytw13caR7XNPMrEQPpykQcWVqRJLivCIllmNow6gLMLVPZ4PvKLe9/CM9PlZxQ0I4+V59M70Paq0JNYsJPVa/N14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DC854iDn; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712318964; x=1712578164;
	bh=jU5NtiO4Jmo6N6XEhJDq51V29uokcFWXuJa7qaP4spc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DC854iDnh1UXxMT0aTx7XFE+luousZF1j8Yexsb3qfOT4QH3aQcoSrhltPANVv6Ya
	 fy9gCo+6uvmwRw9R7X9J5nfSE7j7HGWZZnERCvugvna1KKnFZUoKEVv18s6w+AlszO
	 ziKN/p81sIv661MLyqGxJKRtwm1UcnmX5JubDgvNM+kgo0A+KJriWmNSwTPAeASTYf
	 n6ORjSIiISZsWx4ZbGzzxQSDfJbA2vx0dtwqQHXz4OakD1fmOtZ2Od71NiVMTsbOz1
	 zAg9/O+WOXa1LKfz00PVl/efMlFAgX1Lb6CQZ8XgnVdSl+BLXFbR7Uy51uXf9/Ci9a
	 K0ocUM+cxvaQQ==
Date: Fri, 05 Apr 2024 12:09:14 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Raymond Hackley <raymondhackley@protonmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-samsung-rossa: Add LIS2HH12 accelerometer
Message-ID: <20240405120803.20754-4-raymondhackley@protonmail.com>
In-Reply-To: <20240405120803.20754-1-raymondhackley@protonmail.com>
References: <20240405120803.20754-1-raymondhackley@protonmail.com>
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



