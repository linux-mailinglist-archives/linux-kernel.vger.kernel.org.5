Return-Path: <linux-kernel+bounces-119148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E188C4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC70B24FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C212D20B;
	Tue, 26 Mar 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DGcEKE4R"
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573412D1EB;
	Tue, 26 Mar 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462391; cv=none; b=H5lbCzdFKQCxZmPweM0eaKnoq+loN79qHxpyQghhWbQSOlzErjor1hFhpjDXS6G4rRLe/uc8TlA93jLmnobTHO0bsQqNiXsNHM9k4U5+D0z/oO3cZx5x3Qj3JtGLeufyBmAibHw/Dhd6LHONNEQ82RkHo3WK0jsSeCGuBYmvcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462391; c=relaxed/simple;
	bh=iqCJ/OaHyezop56ox/r8NGwkQ6lD2JshOlCSeJwb0rc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsU9jjxyllTRE4v9OWC7ji1CDoYnopTbcu4ZuZgEezS/pc6W23CiTLqHmJiDtM6BkBwk4qVMiwunJToRNVUZVlSsKr45n3CJRZUZrfVHbQFfmd6/osA8t/KQiQNOaYcxk05Eo3B8PvLd4SEzRG6a+4BDcxQY6XNZ66bXF+hCMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DGcEKE4R; arc=none smtp.client-ip=185.70.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711462385; x=1711721585;
	bh=unSapoCM0+7NQ0sQ0bqtuuuIegjLMwC+z3pRdJSUAbs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DGcEKE4RdrpD3rlcfdpvfB61N2nBVO6I06lh14dWPreOc4kr6b/2qU68iwKVnVRTN
	 4lyHWA037dbCKjlPZPRAbcv/DIYdDRexmw5RZQMTcCh0nBPzcg3OhC7wlWqxeDxbci
	 eWmKnnqGJE/6JQIajST4zjQ1yGVuYcYU0he1UjeAK6fz0INU5O/jEle45E4RPpnSFA
	 HF3EnZiSngk4LdYggxEodXQL5hLx6rdqMZWcuWFLSVfCPR8nII0HvEHQo1Nt6um+CU
	 fcGL89N/06d0YinUDlQIPkiDlY/QOpzpKXhgpSPjCYsf3IVcqFbWkBfv5LUQvbxYRg
	 5Sm3uMbnjj5CA==
Date: Tue, 26 Mar 2024 14:12:50 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/2] arm64: dts: qcom: msm8916/8216-samsung-fortuna: Add samsung,fortuna binding
Message-ID: <20240326141222.200452-2-raymondhackley@protonmail.com>
In-Reply-To: <20240326141222.200452-1-raymondhackley@protonmail.com>
References: <20240326141222.200452-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add common binding samsung,fortuna used by the following
Samsung Galaxy Grand Prime devices:
- SM-G530FZ (msm8916-samsung-grandprimelte)
- SM-G530H  (msm8216-samsung-fortuna3g)
- SM-G530W  (msm8916-gprimeltecan)

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts     | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts  | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts b/arch/=
arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
index 366914be7d53..877fd2d7bb57 100644
--- a/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
+++ b/arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dts
@@ -6,6 +6,6 @@
=20
 / {
 =09model =3D "Samsung Galaxy Grand Prime (SM-G530H)";
-=09compatible =3D "samsung,fortuna3g", "qcom,msm8916";
+=09compatible =3D "samsung,fortuna3g", "samsung,fortuna", "qcom,msm8916";
 =09chassis-type =3D "handset";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts b/ar=
ch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
index 9d65fa58ba92..8c7d71e05da3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
@@ -6,7 +6,7 @@
=20
 / {
 =09model =3D "Samsung Galaxy Grand Prime (SM-G530W)";
-=09compatible =3D "samsung,gprimeltecan", "qcom,msm8916";
+=09compatible =3D "samsung,gprimeltecan", "samsung,fortuna", "qcom,msm8916=
";
 =09chassis-type =3D "handset";
=20
 =09reserved-memory {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts b/a=
rch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
index a66ce4b13547..1781e04a25c9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
@@ -6,7 +6,7 @@
=20
 / {
 =09model =3D "Samsung Galaxy Grand Prime (SM-G530FZ)";
-=09compatible =3D "samsung,grandprimelte", "qcom,msm8916";
+=09compatible =3D "samsung,grandprimelte", "samsung,fortuna", "qcom,msm891=
6";
 =09chassis-type =3D "handset";
 };
=20
--=20
2.39.2



