Return-Path: <linux-kernel+bounces-32433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB461835BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF04B241E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A317BDB;
	Mon, 22 Jan 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Ouufk7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469417BD0;
	Mon, 22 Jan 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909026; cv=none; b=Mchn5LdudC6+VYfWQQO5vgJX/IMNnW6kJu0tq3pgnI4XhpZ0HcqnsDRzW0XbLoHl0dcQh3jjsst9+KWq1IC72Pv9gUC//ZN07zlIiENKlTy1g5/3FJhB8Nlgl0Bq3ZInUH1HOGPXQ2y/vgx+YOeoYxbujXIHEyHvB+TYQkL8Ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909026; c=relaxed/simple;
	bh=JMdye7mRvqKxsy1H6cLivdufLFV//IdChHJEZlWlrzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSYTF5hQj88jJHVkPt85Zngf8n2etDfKJhrnVKOFE67dcYkAvRHOMO1K/mZmFKRPEdzBlQumC1Z310a5CdG3aqcur1Ngr93UcA37FeO/1ohacUsDkZIyE2/fad5JgicKnAb0wSdxjIWCHAjBqNUhqzAUzHiHF0qmpI+Df1mwjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1Ouufk7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso3106213a12.0;
        Sun, 21 Jan 2024 23:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705909023; x=1706513823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc3sa+GYOy4rKNLUFJb6qU3rV63Dt/e4wYasMz8dvE0=;
        b=N1Ouufk7qFscUt7AE3q3uT+BdzdrWKxdrQeS19bWP4PBvYgCGzqfRlgwsCqTpnaZ8T
         d/H3yv/aohrfBIXSzjQvhvKsCsr3UAQkuwoOMArjOTHuBOdzcUZIfMp5jxgC/hlIH21i
         xghI7YK92Gceje+cD2reRTiuu3b8DRPGqK8GHt1bo4ok9Zhzic7LLA2IJX7oEdSXYhxp
         bEMbVCBuYkFPw3up1UIrqcj17NKy6B/i6lL35fHga/ykHfUtjASppCbol0Vq9DEGpNf9
         8igqCS3OWDvgwZy63Us2UTame2W9+g3UANRnm2NFhhZMO74WVT4eQJoSnmcphDsgVis3
         7RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909023; x=1706513823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc3sa+GYOy4rKNLUFJb6qU3rV63Dt/e4wYasMz8dvE0=;
        b=q/nyfQ1WGQlDEUy9zuANSZIWpI9VBDLN1N5XzgSYwPyRpCGqcDlT6gWQJpfn6nhomu
         st1Frc7MScoX0PsVSe7RFNxUhhTiyy5wun1HoCMLKSk5kCf147HxkJWUUpZ7YoDLOJpn
         G/UWMyeQlZHZ1b13UmYyDSFfea5x5pIDYJZZaCppJU+XzVmw10XTDqxlsYEfKx5qYn9n
         QZryUumuhjn+fQi2U0bTZpTiqvqppBCfQErbe3x0Hz5zTZD++XRG2C4VsxVs3ZFFT9wm
         jF4L8hro63i1VBf8lHNSG9hSmOzwU6Wl7VC76w/HVCKrwcqOPH3qFZeWr/+au9CVjb4W
         spqw==
X-Gm-Message-State: AOJu0Yye33kRBuA85ovcxbEueFfhKLNteiquxRPNwDI+4NolGbdEi4GO
	WYKisWQqgnjnvWdgpPrtkLfDTaod5DFfxoz7wZ5CSSwSerSOoqy+2DKJFMTpiP6jZoBp7Qw0xkL
	W1qE9Rei2fF/9hdp/Vpe75jziB2k=
X-Google-Smtp-Source: AGHT+IEAO24HJwuNIdG/7yeelZou9XAo0zFs6Ooz3MuRca4WKw1ZuFCV4Z3gmL3h6SMklFrRMU1JHjCF6aPOWAdXBEY=
X-Received: by 2002:a17:907:8e07:b0:a2f:b9bf:3955 with SMTP id
 th7-20020a1709078e0700b00a2fb9bf3955mr1595162ejc.21.1705909022608; Sun, 21
 Jan 2024 23:37:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org> <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
 <f5c05015e042b11a51a9af26c35f18ed@manjaro.org> <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
 <81a5410c3dbedbd4fe9ce60ab236700c@manjaro.org>
In-Reply-To: <81a5410c3dbedbd4fe9ce60ab236700c@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 22 Jan 2024 11:36:50 +0400
Message-ID: <CABjd4YwxoPrKRPmjn-eWsU1N5fXCjAbnRwfKD9DLKgeL2=vHrA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Christopher Obbard <chris.obbard@collabora.com>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> On 2024-01-22 07:03, Alexey Charkov wrote:
> > On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> On 2024-01-21 19:56, Alexey Charkov wrote:
> >> > On Thu, Jan 18, 2024 at 10:48=E2=80=AFPM Dragan Simic <dsimic@manjar=
o.org> wrote:
> >> >> On 2024-01-08 14:41, Alexey Charkov wrote:
> >> >> > On Sun, Jan 7, 2024 at 2:54=E2=80=AFAM Dragan Simic <dsimic@manja=
ro.org> wrote:
> >> >> >> On 2024-01-06 23:23, Alexey Charkov wrote:
> >> >> >> > Include thermal zones information in device tree for rk3588 va=
riants
> >> >> >> > and enable the built-in thermal sensing ADC on RADXA Rock 5B
> >> >> >> >
> >> >> >> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> >> >> > ---
> >> >> >> > +                     trips {
> >> >> >> > +                             threshold: trip-point-0 {
> >> >> >>
> >> >> >> It should be better to name it cpu_alert0 instead, because that'=
s what
> >> >> >> other newer dtsi files already use.
> >> >> >
> >> >> > Reflecting on your comments here and below, I'm thinking that may=
be it
> >> >> > would be better to define only the critical trip point for the So=
C
> >> >> > overall, and then have alerts along with the respective cooling m=
aps
> >> >> > separately for A76-0,1, A76-2,3, A55-0,1,2,3? After all, given th=
at we
> >> >> > have more granular temperature measurement here than in previous =
RK
> >> >> > chipsets it might be better to only throttle the "offending" core=
s,
> >> >> > not the full package.
> >> >> >
> >> >> > What do you think?
> >> >> >
> >> >> > Downstream DT doesn't follow this approach though, so maybe there=
's
> >> >> > something I'm missing here.
> >> >>
> >> >> I agree, it's better to fully utilize the higher measurement
> >> >> granularity
> >> >> made possible by having multiple temperature sensors available.
> >> >>
> >> >> I also agree that we should have only the critical trip defined for
> >> >> the
> >> >> package-level temperature sensor.  Let's have the separate temperat=
ure
> >> >> measurements for the CPU (sub)clusters do the thermal throttling, a=
nd
> >> >> let's keep the package-level measurement for the critical shutdowns
> >> >> only.  IIRC, some MediaTek SoC dtsi already does exactly that.
> >> >>
> >> >> Of course, there are no reasons not to have the critical trips defi=
ned
> >> >> for the CPU (sub)clusters as well.
> >> >
> >> > I think I'll also add a board-specific active cooling mechanism on t=
he
> >> > package level in the next iteration, given that Rock 5B has a PWM fa=
n
> >> > defined as a cooling device. That will go in the separate patch that
> >> > updates rk3588-rock-5b.dts (your feedback to v2 of this patch is als=
o
> >> > duly noted, thank you!)
> >>
> >> Great, thanks.  Sure, making use of the Rock 5B's support for
> >> attaching
> >> a PWM-controlled cooling fan is the way to go.
> >>
> >> Just to reiterate a bit, any "active" trip points belong to the board
> >> dts file(s), because having a cooling fan is a board-specific feature.
> >> As a note, you may also want to have a look at the RockPro64 dts(i)
> >> files, for example;  the RockPro64 also comes with a cooling fan
> >> connector and the associated PWM fan control logic.
> >
> > Thanks for the pointer! There is also a helpful doc within devicetree
> > bindings descriptions, although it sits under hwmon which was a bit
> > confusing to me. I've already tested it locally (by adding to the
> > board dts), and it spins up and down quite nicely, and even modulates
> > the fan speed swiftly when the load changes - yay!
>
> Nice!  Also, isn't it like magic? :)  To me, turning LEDs on/off and
> controlling fans acts as some kind of a "bridge" between the virtual
> and the real world. :)

Oh yes! I also keep admiring how one can add just a couple of lines of
text here and there that's not even real code, and the whole kernel
machinery starts crunching numbers, analyzing temperatures, running
PID loops, etc etc so that I could enjoy the satisfying whistle of a
small fan when I type `make -j8` :-D

> As a suggestion, it would be good to test with a couple of different
> fans, to make sure that the PWM values work well for more that one fan
> model.  The Rock 5B requires a 5 V fan, if I'm not mistaken?

It is 5V, yes. I only have one fan to try though, and I simply relied
on the PWM values that are already defined in the upstream
rk3588-rock-5b.dts. They don't look ideal for my particular fan,
because the lowest non-zero cooling state currently uses a PWM value
of 95, which doesn't always make it spin up. But in the end it doesn't
seem to matter that much, because that tiny fan needs to spin at full
255 whenever all eight cores are loaded (and even then it can only
balance the temperature at around 60.5=D0=A1), and when the load is lighter
(such as during various ./configure runs) it just switches off
completely as the temperature goes down to 46C even with the fan not
spinning.

I don't currently use the GPU/NPU/VPU though - maybe those would
produce more moderate load which could benefit from spinning the fan
at medium speeds.

Best regards,
Alexey

