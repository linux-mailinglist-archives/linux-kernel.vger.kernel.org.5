Return-Path: <linux-kernel+bounces-91909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A8871841
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B295D1F21A42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115AD249F3;
	Tue,  5 Mar 2024 08:32:21 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76B1EF1D;
	Tue,  5 Mar 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627540; cv=none; b=thuTgD23AtRJ4CvR3tvP3POPk3fRcwx3P/0Szg0IW9RKVyyEwaRR1IcmYTBSv+f/Ouz/U/i+AFBZcdsq03iko/dz1OQ/jew8pSBFlCAVQRRFk+v6joBPTcSHy79dmMb3axyDG9oRlISLHraD602F0TNNDkq1QvMAdDGbBuIy6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627540; c=relaxed/simple;
	bh=JJ/Fi0mAc5MEE2xV0+0fv9UmRbISpTURliEIV4UlhdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqPsNbpEZSeMbkRFXuZY0fuOkOGcycJ1+K3nKIuKmzD8e4VYiQl9WrDd9j5N9p+WDqIbq5/d/JHKhpH0uiicGYGNNNpThj5ZaLEoSXkMyGGogrpRb/XO82vn/C0tSqEtyveQEnIj1/1UxX60HT8Y+IE6Z6KTy7FPGfe6g1ZLKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6096ab005c0so49767927b3.1;
        Tue, 05 Mar 2024 00:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627536; x=1710232336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNx9pLfkP2GkyFmboFzOkAHH6cJF9piyh2NJ3vaihUw=;
        b=RjC3Q0SNHGI6RY3RqBdN+yphPqziFzpV2F0wSA9WGv20TC4lYSiJVCorKKTsDDRuQx
         Uw8mLPcej/cl5qTECeP4ZMNOvSzVFhtYqRtSgRncBGDD8M5dnT1mJiLkTUHwKcm8/4x9
         nF4JolL6qXHNHUCvpMOe6+ucqJjRJKiT3hL2+RmHf5mtv9FO1/x2L3wgk1FInvA2KTKB
         91FwEuSjqvO6KgqROENuDrlPnTiYGMCBEG/2PBkRpUWm2Mza4SxSnuDkgnDCEgh6jfZS
         8LeJP+lcTOXJNZ/95lJELs8X7suEvstNgq/80hhcTeJFgyuK2vAUrb63Ghq8EfK5CFsR
         MG0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJmqk1izOYERVRZpvVLm7nHPR0KtkIbjqlpZKZl+eDbceT6Jpb4reTglcYPeXXpAlhZTZXzwqzhguoxHC2/Lsxi8b5HLDYP2hiFhfVTmJmyNnk1GP0rg0rfAVf+PvxIUw59vN+LD2CTQ==
X-Gm-Message-State: AOJu0Yzsr9WmvC92frtqRLKOjmu9TarJWB9ouX3kgkDhbpsA1ppa4RdP
	siu3M8qxODhC/xtmu9H71txl8RkuqogfDjdOushWrtB1M44m3vfrpiopssM67qg=
X-Google-Smtp-Source: AGHT+IHMJ4hEpcVZUEVs0Gwg+oZhbJr1uOY0V0fbH+OIq/3ibM3F7XrkAlBAdkjGH2K+Pzz0EgTm5g==
X-Received: by 2002:a81:4ac5:0:b0:609:6705:f7bc with SMTP id x188-20020a814ac5000000b006096705f7bcmr11343000ywa.28.1709627536579;
        Tue, 05 Mar 2024 00:32:16 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id r7-20020a814407000000b00609498508acsm3064850ywa.42.2024.03.05.00.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:32:16 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098a20ab22so32216557b3.2;
        Tue, 05 Mar 2024 00:32:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNWBLvhIvd84WTmjpwy/u3gnWFxFsYJSFGlcPb2apfe3VuwLHl0R8m4Q85zf+Vf0//gdn1aXH77/LS2C8jJ76l3zD2oEnpsBqMHh1PJFuq0KthGD/BK8f6MK0yPp4engPujHz4ZWj8Lw==
X-Received: by 2002:a25:824a:0:b0:dcc:dbb8:ba73 with SMTP id
 d10-20020a25824a000000b00dccdbb8ba73mr9230998ybn.9.1709627535542; Tue, 05 Mar
 2024 00:32:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303104853.31511-1-brgl@bgdev.pl>
In-Reply-To: <20240303104853.31511-1-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 09:32:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
Message-ID: <CAMuHMdXWdKZjjZc39iXfa6Nohtn+Xm9YvcF+YoRpNzCgeWD8tA@mail.gmail.com>
Subject: Re: [PATCH] of: make for_each_property_of_node() available to to !OF
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Sun, Mar 3, 2024 at 11:49=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> for_each_property_of_node() is a macro and so doesn't have a stub inline
> function for !OF. Move it out of the relevant #ifdef to make it available
> to all users.

Thanks for your patch, which is now commit ad8ee969d7e34dd3 ("of: make
for_each_property_of_node() available to to !OF") in dt-rh/for-next

> Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")

How is this related?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> I have an upcoming driver that will use this but which can also be built
> on non-DT systems. I'd like to get that in as a fix to avoid inter-tree
> dependencies later.

Do you have a link?

> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -362,9 +362,6 @@ extern struct device_node *of_get_cpu_state_node(stru=
ct device_node *cpu_node,
>                                                  int index);
>  extern u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread=
);
>
> -#define for_each_property_of_node(dn, pp) \
> -       for (pp =3D dn->properties; pp !=3D NULL; pp =3D pp->next)
> -
>  extern int of_n_addr_cells(struct device_node *np);
>  extern int of_n_size_cells(struct device_node *np);
>  extern const struct of_device_id *of_match_node(
> @@ -892,6 +889,9 @@ static inline int of_prop_val_eq(struct property *p1,=
 struct property *p2)
>                !memcmp(p1->value, p2->value, (size_t)p1->length);
>  }
>
> +#define for_each_property_of_node(dn, pp) \
> +       for (pp =3D dn->properties; pp !=3D NULL; pp =3D pp->next)

Is this safe if !OF? Can dn be NULL?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

