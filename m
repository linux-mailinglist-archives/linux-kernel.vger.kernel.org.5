Return-Path: <linux-kernel+bounces-83090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A418B868E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBB01F244A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938D1386CB;
	Tue, 27 Feb 2024 11:04:36 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9C130ADF;
	Tue, 27 Feb 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031875; cv=none; b=FbMeGegxyAk3/HK7IewypU6w2dmiZ4WFYtcBbmluY3oY8bXWuKiqSw5kf8yANOFvLQSMI564VYsVJQxgtWNlrK+U49d3Ww740f6P2wS+DBxCIFYiNgDAI2QxSzZRAiYnyzpqcwUZsUdZeHjKSfLOZrRM59V3gsnczqASQ8rK6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031875; c=relaxed/simple;
	bh=kM9J1nLU0MN3h/U6de1ypqHdb9KiOVaBWFUfIh6BRAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1YsIHAWWR1F1L+MhZ77NI9TvH6Vnt8G+79U32TZ8dBkj8JGJN6MKd6qpb4C9Xl5rbaEAVj+ypdcNnxTVgWUUGi29j7RSfBU+7pgpnXOIjbl1aoFMuKykYiX1+edJrUMcdoOmQvfs735YVkbDN9qtn+089xEgKcNQy0pt0Kaj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-608d55ab7b0so28052607b3.1;
        Tue, 27 Feb 2024 03:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031870; x=1709636670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPv5tY8IlTb3U7rQdZHsbYJc9/8vKc1NrUUSdhaGOUc=;
        b=VKrkAjnyb828d55QjKTklmegqGMpRZ+rFoMG0mIbakmQCUkO6xGGPRtlQpxD2toC9u
         dJmgozYZjTCKDuFlh7ChVT/x99h8VVTIPYpWeZGKl9W4tFuVcefEX4QVl+/1fE1sjc8i
         iVIkMyqTIg6pqmDFhYDWfBXRZh5us95n6MecZqqLg2HlNBKWzcENaEgObqweJlEnFqX+
         E+ZvlIWrxVbL25DbxMl3LVd+6HJPRxoqcuKJap+XXMh/uaTRPIk/YLqfQzzmzIl8PbJh
         w9SNv1gW01ek37igxjPJbH/sPhzFt574a/2v+JZBYHuUOpkN6rx1d/vAnw56r0+g5x54
         +jDw==
X-Forwarded-Encrypted: i=1; AJvYcCWccuPISk8l5VDXR7oiwJMfuPIuOy9RkAnV4Wt+DwCYL19AELNkNF5eLjrMoVGhhqwNLOnIr0WT/jPYuvTtTfqduovs4QQHtFd3YQ/QJ178NWzHn0XsSmkt3Xubu9vAE0GAhnvN3ItD0Pwq83tM1QX8UVIS7IC1W32lZt3IeVc8JK05KfgrfYQL5ayD
X-Gm-Message-State: AOJu0Yx+WLwhl/g6A11SDHNh0Lx0Tv1Y06XykGqJDEC1KBehhj0IrIli
	UqUIJ9I9McGHPaNYgZxq2ShVvvoqJLeYP96g7ScaiqyT4CfsSySJFEF/YvAJ2xM=
X-Google-Smtp-Source: AGHT+IH3nCYhdCtPIrVCOl+x/iPQwL95EBbhEfcIaTCO16G06irj1ZTLMNBrOgF2kdlsuO0tVG/K5A==
X-Received: by 2002:a81:8d0b:0:b0:608:20df:8b15 with SMTP id d11-20020a818d0b000000b0060820df8b15mr1428538ywg.3.1709031870309;
        Tue, 27 Feb 2024 03:04:30 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id c62-20020a0dda41000000b006078c48a265sm1714178ywe.6.2024.02.27.03.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:04:29 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74435c428so3645352276.2;
        Tue, 27 Feb 2024 03:04:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyCV38Vc5aakNCF24Jf7+Ile8DTWMLrtAPEEvygQUvhHc1SFlwLw9wPhsmhwG8yEqTgxDLgllqKSF2kKtHRG3LU5uThYccg+4JPh/3eRzr7PIwWEDbSaFNcKYwl0ZbyamH18W2/Ab5kGXkvMknoK2RHZQhs41DA5ct2SVhYUGn4GRA1Swq//HuJr9c
X-Received: by 2002:a5b:ecc:0:b0:dc6:c32f:6126 with SMTP id
 a12-20020a5b0ecc000000b00dc6c32f6126mr1590255ybs.22.1709031869487; Tue, 27
 Feb 2024 03:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-3-aford173@gmail.com>
 <39aead3b-b809-4c9c-8a5d-c0be2b36ea47@imgtec.com>
In-Reply-To: <39aead3b-b809-4c9c-8a5d-c0be2b36ea47@imgtec.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 12:04:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5vWg=tpB9PCRXmdBmLtt0wNN9dOEN1Lp_N7R68jz0tA@mail.gmail.com>
Message-ID: <CAMuHMdW5vWg=tpB9PCRXmdBmLtt0wNN9dOEN1Lp_N7R68jz0tA@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: renesas: r8a774a1: Enable GPU
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Adam Ford <aford173@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Adam Ford <aford@beaconembedded.com>, 
	Frank Binns <Frank.Binns@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Tue, Feb 27, 2024 at 10:31=E2=80=AFAM Matt Coster <Matt.Coster@imgtec.co=
m> wrote:
>
> Hi Adam,
>
> Thanks for these patches! I'll just reply to this one patch, but my
> comments apply to them all.
>
> On 27/02/2024 03:45, Adam Ford wrote:
> > The GPU on the RZ/G2M is a Rogue GX6250 which uses firmware
> > rogue_4.45.2.58_v1.fw available from Imagination.
> >
> > When enumerated, it appears as:
> >   powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v=
1.fw
> >   powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
>
> These messages are printed after verifying the firmware blob=E2=80=99s he=
aders,
> *before* attempting to upload it to the device. Just because they appear
> in dmesg does *not* imply the device is functional beyond the handful of
> register reads in pvr_load_gpu_id().
>
> Since Mesa does not yet have support for this GPU, there=E2=80=99s not a =
lot
> that can be done to actually test these bindings.

OK.

> When we added upstream support for the first GPU (the AXE core in TI=E2=
=80=99s
> AM62), we opted to wait until userspace was sufficiently progressed to
> the point it could be used for testing. This thought process still
> applies when adding new GPUs.
>
> Our main concern is that adding bindings for GPUs implies a level of
> support that cannot be tested. That in turn may make it challenging to
> justify UAPI changes if/when they=E2=80=99re needed to actually make thes=
e GPUs
> functional.

I guess that applies to "[PATCH 00/11] Device tree support for
Imagination Series5 GPU", too, which has been in linux-next for about
a month?
https://lore.kernel.org/all/20240109171950.31010-1-afd@ti.com/

> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boo=
t/dts/renesas/r8a774a1.dtsi
> > index a8a44fe5e83b..8923d9624b39 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > @@ -2352,6 +2352,16 @@ gic: interrupt-controller@f1010000 {
> >                       resets =3D <&cpg 408>;
> >               };
> >
> > +             gpu: gpu@fd000000 {
> > +                     compatible =3D "renesas,r8a774a1-gpu", "img,img-a=
xe";
>
> The GX6250 is *not* an AXE core - it shouldn=E2=80=99t be listed as compa=
tible
> with one. For prior art, see [1] where we added support for the MT8173
> found in Elm Chromebooks R13 (also a Series6XT GPU).

IC. And the bindings in [2].

>
> > +                     reg =3D <0 0xfd000000 0 0x20000>;
> > +                     clocks =3D <&cpg CPG_MOD 112>;
> > +                     clock-names =3D "core";
>
> Series6XT cores have three clocks (see [1] again). I don=E2=80=99t have a
> Renesas TRM to hand =E2=80=93 do you know if their docs go into detail on=
 the
> GPU integration?

Not really. The diagram in the Hardware User's Manual just shows the
following clock inputs:
  - Clock (ZG=CF=95) from CPG,
  - Clock (S3D1=CF=95) from CPG,
  - MSTP (ST112) from CPG.

ZG is the main (programmable) 3DGE clock, running at up to 600 MHz.
S3D1 is the fixed 266 MHz AXI bus clock.
MSTP112 is the gateable module clock (part of the SYSC/CPG clock
domain), and its parent is ZG.

According to the sources:
  - "core" is the primary clock used by the entire GPU core, so we use
    MSTP112 for that.
  - "sys" is the optional system bus clock, so that could be S3D1,
  - "mem" is the optional memory clock, no idea what that would map to.

But IMHO the two optional clocks do not matter at all (the driver
doesn't care about their rates, and just enables them together with
the core clock), and S3D1 is always-on, so I'd just limit clocks to
a single item.

Just wondering: is the availability of 1 clock specific to AXE, or to
the AXE integration on AM62x?

> +                     interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +                     power-domains =3D <&sysc R8A774A1_PD_3DG_B>;
> +                     resets =3D <&cpg 112>;
> +             };

> [1]: https://gitlab.freedesktop.org/imagination/linux/-/blob/b3506b8bc45e=
d6d4005eb32a994df0e33d6613f1/arch/arm64/boot/dts/mediatek/mt8173.dtsi#L993-=
1006

[2] https://gitlab.freedesktop.org/imagination/linux/-/blob/b3506b8bc45ed6d=
4005eb32a994df0e33d6613f1/Documentation/devicetree/bindings/gpu/img,powervr=
yaml


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

