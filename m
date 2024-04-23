Return-Path: <linux-kernel+bounces-154603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B91738ADE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46602B2143A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF846B9F;
	Tue, 23 Apr 2024 07:27:58 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10B1C698;
	Tue, 23 Apr 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857278; cv=none; b=RnP0Lq7vmhtPcbnCm3Rst25vUiiM3spvsIJVw9A6zTpJ16sj923B/6/jITRID7aaQe3InhM7/aOgTFrrJrN9B/MUCsQ75ZNZJdyRWxawlSlCKP6UAhqlYUxAiWaNvoz5Slcbi7raH1SMfkQmL6V8o1rUXUnWF2mK9v6ztYCO+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857278; c=relaxed/simple;
	bh=WCE297pXyCGDdhhfCD0olqnd+53OCM/7N0xDi3vCiKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W77uO7Wj+M8jDQ4AE/SSYTIS/7YRoC6de6Ciy6e731OUb57URT6aR67qrBSOa9ySbEF7H2V3ogwtsrinT59m+kVkuAKWLMCTR565B1lV0Gz/VUZ9NXsslR2DpcO8clz4HDn0gq94dMuE3ZPXJg/STXDuJ0kK/SSgcMI+xY3relg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61b4387ae4fso34613037b3.2;
        Tue, 23 Apr 2024 00:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713857274; x=1714462074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAJUv+Bt0mn8NDZY50gq/EY+6KHjPMT7UvJ7vKHp6FQ=;
        b=wlkrGejcmBDeDkjLXeZ1ZPoEmkqDEM1Sgf+neyPmDFKULg8yr1rl/zIdtcU74msnwl
         wzJyTWJUNOul9Enq+0Pxff4xsj4qQjkBaGA81teTBt7zJx4voqaWb3yCIpeS1KxV5PJj
         6eg5A8ck111pVbSEZUU7q6Lg4qHD6oMKQqC7E78lcN/yGbQq0VD6n65XZDFtrzL4iYof
         775x6GPiBHLPNVeXxVpICpKonawWYd3GFL7zTP+XeVER47CkKd+Q6ENNdrFEDrgjRh/K
         m/MftvkdZRGgtaiSnBv6kIlykJs++sVlRURBynSvS+fzV6Xb+WLNMunjyZdyhSmuIAlB
         t9dw==
X-Forwarded-Encrypted: i=1; AJvYcCXIWNDx6Zxq82Ke0GEDIzlQNn1w/7FXAYYFT4iP2u8HoOxfNJUlr3rNOJQc+HeJpDymE9dF1gVJlPZS5/Yg//IL+h62S7g9pf9uw96j4FuvQ/bXPeq8zt940rkEJ325AVGjEXbJ/3hs6PeuXTuVEVAqynivpEIEne4M05yOa0V9KFeVmZg=
X-Gm-Message-State: AOJu0YzcqqEIRKG8i3uXY5D1tvFaHYtFut3S5wZfD4u5sEsGrf6m8VR5
	wZDhC34r6zxuWBKhj3PET1qHLWS5/4avtpn91uoy0Ut9GpJK04EhDzd+xBYI
X-Google-Smtp-Source: AGHT+IFu+WZtOTgIRKVC7zH0MysdWnKL7gJp/2tpJONE4B2UX256YUC11BeSiqFiW4i8AboacqcVtg==
X-Received: by 2002:a05:690c:3810:b0:61a:c4a3:8a5c with SMTP id jx16-20020a05690c381000b0061ac4a38a5cmr14438523ywb.44.1713857274025;
        Tue, 23 Apr 2024 00:27:54 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id a16-20020a81bc10000000b0061877ef0f7asm2343678ywi.44.2024.04.23.00.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 00:27:53 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de54b28c41eso662857276.0;
        Tue, 23 Apr 2024 00:27:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSA0DTctmHkkKRg7WYkb3MG2LMmgd2qwNq56wlYmzaW2yYBT6eyaTMEkmR3yShM3+ALuFz0oTxq4XuL/KBinIQM/C09wknAhCp8JldgkW3GOoyCcCad/HuRvkO+AF3MSZm1UTyA6EcXoR9aSAMrCEtJCpAZE5B6oR0WpaZue36eavJf/Q=
X-Received: by 2002:a25:d655:0:b0:dcc:58ed:6ecc with SMTP id
 n82-20020a25d655000000b00dcc58ed6eccmr12671072ybg.41.1713857273097; Tue, 23
 Apr 2024 00:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 09:27:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com>
Message-ID: <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial console
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, ulf.hansson@linaro.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

CC Peng

Thanks for your patch!

On Mon, Apr 22, 2024 at 1:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> In case the SCI is used as a UART console, no_console_suspend is
> available in bootargs and SCI is part of a software-controlled power
> domain we need to call device_set_wakeup_path(). This lets the power
> domain core code knows that this domain should not be powered off

know

> durring system suspend. Otherwise, the SCI power domain is turned off,

during

> nothing is printed while suspending and the suspend/resume process is
> blocked. This was detected on the RZ/G3S SoC while adding support
> for power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 97031db26ae4..57a7f18e16e4 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3441,8 +3441,12 @@ static __maybe_unused int sci_suspend(struct devic=
e *dev)
>  {
>         struct sci_port *sport =3D dev_get_drvdata(dev);
>
> -       if (sport)
> +       if (sport) {
> +               if (uart_console(&sport->port) && !console_suspend_enable=
d)
> +                       device_set_wakeup_path(dev);

device_set_awake_path(), as of commit 10bb4e4ab7dd3898 ("PM: sleep:
Add helpers to allow a device to remain powered-on") in v6.6
(although I'm still a bit puzzled about the difference).

> +
>                 uart_suspend_port(&sci_uart_driver, &sport->port);

I think it would be better to make this more general, and move the call
to the existing console_suspend_enabled handling in uart_suspend_port().

> +       }
>
>         return 0;
>  }

If this works, we can remove the console_suspend_enabled handling
from drivers/pmdomain/renesas/rmobile-sysc.c, and revert commit
309864dcf92b76fc ("genpd: imx: scu-pd: do not power off console if
no_console_suspend").

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

