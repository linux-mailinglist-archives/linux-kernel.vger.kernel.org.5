Return-Path: <linux-kernel+bounces-24654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81382BFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30791C23508
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969E6A355;
	Fri, 12 Jan 2024 12:29:24 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E11F5F3;
	Fri, 12 Jan 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5edfcba97e3so69534417b3.2;
        Fri, 12 Jan 2024 04:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705062560; x=1705667360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61+Evgg1Vmw2HkVJsOdUzlpSbrHkjczepzLoD8ftGEw=;
        b=DSJ79EjAA0rakUyh4pJqJIB/PynAs/OAIUtzQQwjiy+PzzbL16WQYfRJjAmWZEyDJi
         x+pqn4cmjkQZ6+/SyxXU6n7/bdaWV6eO/kNRJB/7SJhuYKOJ9iQ71ANgNidPiJJfKzAw
         5D1/2ol176WmPC3eqf4NHfNPN4jazPnVKYmGO0iQJMwmRlKWfj1fT8griSMIaOSnCm7T
         CBs4FQJt/8roqnp3//ZZkziCt/yBLvcZttpcPBMGrJ0OMaD1xyd3NVir7mCqXW63j80N
         zJTauHeg2CBI7geFkKfy8Sag+k+O3STmDXJ+i+QMglKBSN732aprnfMj0bjq0F+vFiDq
         zZIw==
X-Gm-Message-State: AOJu0Yy+nBMwWC0lcIVo4Fd64DGI+gN5UQcn9mJ73vGV+ZROAyvBgQlh
	HIGTsIgU4kxwLuAniaDND/uNLKQCja+k+g==
X-Google-Smtp-Source: AGHT+IE7+0PduRjPzpJ/9+GpEHxwQCZvLhbY27qoAw0WoFGliebEuHaLNIs8x5ENbsk1CZWFAUG/Ag==
X-Received: by 2002:a81:790a:0:b0:5ec:38b5:3f8c with SMTP id u10-20020a81790a000000b005ec38b53f8cmr1092836ywc.91.1705062560542;
        Fri, 12 Jan 2024 04:29:20 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id cd10-20020a05690c088a00b005fb56881fa9sm1097336ywb.15.2024.01.12.04.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 04:29:20 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f3da7ba2bfso65697527b3.3;
        Fri, 12 Jan 2024 04:29:20 -0800 (PST)
X-Received: by 2002:a0d:d616:0:b0:5ec:ab18:ba7e with SMTP id
 y22-20020a0dd616000000b005ecab18ba7emr1276247ywd.3.1705062559134; Fri, 12 Jan
 2024 04:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112114147.1977955-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240112114147.1977955-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 13:29:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUoDhZSmD5rxhZ7t_DydsZ13UX3eHD3i-OaxDs9P6awAg@mail.gmail.com>
Message-ID: <CAMuHMdUoDhZSmD5rxhZ7t_DydsZ13UX3eHD3i-OaxDs9P6awAg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix change point of data handling
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, 
	yoshihiro.shimoda.uh@renesas.com, takeshi.saito.xv@renesas.com, 
	masaharu.hayakawa.ry@renesas.com, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Fri, Jan 12, 2024 at 12:42=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On latest kernel revisions it has been noticed (on a RZ/G3S system) that
> when booting Linux and root file system is on eMMC, at some point in
> the booting process, when the systemd applications are started, the
> "mmc0: tuning execution failed: -5" message is displayed on console.
> On kernel v6.7-rc5 this is reproducible in 90% of the boots. This was
> missing on the same system with kernel v6.5.0-rc1. It was also noticed on
> kernel revisions v6.6-rcX on a RZ/G2UL based system but not on the kernel
> this fix is based on (v6.7-rc5).
>
> Investigating it on RZ/G3S lead to the conclusion that every time the iss=
ue
> is reproduced all the probed TAPs are OK. According to datasheet, when th=
is
> happens the change point of data need to be considered for tuning.
>
> Previous code considered the change point of data happens when the conten=
t
> of the SMPCMP register is zero. According to RZ/V2M hardware manual,
> chapter "Change Point of the Input Data" (as this is the most clear
> description that I've found about change point of the input data and all
> RZ hardware manual are similar on this chapter), at the time of tuning,
> data is captured by the previous and next TAPs and the result is stored i=
n
> the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
> If there is a mismatch b/w the previous and the next TAPs, it indicates
> that there is a change point of the input data.
>
> To comply with this, the code checks if this mismatch is present and
> updates the priv->smpcmp mask.
>
> This change has been checked on the devices with the following DTSes by
> doing 50 consecutive reboots and checking for the tuning failure message:
> - r9a08g045s33-smarc.dts
> - r8a7742-iwg21d-q7.dts
> - r8a7743-iwg20d-q7.dts
> - r8a7744-iwg20d-q7.dts
> - r8a7745-iwg22d-sodimm.dts
> - r8a77470-iwg23s-sbc.dts
> - r8a774a1-hihope-rzg2m-ex.dts
> - r8a774b1-hihope-rzg2n-ex.dts
> - r8a774c0-ek874.dts
> - r8a774e1-hihope-rzg2h-ex.dts
> - r9a07g043u11-smarc-rzg2ul.dts
> - r9a07g044c2-smarc-rzg2lc.dts
> - r9a07g044l2-smarc-rzg2l.dts
> - r9a07g054l2-smarc-rzv2l.dts
>
> On r8a774a1-hihope-rzg2m-ex, even though the hardware manual doesn't say
> anything special about it in the "Change Point of the Input Data" chapter
> or SMPCMP register description, it has been noticed that although all TAP=
s
> probed in the tuning process are OK the SMPCMP is zero. For this updated
> the renesas_sdhi_select_tuning() function to use priv->taps in case all
> TAPs are OK.
>
> Fixes: 5fb6bf51f6d1 ("mmc: renesas_sdhi: improve TAP selection if all TAP=
s are good")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -641,7 +645,14 @@ static int renesas_sdhi_select_tuning(struct tmio_mm=
c_host *host)
>          * identifying the change point of data.
>          */
>         if (bitmap_full(priv->taps, taps_size)) {
> -               bitmap =3D priv->smpcmp;
> +               /*
> +                * On some setups it happens that all TAPS are OK but
> +                * no change point of data. Any tap should be OK for this=
.
> +                */
> +               if (bitmap_empty(priv->smpcmp, taps_size))
> +                       bitmap =3D priv->taps;
> +               else
> +                       bitmap =3D priv->smpcmp;
>                 min_tap_row =3D 1;

I know nothing about tuning, but should min_tap_row still be 1?
Or can you fall back to the else case if priv->smpcmp is empty?
I.e. can this be simplified to:

    if (!bitmap_empty(priv->smpcmp, taps_size) &&
        bitmap_full(priv->taps, taps_size)) {
            ...
    } else {
            ...
    }

>         } else {
>                 bitmap =3D priv->taps;
> @@ -706,7 +718,10 @@ static int renesas_sdhi_execute_tuning(struct mmc_ho=
st *mmc, u32 opcode)
>                 if (mmc_send_tuning(mmc, opcode, &cmd_error) =3D=3D 0)
>                         set_bit(i, priv->taps);
>
> -               if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) =
=3D=3D 0)
> +               val =3D sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPC=
MP);

The SH_MOBILE_SDHI_SCC_SMPCMP register is read even if its value is
not used below.

> +               cmpngu_data =3D FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNG=
U_DATA, val);
> +               cmpngd_data =3D FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNG=
D_DATA, val);
> +               if (!cmd_error && cmpngu_data !=3D cmpngd_data)
>                         set_bit(i, priv->smpcmp);

So better move the SH_MOBILE_SDHI_SCC_SMPCMP register access
inside the if (), and change the below to else.

>
>                 if (cmd_error)

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

