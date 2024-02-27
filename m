Return-Path: <linux-kernel+bounces-83149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D2868F81
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92932838B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C25D13A25D;
	Tue, 27 Feb 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQySPxZh"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B404E1386C8;
	Tue, 27 Feb 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034903; cv=none; b=DTZBzmfpcmIgVk4l6t4ThOXoHtg8IbBwoo2/HaUm6UixCi3lvOVQRKnoF2Wwln8cvBg+IgV/6BAJVXGYRiFgSS6Ig9wHG6gJJ+nvTrtnjoQ5ZH7jTmUJ+5+Ajdb0kf7wEWkKIJie4YKl8Yyl+LzSeAtUSQpSEJh0ZkCLcfXLEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034903; c=relaxed/simple;
	bh=FUyhKiJCVkumDr18k9AE+n3vk0YM19EfHCPUG652SPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOpPVhhdYjiNxYfqIcKeHa4ZzGVwl7B3aSLZ73D/S/Isgl63QRCWEBMtHqCKFnDfFlg8PLYS83TRlLKVt/p+tHV0FjMbeo6HMCpYL/aB+jfz7t+Scblzlmnt7WyV6StRBa5ky0FcoSjLHi3cT1H81/RRtZABWbiC0fFKnbsC4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQySPxZh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29ad73b4686so1069958a91.0;
        Tue, 27 Feb 2024 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709034901; x=1709639701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4ZJKN0Q446qEQVH8mpv7kUe4f1OhDtxTG8dtoHu+5I=;
        b=WQySPxZhL3KuqMW3scxSr6Gzp0rMIKyAJDy1erDequ4Nv5rKpi1/XlpZQd9IlWYFcl
         S8hVlaJQTLdNfsp81/zIW0GB1z2joXVZYvI+hY1WdBlCd2qv1mNyrMEK3uqYkNoa1yZ0
         DpJJx/Jz4OYDmTR7B9PyL5NXdxPTz7jwDVZTqOZ3P/ClCEzxBCBwDIVppZq82DO8GeiP
         2juESsI8Q96uHCCf8t8ykC/oEJ+IoxujVyr1arfn+4eByFstAfAR5RwASabE8S6V/Vya
         n+EToYICaJR3EJl3hF9b3P2RFlimijS/0u7nQtkU4H/LlcMOJPa2AhIN7EIfSuAyPSbf
         ysog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034901; x=1709639701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4ZJKN0Q446qEQVH8mpv7kUe4f1OhDtxTG8dtoHu+5I=;
        b=MZJ3rw2E6ayvDm62lsiE7avE8PiQRkFAnQtSADXm2gWy9PRCfhBkxlDyiIM85LNwiH
         BvFSRmN/PFYnWJqHTXyCmDQwb8Pjo14rBxwc7myEtq/77aZvdOz23aWN0sXdiV3u8hyh
         pi36HIQ3AYqh8cb1spc0OA5vteIEFDFTpTd5pHrtAct9/Mj3/if5xGOn6BAxR249fSW2
         y0L/FchR1qvWk2kW8iyTLMHnrWQZYN8PDThI4nITWWX2tidZXzJGB7mJ3POWjJO02fcy
         Fa8djDQDNC5LMrsUnyCO8LDp2fgIblnNOz4gBv4cI1rbYkNpVVouGJ6agGMYPlrNHiAy
         FaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCC1YiNCc7RbjdvBADdnujGFlXXFhhT1MKdFl8gH0OpZVe3aqM9+59Le8ycqfpMvi8Cf6E8nwXSw8zZYkzbnYSJrC9TrPLsfgK4CZXtmu68RN9uoqpQ4tFCWSJh5+GUNijnmXl/hsHT9ZqtnJ4CnCXWiviplchMhWVyp4JxRdXq829m5Tj67kEMojg
X-Gm-Message-State: AOJu0YxmgmlvHLonUnSzEc6R+pBj3CCteH/igBIKgkgkkzj18G+ixI5w
	O/ZZxm1ST49va0C4seF0SOgrSwoGNSdAdYm0GHJemAVElmyepOGrXFcMF+kkTcLPC0hszdBWXal
	pmjkfvq0UmTWy8TfCF1N2oB/fk3g=
X-Google-Smtp-Source: AGHT+IHhPXWnX3QrXvJQ64wVH2LfXjnYJhDx8xAd+mEkx47SJCQDUZTu6xGwgmXEb/CzTUNjcuLdUFEZ+c71XRKGPJY=
X-Received: by 2002:a17:90a:5d0d:b0:299:9d8:d7c9 with SMTP id
 s13-20020a17090a5d0d00b0029909d8d7c9mr7489843pji.18.1709034900760; Tue, 27
 Feb 2024 03:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-3-aford173@gmail.com>
 <39aead3b-b809-4c9c-8a5d-c0be2b36ea47@imgtec.com> <CAMuHMdW5vWg=tpB9PCRXmdBmLtt0wNN9dOEN1Lp_N7R68jz0tA@mail.gmail.com>
In-Reply-To: <CAMuHMdW5vWg=tpB9PCRXmdBmLtt0wNN9dOEN1Lp_N7R68jz0tA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 27 Feb 2024 05:54:49 -0600
Message-ID: <CAHCN7x+EV8rw-Ya=wHOr6jsFAg47DDwKg3FZ9p=W-zDaBQEByw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: renesas: r8a774a1: Enable GPU
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matt Coster <Matt.Coster@imgtec.com>, 
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

On Tue, Feb 27, 2024 at 5:04=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Matt,
>
> On Tue, Feb 27, 2024 at 10:31=E2=80=AFAM Matt Coster <Matt.Coster@imgtec.=
com> wrote:
> >
> > Hi Adam,
> >
> > Thanks for these patches! I'll just reply to this one patch, but my
> > comments apply to them all.
> >
> > On 27/02/2024 03:45, Adam Ford wrote:
> > > The GPU on the RZ/G2M is a Rogue GX6250 which uses firmware
> > > rogue_4.45.2.58_v1.fw available from Imagination.
> > >
> > > When enumerated, it appears as:
> > >   powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58=
_v1.fw
> > >   powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
> >
> > These messages are printed after verifying the firmware blob=E2=80=99s =
headers,
> > *before* attempting to upload it to the device. Just because they appea=
r
> > in dmesg does *not* imply the device is functional beyond the handful o=
f
> > register reads in pvr_load_gpu_id().
> >
> > Since Mesa does not yet have support for this GPU, there=E2=80=99s not =
a lot
> > that can be done to actually test these bindings.
>
> OK.
>
> > When we added upstream support for the first GPU (the AXE core in TI=E2=
=80=99s
> > AM62), we opted to wait until userspace was sufficiently progressed to
> > the point it could be used for testing. This thought process still
> > applies when adding new GPUs.
> >
> > Our main concern is that adding bindings for GPUs implies a level of
> > support that cannot be tested. That in turn may make it challenging to
> > justify UAPI changes if/when they=E2=80=99re needed to actually make th=
ese GPUs
> > functional.
>
> I guess that applies to "[PATCH 00/11] Device tree support for
> Imagination Series5 GPU", too, which has been in linux-next for about
> a month?
> https://lore.kernel.org/all/20240109171950.31010-1-afd@ti.com/
>
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/b=
oot/dts/renesas/r8a774a1.dtsi
> > > index a8a44fe5e83b..8923d9624b39 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > @@ -2352,6 +2352,16 @@ gic: interrupt-controller@f1010000 {
> > >                       resets =3D <&cpg 408>;
> > >               };
> > >
> > > +             gpu: gpu@fd000000 {
> > > +                     compatible =3D "renesas,r8a774a1-gpu", "img,img=
-axe";
> >
> > The GX6250 is *not* an AXE core - it shouldn=E2=80=99t be listed as com=
patible
> > with one. For prior art, see [1] where we added support for the MT8173
> > found in Elm Chromebooks R13 (also a Series6XT GPU).
>
> IC. And the bindings in [2].
>
> >
> > > +                     reg =3D <0 0xfd000000 0 0x20000>;
> > > +                     clocks =3D <&cpg CPG_MOD 112>;
> > > +                     clock-names =3D "core";
> >
> > Series6XT cores have three clocks (see [1] again). I don=E2=80=99t have=
 a
> > Renesas TRM to hand =E2=80=93 do you know if their docs go into detail =
on the
> > GPU integration?
>
> Not really. The diagram in the Hardware User's Manual just shows the
> following clock inputs:
>   - Clock (ZG=CF=95) from CPG,
>   - Clock (S3D1=CF=95) from CPG,
>   - MSTP (ST112) from CPG.
>
> ZG is the main (programmable) 3DGE clock, running at up to 600 MHz.
> S3D1 is the fixed 266 MHz AXI bus clock.
> MSTP112 is the gateable module clock (part of the SYSC/CPG clock
> domain), and its parent is ZG.
>
> According to the sources:
>   - "core" is the primary clock used by the entire GPU core, so we use
>     MSTP112 for that.
>   - "sys" is the optional system bus clock, so that could be S3D1,
>   - "mem" is the optional memory clock, no idea what that would map to.
>
> But IMHO the two optional clocks do not matter at all (the driver
> doesn't care about their rates, and just enables them together with
> the core clock), and S3D1 is always-on, so I'd just limit clocks to
> a single item.

Matt,

When the time is right, and the driver is ready for Series 6XT-based
systems, would Geert's rationale for supporting one clock be
acceptable if I added his clock description to the commit message?

>
> Just wondering: is the availability of 1 clock specific to AXE, or to
> the AXE integration on AM62x?
>
> > +                     interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> > +                     power-domains =3D <&sysc R8A774A1_PD_3DG_B>;
> > +                     resets =3D <&cpg 112>;
> > +             };
>
> > [1]: https://gitlab.freedesktop.org/imagination/linux/-/blob/b3506b8bc4=
5ed6d4005eb32a994df0e33d6613f1/arch/arm64/boot/dts/mediatek/mt8173.dtsi#L99=
3-1006
>
> [2] https://gitlab.freedesktop.org/imagination/linux/-/blob/b3506b8bc45ed=
6d4005eb32a994df0e33d6613f1/Documentation/devicetree/bindings/gpu/img,power=
vr.yaml
>
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

