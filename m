Return-Path: <linux-kernel+bounces-93743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30887340E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F3C29133E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87A06027F;
	Wed,  6 Mar 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTa1S5u7"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279D5FB97;
	Wed,  6 Mar 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720583; cv=none; b=nG9gpsFBxiNQ1I9yU1m6nIdyAptmZdmr+aV6MIzOfVbsCEo+4+FuKqPl2O+d1VewfwNWXOT6fCD80RWgXjwQSyMJ7Ll0j3YCEUT3YN6KExpab54eJaOlxyS/vfJZmUdj56oMU/fcMQ9ykPkeuj2KY2ZdBfWZ7hMLSr9OoYAIA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720583; c=relaxed/simple;
	bh=ru5KVpO0fYpM81R7FvwYOV4mwnZ5EV6GBubWlLtAQZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjt1LB3GO+zhueeLaJkTVjr0XM53Zw70XDwcyzeCs/7th7wt9aQ+f4gNrBPCTJRpaBKj4lrZUMEA6iV1fxHWNCE7ytfp3eXa8NiX1PAGfW4XPrYxOFofGMSoca1+a8QjRXPT6Hmyp04Hul76YV9ZV4hcQ/Vl8MqXos6RLwDNxNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTa1S5u7; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d345250ee1so1637935e0c.1;
        Wed, 06 Mar 2024 02:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709720580; x=1710325380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru5KVpO0fYpM81R7FvwYOV4mwnZ5EV6GBubWlLtAQZw=;
        b=XTa1S5u7QBJ5zL6MMY9uNujsN2y7kLGjHiUdaUhHiKFHOdgeTQU0gJzW1A2X9wOnaR
         9rBaq6ewk13ARsgQ7O2S+EmdNR/AWbSlHxi51fyVBvT77tBB7kKKHWAiKC39tkzKTo2F
         SBVGvtC/aFuMmBXBPMSqgoZaWuLf0ZNd+sARshFARi1iTWC0kW5wMt1ZV0oUUZUgM+77
         L4jX3GzBZendjQNXTNGWuUTwORuMlURiIH/+5z++xSwYJdkJVWImSjpojMNKHVbm37QD
         OZHmoEWlOKvRm1uYKHB0indzv5rsx4kTUxySQio1PXU6vO0E3c0+CQWZBUh2uDrlYzL4
         r3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720580; x=1710325380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ru5KVpO0fYpM81R7FvwYOV4mwnZ5EV6GBubWlLtAQZw=;
        b=NPoY5DiCteWgWnec5wtHGiyOhWcasMTLKYxYmK4SWpLAQJW/R3DMLyCZY4cNfulK2R
         5wylK04BBgoEw7BZVBvVxakR2zqQfKRnwlKtiizTTZlBy/E9zCiRFope0Gs80n5Edb/o
         aGq8XWjdGTxLEbcfZotQqAi1es/O1YfcbkHJdVzFJ+k4Wcb0l1lH+ydbyJwQFrUpgIP6
         +ao3PLJgyUPA1YIrqzIWV1g856RHTvDRG3M2SkKDrFwEwDdISLa1bLvJd5gJ/XRzp3iA
         qky+8f+sQ3ZKeYJvcjhi9DNcjZcH75xJNs8wP0hXYUZmDoSDNMEP6F0fZIDeKuH1DjoP
         PBHw==
X-Forwarded-Encrypted: i=1; AJvYcCUfCP2ex1kSmwJ/afCCjFM/3QJXjLh26ghlLTK0IusAadopilEgI+KeErfqdurwRF2T/qAn2vAFieSSqyHrN5X8B1/F74vsr6Dmr1my/hStTdpyRgU+SY6dDzDqnUce1eam4d11whd9UhaB/96lDOEOON9fMrTMmL3ln8gIAY13xQS4psgnJCqpf1QcKvvCskDXfFmTUWRsavvdtNDMqVESHpAo5rm5TRyv
X-Gm-Message-State: AOJu0Yzdk6mZbyaP8HXxw0KAQboESLe1yMLkjMjPU7uLRBR89dXShX/J
	k+sjXB3NMwbFGFfixVyWu4q1Thc+qjVJvEPh2pS2TsgWxQ+5LHDyAfYLMGBBEWQKHrTWMEUlSlC
	9CJRaAo9qxGU1pgM2/dFnM3h1Dxs=
X-Google-Smtp-Source: AGHT+IHKRYv4UNbCa/SCrVYj+kwMhWRFRmoCtxjdFljqdm3C5fqbtwwuS2zlMBmPq5jAO/mmqLDYjK8504lqUBjqk/Q=
X-Received: by 2002:a05:6122:4b0b:b0:4d3:35ac:3553 with SMTP id
 fc11-20020a0561224b0b00b004d335ac3553mr4355214vkb.10.1709720580252; Wed, 06
 Mar 2024 02:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
 <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com> <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 6 Mar 2024 10:21:58 +0000
Message-ID: <CA+V-a8uq=gw0_EVT3_CZD0TO+-DnSqXJtFakFcNWHOfq58g4aA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Mar 6, 2024 at 10:15=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Mar 6, 2024 at 11:06=E2=80=AFAM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Mar 6, 2024 at 9:53=E2=80=AFAM Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> > > On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gm=
ail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document support for the Serial Communication Interface with FIFO (=
SCIF)
> > > > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interf=
ace in
> > > > the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> > > > (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) =
SoC has
> > > > three additional interrupts: one for Tx end/Rx ready and the other =
two for
> > > > Rx and Tx buffer full, which are edge-triggered.
> > > >
> > > > No driver changes are required as generic compatible string
> > > > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) So=
C.
> > >
> > > If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, you
> > > state that the current driver works fine (but perhaps suboptimal),
> > > without adding support for the extra 3 interrupts?
> > >
> > Yes the current driver works without using the extra interrupts on the
> > RZ/V2H. The extra interrupts on the RZ/V2H are just sort of duplicate
> > ie
> > - Transmit End/Data Ready interrupt , for which we we have two
> > seperate interrupts already
> > - Receive buffer full interrupt (EDGE trigger), for which we already
> > have a Level triggered interrupt
> > - Transmit buffer empty interrupt (EDGE trigger), for which we already
> > have a Level triggered interrupt
>
> Thanks for the confirmation!
>
> > Are you suggesting to not fallback on RZ/G2L and instead make RZ/V2H
> > an explicit one so that in future we handle these 3 extra interrupts?
>
> In light of the confirmation above, I am _not_ suggesting that.
>
Thanks for clarification.

> I just wanted a clarification: if the current driver would not operate
> properly without changes, the fallback would not have been appropriate.
> W.r.t. the extra interrupts, you can add support to the driver later,
> if/when a need or desire ever arises.
>
Agreed, thanks.

Cheers,
Prabhakar

