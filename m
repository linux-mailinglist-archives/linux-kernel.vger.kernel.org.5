Return-Path: <linux-kernel+bounces-51605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2152848D28
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E641C21183
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1662209A;
	Sun,  4 Feb 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/FJDf1S"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29B219F3;
	Sun,  4 Feb 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046321; cv=none; b=aaYAW3YNjePGzy26orFfVDyQVjVpEi1/tUOKn34LA+DDDVz4/WnS0uu0rxUlCBEBvn6c5tTfSjLPkZa7xtMr+QNVDRlmaFsJWN+VzVeVNPLXzw28NW1JQJ/Ao70De5eEQ7G8YUiZQmSQt3twF+QDr9r1h1y0/DnEXUoqNXfKpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046321; c=relaxed/simple;
	bh=OysxHNR/8MLJKJoi2a1JRId6KQOu7obGUqwfNQ5mXP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNxWFmVtudA9t9C6cr1tJJkhi/p5uqcLQnZx6Rz+9lPzM+2NCV1tgtbG+m/1525CF9+a19eXbnhmbXA+9JYO8xXE+QvJfMNNYNp4F8EapTqzzS0E/BgbLqNeemsBlSyuDHrLdX/2y44hwknF4+iL/zqGVh3bQpTCKZQ0V6vOwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/FJDf1S; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60410da20a2so33957957b3.1;
        Sun, 04 Feb 2024 03:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707046319; x=1707651119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QkyTj57SM8MQl+b85mT92R7QgyO+Dz+wOf6Kb6ozwQ=;
        b=I/FJDf1SGbodhq0DkXcdEkIDmuYItqAdThdwyCGOslg9TLenD6G19eU6fydKKMpAIX
         hdl/GeHOLM2t2LMxCwqh2WUWl6syuQq0Vr7Lv0WryhbPf5dUC2WgkKV1H/rbT94VvjCd
         ISU25U4IzwUwr4fjgf12p8cO28bSABtdNtjYrqy9B8khVX4DiFvtlwykOwyqAQaI3rE8
         yc9+g+R4F4/FGSCpQcMEIvRp9e3EfNHatgmVmun07THjD9VUsHZfdYzb0bRY+ID+55mp
         c43OSfp6MNDLxUV/B00ifYj8pzcGTteUADarnrHNarHjMvY1GwtGIaA+SMOZ6ob7mj/j
         MPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707046319; x=1707651119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QkyTj57SM8MQl+b85mT92R7QgyO+Dz+wOf6Kb6ozwQ=;
        b=krDq8h6bPPPqMHk2CbRiuPzvf02Y3XsWj91u4uGNrezLYdnlVpjCL/1k1cnh6KuAeZ
         2n1kJWmWanjtX64bKRIDuvwlai80hvlbjUsVy+IUWzx0gBR9aiBUSbPMqR9SIUR8keWW
         YUALSiCtE6815stWQaLrONqkikKsmB2QBtO80ov3rLcRAyF6k5QRpgp0LdaQTew6M3t8
         MUM9ec8kSStPp2DB89p3hAJL9G1sy7S2ZNJa+KQ/O3P3OMWUqSSoCP/MRIF8yqRg0rCd
         ClTMEfP40Vf2jY4XFqKHNA5zz0GuHhUXI2A9mdDkLG3FRoMUe8eN1UIVDg7QIwggSsM0
         grbg==
X-Gm-Message-State: AOJu0YypOboAADaBShe2WzmS98P/220ZhVEI5AVm8wxZYjXZkmPAhiXl
	ZYu2tfUrljjfXYuedaS6JO+ZpbBHsf98c0kXDb+yA99juwtzZq7YcN+fT8PTJcB6NTKP8IBkGcV
	aCJs1gjvWGPFiPw2VP39tDyfaY4uble9iGdELKHb+RxSHuQ==
X-Google-Smtp-Source: AGHT+IExAGT2STpMmSagXa312ySYM4FXedxHnwenSsbEcIAQwvxzb87TuWuoNliCrp97oW7+j/HHNWiZTlrSm5/23Co=
X-Received: by 2002:a81:4325:0:b0:5ff:a9bc:b7f with SMTP id
 q37-20020a814325000000b005ffa9bc0b7fmr12348406ywa.21.1707046319112; Sun, 04
 Feb 2024 03:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117114350.3105-1-maimon.sagi@gmail.com> <8a6c5297-6e86-4f0d-a85e-1a93b2215d68@linux.dev>
In-Reply-To: <8a6c5297-6e86-4f0d-a85e-1a93b2215d68@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 4 Feb 2024 13:31:48 +0200
Message-ID: <CAMuE1bFEbrY2PiDB6OdZGzDNijPAhoGBircTpqiyVs0Qq6bOig@mail.gmail.com>
Subject: Re: [PATCH v5] ptp: ocp: add Adva timecard support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vadim,
Sorry but I was on vacation for the last two weeks.
So What should I do now:
1) Do you want me to set my changes into the main linux git tree:
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    and use  use '[PATCH v6] ...' prefix
2) Or
    set my changes into the net-next git tree:
    git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
    and use  use '[PATCH net-next v6] ...' prefix

BR,
Sagi

On Wed, Jan 17, 2024 at 11:23=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 17/01/2024 11:43, Sagi Maimon wrote:
> > Adding support for the Adva timecard.
> > The card uses different drivers to provide access to the
> > firmware SPI flash (Altera based).
> > Other parts of the code are the same and could be reused.
> >
>
> Hi Sagi,
>
> Thanks for adjusting the code. One signle still have to be
> adjusted, see comments below. And this is treated as net-next
> material, but net-next is closed now until merge window ends,
> you will have to submit new version next week.
>
> Please, also use '[PATCH net-next v6] ...' prefix for it.
>
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> >   Changes since version 4:
> >   - alignment fix.
> >
>
> Please, preserve changes from all previous versions for next submissions.
>
> >   drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++++-=
-
> >   1 file changed, 293 insertions(+), 9 deletions(-)
> >
>
> [ ..skip.. ]
>
> > @@ -2603,7 +2819,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struc=
t ocp_resource *r)
> >       if (err)
> >               return err;
> >
> > -     return ptp_ocp_init_clock(bp);
> > +     return ptp_ocp_init_clock(bp, r->extra);
> > +}
> > +
> > +/* ADVA specific board initializers; last "resource" registered. */
> > +static int
> > +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> > +{
> > +     int err;
> > +     u32 version;
> > +
> > +     bp->flash_start =3D 0xA00000;
> > +     bp->eeprom_map =3D fb_eeprom_map;
> > +     bp->sma_op =3D &ocp_adva_sma_op;
> > +
> > +     version =3D ioread32(&bp->image->version);
> > +     /* if lower 16 bits are empty, this is the fw loader. */
> > +     if ((version & 0xffff) =3D=3D 0) {
> > +             version =3D version >> 16;
> > +             bp->fw_loader =3D true;
> > +     }
> > +     bp->fw_tag =3D 1;
>
> Please, use fw_tag =3D 3 here, other tags are for other vendors.
>
> Thanks,
> Vadim
>
> > +     bp->fw_version =3D version & 0xffff;
> > +     bp->fw_cap =3D OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> > +
> > +     ptp_ocp_tod_init(bp);
> > +     ptp_ocp_nmea_out_init(bp);
> > +     ptp_ocp_signal_init(bp);
> > +
>

