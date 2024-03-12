Return-Path: <linux-kernel+bounces-99940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416E878F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A183B1F22C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F769D03;
	Tue, 12 Mar 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvoNlh8b"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A742A9D;
	Tue, 12 Mar 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230864; cv=none; b=AU7YnoKdbfZWDJsg+R5fIO/er6hax1IkxP00RlDTGbjrqoh68dIEzNJM6MPYm1k23zFyNXUZkzU/llRFmqAWxpBsMi64EYG3DKBMXNvhULsSZfhgWcBPc6IwH7h5Ge/GXpsmKFVR9d67YkKvTn1iYdmqFM6dOKZcLheU5L0CykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230864; c=relaxed/simple;
	bh=PNfBS889iem5S8jWm+B9nUFW1ywCu/6HUug1appnhjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlWbxLNgk5YJZ5r/4qiLFIwJhNH5x8tYMMgwHXJoJ48HtzpMK1jBJpzARFuFgncZgtgJAgn/cjksMSlCF67uPYDVQTV/AtrEkAUWJSNoIgqeG8Rho8yAt3XIlXxW8cGFyFbqzS/O/I9yDrgHyrBDBGZrCkglC9/B0ywgl+xpP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvoNlh8b; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c19dd9ade5so2441830b6e.3;
        Tue, 12 Mar 2024 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710230861; x=1710835661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/RIzEOygq7VMUeLQit4zxfFJspu+naDg/n7R0XzC1T4=;
        b=NvoNlh8bHHJYIlX/dtbefgIiOI5mucLA9eg6NXyLWWt1ZuGjpQ/zqIvRW1+gVrcoTT
         /A4hdoGclfJAhVTvDH1ooj5evbXYqj/whyC8aQUtTh5s1OX1wYFK4OASVjc9oMyy7owX
         zI+4w9saV9Q/ojYWLtb2GIeQY4fmeIA4tPDG7nvrkFA7V78HAxfIa7+hjbeF4KX0WCxF
         CONRCSBnDireNS1dt+/jlwwk2+fgYOei9qORQG/q9f2MTUbImbhd6jeKhtT4IeGYf8vN
         PPxrANb5kX+J5zimk+ZGWdwRXfCt5I6dQzvxxZo+QfmWQOkDGx7Av05tbZJ6i+FTD7/8
         botA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710230861; x=1710835661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RIzEOygq7VMUeLQit4zxfFJspu+naDg/n7R0XzC1T4=;
        b=nWP1GnRT4QeYaS5ANKCHue/fBd/7ESOp2z5+pnJYoXgQk1JlG0HcN+XiW03i/ACsZP
         Yeoq3V4UAeKN1LrhbrI9jFZEJN+LQJfoQB/tk09h8GM/3fQmvAhPcV7QLJ1Z+DGEhnJ7
         Vf+4PG2CjRQzgO1Tm9B2dMzTkSdMRO0rdAGlM9xh+BDlMvdav2sRu5zy8UeXkws4RZFe
         gMZM32aQiFXpoTYv8ZtYwthh1QEcEmxIWLTmNIrqsxS8TTg7mNh/afTaM6+uTAHu+E+H
         +4zEQlOokk1AuuZ2L9KDO59CU7P7jLQbLdjDKY1QHsbw7vWmxu1lxwB5sTrAIs8qdOb+
         NeoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7bGOxAchhRIAYZkgLfbV12GhyltgT0shrEYDvsgWsB7P0tAVcygJ/0yDCgObAHhyV4ICYChdkGq+FN+UcAnkLYptZo99/Y4jnhBKKDSljeqmgH82SY9Ojia+ukv1+lvC2vLBC+kfvnDMKZ57ioa9yA2u9+0vb+f4PMJbQmk0PFL5YfQ==
X-Gm-Message-State: AOJu0YwAyAG9aeBdth2gF8MCh03AlmNE6x0p+2c34kmzhz1RS/tXXpTk
	NLF6JEFdgqUar77RMD857tVfenF8s38ujEzi79LA7E+DSSGIuCk4toNyN+8aDt5TuckshItS7Gz
	WLfzh4Qe6DmSzUTWc0RfsPAcKigY=
X-Google-Smtp-Source: AGHT+IEqGDo4+QqrniADKoFq8kmvx9wqjkjFdrGrz+1YEKvO4L30rSVWPQnVMTLEU9xShw0Iryu5luhAJnmK0B+eWoM=
X-Received: by 2002:a05:6870:854d:b0:220:b713:77c1 with SMTP id
 w13-20020a056870854d00b00220b71377c1mr7483886oaj.31.1710230861330; Tue, 12
 Mar 2024 01:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
 <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com> <twzx4abuhduos5s32txeugqr2yyca6ey7adcontsnapthwqaxa@dscea3ybrlym>
 <CAJRtX8T3GD-zu43-+U_rGQugqzGQQ-QbjHATV1NRdEMWevSUGw@mail.gmail.com>
In-Reply-To: <CAJRtX8T3GD-zu43-+U_rGQugqzGQQ-QbjHATV1NRdEMWevSUGw@mail.gmail.com>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 12 Mar 2024 16:07:30 +0800
Message-ID: <CAJRtX8RagduSxqxh-jH2wcoNgzbRdNRYW5Gcka1_uPR-o-Tj7w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"

Hi Uwe,

Gentle ping,
I'm sorry for wasting your time, and I look forward to your feedback.

> > > +     if (tem < PWM_CV1800_MINPERIOD)
> > > +             return -EINVAL;
> > > +
> > > +     if (tem > PWM_CV1800_MAXPERIOD)
> > > +             tem = PWM_CV1800_MAXPERIOD;
> > > +
> > > +     period_val = (u32)tem;
> > > +
> > > +     /*
> > > +      * The meaning of HLPERIOD is the number of beats in the low or high level
> > > +      * of the PERIOD. When the value of the POLARITY register is 0, HLPERIOD
> > > +      * represents a low level.
> > > +      * HLPERIOD = period_val - rate(MHz) / duty(MHz)
> > > +      * HLPERIOD = period_val - duty(ns) * rate(Hz) / NSEC_PER_SEC
> >
> > So HLPERIOD defines the second part of each period, right? This isn't
> > considered in .get_state().
>
> I am so sorry about this. I made a mess of the duty cycle.
> According to the PWM_DEBUG, it can be inferred that configure the
> biggest duty_cycle not
> bigger than the requested value, so in .apply duty_cycle should round down and
> in .get_state duty_cycle should round up. However, when the polarity is normal,
> This hardware requires a low-level beat count. So the corrected code
> is as follows.
>
> in .apply()
>
> ticks = mul_u64_u64_div_u64(state->duty_cycle , priv->clk_rate,NSEC_PER_SEC);
> ...
> hlperiod_val =period_val- (u32)ticks;
>
> in .get_state()
>
> u32 hlperiod_val=0;
>
> period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,priv->clk_rate);
> duty_ns = DIV_ROUND_UP_ULL(hlperiod_val * period_ns, period_val);
> hlperiod_val = period_ns - duty_ns;
>
> I tested this code with PWM_DEBUG. no warning output. What do you
> think about this?
>
>

in .apply()

ticks = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
NSEC_PER_SEC);
if (ticks > period_val)
ticks = period_val;

hlperiod_val = period_val - (u32)ticks;
..
regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod_val);

in .get_state()

u64 hlperiod_ns = 0;
regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod_val);
..
period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,
priv->clk_rate);
hlperiod_ns = DIV_ROUND_UP_ULL(hlperiod_val * NSEC_PER_SEC,
priv->clk_rate);

duty_ns = period_ns - hlperiod_ns;

I tested this code with PWM_DEBUG. no warning output.

> >
> > > +      */
> > > +     tem = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
> > > +                               NSEC_PER_SEC);
> > > +     if (tem > period_val)
> > > +             return -EINVAL;
> >
> > if (tem > period_val)
> >         tem = period_val;
> >
> > > +     hlperiod_val = period_val - (u32)tem;
> >
> > Wrong rounding I think. Did you test your driver with PWM_DEBUG enabled?
>
> ditto.
>

Best regards
Jingbao Qiu

