Return-Path: <linux-kernel+bounces-103541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484587C0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBFA284D56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B607319C;
	Thu, 14 Mar 2024 16:01:30 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23786FE36;
	Thu, 14 Mar 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432090; cv=none; b=RM686ThBNewat3cji75y3Eo5hQN7Nc3o9O+HE2ihUlcbu0yEO8rY4QoFV96JaxhJeTbUQOVRNBCjnNxpSIgJgYH+RROTTdFm6XHGiHTuf5cpa/Z6HA1IyOO8EfDkyVNUFJdcF6g/yOBRpzF2b+A/e8MiAzZCbyr0zEGIrY9oJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432090; c=relaxed/simple;
	bh=HmW2u3GIQSTHJ1TrNNSxc9z4hL7mtGt+q2u0TcftYuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOdPRF+kuwrVa7VtEj/XHeU7TfqXxeop5LFwyDbOrx5jK0BhNCEnHyeKxmmYhQobVpU/44YpZ8dczIYvNNYYIv6i7GYTSkvJGb3mQSP9GIRwjBCZcU3EoleRomkPqDGWq0gvnljyZfTivsaioqXc/m8/nARHS6xMPPoMOPkiGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a1d2cac52aso440732eaf.0;
        Thu, 14 Mar 2024 09:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432087; x=1711036887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTOcgaYCUNY/ogvH5Tg7ITSO8qkwxO1+5t0UgNhF1l0=;
        b=jjWlZNt77gkxQIYrXUD28JloL+R1vCEhG0NfLv52ClxIRL8LVswrgb6SA2WtptwIHz
         2NmdN8W+cM3UxMP4uMLF1QfCNSwVHN/MFJwudEhCdEa9GDze8zyQ2g+3UZ5K433qRAT2
         axfR3MaLY+NrWGC11TN92823yKzkCj/tDvJ10Ef7Ork6RpkofNnJWNcl6Lf2qjrFtDMa
         gXNSMCU6rpabu7B366O/GrTnvbNE9UcnJj3EZdNEqrHgGokhBi+p7RWThCltpsgN0Y9q
         6/0UtG2z15ru166mBgxx/U44nCpJzQ0WroiesgeFCyiBXTUp79cx7n/7t37PARffdC/I
         gm8w==
X-Forwarded-Encrypted: i=1; AJvYcCW6zfhYXKC4gikae//3p4nQoxbDLp27uL0hHaOXRNPju6z+XKRvvkGHLJydkHENR8hXaGE4B52j+DDq7shdyFPRMFWgGUVkoJaRLOc81rTUnd6JeKNCgHSx+GN9La77iBkyef3QX3wKn7QEkAx+xpwdIVIP2MaXa4d5rbkW66mBoNPwa0Bi7GAnaZxFg/i4E6LqfeoM9q8TEy8R8IzJMRDIw1MEH3iO
X-Gm-Message-State: AOJu0YzCos4kpETrGqwTVsju5b+oR2XxTqb0QjrXajAmnKE62AE+ZJN7
	qTeq528GWySm4aX2/0B3vXSCiEYMbkxhHQovRCHr+nJnoU0Ax7T484W1SJy6428=
X-Google-Smtp-Source: AGHT+IEZILcfMVY7xGnIe6o5ngyaj2dT5WSPFxxw2/gzQJVKkE4mpHvGl7PnABo6WIFo3pl5+HnLCQ==
X-Received: by 2002:a4a:6c1d:0:b0:5a1:1e5e:1fd0 with SMTP id q29-20020a4a6c1d000000b005a11e5e1fd0mr967684ooc.2.1710432087268;
        Thu, 14 Mar 2024 09:01:27 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id cg16-20020a056820099000b005a46c933653sm77080oob.1.2024.03.14.09.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:01:27 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a1d2cac52aso440723eaf.0;
        Thu, 14 Mar 2024 09:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1SFBGnzKFHjdzOheosdjM07eMqFgnD80j8NiPa+b6G/bgf6o3M/Fn9amiUhWzUYWBJ/7srulYBHROo7lyg4pl7v51ej4qITPkySPmXqvYFgCjXJX7m+xXd5w879o4pTDye7YXUUsO7AM8ov6sVEKmQ90D+94PSfiylsVGL47kAAL6pJtxS4ODgxXTIT+l5qQxm9bsnukUEg3kdSrixSZtd8oZz0nR
X-Received: by 2002:a05:6358:938f:b0:17c:1e44:a49a with SMTP id
 h15-20020a056358938f00b0017c1e44a49amr2367976rwb.1.1710432086791; Thu, 14 Mar
 2024 09:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 17:01:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ=m2BJ3Tjt0m8Q_H6dLh62sXjd2EMBTc+kuAwtc5B7A@mail.gmail.com>
Message-ID: <CAMuHMdXQ=m2BJ3Tjt0m8Q_H6dLh62sXjd2EMBTc+kuAwtc5B7A@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] clk: renesas: r9a08g045: Add support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 3:07=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Instantiate power domains for the currently enabled IPs of R9A08G045 SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Change in v2:
> - used DEF_REG_CONF() to describe register offests and bits
> - updated MSTOP bitmask for ddr domain
> - updated MSTOP config for oftde_ddr
> - kept the same description for gic as the CPG_BUS_ACPU_MSTOP register
>   documentation in the latest HW manual version is wrong and it will be
>   fixed; proper description for GIC is located in "Registers for Module
>   Standby Mode" table
> - haven't added watchdog domain (was missing in v1, too, by mistake) as
>   the watchdog restart handler will fail w/o patch [1]; with this pm doma=
in
>   support the watchdog will fail to probe; not sure what is the best
>   option until [1] will be integrated
>
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240228=
083253.2640997-10-claudiu.beznea.uj@bp.renesas.com

I guess we'll have to wait until that dependency is integrated,
or use an immutable branch?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

