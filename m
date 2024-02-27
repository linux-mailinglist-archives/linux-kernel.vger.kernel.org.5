Return-Path: <linux-kernel+bounces-83482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB7869A11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BA4285748
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CE61420C9;
	Tue, 27 Feb 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbA7JDtq"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D231A66;
	Tue, 27 Feb 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046922; cv=none; b=h9R5qtrn8jucvOZ/+bPNToItvrXos1120iA9y5VeKL8tb9ZIyGYsED8lorNmbHkrs32mYbYEOi2Qkq6wICvfszEoMcSNOJzqLHrQL6MtDB85tHwH83Iw/fUdK6CMAkQxy4znvcnz6OSqzl+3c0ARgL63ih50luInd4zGoCtXycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046922; c=relaxed/simple;
	bh=nTpTux08+pm9Ctei9x7DzzD8A1zBDKvgVXhNbZ0Su9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGu4FNZzytjtHV4RaZHUFUQwRZZi/+eW065a9C1OO/ACdWdSe5WkcHKI32aCLp7/bV0fsNaiIoNcDahB6Q2McJELFT6lxC3VQLnw0KWZKCAfNL8QknrgGdE8eK2NIhFCMgdskpGcd/fqDHelW1qIoCjHQP5jSScYOMQX89rKHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbA7JDtq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce942efda5so3471284a12.2;
        Tue, 27 Feb 2024 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046920; x=1709651720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KotY222o/b+zG4JFnMehrQPIDESD06t7QB65RoOyrY=;
        b=NbA7JDtqFGK0m5v0yuURR/44SwHCxmfETOjWYIkGEWO47b34wMx1qFjCGWLMfk80Zv
         VV6n62awBKskCa86Jfnzy9d5XbH+jV72Pdw7gs+SN5Hn9xvKyb39VHtUQMcYqHYMOBq+
         k4d/VWffzucIT2bNjZBkTzBFPi7POb7FU+kTPWQpalSp7nmqWMbLSkuFsKOizYD+uOWQ
         a67IoriPZj1HoRkrbVBNexd9rgnKo5NbKc/OevCWZEPwUxvUExUAnM20Rgzt42awxtvS
         ZXrTTVnTalLEDqRM7aJbPL4I8nHC/cGaPUHwNtYsE+Mf7b3MhbWnZa8JaOfpZZiYjHXp
         mC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046920; x=1709651720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KotY222o/b+zG4JFnMehrQPIDESD06t7QB65RoOyrY=;
        b=grRSScRPQPR6qFU9c3wqpJeTN1kseDzRUujua9FR7haay3kaAIsP4e4+aao+2IhgpJ
         Wzv2eCOIxXTHTWpco7zQllrqb+Kwv9cmGTNNljOch4J0GSlIt9PoeQRPcuV8ShhabQWg
         5WmCpcIrAhiz97Oi0/xQxSSHipjQNFTSrIht/0sdZl0u1A7xl54uW2uiW5vl3VxYvWpZ
         JWSzTkbkwR6jNclgRdKpTyogwMwIkrffDvyaLs3+kfJd2rqq7qOGGBM7Z47TbvnBNgcs
         Xa63OCf/ks9EQ2V/JP/d7morbETDI3EWqIlrOZu3tj2ivKGH8LaejG5bQz8bVBtA3QqL
         F1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3/TG5lhAWB1fLcOJPDjnqOeEJDqFd4MGZjzsUSyfAp4V+EA8GbZ8latopjH0ftS2j1ar2+78uBgCPtPhnQynZMjDwo7JOTd3bVdLu46vpc02YiC75thlfuqVrgpvAAsJOaxR7wZl5eh/MqyUh+h+1BY6iyRyu04kBjS/S2t55Kt+BV035fQZVpGH3
X-Gm-Message-State: AOJu0YzS8k6LkQiqDRsaZzIXjmtRrURZ21eVRO+JbZyFqCTp8pYddxu1
	P0rTDwPq+CQH9xu22Xj649YeloniYUktNIoRMgvFpRQ2m/Oa40CnSdLrOvDAZL7hDW0Bokg72+j
	VklmHarKaeJQE4DCHNONzdCXx5IU=
X-Google-Smtp-Source: AGHT+IFg140Xg2hJz4kVw5bMZewe8s6YfvknB2EKDdvjRIwTASEpsh/NjQy08I9J/xD8cQEN3HS8ShDPQkI9AnWiGGA=
X-Received: by 2002:a17:90a:9317:b0:299:3c25:4248 with SMTP id
 p23-20020a17090a931700b002993c254248mr8646073pjo.38.1709046919772; Tue, 27
 Feb 2024 07:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-5-aford173@gmail.com>
 <CAMuHMdWNQ=_NHPybAhhLJJCytT4y583ROY-meuLyKPN8_Qa1HA@mail.gmail.com>
In-Reply-To: <CAMuHMdWNQ=_NHPybAhhLJJCytT4y583ROY-meuLyKPN8_Qa1HA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 27 Feb 2024 09:15:08 -0600
Message-ID: <CAHCN7xJUBT8hMNEtFhne-wr8mOYe9JZcc=LS9Utt9TyOQQF5=A@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: renesas: r8a77951: Enable GPU
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:11=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Adam,
>
> Thanks for your patch!
>
> On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> > The GPU on the R-Car H3 is a Rogue GX6650 which uses firmware
> > rogue_4.46.6.61_v1.fw available from Imagination.
>
> s/61/62/
>
> >
> > When enumerated, it appears as:
> > powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v1.=
fw
> > powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
>
> Do you have a different build number?

I don't actually have this board.  I just copy-pasted what I thought
it was.  If you have  build number that's more appropriate, I can use
that in the future.

adam
>
> On Salvator-XS with R-Car H3 ES2.0:
>
>     powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.46.6.62_v=
1.fw
>     powervr fd000000.gpu: [drm] FW version v1.0 (build 6538781 OS)
>     [drm] Initialized powervr 1.0.0 20230904 for fd000000.gpu on minor 1
>
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > @@ -2771,6 +2771,16 @@ gic: interrupt-controller@f1010000 {
> >                         resets =3D <&cpg 408>;
> >                 };
> >
> > +               gpu: gpu@fd000000 {
> > +                       compatible =3D "renesas,r8a77951-gpu", "img,img=
-axe";
>
> renesas,r8a7795-gpu
>
> > +                       reg =3D <0 0xfd000000 0 0x20000>;
> > +                       clocks =3D <&cpg CPG_MOD 112>;
> > +                       clock-names =3D "core";
> > +                       interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH=
>;
> > +                       power-domains =3D <&sysc R8A7795_PD_3DG_E>;
> > +                       resets =3D <&cpg 112>;
> > +               };
> > +
> >                 pciec0: pcie@fe000000 {
> >                         compatible =3D "renesas,pcie-r8a7795",
> >                                      "renesas,pcie-rcar-gen3";
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

