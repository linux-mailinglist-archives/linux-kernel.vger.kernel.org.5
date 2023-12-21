Return-Path: <linux-kernel+bounces-9137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEC681C127
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B5F1F23422
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549977F1C;
	Thu, 21 Dec 2023 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="V9OQJ3re"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42319171B3;
	Thu, 21 Dec 2023 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso752495a12.3;
        Thu, 21 Dec 2023 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703198560; x=1703803360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTQxlQCO+Gf4xIjXRg1HmFnmLBOGQYr6tXPcOA6WFzY=;
        b=V9OQJ3re3DqiIsjQ+5hLvKh4opDB4rUQlM6ZA29D5PswtsgDejZZ++B5tLHNYaFbVu
         xWG2kPntJ28gm7HgjL+5VHa7cCoDkWznuw5eA6kvrjsftKOLnIf71Hz2hlBYeGiC3VIz
         ncr9wRg/nU8MBosbPDZOiU/FnTiGJzgDXc0yEx7olsk567BtEPwt5hAU1sJcQPUk99G0
         Fn358Cp0UbeMC+ROklJtW8JA15Si6+wLPUJVJxxWit2HbCGxCG/1lLMTVADYiUhZoF7f
         StYLBRq/6t1O3cIx8p8SpOynxQeWoJi6PQcizcAypUW6XEGhjrxMdEoWsRseRbcuISqN
         zleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703198560; x=1703803360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTQxlQCO+Gf4xIjXRg1HmFnmLBOGQYr6tXPcOA6WFzY=;
        b=n6fD9cmMoQtkYkl2mf1TrpsEwjmjveb5je3F05oN2/4ceAiEJXhQeoTAzReB76z318
         o5wmpu2Huog0CFOl73LqJlOtCprnaU5Jp/DXEzZj3LRN99M4ya16BjIiZWG6K/6k7hRK
         auV0GWD9nEgCMqp3QITVstNQyOpvN2igDiAvyLX3ytJuuacInntsmt/OmbT5vXaQIcO3
         PN38Bh9tzFchWo2zbl6P51otxdkPQtjwXUrL4tUjJUf84XUbT3ePRV/b/g9rPoB80+N3
         W4HhAWZb5CoWVoNoSbCxdbPGhPPPMfP1a8XgAWd6CP5GGeKxUeHIR3TVCq8vO/e5taCJ
         W/Gg==
X-Gm-Message-State: AOJu0Yz0sKrsfUeajiqama168l0bjO3bP1HIcsYbk1rfg5cDMdGxjKun
	Z67bgYNSQPP9hnaSJKykqQPXKKQx7R59Qh5H/68=
X-Google-Smtp-Source: AGHT+IFs18DvgzMKPzBRIvgnZpu8I+QVnR7YPq+Vnesd+qyDskEada4/byLmH1j6vYxxxmhT3SvY3lJ3atYoHbL7e/8=
X-Received: by 2002:a05:6a20:8b04:b0:18f:97c:8261 with SMTP id
 l4-20020a056a208b0400b0018f097c8261mr338231pzh.107.1703198560349; Thu, 21 Dec
 2023 14:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com> <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
In-Reply-To: <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 21 Dec 2023 23:42:29 +0100
Message-ID: <CAFBinCDJnVzE2sMwu52MQGTKW7dtCuUoj63ZZHhJPJO0+dZDkg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Dec 21, 2023 at 10:45=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Dec 21, 2023 at 10:12:22PM +0100, Martin Blumenstingl wrote:
>
> > It turns out that at least some bootloader versions are keeping the PWM
> > output disabled. This is not a problem due to the specific design of th=
e
> > regulator: when the PWM output is disabled the output pin is pulled LOW=
,
> > effectively achieving a 0% duty cycle (which in return means that VDDEE
> > voltage is at 1140mV).
>
> Hrm.  Perhaps the regulator should figure out that it's on with a
> minimum voltage of 1.14V in this case - AIUI that broadly corresponds to
> your change except for the fact that it doesn't recognise that there's
> actually an output in this case since it assumes that disabling the PWM
> disables the output which isn't the case with this hardware.  We'd need
> to know more about the PWM in that case though I think.
If you have any specific questions then feel free to ask.
Generally it's a very simple PWM controller:
- when disabled the output is LOW
- when enabled the output matches the requested period and duty cycle
as best as possible (depending on the available input clocks)

> > The problem comes when the pwm-regulator driver tries to initialize the
> > PWM output. To do so it reads the current state from the hardware, whic=
h
> > is:
> >   period: 3666ns
> >   duty cycle: 3333ns (=3D ~91%)
> >   enabled: false
> > Then those values are translated using the continuous voltage range to
> > 860mV.
>
> > Later, when the regulator is being enabled (either by the regulator cor=
e
> > due to the always-on flag or first consumer - in this case the lima
> > driver for the Mali-450 GPU) the pwm-regulator driver tries to keep the
> > voltage (at 860mV) and just enable the PWM output. This is when things
> > start to go wrong as the typical voltage used for VDDEE is 1100mV.
>
> So, the constraints say that the 860mV voltage is within range.  Where
> does the requirement for 1.1V come from in this situation?  Is it just
> that lima hasn't started yet and requires the 1.1V for hardware init
> (and presumably power on) even if it can use a lower voltage at runtime?
The vendor BSP includes a custom u-boot with lots of relevant
information for which there's seemingly no documentation.
It seems that 1.1V is what should be used during normal operation.
0.86V is what can be used during system suspend (when power to the
Cortex-A5 cores is turned off and an integrated ARC core is taking
over for wakeup purposes).
Hence the supported voltage range of 0.86..1.1V


Best regards,
Martin

