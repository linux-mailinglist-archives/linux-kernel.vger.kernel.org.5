Return-Path: <linux-kernel+bounces-158146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562648B1C27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A38B23332
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628876E5F6;
	Thu, 25 Apr 2024 07:48:56 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCE5D477;
	Thu, 25 Apr 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031335; cv=none; b=MfiNw1Ic6mKVDn9nuJYW8B7em7lEVoNHzipyJHJ1Z6MuOmuKhUsI/VHHUKqe7r0II238hm0j5xST1RepoMbHiqyKSjBirDi/Z3hNJfwJpHSa9cx1MmGvZ2kTjyHScAi+YG80qrhawD9J1P0Vl88LseYhZpVsORAywduncAYa+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031335; c=relaxed/simple;
	bh=QWzMqnvNDE3uWpTxgV5Wt0uL05nTU10AMdyKsaDyklo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erq9r3H6ntdhqxpOFq9UnIwMUtT9WXcA8NBggdrGotswXbrHpMtjnTDROcgg2WVlaRV9Q/9ciGhMTVWsVrieaLNiEdylD9KfeqJpPGJUjLmkz4vEwNQf4wYVWYbUMmR/v69n9ffbFOv66Nw7Ic/e+LSbvgOaSB2TB9cfBjrwkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617cd7bd929so6972277b3.3;
        Thu, 25 Apr 2024 00:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031332; x=1714636132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCeLs5NAma1XU37XgksPfxny5o1JTn/LLmRqHaQAAv4=;
        b=oBTZ/fM+KgsoyB6VwO+2xK6hqHtiXcghR+qvILjU7p5ICnoi2zNFMqQZEJUnYD2ZFe
         ODZ8uBCLBW/+pTauzs9Nch2CHbDEdOJnXDDZ7vFvqsiJs5FjhmqhD0TTsjiX6o+ZABLB
         MqeM/f5VhREVHK2sXsCUZMT505PzRqVC9x9qxoy6uefmjlsg5+RtOMSzAhnLZpLcZyt5
         +ieCj6eWidYQjwzKtp+YXG8I86lUg0M8BemwTOM++uq5EcxDnhf/UCs+tSgAQSPxkk+Z
         j6tsFCdf/XkD684u6vnv7f0OGevERxRQPdwCvQDo17wEpK49jAhzQITlmrS8vv0eVeH+
         bpqA==
X-Forwarded-Encrypted: i=1; AJvYcCXjoI9DSIO39MCFkBW4GB8avXjTsTUTQ4HEbnmQE1JOnaCJyW8MjhYR7JTlpIsopiLQdpL41J+QpGsy68wfHwVPchlCjKm9RQ164GmrvKJWyecREB8xM7gFJVsrDtxA9D9h2cM15M/L8ODZ/icDOiC1M9FsT2fypgPf5KnD3tbvgWrKQVU=
X-Gm-Message-State: AOJu0YzQjJMUiKJ1MDL+xgC+Q57rSGHbrCrKv0EvpMl5iq2H2yel9Zir
	n17A/QjliZ/p2RmqHf2qeS4oAm0WoE3RecWCgy6BeLnk93gLQj/2i5MZuSNyfCA=
X-Google-Smtp-Source: AGHT+IE8f1uBQL5109KAnWBYTJPPcWetC/Iced96NtbTjIMA1h56Su4gVQVTQW5GAZS82XBh7TnJJg==
X-Received: by 2002:a05:690c:64c3:b0:61a:dc61:25e2 with SMTP id ht3-20020a05690c64c300b0061adc6125e2mr5247377ywb.49.1714031332194;
        Thu, 25 Apr 2024 00:48:52 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id y76-20020a0dd64f000000b00609f4170662sm3444253ywd.54.2024.04.25.00.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:48:51 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6184acc1ef3so6633687b3.0;
        Thu, 25 Apr 2024 00:48:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqzvnLZ8UI4QbwgPaqbVZqQymjU2WOO1r8Z04I7cVK+BGwlU9DyNL/8YvCugB6ZqwYfF9Myoym4kfjHnandmfM6KIo/MtISDxTuMXf/WROio32h1I5ZJ5vdpMH85qP4/Elah6pk754IlgKDWe0H0rGkFR5AtCTUTks6iU/Ec6w+g2wAr4=
X-Received: by 2002:a25:109:0:b0:de5:5aaa:7881 with SMTP id
 9-20020a250109000000b00de55aaa7881mr5977202ybb.49.1714031331725; Thu, 25 Apr
 2024 00:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240425070936.547100-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Apr 2024 09:48:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_uojDmx3pH--KsBcae=1VmcNupedGBwovVQcU+z14sg@mail.gmail.com>
Message-ID: <CAMuHMdX_uojDmx3pH--KsBcae=1VmcNupedGBwovVQcU+z14sg@mail.gmail.com>
Subject: Re: [RFT PATCH v2] serial: core: Call device_set_awake_path() for
 console port
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, tony@atomide.com, 
	andriy.shevchenko@linux.intel.com, l.sanfilippo@kunbus.com, 
	tglx@linutronix.de, geert+renesas@glider.be, ulf.hansson@linaro.org, 
	peng.fan@nxp.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 9:09=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> In case the UART port is used as a console, no_console_suspend is
> available in bootargs and UART port is part of a software-controlled powe=
r
> domain we need to call device_set_awake_path(). This lets the power
> domain core code know that this domain should not be powered off
> during system suspend. Otherwise, the UART port power domain is turned of=
f,
> nothing is printed while suspending and the suspend/resume process is
> blocked. This was detected on the Renesas RZ/G3S SoC while adding support
> for power domains.
>
> Based on code investigation, this issue is present on other SoCs (e.g.,
> Renesas R-Mobile A1 [1], IMX8QXP [2]) and different SoCs have particular
> implementation to handle it. Due to this the patch added the call of
> device_set_awake_path() in uart_suspend_port() instead of having it in
> the platform specific UART driver.
>
> [1] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/ren=
esas/rmobile-sysc.c#L116
> [2] https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/pmdomain/imx=
/scu-pd.c#L357
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works fine on R-Mobile APE6 with console suspend support removed from
rmobile-sysc.c
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

