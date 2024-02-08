Return-Path: <linux-kernel+bounces-58093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D184E138
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46097283280
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D92F762E2;
	Thu,  8 Feb 2024 12:53:56 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DD7602C;
	Thu,  8 Feb 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396835; cv=none; b=fcoa0z04Fp/B+RB+ObRpW9017XxGopLc4iP1Z5mmuMViy1L9KzjtNXKDflQV2Am3jFzPsU3OjDzBeAVSiC7zmCeSUilqvaRTWoGcwNgdbWr1MVkPQm0xYOJzVSZ4AmCuFLcuEOgR7H4gqraTXuuEsTTzk9mRKvX29tlQP8yxh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396835; c=relaxed/simple;
	bh=Cli3dfHjTQg2JF+CpPCW6kjPq9xjuZ84+noWzYcT2Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5V+AmnEcndu6P+o0auq8/z8ESHjkhTZ22n0nO3ZnS5jz2xJVE2j2bbEi47syixui6X+yGWJThcT6qC4QMoniqRPWXORVrF+M0c9QVWZmeALRGBZK35LwcBFCDyzjVIfrysTZkbQmp7gW2K2LpmY0avRI/5k6Uwj4TBeSSr+O18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604b27e3bd2so674387b3.1;
        Thu, 08 Feb 2024 04:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707396831; x=1708001631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NztMPrBdvMmS8LR3qgfsF/yKHS6WGHXK/n/wOhAxkkQ=;
        b=D3yWNgnQmfuDtHQEgN/MgDi06Stl2jeD4EdT4R+8PxEgEiSyrL13/e3N4Y3XQGvNVQ
         ZvtMGPuSirvmxxsFlMqKF0EwoXh3lXjZiS49Q6tvXAAwT9L/7WkzL/i1xsHQszIC7F9E
         VRWqEchzKLEE36f7Oul7DdAGWwXyUXUeOc43PypWHz712hs8DgqM3Pv0e34KMHAxSVYF
         SXgvstNK3o3PqkmvZcZuNHVUxzLbYQiUfWrXdRNmkt5m6hLSfHeVCtIjvmrnR2xf+qP6
         jK4AgKADFcC2dItzjHaz7rIjtmYzmOOHrC14/gD1jfFzunxcrpJaoonsJ8NpZ5qZt60e
         pxnA==
X-Forwarded-Encrypted: i=1; AJvYcCWrwFgBM0CtTXpA+p1/SM2Bixjfhq6kJ9mBHoqYtOpsF1BbYN4WVPRrwVaUT7uScFULkw33qrsfqDqLQRYYrCvubc5vv7FVLRGgKXBmLWHTy76uwAvmpGgEOBgMf2ZrG/yS32jWri3ll5q37bUQzbS/KFUlVggBM3jv62jcfBnpjdnBnCmqSip/9LLp5TvXt/kgsdAsamX7IJuGELcQbRP0qeNXZg7EAsRjEUk=
X-Gm-Message-State: AOJu0YxiL/FuLyGq9iMSAXfyv2FhWxbBvEQZ40aDm5qMVyqQvWOuLoAU
	/iqgUVuvh7pWSE3YC+XQObpx45uykcGS2ZTdzfRpaOU8Atj9ZQKx9gLi6ZD0GdQ=
X-Google-Smtp-Source: AGHT+IHGcKcNdmGCYkQJ34MFr8SzjnS5WA9rW1UtvmPqYfjSg2zruMJ2g7uONRrQbTwDTSFNvFDpsQ==
X-Received: by 2002:a81:431f:0:b0:604:a51c:cbd3 with SMTP id q31-20020a81431f000000b00604a51ccbd3mr1074665ywa.15.1707396830821;
        Thu, 08 Feb 2024 04:53:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXy893PHtyeRMfsFwW2vC40iS5aQyzlbsAW3sjpQAdedFG3yBTorjO01r38/7szW7YlNU7tN8SymExs4cR7rR0NziV+bhzP6Dz6/577hIzUOB/+36a6lkKEYvTyjWp6lY9MJnt6wHC50F4poWWUKR2qO6c/x2VDSuSwQC2eyNKm/qf6RU4IGBl2RVGujpPxmAJQwY1Rr/3QxJUa+ecmjk7WWOsLq2cWx7eIJb8=
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t142-20020a0dea94000000b006049b905176sm505471ywe.39.2024.02.08.04.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 04:53:50 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed179f0faso625571276.1;
        Thu, 08 Feb 2024 04:53:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0Xe+N6h3zn5QRxl/l/uW3XtSjIArmOS8EVDT6BXiYVnbXk+G61R2mvYfdTPcDjxjbF4x2eYmg5bGDvLR7hg2Efae7c9BDX+8BI/Hsiu5em4r1B6IB/TghA6v41e4PrtBtdzEbDPNGWcH6NtRoWvqNlcAAJSSdEIyw9veRkhn/j8jWOhWckDRWI4auPnm5eOHKjaVoKdZdTIzYEYjM//MMhdTQbH21qLcmvOQ=
X-Received: by 2002:a25:c8c3:0:b0:dc6:e7f6:254a with SMTP id
 y186-20020a25c8c3000000b00dc6e7f6254amr1664738ybf.8.1707396829937; Thu, 08
 Feb 2024 04:53:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208105817.2619703-1-claudiu.beznea.uj@bp.renesas.com> <20240208105817.2619703-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208105817.2619703-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Feb 2024 13:53:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+CryvbFkcFGthk2VM0j7m13rQJ_0GtumPg2f-hpuMvA@mail.gmail.com>
Message-ID: <CAMuHMdV+CryvbFkcFGthk2VM0j7m13rQJ_0GtumPg2f-hpuMvA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:26=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> clocks are enabled though pm_runtime_* specific APIs). To avoid building
> a driver that doesn't work make explicit the dependency on CONFIG_PM.
>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v6:
> - update patch description
> - fixed the dependency on COMPILE_TEST previously introduced

Thanks for the update!

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -911,6 +911,7 @@ config RENESAS_RZN1WDT
>  config RENESAS_RZG2LWDT
>         tristate "Renesas RZ/G2L WDT Watchdog"
>         depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
> +       depends on PM

depends on PM || COMPILE_TEST

>         select WATCHDOG_CORE
>         help
>           This driver adds watchdog support for the integrated watchdogs =
in the

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

