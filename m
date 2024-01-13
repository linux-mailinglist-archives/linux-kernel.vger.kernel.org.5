Return-Path: <linux-kernel+bounces-25271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446EA82CC77
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C4628423D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F720DF6;
	Sat, 13 Jan 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkhuXsbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2B20DEA;
	Sat, 13 Jan 2024 11:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD20C433F1;
	Sat, 13 Jan 2024 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705144982;
	bh=aWbp+sEf+jIAbTFLPFuB/3Cx5+Za97c58mRFpcxYGJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gkhuXsbjaKE7PSoY2E4Q9y+qX+HHGHULpuCwR2/TinkMp5adGUMEnR0Xy+zogBmUR
	 2636q+k0hAjEhu8/jEr/AcODCOfEbmIKZO6oukRq/zT8ez9yUR9E19+rIk579l8B4o
	 gfu2et5OVbkTQqLFxcimEVwzOk3FSVh9Aa7GkzhrWvWmzP4P+cYbk2LL4DZQMOcMTB
	 /u7F/30f6cbWrTw5tSR67bZw96BfggfEhcCfVBkwIXdEIEn9veCK/Somddk4qEh2iG
	 cRb0jYb2ZuW8RitV8mrGt92DYGwO3c9uTMFyCfC2oUuKX+vLgwBszN9uBoV4udO/CC
	 Q/BmTPOui02Bg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5989e17b01fso1914738eaf.1;
        Sat, 13 Jan 2024 03:23:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwqXqC1ammfHP0bZanm9xUyku15HWXFz8YaPP4WspHu2c6+kl3e
	rj68V4pYAP21M7f0mjaAFS9IZ7im3TSJWx4eQ6s=
X-Google-Smtp-Source: AGHT+IExm2onaWEcRV1yyPLaI3C+6VllCEvk/CLeQioCLoz2xERGv+yJLzCKN2FmzVHpOOZKxjhJmHY2XiO7re0emlk=
X-Received: by 2002:a05:6870:3920:b0:204:1a34:9f12 with SMTP id
 b32-20020a056870392000b002041a349f12mr3276040oap.89.1705144982182; Sat, 13
 Jan 2024 03:23:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228054630.3595093-1-tfiga@chromium.org> <CAK7LNATBipJtprjvvRVYg8JcYOFXQdpLEyEc+4+8j1PtBQ+PUg@mail.gmail.com>
 <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
In-Reply-To: <CAAFQd5C3vAUJhKiQ1LPkZv3dJxNvK4QinRezV9Q8rz_Ov6FSUQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 13 Jan 2024 20:22:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com>
Message-ID: <CAK7LNAQcaDneE4rnjvV+GTSBBMozm5deu_q9+STTn60ervZJbA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: menuconfig: Make hidden options show as dim
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:05=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> w=
rote:
>
> On Fri, Dec 29, 2023 at 1:10=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Thu, Dec 28, 2023 at 2:46=E2=80=AFPM Tomasz Figa <tfiga@chromium.org=
> wrote:
> > >
> > > When hidden options are toggled on (using 'z'), the number of options
> > > on the screen can be overwhelming and may make it hard to distinguish
> > > between available and hidden ones. Make them easier to distinguish by
> > > displaying the hidden one as dim (using the A_DIM curses attribute).
> > >
> > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> >
> >
> >
> > Do you think this is useful?
> >
> > This changes the color only when you select a hidden item.
> >
> >
> > For unselected items, you cannot distinguish hidden ones,
> > as A_DIM has no effect to black text.
> >
> >
>
> Hmm, are you sure about that? For me it seems to dim the text. it
> seems to be also used in the existing code for dlg.button_inactive.atr
> of the mono theme:
>
> https://elixir.bootlin.com/linux/latest/source/scripts/kconfig/lxdialog/u=
til.c#L26



Then, your code works only on the mono theme.
(when your terminal does not support color, or
"MENUCONFIG_COLOR=3Dmono make menuconfig")



In the normal color mode, the foreground text is black.
(Just like a picture in https://en.wikipedia.org/wiki/Menuconfig)
A_DIM does nothing for black.



--=20
Best Regards
Masahiro Yamada

