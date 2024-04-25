Return-Path: <linux-kernel+bounces-158455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B70068B2066
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB9C1C2275E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458812AAE5;
	Thu, 25 Apr 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3xRNVP/"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EBE86249;
	Thu, 25 Apr 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045070; cv=none; b=oDieSTBEgUp9g1Uc6rdDwIplJxFp68uFYLlyMTeZA5x9lp2IAXw3uamVCuyshagpgDDISpedIwOappMucl1oeBHfDzIvy7ZJsoh6yBEKZhSOYwoShmuvsNxpmx/rA4skM1Zxw9Rv3OoQM1tH5jmpGjcqFDzYcCt7TE497kHVBeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045070; c=relaxed/simple;
	bh=32c1Ug+ZtHLnXowIWJ/Q8UIpv0RKY8tJAG01+szUd/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2GeWja6yUsBRmbV5TlNnz0brEr8c7uocy6FyL3rNHFkkNfzUreZCWxJdi+RtOntjv5bf6bQ8mo7rc+DxNzoWNBBKiEqiIoqjh4a+Q9RdO2FNQNnQ7vnvdHf+hDE+dazGWDuRJQ9cFyY7bU//lTDz9ebECI4CTti+nEU/ANhmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3xRNVP/; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4daa91c0344so350944e0c.3;
        Thu, 25 Apr 2024 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714045068; x=1714649868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWXr5Wia3Z8TV2tiEQbqh2eOKm38jeE1M6pg57aIG9Y=;
        b=C3xRNVP/xVUi3gdPZaUrQnSi5bd2gC/90LHNtu2a9dv3aBBPT5TsfnYzxSFlbqLsi+
         Vmiglls2TMGnpcRcVDoVFCA2Ueqjyl8ehR5bgfgfKTo9aw6TVZ86Ewbo+FHDKI9RwiUf
         2pE6kAtgvL1t1LR+clkiykXc2I8Y4bmDrLcLl18cFMN3x7gVzWwsuQgGJY0lsyQdPWBB
         hH/4SJx67GqZoq/ozl31dKBkxSoV05VGHa3mbCg+E9lUk0ecM1eWMvDRy8hT2Cr3gVKs
         GwWWYOczTUpVBGZRTgAqdM1NvVv70lYNvFQHGmXZ9HhSP1gjKzbRFBNIZUOgZUb5Mo9W
         czrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714045068; x=1714649868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWXr5Wia3Z8TV2tiEQbqh2eOKm38jeE1M6pg57aIG9Y=;
        b=rKjSuDY2VUn0B2yWpxmHMluhgP7HragpA9QLDvbzPIjmBxOCbuUPR9iAJ6Y/5aGisT
         E5MULwDrg+SBYEsvTrHD42ySgxz/Ve6havSA5mgjGPQuNYdXkaR23kANW9MBqLHumTuj
         HX6TkzwgqEdtdfek6IpfbIp3XBQxc63pMC6wuHHFoVOZEhkI3chhT34x1Otv4ocjnsJW
         iRFzgKGxMMtJLFJpoX8NCDYxWC54+d3ENXc9bCblFVaN2MVuWJS+LUZ10Ipab4QI1LqJ
         KqqFM9ln4LepOE8wNn4Me/7neMjtEYsLMnSGuoleBiWFS/C/MqmIge/trkxU43F4oF6t
         MT8w==
X-Forwarded-Encrypted: i=1; AJvYcCWHfmopfWI/14bPCMbJ00xFlHE4RGi9kbFnshn27I4+tsL7EPP7/8SW6pZRQxi83CrH9QkJbgb6cd6pp4D9WZ/YOgcLFtKzCGdQHsn4ygHJYIiZMRU1H94J+6+Br6Hdv/cE6ok3QopD05Oq1NUzV7GIfrK8FpGwHDwg2krxLx4ifxzEpvakGF26wJl6
X-Gm-Message-State: AOJu0YyeHtKdbhmnA6G32+Wm9JXQ5ad0fAGAewcYhUgXQqkFAQZ3UXIm
	LadyA/4OQLnJMRIxV3CuMMuuuyodozqhMf+5iEXt5d1X1F+Mx9rS+itxTNjsQM9YiUI9+NoVQCA
	FgXyUBLKquZYp+hwrj9tPKgjYaTFRB54B
X-Google-Smtp-Source: AGHT+IGC0V6p9miFLGnPouqI4b05r2mYNKxuSITGIKjFEOdOjUuwlxU66rhg7qqF2u6FXkqaoi40mcGY57PrMZotNQw=
X-Received: by 2002:a05:6122:3c44:b0:4d3:43f8:8541 with SMTP id
 fv4-20020a0561223c4400b004d343f88541mr6563673vkb.1.1714045067835; Thu, 25 Apr
 2024 04:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240422205053.496095-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXx46TORh7fCNBwbddSLLGFmV_haQ1q+Y=n4GkzheDzaA@mail.gmail.com>
In-Reply-To: <CAMuHMdXx46TORh7fCNBwbddSLLGFmV_haQ1q+Y=n4GkzheDzaA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 25 Apr 2024 12:37:20 +0100
Message-ID: <CA+V-a8sJTp3EhHHM_26sNdZKVwmOGx35G3hDvb7y33L5+w4JEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Wed, Apr 24, 2024 at 3:59=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Apr 22, 2024 at 10:51=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The IX45 block on the RZ/Five SoC has additional mask registers
> > (NMSK/IMSK/TMSK) compared to the RZ/G2L (family) SoC.
> >
> > A new rzfive_irqc_chip irq_chip is introduced for RZ/Five, where functi=
on
> > pointers for irq_(un)mask and irq_(dis/en)able handle the (un)masking
> > of the interrupts. The irq_chip pointer is now passed as an init callba=
ck
> > and stored in the priv pointer to differentiate between RZ/G2L and RZ/F=
ive.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3
> > - Added RZ/Five specific irqchip instead of polluting the functions
> > - Fixed review comments pointed by Biju and Geert
> > - Updated commit message
> > - moved locking respective read/write functions
>
> Thanks for the update!
>
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -138,6 +142,113 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
> >         irq_chip_eoi_parent(d);
> >  }
> >
> > +static void rzfive_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *pri=
v,
> > +                                          unsigned int hwirq)
> > +{
> > +       u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > +
> > +       raw_spin_lock(&priv->lock);
>
> I think you best move the locking to the callers that really need it...
>
Ok, will do.

> > +       writel_relaxed(readl_relaxed(priv->base + IMSK) | bit, priv->ba=
se + IMSK);
> > +       raw_spin_unlock(&priv->lock);
> > +}
>
> > +static void rzfive_tint_irq_endisable(struct irq_data *d, bool enable)
> > +{
> > +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +       unsigned int hwirq =3D irqd_to_hwirq(d);
> > +
> > +       if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ) {
> > +               u32 offset =3D hwirq - IRQC_TINT_START;
> > +               u32 tssr_offset =3D TSSR_OFFSET(offset);
> > +               u8 tssr_index =3D TSSR_INDEX(offset);
> > +               u32 reg;
> > +
> > +               if (enable)
> > +                       rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
> > +               else
> > +                       rzfive_irqc_mask_tint_interrupt(priv, hwirq);
>
> ... else you will do a lock/unlock here, followed by another one below.
>
and move the above code into the lock below.

Cheers,
Prabhakar

