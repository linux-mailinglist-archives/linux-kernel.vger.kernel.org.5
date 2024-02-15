Return-Path: <linux-kernel+bounces-66885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368B856317
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCD71F2386F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5412C52A;
	Thu, 15 Feb 2024 12:26:52 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321938060F;
	Thu, 15 Feb 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000012; cv=none; b=MWIvMh5x9NLLngDkk5vR9OnqUBVlPSetjavc7OriHHXu8EOukJitj56s48ZQpcM5gMDMLVY9AIAw2KAwNEAAtgZMJK7uGWoES7y9P9rFgD8H5llN+dx29s1g3xasvRJUhIgTqjqNcYX37m58c1H/s/XJ0uDfei4H5ChfTNpbTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000012; c=relaxed/simple;
	bh=ZSLl5wO0RK6Im1rrNFdj++409NGRagzqEQ/iQpE2vRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuAP0PIYJguiS+Skf9Cm0/pBmHLdlD9kxJd7JWw4DZMiZ9rMhDOErUvYJXXf9S+jMFwq59tSPwgVG/DJ4H0w+xeIHLCcvv/rnG2NGtLsy3uZiVWgvfAwcb5MRSey5EpVDAUnQr1SKHdJiHC+0dO3Sby+QbeygoDG2ESwveOAO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607e41efcf1so1907867b3.1;
        Thu, 15 Feb 2024 04:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000008; x=1708604808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZVzEb8CURiPJp+VsQCWJGxahJj6VqLy6p+6UgLkLAw=;
        b=C4nt7nqw+nfvbGsdT4lEtDXC+HaESGk1JBxcpt2QFXuiTdPmjlKJcbVRhtuzg4HUQT
         K+EXXOvh4jTLXhxQyyfc/9ZkC1kgJXPUKiVB5slnk+BF3ElJsn5oi5xJhvPmZHuaCZhv
         6n5GUpvM2e3TSPg/RYLR9TlJapky8Dso6Z755yYfuKvR3XClN4E0NrOqyWWf9txRTRih
         rARxjMbgXeKLkwzletvKs7AiLlG8OXUgniKwjZb4neFWdlw/FHVX1jSEcpv8plgOhZjQ
         9LBvcwSnYn7ieA+BWRtYCnihGwLFxoo83ZI0h/yKLsrvmdyU6I0phrCGuAgbHKT/j1I1
         ahKA==
X-Forwarded-Encrypted: i=1; AJvYcCW3n521ZavDeFQG5SiHjcbHq2zLw/pQF7M3+lllNto7XDE/oOp7zTtPuYn+Mjy3OmOU/KBSoDz1EIVOCdHtOyDbmxEV1JPLvFVfIru5
X-Gm-Message-State: AOJu0Yw1CwWwQ95EH6Nd6SfKUkP7Z7spdMIrn8MFQQcvdvu7xvQdeEXj
	bjt0GCmLKDdLWVAVJcOEklqZcn/kU2xY4OQIqAdmtZYzs/jPwbZOCoLh+npwSKmOmQ==
X-Google-Smtp-Source: AGHT+IF6bq/ShfaLrkYDH51p7nIPkFSpxYMIpkoIlA8Iq7xWCpdqqsE4uR0Rx5ktd98IJFfoviWa3A==
X-Received: by 2002:a81:4e06:0:b0:607:75e1:9da7 with SMTP id c6-20020a814e06000000b0060775e19da7mr1573600ywb.30.1708000008499;
        Thu, 15 Feb 2024 04:26:48 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id m11-20020a81d24b000000b00604863dc35csm213475ywl.111.2024.02.15.04.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 04:26:48 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607d5af59feso3793917b3.3;
        Thu, 15 Feb 2024 04:26:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+w1aOWMYxAebhsh3TreTe29QWXrpLRQ1YAJjhI39pJhjxgto1vHQF1B6+LHin/aZgJFD8/hlq51pQW3YPkftRgVWDkE419p48MFRC
X-Received: by 2002:a81:4fcc:0:b0:607:845a:7f4 with SMTP id
 d195-20020a814fcc000000b00607845a07f4mr1487774ywb.27.1708000008078; Thu, 15
 Feb 2024 04:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
 <ZcpSDOk-IQVasHud@smile.fi.intel.com> <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
 <CAMuHMdV8mTa-qutFgqRKJyES7evEqEYhs=_eHtrKTTs5NkNa9A@mail.gmail.com> <Zc3yrdAdQ7-SRs1C@smile.fi.intel.com>
In-Reply-To: <Zc3yrdAdQ7-SRs1C@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 13:26:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUB3D6O45ie+5+h55KRPpA6FdED_73fKBH7nULwsbgRNg@mail.gmail.com>
Message-ID: <CAMuHMdUB3D6O45ie+5+h55KRPpA6FdED_73fKBH7nULwsbgRNg@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Feb 15, 2024 at 12:17=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Feb 15, 2024 at 11:57:53AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 12, 2024 at 07:14:53PM +0200, Andy Shevchenko wrote:
> > > +description:
> > > +  The Maxim MAX6958/6959 7-segment LED display controller provides
> > > +  an I2C interface to up to four 7-segment LED digits. The MAX6959
> > > +  in comparison to MAX6958 has the debounce and interrupt support.
> >
> > IUIC, the primary differentiating factor is that the MAX6959 adds input
> > and GPIO support?  Debounce and interrupt support are merely features
> > of input support.
>
> What should I do here? Rephrase?

    The Maxim MAX6958/6959 7-segment LED display controller provides
    an I2C interface to up to four 7-segment LED digits. The MAX6959
    adds input support.

> > > +  Type of the chip can be autodetected via specific register read,
> > > +  and hence the features may be enabled in the driver at run-time.
> >
> > I don't think you need to read that register, as the users of the
> > features (keypad mapping, interrupts property, ...) also need to be
> > described in DTS (once supported).
>
> So, the idea that if DT describes those we will check the chip ID and
> instantiate what is asked?

Even the check for the chip ID is probably not needed. E.g.
  - If the DTS has an interrupt property, (the future version of)
    the driver sets up the interrupt.
  - If the DTS has a linux,keymap, (the future version of) enables the
    keypad.

> > > +  Given hardware is simple and does not provide any additional pins,
> > > +  such as reset or enable.
> >
> > Does this matter? I.e. is it important to say this in the bindings?
>
> From Krzysztof's review of v1 I understood that it is important to say so
> people wouldn't wonder if HW has support of that which is not implemented
> (yet) or simply has no such pins.

It might be good to mention that in the commit description.
IMHO a list of all possible things that do not exist does not belong in the
bindings.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

