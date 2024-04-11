Return-Path: <linux-kernel+bounces-140740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C28A1893
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26371B28F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255B14A9F;
	Thu, 11 Apr 2024 15:21:15 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBAE55F;
	Thu, 11 Apr 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848875; cv=none; b=W3bqZFUBOh4CrsGjVj7gVmzAxgx/XwdBWXsGLfaW0PumIDnzUeoz9DBdFLRHApxewbt03K7FsWsMfK3GNTPVTOHWR1denoRjW6XmRs/iZkrFUewEj8FQioKJhNFFnW2hcqFZdY3qYe4tiYKN9/Sy3tlqVdm03Sm9nDUZyZ0Gqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848875; c=relaxed/simple;
	bh=RJssVZ7udHxHo3Et4hZ7dfRETRPZhl3bmJL+mnWNB7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUBAO6eaFug28GF+ZZZePEgu09jUipjlhXBgtjDWzhgA8kMpP62tx7W3Sjhb0C0g2vr0QdgZVU22oOJrbzouyxeuBSksfbjgb8uIsFXJ3cR6UPrB0TwKFUmhrXznE6WCRLVVp38aRD0GRRStEYGc1G3jhNvkrvszGUp8GJRs4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea1d2c1d58so2131774a34.3;
        Thu, 11 Apr 2024 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848872; x=1713453672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvwCFVAdeanbRP1IDnrbTtt4W//JJjkKoqgQmst2hsg=;
        b=IqJ/5n1o2wjLT2F2jDfAarQimsxBD6sLd5/s7BGK42yGILp9lyN4hPctjzln9ov4Oj
         t3J9wyZZEWMrwg4Jc/0DK1fOS6tpu30zrZMrzg6j224iVkwqHJaReBf0UrXnqksa4go8
         LZZTGa1Vue5o0sUoyp7NuvIcvOIQP3ksNdZvpvxqHXU1GYhY5CRMF0fIbt0DMKZdUUuN
         KU+TTIbJmCB32FqOjTEj8xB2Qg8ai/4JG0V520SahLEiAoBUUS+SaYrdybMCzwUohBcA
         fbNAG+UH26CFeCiy6Gpcs0LjoO/xYqrrfs1xnzOWe9qbTWdU66mcgHIsMwVmDv/27PCR
         qPSg==
X-Forwarded-Encrypted: i=1; AJvYcCWoV9aDXZNRN2YxqIeN/HxK86V9JuJEpp18BkV/YVuwC2LKrKkUH/rvnyCAyIncN3aaIScf8MBgfjLU/lgqRjdYyMDcWePwfj6XBmmKyfrbQboa742ddkqwh76GdbJieboqk9pmFOVr9V9CLNIuhfAiIEurXkMhqizeCzItDvSMCnvPoiWl/5/M2tNOAm7ULNqa7FmB8k/hLCTbBF4VMr3Bc0O+ohpaFwBqHAyIfCUJeGIhBadxpHJbfeCz6R0MXUGj9AuwCw==
X-Gm-Message-State: AOJu0Yy992Hzg7PNa99UOSYIrQ6HgkF/F8Va/dP17FVTxlCwmIr5IEXT
	XrGPLNSpHZmhmvZBA3APhOJmXgHeANkIo42SThTnNFNOMEmB5XzLVH2f8Wr/
X-Google-Smtp-Source: AGHT+IFKatdvmiB7Q+dm5pkiFASZLvgcLBXvJO2C6iEi0l0sMqlgKEeeFsuI9Ng5fXBBFq/U1y2uzg==
X-Received: by 2002:a05:6808:8d8:b0:3c5:eeb5:c6e2 with SMTP id k24-20020a05680808d800b003c5eeb5c6e2mr6356039oij.36.1712848871698;
        Thu, 11 Apr 2024 08:21:11 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id j8-20020a544808000000b003c5d2c04a52sm251045oij.34.2024.04.11.08.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:21:11 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c6efac587eso53490b6e.0;
        Thu, 11 Apr 2024 08:21:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7C0vdcdCbkj31EXVhBXtFKjQluSIPlaOVqa0fbEniozH39Mic6yPRTSa8mA7DVKOZK2VJcQrLUX1TBEzTTn4FLP8GuQmo/MUO3SbmxiLqyCw0Uc4Y7h4012WpLOm9E3+P/RmnfC9h4pabCwPyA/LTJk/yrLRfqVnU4VTkuT6MaMVpw5pn8frWSGm+nevFuM2z9bw4m3phDk7IrGetuSFqrR57FLfeqlZag9cjY0hp803XgLTnf3XAlEpvk36/e1NsQfugQw==
X-Received: by 2002:a05:6808:2228:b0:3c5:e2dc:8a6a with SMTP id
 bd40-20020a056808222800b003c5e2dc8a6amr7491416oib.24.1712848870629; Thu, 11
 Apr 2024 08:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com> <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 17:20:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-SOzs87+ErfGCcw1eYaaDqsLc4++fNUbTsVrkFqyHPg@mail.gmail.com>
Message-ID: <CAMuHMdW-SOzs87+ErfGCcw1eYaaDqsLc4++fNUbTsVrkFqyHPg@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
 domain in rzg2l_wdt_restart()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	geert+renesas@glider.be, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

CC pmdomain

On Thu, Apr 11, 2024 at 1:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt_restart() is called from atomic context. Calling
> pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
> APIs is not an option as it may lead to issues as described in commit
> e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
> that removed the pm_runtime_get_sync() and used directly the
> clk_prepare_enable() APIs.
>
> Starting with RZ/G3S the watchdog could be part of its own software
> controlled power domain (see the initial implementation in Link section).
> In case the watchdog is not used the power domain is off and accessing
> watchdog registers leads to aborts.
>
> To solve this the patch powers on the power domain using
> dev_pm_genpd_resume() API before enabling its clock. This is not
> sleeping or taking any other locks as the power domain will not be
> registered with GENPD_FLAG_IRQ_SAFE flags.
>
> Link: https://lore.kernel.org/all/20240208124300.2740313-1-claudiu.beznea=
uj@bp.renesas.com
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -164,6 +165,17 @@ static int rzg2l_wdt_restart(struct watchdog_device =
*wdev,
>         struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
>         int ret;
>
> +       /*
> +        * The device may be part of a power domain that is currently
> +        * powered off. We need to power it up before accessing registers=
.
> +        * We don't undo the dev_pm_genpd_resume() as the device need to
> +        * be up for the reboot to happen. Also, as we are in atomic cont=
ext
> +        * here there is no need to increment PM runtime usage counter
> +        * (to make sure pm_runtime_active() doesn't return wrong code).
> +        */
> +       if (!pm_runtime_active(wdev->parent))
> +               dev_pm_genpd_resume(wdev->parent);
> +
>         clk_prepare_enable(priv->pclk);
>         clk_prepare_enable(priv->osc_clk);
>

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

