Return-Path: <linux-kernel+bounces-44969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE428429CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E54B29ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E31292C9;
	Tue, 30 Jan 2024 16:43:18 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB4128391;
	Tue, 30 Jan 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632997; cv=none; b=fWQHKNl90SJZovR/qLBj9CiB7j/dxdOIb4Mhf7yat89nljpomHXGgFXuVSlRAgC8UyJNVL1A9R8+Ea4oSjJ+jT6jryQV7tqOZhPIelrI0V2BMnvLDAGZSq6P6NEa5R+IiYU2z3H+X/qIBguRT/zcAfPkWkm1rAOu3T/omNBFNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632997; c=relaxed/simple;
	bh=k/cw4o9Nkg+vVVqsgUAubQVLjRvLodDejnegtuMIjIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mdbs74K3DphyOxczPHeVryUcFcT9z7ts7JSvaFxWL8U2RJD7HF2y9LlnIIsq4LS401ieEcapf/YRHr6JgBL5gOStQi8scZuK4P65SA94TTDQgJJHLJcpHXqM36e4LTdaz1CUAEjU7AztA0z0wjhkCh+XomVSXcIsgc/t/RZjy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-602c91a76b1so50866077b3.2;
        Tue, 30 Jan 2024 08:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632995; x=1707237795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jG9RI5gp4dsbVA0rgVD5sIOvmapDxiObHhaU7j767x0=;
        b=ManDeQqSahSeO96sfkER4WvdJg/5l67hzIsU5mlkJx3GfHXUbWyuE8vucdSprRgAkD
         gxSTMZH5A+fNBqk7oIZI30E97xvohg2Z/Ww7AIlDImDAeo0tmaALO8tLiZQGpR9OsmaI
         Vqwws4xZHDkzhj4LcdoDJ7dir7PnXTIckJupj+CT1nu2/+quvTFulKStwP936JM784rF
         AIQjobnxzIyUVfbQwDMROJC7Xz7WWEfuCQR7duAFK8ecG53fA48IdX53MUKlH6AXqzQ5
         F/2Zf79BD5bxPpCOZxQOTGi4OnB4x5p4K971IuXweGeEjA/vniawUWx65MxeYC2fC0Rk
         oq7g==
X-Gm-Message-State: AOJu0YyLJr8pZFLSUUEQM4UzYjgMGXIX+EMUOJdcP+CbGaoIwTOhv64X
	yluvVWJvMcwl3IiQlELQ/eSZ0cSeLqPy//zV+IEZ49+B19OmFAHtOAOWqLSPqYU=
X-Google-Smtp-Source: AGHT+IHM2kLih245Lxq1nUdIxQnTza+R1zGhBTfH8dLrdFJF9CzQqLfT9d3tVcBLXxoOzR8B3uJpjA==
X-Received: by 2002:a0d:f4c2:0:b0:5e2:2bfc:c6dd with SMTP id d185-20020a0df4c2000000b005e22bfcc6ddmr7716297ywf.23.1706632994912;
        Tue, 30 Jan 2024 08:43:14 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05690c34c300b005a7d46770f2sm3235003ywb.83.2024.01.30.08.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:43:14 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-602c91a76b1so50865927b3.2;
        Tue, 30 Jan 2024 08:43:14 -0800 (PST)
X-Received: by 2002:a05:690c:830:b0:5ff:488c:9a6a with SMTP id
 by16-20020a05690c083000b005ff488c9a6amr7478186ywb.17.1706632994283; Tue, 30
 Jan 2024 08:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com> <20240122111115.2861835-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240122111115.2861835-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 17:43:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX+AN6a0KSnUfTRU5rmCyJBW_nqoqRsU+9ui6uMG-WdGg@mail.gmail.com>
Message-ID: <CAMuHMdX+AN6a0KSnUfTRU5rmCyJBW_nqoqRsU+9ui6uMG-WdGg@mail.gmail.com>
Subject: Re: [PATCH 02/10] watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Mon, Jan 22, 2024 at 12:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> pm_runtime_get_sync() may return with error. In case it returns with erro=
r
> dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get=
()
> takes care of this. Thus use it.
>
> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -123,8 +123,11 @@ static void rzg2l_wdt_init_timeout(struct watchdog_d=
evice *wdev)
>  static int rzg2l_wdt_start(struct watchdog_device *wdev)
>  {
>         struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> +       int ret;
>
> -       pm_runtime_get_sync(wdev->parent);
> +       ret =3D pm_runtime_resume_and_get(wdev->parent);
> +       if (ret)
> +               return ret;
>
>         /* Initialize time out */
>         rzg2l_wdt_init_timeout(wdev);

To actually handle this error condition, rzg2l_wdt_set_timeout() should
be updated to propagate the error to its caller, too.

Anyway, most of this is moot, as pm_runtime_get_sync() won't ever
fail on Renesas arm/risc-v systems...

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

