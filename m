Return-Path: <linux-kernel+bounces-108596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F776880CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA029B21CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAF2E40E;
	Wed, 20 Mar 2024 08:10:16 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69FC36B08;
	Wed, 20 Mar 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922216; cv=none; b=HJOsObnOQq+eJE1n2VmOV5k4R39YZBOQyeT1z8GrOAnQmL4JvHln7ORcyeGkM2GzTWTkAV4b0P2NS8QWjoesYsmpC5lVgPtJnv9Iekk7YzxO4bwR1cBKoiiQIE7dxxflalFtbI5YK77xZiO2yYS/G3ZuAL7OUxAkJE4Cu3jWfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922216; c=relaxed/simple;
	bh=pd31bKmxlo1OpLOh9Iu3x7FhDKDblBIut3laVIUhbEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBtS5gDfrwpULKS6JYNJBI221M3vANf73sF8dj+9AoFmJNbvbZ8CpJjDQ2+XRbcsYJHX2zNBd1CX1HJRf8DcYgLYaOL8QdOZaO7TycFAgxksuVN3+DfyTsfZ+8CGtR3SrUFKXSpwzMQLfL8QeKQiHSvlDfHIo89bZKlE3bHEN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f4155b76so67466987b3.1;
        Wed, 20 Mar 2024 01:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710922213; x=1711527013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43ZZjuvoVhbmxE+0h9EquEuye5a0cFL3jn7HritCKTk=;
        b=X+an27iZpvoNsIlZsU1P028pSCkSm/QBD4TD4bMgMpZTk9C0RE8SE9jqhQL/TsUObE
         DZjSFtkNHBMvfpiIJ2SOWaR8crVS9GtIOKexGO3Uy+RgDHzA3bTfrwTQiauUxnLkGQu2
         LAi8wBayEDIM7Crgk3lCrNwrDHocKdLpzsXl51RSQF+f8WqrH/dqhGAJBN8iEJlyBUaP
         K1bZHC+nmApMwwBKRoY9l1ZWzg3eJNIAUFfSIVmuvH7KzrOJs+OMsT3B0/LqzexVpgMo
         7zTqe8hCTzadA8ZyzHlvKGFnQDeJuKRDJXZdNKB/ZV1MvbN7xQ0yBnfVp+8o7R8gKoob
         I3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa14fi9x+tRcasJuz12s4nGBS3IcQQv+sVVtZN0KHIEJuJn71sYwVkH0eFJgfJes/qMNc8fBZXBTKTUHIbLSRHuJp7OLolVCL12JUL8TV+38wHI87R7fs16dT+O04fM+hSPaWqR7R0lhVNB7Jio7jqoMGiHxNNyeMBidJiusKN7NlNLWHQH4IpW74t3y/1BKo7pfhrDjWsDhbmAHp256d1q7cR5Kg86d5v
X-Gm-Message-State: AOJu0Yzvuh2+M7jmMOHrINTV4FI0PmfwQLrWeRn7sFL3d1lxS6nYJu23
	L/XuxBGuHuYhVaPqV3yreeNRz3zlfmxZD+ExuCmcrrKieUf1t5375OlSlTCqGnw=
X-Google-Smtp-Source: AGHT+IGG7LPH69+ANDwqUFBl0FI2hP5vUDdaozHNNo1k84OqdUBhi3X9ilOdzDkB1/9DGOHggwfI6w==
X-Received: by 2002:a81:838d:0:b0:609:3c37:a624 with SMTP id t135-20020a81838d000000b006093c37a624mr4939905ywf.35.1710922213412;
        Wed, 20 Mar 2024 01:10:13 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id t3-20020a81b503000000b0060fd72deff2sm2149053ywh.64.2024.03.20.01.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:10:13 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609f060cbafso77296427b3.0;
        Wed, 20 Mar 2024 01:10:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxSFXUjs/1dytvtL7H3Bc4YhtuMu52/wpaIsuo/nTf5TgBiYqke/KzqI63kg4lItlvUy8d/oej1PINr+6uw8qIDwObA8WsrU7R+f1sltiBaYab5W3wL7CV6N+0iBh5sVyHJjR9xmNhmNTcIqgm4M1+SePczRxvYKJwWBtkLyNv/WnR814rDQRw02fmaQ/EwLPmelm4u1dxAJtF/eOzIEdug7fH7NtzaIMa
X-Received: by 2002:a0d:ea16:0:b0:60a:66d3:c021 with SMTP id
 t22-20020a0dea16000000b0060a66d3c021mr5256277ywe.22.1710922212867; Wed, 20
 Mar 2024 01:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <db13e305-adc4-4990-b9ec-b1cdcdad4406@linaro.org> <010e4742-438f-413f-811f-a033ec104832@linaro.org>
 <CA+V-a8txP39HJJrJcNqCUgw2NkdA3uSvBrbdSzw0bN6r5LpNaQ@mail.gmail.com>
 <51743788-3444-4817-864b-404205a06137@linaro.org> <CAMuHMdVWMt_JqpiWasZxS3D8dS5JYgxDU0SKbFxNVV-zWk8D+w@mail.gmail.com>
 <5b87eee4-2b28-48a5-a7c8-6c450be724e7@linaro.org>
In-Reply-To: <5b87eee4-2b28-48a5-a7c8-6c450be724e7@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 09:10:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPpdqTCVO5Yu1XO1RSnryHUcXZ4PDhfTJ0sGcstWhO9A@mail.gmail.com>
Message-ID: <CAMuHMdWPpdqTCVO5Yu1XO1RSnryHUcXZ4PDhfTJ0sGcstWhO9A@mail.gmail.com>
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

On Wed, Mar 20, 2024 at 9:06=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 19/03/2024 14:25, Geert Uytterhoeven wrote:
> > On Tue, Mar 19, 2024 at 2:04=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >> On 19/03/2024 13:43, Lad, Prabhakar wrote:
> >>>>>> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif=
yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >>>>>> index af72c3420453..53f18e9810fd 100644
> >>>>>> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> >>>>>> @@ -82,38 +82,6 @@ properties:
> >>>>>>    reg:
> >>>>>>      maxItems: 1
> >>>>>>
> >>>>>> -  interrupts:
> >>>>>
> >>>>> I don't understand what is happening with this patchset. Interrupts=
 must
> >>>>> stay here. Where did you receive any different feedback?
> >>>>
> >>>> Look how it is done:
> >>>> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetre=
e/bindings/ufs/qcom,ufs.yaml#L44
> >>>>
> >>> Thanks for the pointer, as the above binding doesn't have any
> >>
> >> Yeah, that's just an example to point you the concept: top level
> >> property comes with widest constraints (or widest matching items
> >> description) and each variant narrows the choice.
> >>
> >>> description items as compared to our case, to clarify I have updated
> >>> the binding is below. Is this the correct approach?
> >>>
> >>> option #1
> >>> ---------------
> >>
> >>
> >> Yes, it looks correct.
> >
> > Why duplicate all the descriptions? The only differences are the number
> > of valid interrupts?
> > What was wrong with "[PATCH v2 2/2] dt-bindings: serial: renesas,scif:
> > Validate 'interrupts' and 'interrupt-names'"[1]?
> >
> > https://lore.kernel.org/r/20240307114217.34784-3-prabhakar.mahadev-lad.=
rj@bp.renesas.com/
>
> I have impression that only two variants out of three have same
> descriptions... but now I see mistake I made in above. I read that first
> interrupt is "Error interrupt" but it is "error or combined". Sorry for
> that, I think most of my comment there is not correct.
>
> It could be made oneOf?
>
>     oneOf:
>      - items:
>           - description: A combined interrupt
>      - items:
>          - ....
>        minItems: 4
> ?

Yes, that would be even better.

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

