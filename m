Return-Path: <linux-kernel+bounces-68722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA0A857F04
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AEA286723
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C812DD86;
	Fri, 16 Feb 2024 14:12:22 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773112C804;
	Fri, 16 Feb 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092741; cv=none; b=o/nJnlKsnHjhzY11DD7Kfdj9QPGkE6sTO9iORRvtxajR1kBXWRxncO4rTLFGEh9vtir4zN6vDznSmZ+pfImMqydS3osd/G9rsGO1eJS4vP5ZM2NesZq7OE8Ud2Dokw4Pzo7+G8lS2ig/y+cbif7eV5DeNsFN0ao37LXY4fqY+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092741; c=relaxed/simple;
	bh=2ewP/U/Wz0MRmlo1erIRFO9IZmPv1MjmeWkHxi3ZwdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r79sSK/kBJKPbb/QPngugnmE61BSrm7gHg3/4ZGWlcCdJNXLi83+vhNEUSugmc+ufUVUioiDxwSp6jLLUrciKeDHC7MVw9+8Af3mTqgLAN9gCoSl81WNlYFOCpoKQjNgeDT+y3iw6Ffc2mGRRChaFOhEgx9iRCauWphREsFmVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60777bcfed2so16221037b3.1;
        Fri, 16 Feb 2024 06:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092737; x=1708697537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeuOE0EFMegO/dS0ehIexjTqXFt2216JGNfZrumvThs=;
        b=XPPtCMPQ7oZbYVczOUqoHcbMGvIWvLOg7GUZwCB/j/pm3bvDBEI3NRDvxYWImftsAE
         Xb87o9XcFCp46E+7kqfzNyDh5dWrSZFz2fUF4WVzODvL7VHzImbepHUM3r1SuV0HQHR8
         JOZbutuTC4mahbsnhlHyG8AwokY0Ilvr/MlElDBEfl9/FAi3B8D4QK9RArqZsB++VdjP
         jtPcrPm6gFYrDfvgnimrigxUpvSO/nG9tI9j7pPmKqmpytrnjb3K/jcbLnk+/2L+p1Kn
         YkGkNDGpcI5X6en872COg4+0+/Gn9jtzq4Wqde62uxHA81Yg/kNfInnfzQxnZ76BS8Xc
         jXew==
X-Forwarded-Encrypted: i=1; AJvYcCUKZqhnN4rPuTz6vEKDYlorFJEnYVIMlJNnjRU9pcxYIqaM0eCf7Ig4i3BHfhbBdw6vGR1ak5eYIuGviB3nFfDaH4vAJx+UyMt8mKuBq6I/1SnH2klHmm8TQb3wF2NC5QqIcIdz5iAfwehCpgWN/YBI0AQKADXCkz5GLKISY4p1z3OZQZdsqh1b6rUqub5uqWxhWinYVSUsJ7k3ytO29mpH9/StkOKE
X-Gm-Message-State: AOJu0Yx4Ff//Ck9xfzGxT9f3UhOxfeqGfUA0/EoMH9l+5aJKR/Ik2oAV
	R0w2/d9aEwTVqBGaz3s3cU+iO8Al/bor+9bmodyNW9l9e8h1FTbX5wib/BqfAwk=
X-Google-Smtp-Source: AGHT+IFwJ98FCo8Fu3IofI1GKecSqKujWnT6FhzTmE+NSA7RzqGmjvU4NQcwi08ejyHzbULXyCkjTw==
X-Received: by 2002:a0d:e2d6:0:b0:607:8c84:d474 with SMTP id l205-20020a0de2d6000000b006078c84d474mr5498730ywe.31.1708092736997;
        Fri, 16 Feb 2024 06:12:16 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o186-20020a0dfec3000000b006047f2e65e1sm350085ywf.106.2024.02.16.06.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:12:15 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1943529276.2;
        Fri, 16 Feb 2024 06:12:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEyFDhXBPo3bAHXkVcba953ZWA3ae+kry0nTkGQsydtYjDYh2wNyxG3xT15QEqK0qanQmameHJaZxpPKKci6kFxVLmWngsoQdCNjyK7h23Ih1tc+xBO9WwczsZowqC7Uvn2SKsQFySsvm7MQuI09BYORBRAPR3KJd3bkICDuP7ISg+wfdKLqFNH/jG153V9rhSbWfhB0BYQ1ju/tcj/+Ew9l1h5oaj
X-Received: by 2002:a25:6905:0:b0:dcd:1b8f:e6d3 with SMTP id
 e5-20020a256905000000b00dcd1b8fe6d3mr5491918ybc.48.1708092735326; Fri, 16 Feb
 2024 06:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-17-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-17-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:12:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXhu9H71w0oB_3NGL9xJWirfxgwjt+ngB-BMcD7KEgMHg@mail.gmail.com>
Message-ID: <CAMuHMdXhu9H71w0oB_3NGL9xJWirfxgwjt+ngB-BMcD7KEgMHg@mail.gmail.com>
Subject: Re: [PATCH 16/17] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Update CPG #power-domain-cells =3D <1> and move all the IPs to be part of=
 the
> IP specific power domain as the driver has been modified to support multi=
ple
> power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -168,7 +168,7 @@ irqc: interrupt-controller@11050000 {
>                         clocks =3D <&cpg CPG_MOD R9A08G045_IA55_CLK>,
>                                  <&cpg CPG_MOD R9A08G045_IA55_PCLK>;
>                         clock-names =3D "clk", "pclk";
> -                       power-domains =3D <&cpg>;
> +                       power-domains =3D <&cpg R9A08G045_PD_ALWAYS_ON>;

R9A08G045_PD_IA55

>                         resets =3D <&cpg R9A08G045_IA55_RESETN>;
>                 };
>

The rest LGTM.

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

