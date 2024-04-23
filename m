Return-Path: <linux-kernel+bounces-155423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDC8AEA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336BD289303
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35013C810;
	Tue, 23 Apr 2024 15:05:48 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6B13BADD;
	Tue, 23 Apr 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884748; cv=none; b=IouaFfEhI5JFOjLh3iHzkk6DfrQ53CaqUuBR7jzQokDOr8v+YuivW9xufn2J9BT2ezO/t4GyJzAPT91dcWrQtY76beXRrxKs0RGN9dUQrdU99C8NLOsb37pIXS1U5igCZ0bfd/yi+a8mgua2qKphsKJhkH30/EbtYl3flaoWSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884748; c=relaxed/simple;
	bh=h5kV1l89BoEi9fDSpK7Gp7bev6cXdWjIrcXMe8EAFxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOhbKrw+K/QKmfJht9gpKP7/71iinoTQSWOxAcYKtQWzaLCOUfx3+Cx3RbWNi4Mvd72qXw1kODCYZeaeBV30Z6N0dqslzsQWc5Tr5rJTi+ejzslBhyFyEA41arz3ngPG1Mxi0/Xzpy7JX1cndTVNXdHnRS/sihxNcQQV3M6e3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ad2da2196aso2331436eaf.2;
        Tue, 23 Apr 2024 08:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884742; x=1714489542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAVYrqEHhFdWuNhEyQZKOUcz0r0/ZgTBbeGf7YkVpTw=;
        b=bT/euAxKkU9GbwJlm9WFGZlYBjO2GmwEU7xW5Yvup0tjaygrYhJBaK8TEffa/N0tXW
         mZtZJZOtP8R6U/4fxm7cfzsm084EGpcKpyX1yDj8/WpJ10iBbJvHsPcVxT8L4l6ovjus
         9wU9ugndeXeS4PnsYc/4PPaKALqGIffajeul0jh8F7rCED1CNEhylQCqGCHaeghAMhGE
         +iSo+Umu4obs9Mihupkip//o+Uj2gChjeUkNkEAOaWtQnCVSdtthtFXl8OcpixgKp0ya
         nknBXSuz3GurQdNyMZe0NZ2CzIkDFRt3HZ8gss9dYC2x5Fi/yOvdG1RpZxEBH4v93Ra4
         xItw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4RW5/UgIbOAPoNBFthz1iZR3E4R+cblw892YkX7HnkQo9JioulNIeyvgC88+DbHLPQ6+C/Fmd0rA0Nk/B0BJYiqgUpD/EvATpvAgI6jVVHBb9BtU2BVf2O+GyHX3Sc1BA8MVblKHPXSjaUnKWuHl21yf/VPWfJtur/zvpKZYc5ECDUo=
X-Gm-Message-State: AOJu0Yxn7vLydNhuxv/86Qf4+WovsuF6lzyugueVSV+lQjSj2bx1UyBC
	fIlhFS/S96MTe91f60dwDGmgZb9Mw0w4E0FMox9ZB8RZdWpQzKCcSuEMOXis
X-Google-Smtp-Source: AGHT+IGXHW6AudjriUZ7U0rbyVVeOreoHKa/wNFM1GRx5XBd1bjI8PswXDqWnXR/d9m7B7DV4ROSYQ==
X-Received: by 2002:a4a:b0c8:0:b0:5ac:5c89:2d08 with SMTP id l8-20020a4ab0c8000000b005ac5c892d08mr14998511oon.1.1713884742089;
        Tue, 23 Apr 2024 08:05:42 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id s68-20020a4a5147000000b005a48e64c699sm2627028ooa.40.2024.04.23.08.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:05:40 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5af27a0dde1so1335562eaf.3;
        Tue, 23 Apr 2024 08:05:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw/bORkETv/D41c6VoBm5srTy6YEBrXUUtObPXApu3+iKcMoKviPOI7kYIa7roZPtsaHuefScdmSzhncuCo3ex/BNsDqGqAxNtYHe9XEmF4GUFUbF/ggKaPTQ5wMZlKQViLHDD+E9yUHqy7E08Rf/QTXl53OyJELLgeXDhWPh+Oo/verk=
X-Received: by 2002:a05:6358:b5d3:b0:17e:6a5b:4d3a with SMTP id
 wb19-20020a056358b5d300b0017e6a5b4d3amr18788376rwc.8.1713884740245; Tue, 23
 Apr 2024 08:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422111123.1622967-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUXRx1-95PD_WG4X=y4UefYXzTqm7T2mi+di+ZdKGUXYA@mail.gmail.com> <3d8925a8-32ee-467a-aca7-d4a04f26821f@tuxon.dev>
In-Reply-To: <3d8925a8-32ee-467a-aca7-d4a04f26821f@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 17:05:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoK_qC8JPdRUQQZvNNLzuufWidxjee2HW7KrDGiNJCMQ@mail.gmail.com>
Message-ID: <CAMuHMdVoK_qC8JPdRUQQZvNNLzuufWidxjee2HW7KrDGiNJCMQ@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Call device_set_wakeup_path() for serial console
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, ulf.hansson@linaro.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Tue, Apr 23, 2024 at 2:47=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 23.04.2024 10:27, Geert Uytterhoeven wrote:
> > On Mon, Apr 22, 2024 at 1:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> In case the SCI is used as a UART console, no_console_suspend is
> >> available in bootargs and SCI is part of a software-controlled power
> >> domain we need to call device_set_wakeup_path(). This lets the power
> >> domain core code knows that this domain should not be powered off
> >
> > know
> >
> >> durring system suspend. Otherwise, the SCI power domain is turned off,
> >
> > during
> >
> >> nothing is printed while suspending and the suspend/resume process is
> >> blocked. This was detected on the RZ/G3S SoC while adding support
> >> for power domains.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> > If this works, we can remove the console_suspend_enabled handling
> > from drivers/pmdomain/renesas/rmobile-sysc.c, and revert commit
> > 309864dcf92b76fc ("genpd: imx: scu-pd: do not power off console if
> > no_console_suspend").
>
> OK, first I'll go with this patch and after things settles down with it
> I'll propose changes for rmobile-sysc and imx. Is this ok for you?

I have already made these changes to rmobile-sysc locally to test
your patch ;-)

It works fine on R-Mobile APE6, so
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

