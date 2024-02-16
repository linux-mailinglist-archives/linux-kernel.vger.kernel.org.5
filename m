Return-Path: <linux-kernel+bounces-68720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74622857EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15460B27D12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1712EBEF;
	Fri, 16 Feb 2024 14:11:42 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1D12EBC3;
	Fri, 16 Feb 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092702; cv=none; b=s7ZSNG7OsNu2DfRuFXzdsxQAyhhexuHVlEWefWtBQEId2fzWUC9q55JvBVW37biAweHUEjD+ArMJkaizSd7zP4IedMSfpYGBBmj3fAc1+CMwi1B6o1nQAQxrP8z7GRzP7e9Tr6NsCvVPSQLZ8Binx09UMTnT5lmK0A39zRmickc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092702; c=relaxed/simple;
	bh=6g3ZAzUrBPJ3IzVRdyd5Ug4iMOzihwdLzZ0W/NbGHsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+26brJx53wkDjft4beYuLE6+fK6eCMDwvc/qHo/JOF37mhhTBC69cS3MDr8L/ohUWRUK7cXnnugbOjZ73BwS0358CYMkLhAUZGdUxKInsRePMz/3vdjKeNaXptbqWGhfDEcbpiafLJjhoQRdHsflrdOcLkVnrweHqEZvbImtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607bfa4c913so19854917b3.3;
        Fri, 16 Feb 2024 06:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092699; x=1708697499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxU+OH4tOB8SnuDggPv443FXpkfBxYUxV4DulHiEADs=;
        b=jVw3GAlmX0YfbC6zQAz4JB/OULqC0nJ3JvYkLJCNiq9o2en3VxQQe4TZ/qd8lxWFma
         ffvQJyDEzjF4h/Cgm7XuLuJKs8cRWaz43mZ3GLQBtNPP8/lcd+Zjteq2HbnBuLsDo3pw
         +TiBAxFp56R09FD1xrIINtwu2rUFlx88nF9tnTZc9wFM9QGuqL/9pAUDeqyVxkEGBBvS
         hLj4+Us9Rzmwy7czV0O982/7StwQe9K2UVp3Yn/1d+VEoG5ap7O4LrbUPiitNoAF2R6/
         XcXXBXRN8Lq0zS5CbdPnrrAxjIjKD2mGzn5yM4sEXvKe9WG7TzICoY/C+oJ6DrjG+KP3
         Qu8g==
X-Forwarded-Encrypted: i=1; AJvYcCVBAiR7zEqBzp4SfutZudYIMgRmUhPI2wgOAUhBsYXJac20c1iYxYQISevmhcbmI9RyHm2usDwC8qG4jnUd9G42Gfv1wz7iIcI764N+MKjr180MHzJ8Md4smjOW8DYWg1WgpojCwmpuQxaQhts4RduP1OWaTU0J0Q4LFEbvl141PSbggIRudXio2lcAormWFoFJyQClUlxmbmhaaT+7Yn8s5FiP2tO7
X-Gm-Message-State: AOJu0Yyp1DtF4VFD02/9iXIN8H20PTeC1oJXmbqgqUV1HqgAvUHdR7HL
	ZvjyVP5ZC5SJpFjdd0bTioyHunnZ/LS6LJ1lkwvo/2uCs4e5ujCVen/LRsuATMY=
X-Google-Smtp-Source: AGHT+IFilFwh8JWJ9Q+WtlI415oPPgaaaWZtmA18TdEG+9mdk4mxS900e9Cd4kEr4lPk9MSYXQo4Ng==
X-Received: by 2002:a0d:cbcd:0:b0:604:98b1:bc5 with SMTP id n196-20020a0dcbcd000000b0060498b10bc5mr5079829ywd.2.1708092698673;
        Fri, 16 Feb 2024 06:11:38 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id z202-20020a0dd7d3000000b005ff9c1373ddsm350272ywd.88.2024.02.16.06.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:11:38 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607bfa4c913so19854537b3.3;
        Fri, 16 Feb 2024 06:11:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXESgwDrLb72sY8BBruPyII0+bapUSJaj2SpZzgJE+7KsiPmo+Ey44SJTBHrTXEMN0oJy672J6pH0wSARD6ZpL3sDSq3OLbejK+LzhK7Kni5Nu0tocPRMT1OBQ1M/4Y3cXuJqDOxykOyGuMF38/dehYBYCvDGQARKTBo74sVADKHC8ptNj9kXIbx9KDVMALpH8BDvJ4Inz+UPVG8Zrw3R6F9w7bjfpX
X-Received: by 2002:a81:ae4d:0:b0:607:f50f:3770 with SMTP id
 g13-20020a81ae4d000000b00607f50f3770mr2394746ywk.41.1708092697973; Fri, 16
 Feb 2024 06:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-15-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-15-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:11:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXoRiH5rCO+RqA1ZYMVtbdMGjW2WC3cCTE44ipWR9ccnw@mail.gmail.com>
Message-ID: <CAMuHMdXoRiH5rCO+RqA1ZYMVtbdMGjW2WC3cCTE44ipWR9ccnw@mail.gmail.com>
Subject: Re: [PATCH 14/17] arm64: dts: renesas: r9a07g044: Update
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
> always on power domain as the driver has been modified to support multipl=
e
> power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> @@ -238,7 +238,7 @@ mtu3: timer@10001200 {
>                                           "tgia8", "tgib8", "tgic8", "tgi=
d8",
>                                           "tciv8", "tciu8";
>                         clocks =3D <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3=
>;
> -                       power-domains =3D <&cpg>;
> +                       power-domains =3D <&cpg R9A07G044_PD_ALWAYS_ON>;

This should be R9A07G044_PD_MTU, but that domain is not yet supported
by the driver.  Instead of adding incorrect hardware descriptions,
I'd rather defer this until all domains are handled by the driver.

>                         resets =3D <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
>                         #pwm-cells =3D <2>;
>                         status =3D "disabled";

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

