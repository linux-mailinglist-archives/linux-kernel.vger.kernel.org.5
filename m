Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F079E1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjIMIUD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjIMIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:20:02 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC2E93;
        Wed, 13 Sep 2023 01:19:57 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-576918d0a42so2095756eaf.3;
        Wed, 13 Sep 2023 01:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593197; x=1695197997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHwUPsbjTsV+d55BpTzeXRt9rHHTquV5VO6+Kicxk+4=;
        b=A/TS0/p5T9mrgfmktGbp1E6aFsKTVz1yMoQmO2zkYR4zs3v+W/BWlYu0bI0dF93J8v
         diip6Vi4zyM6fC5gwNbyVpjxbZDuNx7bOrDVkjTMGHIJDEetmUeNPEvE/UrWiZ6cKCqD
         j9Hyxd0gkyR4KUOEVPUAzg0YvoW4zpy0VFYBgqQ39W2wK9dlQySI7d2nzOCU7yi2ZPJL
         h/1OC6ZQhKAXG3NoWUIQ41BtiDts7u38iYIRuWpv1t2lUUjKp+svekM+y3CXyaa8543W
         pyeDmMfOSK4u9rTXtW3JRlx8i+8qAGofzCJlttpRiVC95/MteDW/SKGVT8ifsVG1ZoFb
         SAPA==
X-Gm-Message-State: AOJu0Yw2HpUwxLqhEwV4yO1UHXDvfO1fbjVKjfi+QvUDv3X0SE1tAE+Q
        wkmtOIcqyDf5RU1ODHiltcCzO3pcU5H9Gw==
X-Google-Smtp-Source: AGHT+IHGmnTA0ep2vh+BATUI83Nvl4di8jaw7l63htXCSmQ9O2zw5VGxKdejTVPYNX7UFd/3chT3lg==
X-Received: by 2002:a4a:2a12:0:b0:56e:4bb5:3095 with SMTP id k18-20020a4a2a12000000b0056e4bb53095mr1995906oof.5.1694593197106;
        Wed, 13 Sep 2023 01:19:57 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id q198-20020a4a33cf000000b0056e90dc1ef0sm5165648ooq.9.2023.09.13.01.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:19:56 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a9b41ffe12so4925179b6e.3;
        Wed, 13 Sep 2023 01:19:56 -0700 (PDT)
X-Received: by 2002:a5b:70b:0:b0:d80:c80:af18 with SMTP id g11-20020a5b070b000000b00d800c80af18mr1635228ybq.52.1694593175901;
 Wed, 13 Sep 2023 01:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230912221127.487327-1-ulf.hansson@linaro.org>
In-Reply-To: <20230912221127.487327-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 10:19:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUW3PF_d+pHkDeB_iwX0uUYn6g2WvvXXw=GLJ2+fvHKOQ@mail.gmail.com>
Message-ID: <CAMuHMdUW3PF_d+pHkDeB_iwX0uUYn6g2WvvXXw=GLJ2+fvHKOQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: Rename the genpd subsystem to pmdomain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Thanks for your patch!

On Wed, Sep 13, 2023 at 12:11 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> It has been pointed out that naming a subsystem "genpd" isn't very
> self-explanatory and the acronym itself that means Generic Power Domain, is

Generic PM Domain?

> known only by a limited group of people.
>
> In a way to improve the situation, let's rename the subsystem to pmdomain,
> which ideally should indicate that this is about so called Power Domains or
> "PM domains" as we often also use within the Linux Kernel terminology.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

>  drivers/{genpd => pmdomain}/renesas/Makefile  |  0
>  .../renesas/r8a7742-sysc.c                    |  0
>  .../renesas/r8a7743-sysc.c                    |  0
>  .../renesas/r8a7745-sysc.c                    |  0
>  .../renesas/r8a77470-sysc.c                   |  0
>  .../renesas/r8a774a1-sysc.c                   |  0
>  .../renesas/r8a774b1-sysc.c                   |  0
>  .../renesas/r8a774c0-sysc.c                   |  0
>  .../renesas/r8a774e1-sysc.c                   |  0
>  .../renesas/r8a7779-sysc.c                    |  0
>  .../renesas/r8a7790-sysc.c                    |  0
>  .../renesas/r8a7791-sysc.c                    |  0
>  .../renesas/r8a7792-sysc.c                    |  0
>  .../renesas/r8a7794-sysc.c                    |  0
>  .../renesas/r8a7795-sysc.c                    |  0
>  .../renesas/r8a7796-sysc.c                    |  0
>  .../renesas/r8a77965-sysc.c                   |  0
>  .../renesas/r8a77970-sysc.c                   |  0
>  .../renesas/r8a77980-sysc.c                   |  0
>  .../renesas/r8a77990-sysc.c                   |  0
>  .../renesas/r8a77995-sysc.c                   |  0
>  .../renesas/r8a779a0-sysc.c                   |  0
>  .../renesas/r8a779f0-sysc.c                   |  0
>  .../renesas/r8a779g0-sysc.c                   |  0
>  .../renesas/rcar-gen4-sysc.c                  |  0
>  .../renesas/rcar-gen4-sysc.h                  |  0
>  .../{genpd => pmdomain}/renesas/rcar-sysc.c   |  0
>  .../{genpd => pmdomain}/renesas/rcar-sysc.h   |  0
>  .../renesas/rmobile-sysc.c                    |  0

> --- a/MAINTAINERS
> +++ b/MAINTAINERS

> @@ -2598,7 +2598,7 @@ F:        arch/arm/include/debug/renesas-scif.S
>  F:     arch/arm/mach-shmobile/
>  F:     arch/arm64/boot/dts/renesas/
>  F:     arch/riscv/boot/dts/renesas/
> -F:     drivers/genpd/renesas/
> +F:     drivers/pmdomain/renesas/
>  F:     drivers/soc/renesas/
>  F:     include/linux/soc/renesas/
>  K:     \brenesas,

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
