Return-Path: <linux-kernel+bounces-33195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50B8365E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1C2825F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1283D57E;
	Mon, 22 Jan 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="P9Bq6stV"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153C3D56D;
	Mon, 22 Jan 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935266; cv=pass; b=Z9yXAWEgpT4lAQxTRTuBKG1sq5aZ1uPew8UEj3HzAzRlCJ2SFxHWcVaFGAr8el3Rq+cMl18rOFFitidlqz81OZWLoc8Vlg2kQxob65xwh17wHl2aC96HXMFVTBaovIEFAoseeRn04QTEWseSWn/WQWYxMwi93QlfEzhTqa3sUP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935266; c=relaxed/simple;
	bh=fy3UHK6HOYrFTv/m0+PoNLYHH9w80aFHo8m1KKsHCRw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pLwFfQwFcJgJVw6qN2OZaSJNP5AZSM/ZcB8q8LYtXSkRin4PV45QTJ6Z3YCnq5P66wD0hndWr7H7Ud2iqa5TrEv173mY51oO+XvYHvPHj9GafXKW1cO9EcPxzGBxYCw+q1H/H3VgEvQFt0QGPalqugXOUCF+AvaKiiQ73F+A/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=P9Bq6stV; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1705935261; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=POtGExCcsDaAKCEYOWxA3C5glNplyfPlW0kISEnw+r9ensVcP1FWPNYuzxY3A6r1Cua5iEXcQxIKecS0oaFZsAzQoBV1I3AQ0ofm4faDiZE9apibTLOy+S2Vfw6U1TwWOI/VJyjQRJZzj+jTr11QnBtdPuQqcC2599sS4hsL/V4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705935261; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nJiBhLPvPsrIOjSvCVoQ6mqDO5KXSL8mgOu7VVMPH9U=; 
	b=RYi02WdsYISJI9NpufgawTye8yTFj6dMdh222JmtLv+SESAFeHewnRMbvnpfIaN0Q5PazSAbGHy0KTrlgWeV8mNxa5FprIUuLowza8s+ZlBATkag8wr+B0CVcx1d3k6U1voIQ38mWkcM12JE0/2xbwnwAsf3SXzSyNNVDThppgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705935261;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=nJiBhLPvPsrIOjSvCVoQ6mqDO5KXSL8mgOu7VVMPH9U=;
	b=P9Bq6stVrRlSWa5pBpusGJ6lvjrgtYRPRtAERoKkNoIKM0++NmX4fFMSzJ0oci8Z
	iFSAYAmqDiEp3foKqsbU5/5M61oAsbcVZDkK0fzxBtfArY/6rR+V0qYI1SGCLjujRTs
	uZFzPfTq9lP5ZXhYBnqSylgRE1XtEHMHNxgAb8yg=
Received: from tb.lan (182.118.232.146 [182.118.232.146]) by mx.zohomail.com
	with SMTPS id 1705935258651526.4153199298788; Mon, 22 Jan 2024 06:54:18 -0800 (PST)
Message-ID: <3647c5f823260865eb870ff1ce45c787bcaec256.camel@rong.moe>
Subject: Re: [PATCH 1/4] ARM: dts: qcom: msm8974-samsung-klte: Add label on
 /i2c-gpio-led
From: Rong Zhang <i@rong.moe>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Date: Mon, 22 Jan 2024 22:54:08 +0800
In-Reply-To: <73d75a74-71db-43c7-935a-65423159ce42@linaro.org>
References: <20240121154010.168440-1-i@rong.moe>
	 <20240121154010.168440-2-i@rong.moe>
	 <73d75a74-71db-43c7-935a-65423159ce42@linaro.org>
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
> > Some variants of klte, e.g., the China edition (kltechn), have minor
> > differences to differentiate them from klte. This includes the GPIO pin=
s
> > connected to /i2c-gpio-led.
> >=20
> > A label is added on /i2c-gpio-led to allow DT of other variants to
> > reference it conveniently. Considering both LEDs and a GPIO expander ar=
e
> > connected to the node, it is named "i2c_led_gpio".
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts b/=
arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
> > index b93539e2b87e..013946ccda0f 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
> > +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts
> > @@ -77,7 +77,7 @@ touchkey@20 {
> >  		};
> >  	};
> > =20
> > -	i2c-gpio-led {
> > +	i2c_led_gpio: i2c-gpio-led {
>=20
> This does not make much sense on its own. 6 commit msg lines just to add
> a label. Squash it.

Will squash it into "[PATCH 4/4] ARM: dts: qcom: msm8974: Add device
tree for Samsung Galaxy S5 China".

Thanks,
Rong


> Best regards,
> Krzysztof
>=20


