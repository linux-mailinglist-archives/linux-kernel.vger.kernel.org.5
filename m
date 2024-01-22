Return-Path: <linux-kernel+bounces-33193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7D8365DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162D71C2254B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508853D57B;
	Mon, 22 Jan 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="UvJ8jqaG"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FFD3D56A;
	Mon, 22 Jan 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935115; cv=pass; b=j0KVUx6Ubw5ci2Q54hLDuJEZSsO6KeBNbUyXukik80LbeEjF8gnIwQut2ygxxowiCiLbNs0FFTaHiR+2vVZ7CLIixWwAFh2/piX8IY66vlirG8PTR2oKjLYGMpNxP7Yrxf1ATMkFRIoYkWl3HVArpTLFX1l4aWOyzGC4cOmESJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935115; c=relaxed/simple;
	bh=QPEmTO//Ej02xWnJIaFcwcy9claPMTP7Y7aalXX/pvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpCpEjlAfviyTJsenFBAMo7UOIMMTxpTyqnICSS0tF4aM9sHRomJw1dBRYF58TUl3OBw8Yy3JltOb9ePZRczWv3TBIYzC8Hp/FdsLvXYu7mAyzxm1j/YrwJxD19Dh0lOmJA0Ax/E3Ueo5kZo1ai0vem96OCTvGWupHWAgS+vZKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=UvJ8jqaG; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1705935107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y/opb7Pi8gBPMPIewQVeMgG1jD9NIuTZsW2ZOfDl1tcVGtkZSK4PAjvMibVWl41AizLzYgnsRls817WJJ3gHSzVFZyRyF4IJXdtvqjb8Wwk2TUrSYE2+IjXWDpH/LMbMeA8a7Y7Xfyuj/7UNz3WRyB9L2hPuFqL5qaF0RkF87QY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705935107; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=70Y+BUKgesUh0yDVSO3rqJnCRhG39+DGRu9Gc3QHCoY=; 
	b=YtxBynufkgWosXYpK8m5nMDg8IOclsHwin+b2/6PgRPEm+NCSH4cQ1KXFZakEq6UcQg0GiBi98Hcvf0PccKfTkqS5/YDOc2n1LsvItQPReGI7FE34pKOZh2UY6uGekLOzpb5ht8NNDs1eE8jecQAxacuLHFe109MGytFL8V166E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705935107;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=70Y+BUKgesUh0yDVSO3rqJnCRhG39+DGRu9Gc3QHCoY=;
	b=UvJ8jqaGPJ5VJCbxo/VVV0W+6hNF3uMVCkJ3S+VoBc0iHKIMB6FGYPAkiF8WJPM8
	BUcK2ZfKv7ktkqkMpbKQHuNIMPzOiribyTq+vj0bMe4aytyVfD7P8xNIHm48CwqzdRu
	dW5iyGqPQv++o2EZbAd/sEya6gFOZ21BA/VEjE5Q=
Received: from tb.lan (182.118.232.146 [182.118.232.146]) by mx.zohomail.com
	with SMTPS id 1705935105789436.18406035159467; Mon, 22 Jan 2024 06:51:45 -0800 (PST)
Message-ID: <9b1c28415b5e3a5d94d167612fc0b7e0f9d0a767.camel@rong.moe>
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for
 Samsung Galaxy S5 China
From: Rong Zhang <i@rong.moe>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Date: Mon, 22 Jan 2024 22:51:35 +0800
In-Reply-To: <12e04abf-7720-4c2c-9f1f-0cfee7ba004e@linaro.org>
References: <20240121154010.168440-1-i@rong.moe>
	 <20240121154010.168440-5-i@rong.moe>
	 <12e04abf-7720-4c2c-9f1f-0cfee7ba004e@linaro.org>
Autocrypt: addr=i@rong.moe; prefer-encrypt=mutual;
 keydata=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
	cMTsfqztU+orM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2024-01-22 at 10:48 +0100, Krzysztof Kozlowski wrote:
> On 21/01/2024 16:39, Rong Zhang wrote:
> > This device has little difference compared to Samsung Galaxy S5 (klte),
> > so the device tree is based on qcom-msm8974pro-samsung-klte.dts. The
> > only difference is the gpio pins of i2c_led_gpio. With pins corrected,
> > the LEDs and WiFi are able to work properly.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
>=20
>=20
> > diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts=
 b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> > new file mode 100644
> > index 000000000000..5a8d59ea4439
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "qcom-msm8974pro-samsung-klte.dts"
> > +
> > +/ {
> > +	model =3D "Samsung Galaxy S5 China";
> > +	compatible =3D "samsung,kltechn", "samsung,klte", "qcom,msm8974pro", =
"qcom,msm8974";
>=20
> That's not what you said in the binding.
>=20
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=3D1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).

Oops, I've forgot to run dtbs_check again after my final decision of
adding "samsung,klte". Thanks for pointing it out.

I added it because I thought the difference between klte and kltechn is
so tiny and I've seen some other dts doing that.

I've glanced similar dts. To solve this, I think we could either:
1. keep the dt-binding in [PATCH 3/4], and delete "samsung,klte" here
2. rewrite dt-binding like crystalfontz,cfa100{36,37,49,55,56,57,58}:

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 2bd29a2399ad..4979ccae2b64 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -223,11 +223,17 @@ properties:
               - fairphone,fp2
               - oneplus,bacon
               - samsung,klte
-              - samsung,kltechn
               - sony,xperia-castor
           - const: qcom,msm8974pro
           - const: qcom,msm8974
=20
+      - items:
+          - enum:
+              - samsung,kltechn
+          - const: samsung,klte
+          - const: qcom,msm8974pro
+          - const: qcom,msm8974
+
       - items:
           - const: qcom,msm8916-mtp
           - const: qcom,msm8916-mtp/1

My preference is (2.) since other variants of klte may be added in the
future. I would like to hear your preferences.

Thanks,
Rong


> Best regards,
> Krzysztof
>=20


