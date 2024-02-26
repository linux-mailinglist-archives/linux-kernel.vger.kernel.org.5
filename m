Return-Path: <linux-kernel+bounces-81857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2259E867B07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB031F2CA16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2912C554;
	Mon, 26 Feb 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiXu/agE"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFA12BF0A;
	Mon, 26 Feb 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963311; cv=none; b=BRWf9ZFE5YFWDm93WpETer3lV9MKnkVZdLcQu+2SxTCZrWxMX5qJmeCag9Sf62UZdVHGxZm9o1xQZd2S2dp9eiG4G7XiPQdQKwovvGDqy4W22Up1uHeuxNnspL1QwChbPapRYzdgST3IL4P9+C3jV0ZcmmUO3DRS4nZOnzfRYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963311; c=relaxed/simple;
	bh=YPgDeRMRVLtnHfl04hdaDS9KGjCh+SsqQcfmaX4GLmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0DKbtWRizz2MS1yMId66Ms/osRMHtnteaYo81/0+MZEEZtt3Ab/+uv96w5faUVupryjDKRebXwh/Vbb4lnFfU2HEf1vX/d42eMuRXwdetBI6D24ZKdkuK6kIoTC6275IWNj7x36dVs0PvQWb/CuukdkJMfU8ZAXJDwDDk6WN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiXu/agE; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4cb26623d8dso573928e0c.1;
        Mon, 26 Feb 2024 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708963309; x=1709568109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr6er5yzK+VgY/KBbDAv+oUau3v0fquMnz84YiSHUuk=;
        b=ZiXu/agEaD7a+BSStD/oMQx0NiPC1/pSsz1VMfwOYZn/7Oe/Yn34t6BU3SA14UQpn7
         lmbLIvDZadC67rEZSPVEjV+Gy1hf5c83ovdAmZuG5FxWatM1/6104fdgs7K378gRvJaG
         I6k7SoUpR9WAnyOA9i9PuqPX2zocTWnVT1dWuc1cJSYZQhHTxAA2Ljt+Ao+yHRx9SzWQ
         FTzVEChAP23MnwPNkC0uIgXZz3RDH0xdlfncj7JhII1YiO/2kTLQZjc/mj0qi4gLy+xz
         6BfHvCLeIpWN+SNXrUKG+R75XQt0FcYCh7WK6sf4DD3NDMJWlGk/cRSYbvr9dS4V4hUL
         owkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963309; x=1709568109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr6er5yzK+VgY/KBbDAv+oUau3v0fquMnz84YiSHUuk=;
        b=W9GY9iWqGd0jNl8uDAElD3HeL58AoudamjCgJh6fTBbJerAnRTPWjZ94+yYCyZDWo/
         tua9EsMgXaDYcrUn8Dl1fg3XbdkyPIYbHepev29R55s60OoZbaQeJN0fq1M6SdCDxoQ2
         pxmGxqAqjT6N8ApBkLk0NHJWs5zCG0L4SA7EkMhuvhF2V86SsqCKVDXhq22UlhUU4wSu
         tdHXFDvWBb3bDxhwNKMFoqzdJf+IfXCt3oRz/ORX2Uq8bozNbggeLMmZwJZE17JLg2Aj
         vgbHLFPP+LgaXnXlDjG+Xjxj7bBwvhhQCJ5JPm8xfOffpNUeXeDkdfL4JLY4hZOxrizj
         /23w==
X-Forwarded-Encrypted: i=1; AJvYcCVSMbFEaLjwe8jrZXBJXTQbQ9FEWuD2jLhAYv0Lig4oAMCCeN9pVi2pfE4p5Ubef65Mr3Ft0Bd5Vifrkr3jrT6s7RnILNs0TN3oUle1kD2dcjRXlMeGqWltGBmQPyqw4zeTOO+lqvoxIF8jrjgMXnGNK1el9XG+v+LyOfzQ/TJ73lNQBwBy7ZjbzbJf
X-Gm-Message-State: AOJu0YzRs3o47w2pRHSvpg2H7jFd7wTAOuwD2pzdz6UheKovrXpsaYOQ
	EuuTH1LDDUtA/xuTa721VJML1dYaiU0+5zwS3jeTMVfH0SGD2s+p1KxumqoC+OX21yRgy4S5tDR
	cWbZQW9hYKGL9qYGAl7xVtEHOhgk=
X-Google-Smtp-Source: AGHT+IGsv4knkXxBVsnhcjIYxDKPlgPUfu1PPn87PUSjQhpSoWYOr16Fc+xOKTUaHGroCvn3RtQLBkqKyu+fia8fDnE=
X-Received: by 2002:a1f:c642:0:b0:4cb:2662:3651 with SMTP id
 w63-20020a1fc642000000b004cb26623651mr3650234vkf.6.1708963303632; Mon, 26 Feb
 2024 08:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV3eVTek9sYwXbqu98ta8wx197GMc-k3q1RZRb8ar=jFg@mail.gmail.com>
 <CA+V-a8uNaRL7wE0SmwmiCq3o798-2Kd-fegKJ2Tep5mZuS2O2w@mail.gmail.com> <CAMuHMdWwn2nVx=vebT+Egas+b_dt7d28eN_ykrA+ckZ2GPuXHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWwn2nVx=vebT+Egas+b_dt7d28eN_ykrA+ckZ2GPuXHQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 26 Feb 2024 16:00:53 +0000
Message-ID: <CA+V-a8stTXWue+oCLpCooL5WxXJofovjtxkEcEk_SB0_RZdz0w@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H{P}
 System Controller
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Feb 26, 2024 at 3:15=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Feb 26, 2024 at 3:01=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Feb 26, 2024 at 1:41=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@g=
mail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g0=
57-sys.yaml
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Clock from external oscillator
> > >
> > > Isn't this SYS_0_PCLK inside the CPG?
> > >
> > As per the block diagram (figure 4.4-3), if we follow the clock source
> > for SYS it traces back to 24MHz Oscillator. Let me know how you want
> > me to describe this please.
>
> Yes, that is the diagram I was looking at.
> MAIN OSC 24 MHz -> MAINCLK -> SYS_0_PCLK.
>
> MAIN OSC 24 MHz is a clock input to the CPG.
> MAINCLK is a CPG internal core clock.
> SYS_0_PCLK is a CPG clock output, serving as the SYS module clock.
>
Agreed.

> I think the standard "maxItems: 1" would be fine, and no description
> is needed.
>
OK, makes sense.

> > > > +
> > > > +  resets:
> > > > +    items:
> > > > +      - description: SYS_0_PRESETN reset signal
>
> Same here.
>
Ok.

Cheers,
Prabhakar

