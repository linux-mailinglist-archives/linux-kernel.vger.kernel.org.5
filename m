Return-Path: <linux-kernel+bounces-112546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38036887B5E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB3BB21BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C16290C;
	Sun, 24 Mar 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfRclf39"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649981E;
	Sun, 24 Mar 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246267; cv=none; b=HJRim6hDMnmmM4AOlQC+tQQdx8SRe/ogPdWYE5KNNIWOWk/YoEscS8Kb5XNx4hAZtxVn7prjgnxcP7o7u/BYy+88CyKVn52Z/DoNW6BJhQAkwrUJ61VKUDfcZof5s4cDePBXoFHDKPuuIsimLSsWZYDDeqyP0LRcKUevRh79DHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246267; c=relaxed/simple;
	bh=O4mxWIZtqaCaa6tGkopSI4pdla5nDON3z7rbb6/L1r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZDUS7Kqa3nOaSE8Ru+Qhrv5iaNuZ3Yqb+lkcYz3mA03YCW/GRnuJbzlKIf4LTxv0QInE9cRmv8ccyfqTzIZlO8HmlMWKjRHfg5DTQqFfRbUjSt/mebIRWvGjrYAnjW1Qwf4Yhkf4pQiVzJge2Eb92mbJHBDWTrXHXGcJoU2qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfRclf39; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e10a4083so3777936e87.1;
        Sat, 23 Mar 2024 19:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711246264; x=1711851064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9wMu56cuKN3w+mxBDS/FvXc6kf2qXtgJwy0PKkso6k=;
        b=jfRclf398hU7aTyO7NtvZCVMKolLLjtNA39qTjKiqvgvEk13vpdGBzFkAzvgldCYWa
         M9Ex0K4w9B15L1SEyDENr+u2gTv8vAIImOhnNVOgmTZmum+Suc6Z+OVKB97DLF1EmXBP
         VFmTbugOwthsrkT8M4q0ilrBrwZ7PY84vtOvknoisczX9ul6Gc4ZJqiUzaXuISc+GyDg
         wnPd57sUqrvCpY1SL8R+2tpQm8cQtNLxtEe2tdffVkou6pfogGe33OJty5l5vUFLyg9N
         zSBPukXPYytekGjG/h7dG9o12codxKLUNfHcZVhLu+FQZgwGHSwHOkRxtmVIjh7ookeU
         rEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711246264; x=1711851064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9wMu56cuKN3w+mxBDS/FvXc6kf2qXtgJwy0PKkso6k=;
        b=hE3qFeSVk5la2ruGbPrKc5r6l6rwhtJ2oIHY1vtHR7H8/u6OfgaOBKkC3CWezHgcfY
         O+LnIY/tHqllQk83J1oqcUu0zUKEuMm4fU1bzs7lE4FvlZ9/i5wcpfPbRov8yEKoIMRN
         69KSVWgWt2sSrSzOSDYeOTXNLjcelVGuyYKbmHeozF6jRgM1tZ2U6hyxRactvQAFglrB
         bibcQNx2LTCA6Wv+LVPW/6NM5zERwQpp4W6jdMD3+kKC8A1TiJ7cZJwhFY+p/6o/ND0C
         GbUr85a5KfkIJPEqVkgvSBsm1wA3g4f38CCmz6CrP1nKPFw6JvdRUJS+CsqzOOrZK7WX
         Saig==
X-Forwarded-Encrypted: i=1; AJvYcCXxe3JyREYhVGUD6GozFAtGaL+bGQD2co3QoIy4p9EbD7zSi0C+kdlP6Zy149tFt/oAs1lkehTHxA8fqQdv/4ZsGO6lNk3d7r+P22qTeMU01YrTYBvYGN1ZAJdWEma/LTYf0GdPFART0PWiARL4Vo70DIM1umwVM9pjKY+iHx+iOQ==
X-Gm-Message-State: AOJu0YyJ1DPvxsO4d19sUCe/mUhvnEcf19IHem1YIdjJXX+fR577Zgld
	AAHWIK7rS4hA7MqQe52aZ+6G3sSIvY/FDnriqOIFN6YB/X0JIQ2scxsDIGUkAL1rnfsTMba3CV2
	F+RBL1hxqBr9+wblTS8CAUnM+H8o=
X-Google-Smtp-Source: AGHT+IFOyuKElypawmVuALXhEMGMLfWqusJVVb7LEmch8qfvQf/2Qx6F4tMq/LvEII9lATb9de4+2xPCidrrfM4YdL8=
X-Received: by 2002:a05:6512:1ce:b0:513:cf5a:f872 with SMTP id
 f14-20020a05651201ce00b00513cf5af872mr2003294lfp.69.1711246263889; Sat, 23
 Mar 2024 19:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com> <d2568101-f3e0-4c2d-8613-52d023e22b77@kernel.org>
 <CAJq09z6q2gaZYqc-=fQEMOA1ViAKTEJqT9iF2xsYCde9syouig@mail.gmail.com> <e32363b2-66c4-4b76-a56a-40eec3a3c907@kernel.org>
In-Reply-To: <e32363b2-66c4-4b76-a56a-40eec3a3c907@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 Mar 2024 23:10:52 -0300
Message-ID: <CAJq09z6qinM-bp3ht35JdcggVpwQscThAQOAs2yB2do-BFN9VA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED usage
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

> >>
> >>> +
> >>> +            patternProperties:
> >>> +              '^led@[a-f0-9]+$':
> >>
> >> [0-3]
> >
> > leds are already defined for a port. I'm just trying to add a
> > restriction to allow only 0-3 leds and use that to identify the group.
>
> Where is the restriction, in your original patch?

I tried to limit the led index to [0-3] (from the original
'^led@[a-f0-9]+$') and reg also to [0-3] (originally not constrained).

>
> > These suggestions will redefine the leds property, forcing me to
>
> How? I really do not see it.

I thought it was including the previous object definition when I
mentioned the same property again. However, the
"unevaluatedProperties: false" made it clear that it is actually
replacing the previous declaration. Sorry for my lack of experience.

> > declare #address-cells, #size-cells for leds and reference the led
> > schema in led@[0-3]. Is there a way to just add a constraint to what
> > is already present?
>
> I don't follow.

I would like to somehow add a restriction without replacing the
existing subnode definition. I'm not sure if the YAML scheme can
modify an heritaged sub-sub-property without redefining it all over
again or if the parent object requires a specific subobject property.
Anyway, the discussion ended up concluding that it was not worth it to
add such complexity for this situation.

Thank you for your time.

>
> >
> >>
> >>> +                type: object
> >>> +                additionalProperties: true
> >>
> >> This cannot be 'true'. Which then will point you to errors and missing
> >> ref to leds schema and need to use unevaluatedProperties: false.
> Best regards,
> Krzysztof
>

Regards,

Luiz

