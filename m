Return-Path: <linux-kernel+bounces-97951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4274787723B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFE8281985
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3345BE0;
	Sat,  9 Mar 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X64LriDP"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A44439F;
	Sat,  9 Mar 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001717; cv=none; b=X2L0AjpnBXI9sBEXqKrbCcVudoTapeKOn7TYAW7omW6DCnXW6O5vLVEixhBsoWswYMJPcAx1maWtZ+pvuWb3SsIWCoTG8v8apOmKlJvb9elJEE+gr9Jg6SiWIq+7q+LaxepJBfRu6euDmnDEHqvWoE5EvlDJRHYCLzjSPEEJRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001717; c=relaxed/simple;
	bh=smky8eK+mpaxLg9vvUAeDfkDihmOy7wpuSWlE1kx4L0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSvx44S2HORqZIc7PI3U2A8C3YckS+ZPf55C8ZsGb2MWLCksGGvAJf3sJnmFa4cnVJppvg9eG5liVtZoBr4DqP6dIbhjhoeA5aBW3UEJzX+3mPGcrErKFA/TMnh6Ehz9oVItq91Vddsp4zgLQj2YFfiZLUaa1uMwRWXRX4AgZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X64LriDP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5682e8f21a7so2221708a12.3;
        Sat, 09 Mar 2024 08:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710001713; x=1710606513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR3Q9ZDfuXFwx5nhQ21SINlsMoWawyf7bpuFRxJi820=;
        b=X64LriDP2T92GenP4UjbEJb8qKnhCdc7sd3Xr9XRWW1/W8YkVhhpizhig6MtjSF1KU
         acggKX10QGKfWfRVuC0/85wMPDNGiYvSeFCRoOiZhO7m5LKZYkujhT+lJPkBDjGs8AiU
         JbsuBi3bQ9zirOIYm394PF8GKui6Dy9GQTgJWIgsSto0COpmmvmUK3qxIDhg3vWxQhIV
         TOWYkgRaNtHhwxnwJ1miA236Y0x+3vzkSMxbJOLj9qqA3WZfO0pat+5PJquOwMS1gsy0
         nW1yeBix22Frtije89F8FDk3vz05ELoOA1d7eTrNSa6yNYpGEw3WojybGINCN2ukp7NZ
         dOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710001713; x=1710606513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xR3Q9ZDfuXFwx5nhQ21SINlsMoWawyf7bpuFRxJi820=;
        b=ISoVEo5PfMppiu25NbE/OIVsTiasUJx8lLL72NC6VOxM0vSyY49Ibyh3DzjKi1Mr9/
         VJ3MiysJCjMLeeJTrRChSRKeSPwxSVhm2QAAgPZHEKnYw9Cnd8ykOzM68bxv8TA9IZ0Q
         APXZm/PWazbJMXkmo1s+dji/GUf2JTi18dCcz0Zv+6huUQ8EofVBiM/tUz/AYCdz97nE
         6UzjIeSEYw82Bl7kOyd/JQXaaD26I2T3SoclIqXnTXo/2K0w6GnvPlM6dgblO9sI0IpG
         kUtS8SvBlQdLX42vdLsnIw5khi+GVfSnZU9QFFSQo6e8EXrOJP6/72fb2o3DtTYtvI3O
         3qkg==
X-Forwarded-Encrypted: i=1; AJvYcCX3MLbc0uCgqpbhuFFIXCvc5QY98kn4IuyrNLba+YGtYL3jhcQKfa0rx2YqDc+EHpM/guAcFl0NkkG6r476g4ynmTFP8gZf3ZQS2I2l
X-Gm-Message-State: AOJu0YyYdVC4LrnuA+qlqKsHC4Noim/oOZqJ8ngIelCtA06ygC7/MJRV
	KMg69tf7zewqoIgq5F0Uw/mCt0sZu3JmTQo3F+k44g8tfiEtrDEsFdC8ie5ynfB4L9NiDCsnv57
	EaqUqsApeqYqP/NulcKdsjuol+Bs=
X-Google-Smtp-Source: AGHT+IGJ8T+BlICUm6CpJVvufFFc6uZ8GgNGRjAhkFuXuOejmdQutDzao0gjZRvUB19ikZ8PhKPMaR2a6RBpH3w/A5I=
X-Received: by 2002:a17:906:b110:b0:a45:c9fb:86d7 with SMTP id
 u16-20020a170906b11000b00a45c9fb86d7mr1203104ejy.54.1710001713236; Sat, 09
 Mar 2024 08:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303121410.240761-1-andy.shevchenko@gmail.com> <63c898e4-fedf-44eb-8887-ffda4a81e1e6@wanadoo.fr>
In-Reply-To: <63c898e4-fedf-44eb-8887-ffda4a81e1e6@wanadoo.fr>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Mar 2024 18:27:56 +0200
Message-ID: <CAHp75VfDNrDcLbBwHpn52qFEH=wFdnG1sx2jrU25oYJQ6OHGHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: fractional-divider: Move mask calculations
 out of lock
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 9:19=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 03/03/2024 =C3=A0 13:14, Andy Shevchenko a =C3=A9crit :

..

> > @@ -195,14 +195,14 @@ static int clk_fd_set_rate(struct clk_hw *hw, uns=
igned long rate,
> >               n--;
> >       }
> >
> > +     mmask =3D GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> > +     nmask =3D GENMASK(fd->nwidth - 1, 0) << fd->nshift;

> if this is a hot path, you could maybe even compute:

It's not. set_rate() may be called only on disabled (and unprepared?)
clocks, which makes it already a too slow operation.

>     mask =3D ~(GENMASK(fd->mwidth - 1, 0) << fd->mshift |
>              GENMASK(fd->nwidth - 1, 0) << fd->nshift)
>
> unless gcc is smart enough to do it by itself.
>
> >       if (fd->lock)
> >               spin_lock_irqsave(fd->lock, flags);
> >       else
> >               __acquire(fd->lock);
> >
> > -     mmask =3D GENMASK(fd->mwidth - 1, 0) << fd->mshift;
> > -     nmask =3D GENMASK(fd->nwidth - 1, 0) << fd->nshift;
> > -
> >       val =3D clk_fd_readl(fd);
> >       val &=3D ~(mmask | nmask);
>
>     val &=3D mask;
>
> >       val |=3D (m << fd->mshift) | (n << fd->nshift);
>
> and pre-compute "(m << fd->mshift) | (n << fd->nshift)" outside of the
> lock too.

All of these sound to me as premature optimisations. I only wanted to
get back to the status quo.

--=20
With Best Regards,
Andy Shevchenko

