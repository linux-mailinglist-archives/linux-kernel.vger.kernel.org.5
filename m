Return-Path: <linux-kernel+bounces-61696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE7851575
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5DA1F22A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438D3C46E;
	Mon, 12 Feb 2024 13:30:03 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE033BB35;
	Mon, 12 Feb 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744602; cv=none; b=cJFx+ibPByipPIld77JSjhiQT/DFiB9Sqb9Pl+KI7CNzKTPnwDdvjiof3UE3W3l5u/DzS40lo3M3/9p/HGp9FaJ4C3WvgocNV7TAOkkrc1RGN+r+ftM37a3pzj708fAqdjy6fTUv/tFQuryiVyeCDD5dkyxysoojl7JVU4AjIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744602; c=relaxed/simple;
	bh=1oVIpdA3PWu0N2hwgGsr+QE7zE+6Gl0uk0jmM/Llz0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzbR9Yo+gZ7Bl3Xg2I4rpQe/zUKzsG/Fo/wzAQ1Wk/dJc4MV65rbmy3NSiHizYaIl9RtidGNI2HEjJM3DuQuNr3MURv6Pu98V+PG8jdDUklGEwXQNHYP/NJhZKOW1MWyjbEDW+T2Q5qo6Ce0rpP/6iILL621eq3o6KtAJ0DuXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbbc41d3d5so200220276.3;
        Mon, 12 Feb 2024 05:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744599; x=1708349399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDv+FBRkyzx2DZnQ26S++v9SBrU+T+SPPA5jSEnI6wE=;
        b=rcV5s+iJQnm7yV+xZY7oRB3oc7Hbrg5CHOLhLLeDAMr/N9Fowf5PpwK7z7J19EYIAj
         Ts8wkdPkcazV00yDoAg6zHGH2B8KYYfPJ6jUCF7Qf/qGlOxBuRJm4oaT8BpQpOVTI513
         V0+N13Pui9GXo/iGQOOzberGZjyFgfkXHLVgsxFUymGmts+uqNgZPPlRvuv+fN3yL4UA
         ji17ZLQMaveH61S8/vs7X+X6FS7/xmGCG59faK7ww3OIlWFd2CJsLvKIe9vd/PEE+5KX
         FwkJ9b5r7LbJ0133gmn7sFdnQKewXqX8EVhi5zFOXRZ4UrKL3sCDQuAisaLFrgtUi3AX
         jn8A==
X-Forwarded-Encrypted: i=1; AJvYcCW6S6MNusqwMwe7bjB71P7Jb/1+E9d5mv+8CC7AP4WUwJfyf8uF1zUgeIfn+eiixeWKcKuR6uTzE+kgqcb5e014fFXIVyo7OQIuintDztZNKv7UttMhb07PjOW4lMWA1/w6+TE572rAUQ==
X-Gm-Message-State: AOJu0Yyz9NRm0eXOf3qQSOkfQ+4zcw8BKc8qLSoDjlKk8fuDvLddW+zs
	kvx2qyN1xp7ymFA8yr6UiT9K9omgDW64fCCbUICaplErGXwnvB+mFFsruXlDHlo=
X-Google-Smtp-Source: AGHT+IF5/4SkXJ3leLn/t7HooEWb0fsuipMG/ViFIU2YIDaDvH15x55LrAsj5HrWtc2hFEP+acd3lg==
X-Received: by 2002:a25:fc21:0:b0:dc2:7018:806d with SMTP id v33-20020a25fc21000000b00dc27018806dmr5160771ybd.16.1707744598894;
        Mon, 12 Feb 2024 05:29:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtUqTyLe8R2G4Ia0vpM7mESNloChTfMkWzHWqBc4VEhiwjvoZ0uKzIFVbGyu1pvpuSv/wblyboXnmHsDXyVJEjB2k1EZWlCF/gw7RiDCG5CIzSf64bQ6ab/b1qWLJ3i9FMW26/RHSfNQ==
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id z19-20020a25ad93000000b00dc73705ec59sm1243948ybi.0.2024.02.12.05.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:29:58 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbbc41d3d5so200204276.3;
        Mon, 12 Feb 2024 05:29:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt1L+mYbhYWpc4oe7g/VSGre25Y3M22VTjIEySrfDxa9+FU3IUxzDWfskVKmnSYX5MrOfyNhPkkgpvZrykBtW2A12gvNHvxnbJ7cmGjYTT1NPFfU77VtgYeD9SrKhu6X0n7Jo4ZHtELA==
X-Received: by 2002:a25:d88d:0:b0:dc6:c3e0:82d1 with SMTP id
 p135-20020a25d88d000000b00dc6c3e082d1mr4746653ybg.60.1707744598434; Mon, 12
 Feb 2024 05:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129212350.33370-1-wsa+renesas@sang-engineering.com> <20240129212350.33370-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240129212350.33370-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 14:29:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuWHCLa8HFXBZK4M4fqivudxjHcqqUyZ2=a3=OfFLPYQ@mail.gmail.com>
Message-ID: <CAMuHMdXuWHCLa8HFXBZK4M4fqivudxjHcqqUyZ2=a3=OfFLPYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm64: dts: renesas: ulcb-kf: adapt 1.8V HDMI
 regulator to schematics
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thanks for your patch!

On Mon, Jan 29, 2024 at 10:23=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> It is named T1.8V in the schematics. Also add properties dcoumenting it

documenting

> is always on, also during boot.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -32,11 +32,13 @@ hdmi1_con: endpoint {
>                 };
>         };
>
> -       hdmi_1v8: regulator-hdmi-1v8 {
> +       t1v8: regulator-t1v8 {

"t1p8v"?
Or "reg_t1p8v", as the former is a rather short name, causing conflicts?

>                 compatible =3D "regulator-fixed";
> -               regulator-name =3D "hdmi-1v8";
> +               regulator-name =3D "t1v8";
>                 regulator-min-microvolt =3D <1800000>;
>                 regulator-max-microvolt =3D <1800000>;
> +               regulator-boot-on;
> +               regulator-always-on;
>         };
>
>         pcie_1v5: regulator-pcie-1v5 {
> @@ -154,11 +156,11 @@ hdmi@3d {
>
>                                 pd-gpios =3D <&gpio_exp_75 5 GPIO_ACTIVE_=
LOW>;
>
> -                               avdd-supply =3D <&hdmi_1v8>;
> -                               dvdd-supply =3D <&hdmi_1v8>;
> -                               pvdd-supply =3D <&hdmi_1v8>;
> +                               avdd-supply =3D <&t1v8>;
> +                               dvdd-supply =3D <&t1v8>;
> +                               pvdd-supply =3D <&t1v8>;
>                                 dvdd-3v-supply =3D <&reg_3p3v>;
> -                               bgvdd-supply =3D <&hdmi_1v8>;
> +                               bgvdd-supply =3D <&t1v8>;
>
>                                 adi,input-depth =3D <8>;
>                                 adi,input-colorspace =3D "rgb";

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

