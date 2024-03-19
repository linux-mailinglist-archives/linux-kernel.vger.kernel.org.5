Return-Path: <linux-kernel+bounces-107585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA087FEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046171F22E54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834080027;
	Tue, 19 Mar 2024 13:26:01 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4E8002A;
	Tue, 19 Mar 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854760; cv=none; b=obKaKNxV0zKv6pUetpFTk0FnSreOj40bOd+RUlrAHYIByUJfNrFF0HUjjmyd8hYXr5mSnHlrj62fjItVYP/75W9KezpHyvzWuY4b50MPbsOffZ7aHJWwoh6t/npwGR1E+m5j+wK5tg+Qaix1lB+vuoM23TGY/bnLIIJpyvX/KiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854760; c=relaxed/simple;
	bh=QMp0a6X0zF1/jLhQMcPxC09b0tWyVVG0eCAEf4UbP4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtPwC6Vd56N6qAKWm0BcH+1aoCRiWMVlMsQiMOlqYumMqP502/F4yLNUu5+GsYIkQm9RS7SRoTkN31GyC3DmSJIAlZsCJHF3xEHzcBjrbJmg8+DD5TxUQz874QGLSJh0I05aZ4hYwwrTGo3Kv6aGPf/Sjy+UyZh+6Rc9xpghWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609ed7ca444so51530507b3.1;
        Tue, 19 Mar 2024 06:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710854757; x=1711459557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roVBegNwTJt5k2/1YSZU0EzfT6WRuPewqC12eJohDSE=;
        b=P9HAYdhZvfqfSJoi+dngcjmjIagdjNjv7jzMTpNaZEVms7xCbQ8I6/Rqh7DNVHopLQ
         G/f+nC6Jy6UJu/tbRrZC+r1KizbLvUltacM/Tg4t+Z451T5xHWsGBV3UVXjXzi0kAGa+
         5+k7qaBDeUdS+05aIQBcE+wWBvG+aEhAA7ggE6tg3l+FtfJH2wQwYAzxBE9y6wWLyPpo
         Mtzxiv7sPXMat3dxnz3B+d1g507gWs+2QsoWUJBP56vDr45L6BLor6ryXeaf5dyD5xCJ
         iUvqqxzEeigaUGIiTKNOLhixs0CJSraR+ratUwS0qCdvT2hRA3dCLveMl/YyzhcumFWP
         BY+w==
X-Forwarded-Encrypted: i=1; AJvYcCVUfZLfrdE/hKrqXB4+8L+lIOS8cbyJhY05W+x/sM1NCqTYxyFf96zKeEmbfbw4JuxO8z1PAsid0vgq9JjoUYkcVk5+YOgCmmtRFtvaxiUvk6TYBT6f7mmWU7O+VxG+n0yDOKQPxOiV0G/1OKOHgD8PlWvX+3XP+dfx9nQ8YeHSAdhK+ywVv93Kpuf1FmJCqw8pQiekWNDWp/UEu63e5vQNcoaN31E4NErL
X-Gm-Message-State: AOJu0Yy34WPLd1K67g0v4NiL8+i1GTSKgVTvRC7Yyil6rAVmUE7D+5Tn
	eAA9NOT+QMLXvTUGFwqJutXzDgv+A+mxXUd/Op5KgpntOChPI5eeRM9783dqh+o=
X-Google-Smtp-Source: AGHT+IEpK0fCbMXb5ndXOgGdw9eq4LBstpJ97QsVGI4+/tj7rJPsLOz+AAa+kfxbWcbZIB27nbKP+w==
X-Received: by 2002:a81:8a41:0:b0:610:b448:663b with SMTP id a62-20020a818a41000000b00610b448663bmr6573252ywg.37.1710854756950;
        Tue, 19 Mar 2024 06:25:56 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y21-20020a81a115000000b0060a085163adsm2368014ywg.73.2024.03.19.06.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 06:25:56 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609ed7ca444so51530237b3.1;
        Tue, 19 Mar 2024 06:25:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWULV3Fj9FllAcDslO7dDZ7P74ZED8L/VeiZpIu7q7GJ63x5pzioMqLTepe67Dy4x6mC+NJjizF2MISPZ1UdOzDqApW0TrZJ+VXNJDywPPbdXeEcOuvFB7jXmKuG9lPWxp0ZZvj9OJXigREiuJ0cE9xhMmGzEmxQNrA2XmL4eoPYQYlBE2RicFlvKcxQAvT7cVFNNgq8EhcIBzFk70C8Tr8ED03R6PiSxa7
X-Received: by 2002:a81:8a41:0:b0:610:b448:663b with SMTP id
 a62-20020a818a41000000b00610b448663bmr6573232ywg.37.1710854756514; Tue, 19
 Mar 2024 06:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <db13e305-adc4-4990-b9ec-b1cdcdad4406@linaro.org> <010e4742-438f-413f-811f-a033ec104832@linaro.org>
 <CA+V-a8txP39HJJrJcNqCUgw2NkdA3uSvBrbdSzw0bN6r5LpNaQ@mail.gmail.com> <51743788-3444-4817-864b-404205a06137@linaro.org>
In-Reply-To: <51743788-3444-4817-864b-404205a06137@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Mar 2024 14:25:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWMt_JqpiWasZxS3D8dS5JYgxDU0SKbFxNVV-zWk8D+w@mail.gmail.com>
Message-ID: <CAMuHMdVWMt_JqpiWasZxS3D8dS5JYgxDU0SKbFxNVV-zWk8D+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Mar 19, 2024 at 2:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 19/03/2024 13:43, Lad, Prabhakar wrote:
> >>>> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.y=
aml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >>>> index af72c3420453..53f18e9810fd 100644
> >>>> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >>>> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >>>> @@ -82,38 +82,6 @@ properties:
> >>>>    reg:
> >>>>      maxItems: 1
> >>>>
> >>>> -  interrupts:
> >>>
> >>> I don't understand what is happening with this patchset. Interrupts m=
ust
> >>> stay here. Where did you receive any different feedback?
> >>
> >> Look how it is done:
> >> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/=
bindings/ufs/qcom,ufs.yaml#L44
> >>
> > Thanks for the pointer, as the above binding doesn't have any
>
> Yeah, that's just an example to point you the concept: top level
> property comes with widest constraints (or widest matching items
> description) and each variant narrows the choice.
>
> > description items as compared to our case, to clarify I have updated
> > the binding is below. Is this the correct approach?
> >
> > option #1
> > ---------------
>
>
> Yes, it looks correct.

Why duplicate all the descriptions? The only differences are the number
of valid interrupts?
What was wrong with "[PATCH v2 2/2] dt-bindings: serial: renesas,scif:
Validate 'interrupts' and 'interrupt-names'"[1]?

https://lore.kernel.org/r/20240307114217.34784-3-prabhakar.mahadev-lad.rj@b=
p.renesas.com/

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

