Return-Path: <linux-kernel+bounces-31134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90F83298D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1B12840E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7B51C57;
	Fri, 19 Jan 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1/LYnTw"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EB4F21F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667527; cv=none; b=WAATJA25gz13MItMs9T5x4D7zN8Ybw+nrN27E6LTfN+Wkbo68o/EKcouzKqrWFxpAvnjoQGw3Cuhv+bVzEqS1q21GPB0ltTuFM6aIiIe7fbwnwk8QRy+d4i35ybzArdcnDf169I1qOGDDdbjtLycXjNr8pXPdt63jbqaMEN649I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667527; c=relaxed/simple;
	bh=I0UZfjlfi2E6U7pmjX/HhVBMtbSsDUbWol5BCeCBZhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2fFBzwHpEIri1joP76j2yCzMgm1h3MBXzrh5XjElHpwQwAEJm0fmEINLBM0jQ55xWeF6wsKuQ6co7g7y5KGAbZcOl0d5VRgIM7nwLybEdYapWPclu9OQ6DMlm/f7l2tjhEYf/SXMvth1BVjhvVFORir5k5Tj8aS89Fnu3/M0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1/LYnTw; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff84214fc7so7687737b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705667525; x=1706272325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ffjuk5UUhf2ajhXazA1TZbNijQJTawfOkhzxR9sRdg0=;
        b=V1/LYnTw529sx6xKDy+lxEaAzYcL+//TVJyrgv7aPGLAWtHTUx6SJzRmdjZJtH9DMG
         K3tvZ7h5ggUhiWgn+V9ZsPkSmkAr1letpe0WpJbQM0fCeQ8Prs4Pn1KW2qLaipIIofLo
         HZhpP5olkRUApDUpCQhig6SKYI45CLJJrR9lwbcRcV8Us7sisZBM+bTRomNJeL/fSSqK
         3ATJtzS/wVsj32xzxEjaWEDn37cIUSKLUorLEX8vl2GjB1gd/wKVwrt0ns5tsWYQfi2a
         NuQXgw+unAPNG7UrUS8MnL7Jtnmmzn/+EVBaJX/mtI9hhXSzhLHpwNKkAfXLE9ASjYVM
         rzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667525; x=1706272325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ffjuk5UUhf2ajhXazA1TZbNijQJTawfOkhzxR9sRdg0=;
        b=VSQlZcQ3p7pKEeOMvF3OnvA3DR8Y8GyXNdVbmLiqE0waQsMmXET7wxIXwPB6ARZM6m
         2CBEATs4jGZn2ua9aXH0+Ydwpq2Nb5yUNuh7MXCD5xUALkdk5CvzciW2x0LQoByv4RTf
         mdFgAiFOw2q/h6XNExTuF1XUSVosbauRSeDTJDNjAf/HpQRV4YOLpaDZxGbz+KpBC6W6
         alpAsEigGZuYrL8MO5SHeXAe+3Iq9/tfFnlhl3FqmMkNQTHg9Y1yzRMwExlJ5IVEs2+Z
         sRo4X9+IKDUGXGzNCF8UWgNGlfS2q0BJpTm+eSvt0/7rFYHm/ne+bl9ahCbAbhpw77Hk
         4bGQ==
X-Gm-Message-State: AOJu0YyeZ47s85ad8JVaY+UK+Eucs1tMaXJUO7RIm7FMjWRkqBMcloz3
	Qg1KlQPFHE4kXrCYsc4QpcvKpXhPQkUU+NMg+LP+1FgMsE2tAyk3gESyCuplV5mKCEzjVl2/HDP
	AZqokmaD5zBM+3TJu5xu1k49o+mE4pDkBHGET6w==
X-Google-Smtp-Source: AGHT+IHzWY0Jg7Cbw032GIQItsk8GMJ1egjxjW1I4qO2drEBWMBFSWUWUH+O4Oj0Le9R6bky8UA9z26DkZt+clJZEBE=
X-Received: by 2002:a81:4a83:0:b0:5fc:b5d4:f1cf with SMTP id
 x125-20020a814a83000000b005fcb5d4f1cfmr2465344ywa.35.1705667525159; Fri, 19
 Jan 2024 04:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
 <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com> <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com>
In-Reply-To: <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Jan 2024 14:31:53 +0200
Message-ID: <CAA8EJprFV6SS_dGF8tOHcBG+y8j74vO0B40Y=e7Kj1-ZThNqPA@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2024 at 13:52, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Thu, Jan 18, 2024 at 7:53=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
>
> [snip]
>
> > >
> > > I'd still like to see how this can be extended to handle BT power up,
> > > having a single entity driving both of the BT and WiFI.
> > >
> > > The device tree changes behave in exactly the opposite way: they
> > > define regulators for the WiFi device, while the WiFi is not being
> > > powered by these regulators. Both WiFi and BT are powered by the PMU,
> > > which in turn consumes all specified regulators.
> >
> > Some additional justification, why I think that this should be
> > modelled as a single instance instead of two different items.
> >
> > This is from msm-5.10 kernel:
> >
> >
> > =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
> > /**
> >  * cnss_select_pinctrl_enable - select WLAN_GPIO for Active pinctrl sta=
tus
> >  * @plat_priv: Platform private data structure pointer
> >  *
> >  * For QCA6490, PMU requires minimum 100ms delay between BT_EN_GPIO off=
 and
> >  * WLAN_EN_GPIO on. This is done to avoid power up issues.
> >  *
> >  * Return: Status of pinctrl select operation. 0 - Success.
> >  */
> > static int cnss_select_pinctrl_enable(struct cnss_plat_data *plat_priv)
> > =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
> >
> >
> > Also see the bt_configure_gpios() function in the same kernel.
> >
>
> You are talking about a different problem. Unfortunately we're using
> similar naming here but I don't have a better alternative in mind.
>
> We have two separate issues: one is powering-up a PCI device so that
> it can be detected and the second is dealing with a device that has
> multiple modules in it which share a power sequence. The two are
> independent and this series isn't trying to solve the latter.

I see it from a different angle: a power up of the WiFi+BT chips. This
includes devices like wcn3990 (which have platform + serial parts) and
qca6390 / qca6490 / wcn6750 / etc. (which have PCI and serial parts).

From my point of view, the PCIe-only part was nice for an RFC, but for
v1 I have expected to see a final solution that we can reuse for
wcn3990.

>
> But I am aware of this and so I actually have an idea for a
> generalized power sequencing framework. Let's call it pwrseq as
> opposed to pci_pwrseq.
>
> Krzysztof is telling me that there cannot be any power sequencing
> information contained in DT. Also: modelling the PMU in DT would just
> over complicate stuff for now reason. We'd end up having the PMU node
> consuming the regulators but it too would need to expose regulators
> for WLAN and BT or be otherwise referenced by their nodes.

Yes. And it is a correct representation of the device. The WiFi and BT
parts are powered up by the outputs from PMU. We happen to have three
different pieces (WiFi, BT and PMU) squashed on a single physical
device.

>
> So I'm thinking that the DT representation should remain as it is:
> with separate WLAN and BT nodes consuming resources relevant to their
> functionality (BT does not need to enable PCIe regulators).

Is it so? The QCA6390 docs clearly say that all regulators should be
enabled before asserting BT_EN / WLAN_EN. See the powerup timing
diagram and the t2 note to that diagram.

> Now how to
> handle the QCA6490 model you brought up? How about pwrseq drivers that
> would handle the sequence based on compatibles?

The QCA6490 is also known as WCN6855. So this problem applies to
Qualcomm sm8350 / sm8450 platforms.

And strictly speaking I don't see any significant difference between
QCA6390 and WCN6855. The regulators might be different, but the
implementation should be the same.

>
> We'd add a new subsystem at drivers/pwrseq/. Inside there would be:
> drivers/pwrseq/pwrseq-qca6490.c. The pwrseq framework would expose an
> API to "sub-drivers" (in this case: BT serdev driver and the qca6490
> power sequencing driver). Now the latter goes:
>
> struct pwrseq_desc *pwrseq =3D pwrseq_get(dev);
>
> And the pwrseq subsystem matches the device's compatible against the
> correct, *shared* sequence. The BT driver can do the same at any time.
> The pwrseq driver then gets regulators, GPIOs, clocks etc. and will be
> responsible for dealing with them.
>
> In sub-drivers we now do:
>
> ret =3D pwrseq_power_on(pwrseq);
>
> or
>
> ret =3D pwrseq_power_off(pwrseq);
>
> in the sub-device drivers and no longer interact with each regulator
> on our own. The pwrseq subsystem is now in charge of adding delays
> etc.
>
> That's only an idea and I haven't done any real work yet but I'm
> throwing it out there for discussion.

I've been there and I had implemented it in the same way, but rather
having the pwrseq as a primary device in DT and parsing end-devices
only as a fallback / compatibility case.



--=20
With best wishes
Dmitry

