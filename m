Return-Path: <linux-kernel+bounces-9586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67A81C7EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B31287AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66376156F8;
	Fri, 22 Dec 2023 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OnBvpJr+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0714F97;
	Fri, 22 Dec 2023 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28b06be7cf6so1075101a91.2;
        Fri, 22 Dec 2023 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703239962; x=1703844762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdoNGX1KxNkpP3oAqLoaAe4EdC/4AxyKYEpoYHOwAEQ=;
        b=OnBvpJr+++JUFVyPtvv/1c9aaXXrIcnn494KCgFV2Wd8d3YOs2efxMAVzEcqnfKBYC
         GF5M0uS598uJROAHeHM4pa26U6kYd0RBqBEDmmmFbY9yzHIQZNx1RfTU5Ee6cKYaSt70
         NfCXJVna+t9TM02C6gZPfMMwlaOnkmT+8iW8/yjFlVZgh1lbZoUyC6G/yamjgOdreStt
         qSP3LPuIIJnMo6Wpx7/DxhfdEAiTmPfc/xgvm630dQIuwRBgcPrtsOdFy3LHW6TQMQcz
         lfePF4xdP3ukXoz/d0wLO/TH6oCe9L9nNNvumlUA/ZlBosp9tRspnS9SeqQozdJoxjz/
         qMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239962; x=1703844762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdoNGX1KxNkpP3oAqLoaAe4EdC/4AxyKYEpoYHOwAEQ=;
        b=CpI13Xa7gTkxpRJOitykZENcHgTo79D4/9WIlrLY5QM8gaXADKOxE9srMOl0TuQYxW
         TnXZpKk741Dd4Sp4cYw6bRobAmOeI0X1SYjGGPbLgTxDneqR7UteWayPq1vnH1SJneNe
         IENQMCMinLKe+l6xlp7E9qd+ZtZ+OZbFCeLOj/CuYAGZyJl8IsblWSVYTWyAQdt4L/zc
         MBkUCSLfrXAJBvbZIJZpdLSCR46Lrn/a6AHl3xTlitfLFF2E7YpB+1O9uAdqsyEBvjie
         zN5LljU3X+Nyz0IRfOmPBwQ6k1jDi/0sJ0JRF1JRPIRCXIZqdac0Dh3VUZtlRv51hxSX
         azjQ==
X-Gm-Message-State: AOJu0YwT5Shq6ijCnbkbVyNo3AM6EpsnoTzHOICFqo9i0yqVdOpT/rXj
	QJRtrWAhhyAiJRaxvk+rb/zyrlg/ZTtnXyCZXOcGVw3qPX0=
X-Google-Smtp-Source: AGHT+IGRIV7pvjiFYSQ9d7sslbxtt1545Nx4nbcj99xJQon85WbiNN8wVRIajG7u8TGRT10Y5ZPxfZV5MRwr7bOGOP8=
X-Received: by 2002:a17:90b:19d2:b0:28b:cf7d:bc72 with SMTP id
 nm18-20020a17090b19d200b0028bcf7dbc72mr695938pjb.56.1703239961483; Fri, 22
 Dec 2023 02:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <tek6c6symqgm6x6ujh4m67q32en24pzrkjbchffir7qljo4gor@7qpu4zmgyzpq>
 <CAFBinCAxh0xU2mDRX3t42j6oJ534p9RPUV+dYoRe0oacTw_7iA@mail.gmail.com> <2f2bc3xvemk2x3sno65so6vglmpavjtyeiqzy6yyzwvx5hqtmi@tsfx2hr7rmqp>
In-Reply-To: <2f2bc3xvemk2x3sno65so6vglmpavjtyeiqzy6yyzwvx5hqtmi@tsfx2hr7rmqp>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 22 Dec 2023 11:12:30 +0100
Message-ID: <CAFBinCCLorBkGmpeUiep6gT7N__2641ec+f=hJyUgVEv1x6EdA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-pwm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Thierry Reding <thierry.reding@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On Fri, Dec 22, 2023 at 8:10=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> Also the calculation is wrong: If a relative duty-cyle in the interval
> [91%; 0%] maps lineary to [860 mV; 1140 mV] you get 1100 mV at
>
>              1100 mV - 860 mV
>         91 + ---------------- * (0 - 91) =3D 13
>              1140 mV - 860 mV
>
> (If the calculations in the driver used signed multiplication and
> division, all the checks for max_uV_duty < min_uV_duty could just go
> away.)
>
> So you want
>
> +               pwm-dutycycle-range =3D <13 0>;
Thank you!

> (if this restriction is really necessary).
I could not find a way around this.
Without this change pwm_regulator_set_voltage() is called with req_min
860mV and req_max 1140mV.
pwm_regulator_set_voltage() will then pick the lowest possible
voltage, which then results in 860mV (exactly what I get without any
patches).

To be able to keep the original minimum voltage in .dts would be to
work on what Mark suggested where he said:
"I'd expect a change in the init_state() function, possibly one that
programs the PWM to reflect the actual hardware state"

[...]
> > -     if (pstate.enabled)
> > -             voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_uni=
t);
> > -     else if (max_uV_duty < min_uV_duty)
> > -             voltage =3D max_uV_duty;
> > -     else
> > -             voltage =3D min_uV_duty;
> > +     voltage =3D pwm_get_relative_duty_cycle(&pstate, duty_unit);
>
> I'd add here:
>
>         if (voltage < min(max_uV_duty, min_uV_duty) ||
>             voltage > max(max_uV_duty, min_uV_duty))
>                 return -ENOTRECOVERABLE;
I can do that - although I think it should be a separate change.


Best regards,
Martin

