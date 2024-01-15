Return-Path: <linux-kernel+bounces-25633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D482D3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E94928160B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22023DE;
	Mon, 15 Jan 2024 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f/Kbd3oe"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B38823B7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so5918193a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 21:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705295763; x=1705900563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAEFnzZTDTcgl+D5J1rqXUA5mEA/aJB9HaXWVU5heIE=;
        b=f/Kbd3oekVQmacZH1zuq/O1Cppcl/AOkhv4pXpQ2sehf80tJep7ZwmVcjkCly9CfA6
         Hveg66xVY9DRlB3djxCggOG7GaPlBT3PV1WO4Renh+zu3oQwFcO6OQzgyt7Gs5KDGu0l
         pf+V7y/06NGln7LlHnR1GjfseLP7DRBHc/2C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705295763; x=1705900563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAEFnzZTDTcgl+D5J1rqXUA5mEA/aJB9HaXWVU5heIE=;
        b=dUJmkA3PJX7t03r6Z+VnzJLrRoM2Z9v6gINwxXaJM6pFS1gPlt4QmilBpmy2iFOJ64
         l0IxM8w4KhclB1kINCvnXqENon7S42zMsLri4OKiq1QSezEZpxA+uTwi67iXaOniH0TN
         ImFTlFrbgVvpgf5QsSlE7VjI0qwSoj2UTctxLEaYLZYcihhwejLr+GMK2tL/v/qi64hK
         5QT7QJLXbY+mTs59HuOTPD7rdpPfxR7ANWd848RHyPNZFqZwafXv9dJX6yaRWLaUyGtT
         Da4vYPhUMriHUUo8ZPLzf8Mxnipgys4wpv91QlCACda4T66IooSewu+EbOcmrhAePzcR
         Y5pA==
X-Gm-Message-State: AOJu0YxveNCp67ZszKk98VslqhgT+KaIhtEdmz1QuqCSbV1wayKVdjvs
	nXg20sfrsg2TtX2t41iOKE+p0QDQxu/UBB46Wy2YnW7R3/nx
X-Google-Smtp-Source: AGHT+IEdDN1qU+r32AgupnyNFvJCtSIGqkzL4y2FWLrfJXlcoMuBkZlYuBwBh0CkHUG34am4DrqbSQ==
X-Received: by 2002:aa7:c2da:0:b0:555:936e:feb6 with SMTP id m26-20020aa7c2da000000b00555936efeb6mr2262701edp.22.1705295762831;
        Sun, 14 Jan 2024 21:16:02 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7d60c000000b0055732bd1fc0sm4981889edr.82.2024.01.14.21.16.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 21:16:02 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso7959165e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 21:16:02 -0800 (PST)
X-Received: by 2002:a1c:7c1a:0:b0:40e:61c7:ce89 with SMTP id
 x26-20020a1c7c1a000000b0040e61c7ce89mr2530807wmc.59.1705295761536; Sun, 14
 Jan 2024 21:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228070941.3611649-1-tfiga@chromium.org> <CAK7LNASbgXSZNiwhMf8jm7511eyDm8oCqY=MzWhgWwNuVLk5Vw@mail.gmail.com>
 <CAAFQd5CRtgMUN8xZ_4BOv04KzCvXtrKHhWGQhhqgENyMCVWbKw@mail.gmail.com> <CAK7LNAS29-KZvuHE=WE7ravvqh4e-M5Da=MZ2vh_EM7_Jo_jbw@mail.gmail.com>
In-Reply-To: <CAK7LNAS29-KZvuHE=WE7ravvqh4e-M5Da=MZ2vh_EM7_Jo_jbw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 15 Jan 2024 14:15:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DfS_2XqTpb2USOMUFN+CV_ieEYiaEKZLtyidDR29SMJA@mail.gmail.com>
Message-ID: <CAAFQd5DfS_2XqTpb2USOMUFN+CV_ieEYiaEKZLtyidDR29SMJA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add a build target for checking current config
 for issues
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 7:51=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Jan 10, 2024 at 10:15=E2=80=AFPM Tomasz Figa <tfiga@chromium.org>=
 wrote:
> >
> > On Fri, Dec 29, 2023 at 1:11=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Thu, Dec 28, 2023 at 4:09=E2=80=AFPM Tomasz Figa <tfiga@chromium.o=
rg> wrote:
> > > >
> > > > The new target is called 'checkconfig' and currently is basically a=
n
> > > > alias for `listnewconfig` with KCONFIG_WARN_UNKNOWN_SYMBOLS set to =
true.
> > > > It can be used to validate if the current config is directly compat=
ible
> > > > with the current kernel version or needs some manual adjustment.
> > > >
> > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > >
> > >
> > > I rejected a new target in the past.
> > >
> > > https://lore.kernel.org/all/20230817012007.131868-1-senozhatsky@chrom=
ium.org/T/#m55c37e3091158f8cb008d9e0b5c6bf3f5ead225a
> > >
> >
> > That was specifically for the unrecognized symbols warning. What I'm
> > proposing is a universal target that would include any possible
> > diagnostics.
> >
> > >
> > >
> > > Instead, you can run
> > >
> > >   KCONFIG_WARN_UNKNOWN_SYMBOLS=3D1 make listnewconfig
> > >
> > > or
> > >
> > >   make W=3Dc listnewconfig
> > >
> > >
> >
> > I can do so, because my team member implemented it and told me and
> > other team members about it. But how would someone who hasn't heard
> > about it be aware of the existence of this useful feature?
>
>
> People are not aware of your 'checkconfig' until
> they run 'make help'.
>
> The same for W=3Dc.
>
> 'make help' explains it.
>
>
>        c: extra checks in the configuration stage (Kconfig)

Okay, that wasn't something present in Linux 6.7-rc7 that I used as my
base. I checked out the current linux-next and it's indeed there,
which I guess resolves the original problem somewhat. I still don't
think it would be very clear from the description for a new user,
especially given that it's far below the config-related targets, but
at least it's there. Thanks for adding it.

Best regards,
Tomasz

