Return-Path: <linux-kernel+bounces-62146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9D851C32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF171C2164E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD38405DF;
	Mon, 12 Feb 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4obhhep"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F6D3FE52;
	Mon, 12 Feb 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760439; cv=none; b=tbMEe75R7AsG0hQon6nNQxuDcSCOHGOnkMXIvfolTLhwQQADVjJw5llCXRYQimIs11pANjkIemB9V1igxWEkZtxz6R9IBvjjxd3ka32H7khULpLQEZ3wGwUt71tLaA+/niBxokYaI4GMOuNBS2nYS56nVUnJ4rS+IL4RZqeWHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760439; c=relaxed/simple;
	bh=F6SsN4ngSTP5carvI6Q6KddAfM3OoB7+2wTWiu+HrVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1ztV79RrejTbP8lvGEHOauUyvRFHUHy7LxZKaUJX4Mpek4oIawDi1nfs+yxsYcWpWX03WyMcy1w5CKW5IJCiNIGxaT9S4abOXa5SOM0NoS7eCmu+tSRCZcgmTC/9zPwjmcE3NuQ40o1PabVg6pBuGmbjlCWoZFi/vQm4c/y0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4obhhep; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5a6b1dd60so1476358241.3;
        Mon, 12 Feb 2024 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707760436; x=1708365236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNx4A3iHZp5oxyNcXN+og4JNdWFeIzGNClAgiRIvrec=;
        b=V4obhhepuuZE7V8nJsKyGD5mmEEbpFjksc5xcYB+/Ds1ulzJZ3tA1t0t4YrfP7n19L
         izepzRSZmZ0424nWGhTa+efmzt4CxihUmN11jUPYqjco9fF4W59Is0Z0CYsLkbixC8Pc
         NtqVEt8pTRgBuR8ZPmZk22RU75bsVjuIznDr4qOWr0KzXAcOblMiznZZsu+uzL7LX5hQ
         XxcNI71BYKmogIHkJVZ85PrLVHaVv3Z5vwyEQu0fp/8h5IR/nJuLL6LDwnVq1mwy72et
         K2gmYVQYKL1od4/dDVeUfFsTWZiSdRsV8OcqTEcPh4/R9uo+ZN1jXfHjO8u6dmb6JbQx
         /kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760436; x=1708365236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNx4A3iHZp5oxyNcXN+og4JNdWFeIzGNClAgiRIvrec=;
        b=Ou/Q4ivcc7w/+Qk54C7aM7DbJ4RSkOgjlKkARRnqdJB3hsuWDuD2deC/f4ff/psOr1
         iG15y+Cwqr8RO+KSbr18lXWasuwG8FgYhaW/QLwIjCKVkUlCsTyTrPD5MAxOSEjx5fzt
         o17eEKuheDb0ESh5/Oov+4/OXOkdlKPmdoTi9SZCtxRW5JQOfkG1PhPZchauNFAw2SMp
         QBGPrZbuQ3jLpmgtNZMPVkpTgGGKA4iqogcdXsXhKq8zlGdpluiqQCD0bLmMNPTSnogr
         mG6tLxNyfsh9tLt0H/x4qyfc0pgewNjPGEm4xehqIS11qkbX6hdqb81vBbgn9D9ftKIc
         0tpw==
X-Forwarded-Encrypted: i=1; AJvYcCUwm9H1VN4FToiRkzMXv9sBSfBx17FPLjgsdB4l5RqmpqmZBO89LBejLRuwmMtkI0S6HJZZ6lrPL4C2bqUs32QR41E94oXdSmFtpudsNBOXXrRNoVkazmNgWnoqGGIt8S6rE957COImVPzybqXSUMokG8KHTlVT05Jj/wS55TuQfpWI2iPMu5W7PnUV
X-Gm-Message-State: AOJu0Yymqc4SJ4FScxD5A71d6UByt7zUrf0/Vg+WmB2+FhURDOvCVnWj
	QAeicyC4Vv+3qGnSriPcrUKFv7R7GcHUh8K8GmGcQ6jIcJpAAiGZVWqUvDKSXNZU6J3K1uz9lYw
	lj09OB+jptGUEnObB9/ShBG5Q+8g=
X-Google-Smtp-Source: AGHT+IGa+SWVFDlNa61GPWR/EEMj0AtnZiRgMFDtCjXrUmtsngHq0jI8TRLNTwoBRezWlo1H819EZqhtEe6J7M7PCCU=
X-Received: by 2002:a1f:6642:0:b0:4c0:2b39:dc86 with SMTP id
 a63-20020a1f6642000000b004c02b39dc86mr4582286vkc.5.1707760435327; Mon, 12 Feb
 2024 09:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW0xWgA+9rtDcRUgoS1HYvd+mukvK25MHbzHpo=1uGq0g@mail.gmail.com>
In-Reply-To: <CAMuHMdW0xWgA+9rtDcRUgoS1HYvd+mukvK25MHbzHpo=1uGq0g@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 12 Feb 2024 17:53:28 +0000
Message-ID: <CA+V-a8t2c30g8vDeACagqPTiNPq4oVUT2nFXaSD=AoDCyKXK7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Feb 12, 2024 at 4:25=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Feb 5, 2024 at 3:44=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
> > supported by the IRQC block, reflect the same in DT binding doc.
> >
> > - R9A07G043U              - RZ/G2UL
> > - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> > - R9A07G054               - RZ/V2L
> > - R9A08G045               - RZ/G3S
> >
> > For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into sin=
gle
> > interrupt so we just use the below to represent them:
> > - ec7tie1-0
> > - ec7tie2-0
> > - ec7tiovf-0
> >
> > Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupt=
s
> > were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
> > SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
> > support these interrupts. Therefore, mark the 'interrupt-names' propert=
y
> > as required for all the SoCs and update the example node in the binding
> > document.
> >
> > Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ=
/G2L Interrupt Controller")
> > Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-=
irqc: Document RZ/G3S")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rz=
g2l-irqc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rz=
g2l-irqc.yaml
> > @@ -88,9 +88,15 @@ properties:
> >        - description: GPIO interrupt, TINT30
> >        - description: GPIO interrupt, TINT31
> >        - description: Bus error interrupt
> > +      - description: ECCRAM0 1bit error interrupt
> > +      - description: ECCRAM0 2bit error interrupt
> > +      - description: ECCRAM0 error overflow interrupt
> > +      - description: ECCRAM1 1bit error interrupt
> > +      - description: ECCRAM1 2bit error interrupt
> > +      - description: ECCRAM1 error overflow interrupt
> >
> >    interrupt-names:
> > -    minItems: 41
> > +    minItems: 45
> >      items:
> >        - const: nmi
> >        - const: irq0
> > @@ -134,6 +140,12 @@ properties:
> >        - const: tint30
> >        - const: tint31
> >        - const: bus-err
> > +      - const: ec7tie1-0   # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 in=
terrupts are combined into single interrupt.
> > +      - const: ec7tie2-0   # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 in=
terrupts are combined into single interrupt.
> > +      - const: ec7tiovf-0  # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 in=
terrupts are combined into single interrupt.
>
> These lines are indeed a bit long, and might become longer when newer
> SoCs are introduced.
>
Agreed.

> What about changing the descriptions instead, like
>
>     -      - description: ECCRAM0 1bit error interrupt
>     +      - description: ECCRAM0 or combined ECCRAM0/1 1bit error interr=
upt
>
> ?
>
Agreed, sounds good. I'll just resend this patch fixing this.

Cheers,
Prabhakar

