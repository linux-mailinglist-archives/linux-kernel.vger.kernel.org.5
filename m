Return-Path: <linux-kernel+bounces-103546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94487C0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4FAB21E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5573517;
	Thu, 14 Mar 2024 16:07:08 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6636FE3D;
	Thu, 14 Mar 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432428; cv=none; b=JMSu8cHJNpM4MXz65LpW9SXV4UF2+Lt35rn9Ykyw5ZvC0AZc4Lm8eWm8dyklrii9pd8nzobmJ+mBFgMVyPZstNW61xsSWmSPhq0wxqUNm0Ow7AIyy+Z3kvj2B2KQCybKV75yDMhSscey8lX0EDotA7G/gJHjfLxW0TVVN3mp0EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432428; c=relaxed/simple;
	bh=MDzpk43eh22P0R0NApZDUC71UiIaKJPveQH1+Xl1c64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WX5lrFjhdh3C93h8LdXPfrYXT9lcMgL4wGkukThMGxhU5+y8WfzeprDPSIWHXhJ89S/yM084yOSBPAB+As8CwL7d47E3ZX7bA4E1JXVw/7Wd1L0a6KAMDhUONB3Wd9L5c6xxbZezEphZ0prxmIZVyBg1RcGAbPDXW7mAkL0ptf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a068e26d8so12899667b3.3;
        Thu, 14 Mar 2024 09:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432425; x=1711037225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqZ3MmEp1ebJVjVSy3ZynzzAJyoVBhTKqkJI8M7G840=;
        b=smZFHM5/FEzd2Odhgju7Yzl07Rugmj7VmCleWB6H9+oceqUATLWMxAEkD4NxK2PNF+
         DLycubrhLPuoPQFeTElFAJKH1XscdLxooiDd13JPQFrXvekqT4bPCBDAFgr9wfMHGGMr
         dA9NFRg3uRjfDaXsFIftXmFQaeClSmLIhA2JhmdgQjryoWc0hLPhMC+h5Pp8eXS1rL1o
         J3Mo//XFXieNik0nlJHKB7kPjVjEY6O23g/Cqm74+6Yarw7b4GQ5RvO0prz6UiOmf6vF
         wPwuLIBG8HjCh1Wk6nZ2d1fay6VWijTgx1+VARnIhI/i7q0rt9930RRbZtbxxSNQxvFG
         gEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRah9KKCShZxKhatMGsSSoRphhD8spOEvQ+RhZTN14lmKeZ+dal+8Cmqh0NmYDe++BDuhgLR08ZmVFbvv4+R4wbO70Cc7eQ2lecT/DKW/v+xmgZZLbJLHjMLGdSa4qmZIZ0e/PRm+HBA6Bl+5MtMpTnVe0UDls0/xydZoxCifg/fRD0viPWlOn5E4V/0r0qJ3FIXZr2L9Y6exBnP7U8U4tzrhXqCB5
X-Gm-Message-State: AOJu0Yweatf8RKffnvWls/RWjeVGTMFlb37AtRi6/fJhIk3RENqbWBAn
	EHOefkDhbLSqfgZVpJV7yn9riaL/ECx9Es7gvjpPvIcIzbww9qB63D2kfOtFnw4=
X-Google-Smtp-Source: AGHT+IHrgr+zeOkNEG1h6Ve3AnEIAP4R3GhDXV5XIXwOlt2gea9PGSzLxggdT4IujJFYAlEaGrPm2w==
X-Received: by 2002:a81:4849:0:b0:609:f87b:aad3 with SMTP id v70-20020a814849000000b00609f87baad3mr1246327ywa.31.1710432425274;
        Thu, 14 Mar 2024 09:07:05 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id eu10-20020a05690c2e8a00b0060a545e4d8bsm315956ywb.103.2024.03.14.09.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:07:04 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a0579a931so11776227b3.0;
        Thu, 14 Mar 2024 09:07:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwMBAdorMcdRofo75YK5vmeyOsSsv8gzvSo8SZOjLyba3JNm/zm9hLn+1lii8MeWcjfDHa6hOl/Fnq1Kj8noogolEvY8G4gJqEgYcuZ9mpFLqHbjUWgMOyIvrkKWcgr1iU6EX5hHxXVfpZ7JOAbDZ55NFXqj6MbmLDyeA+CibHa6a4tU9bUoZF5Pw3mZuPx1GVonT1oeNiTO+JwtXiJCrhcKc52nhD
X-Received: by 2002:a0d:f184:0:b0:60a:b48:e467 with SMTP id
 a126-20020a0df184000000b0060a0b48e467mr1081886ywf.25.1710432424284; Thu, 14
 Mar 2024 09:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-10-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 17:06:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJtBNBqitJ3-5zC9JAJSZvP+4-9wOK9p8OO-OR42dUqQ@mail.gmail.com>
Message-ID: <CAMuHMdXJtBNBqitJ3-5zC9JAJSZvP+4-9wOK9p8OO-OR42dUqQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] clk: renesas: r9a08g045: Add the
 RZG2L_PD_F_CONSOLE flag to scif0 PM domain
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Mar 7, 2024 at 3:08=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZG2L_PD_F_CONSOLE is used by the rzg2l-cpg driver to check if the
> SCIF domain need to be powered off in suspend. This is necessary when
> no_console_suspend is available in bootargs as we want to still see
> output on console, thus scif0 domain should remain powered on.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -293,7 +293,7 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a=
08g045_pm_domains[] =3D {
>         DEF_PD("scif0",         R9A08G045_PD_SCIF0,
>                                 DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1))=
,
>                                 DEF_REG_CONF(0, 0),
> -                               RZG2L_PD_F_NONE),
> +                               RZG2L_PD_F_CONSOLE),

This is not really correct: if SCIF0 is used as the console depends on the
use case, i.e. on chosen/stdout-path.
So this flag should be set at run-time. You can check the power-domains
property of the node pointed to by of_stdout to find the PM Domain that
holds the console, cfr. drivers/pmdomain/renesas/rmobile-sysc.c.

>  };
>
>  const struct rzg2l_cpg_info r9a08g045_cpg_info =3D {

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

