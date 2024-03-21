Return-Path: <linux-kernel+bounces-109801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7488855E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0020A1C20DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9BF1C6AD;
	Thu, 21 Mar 2024 08:40:28 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C656199AD;
	Thu, 21 Mar 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010428; cv=none; b=cq89opfaG2JM+vmQ3iYqXlmmVIA5mO135/eQ1Y2uozJ8o+3ox4/4hcG++P5i3pQEG2b03zECyxFhOliuLU1pxe016zm5Qj0yt8+cZYxbhlFwYafkaAqmfUjy2QN4Bb3qv826NIw/XW7fSHPt0/vxctHy9ck7Tv+sbvC4r9N7Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010428; c=relaxed/simple;
	bh=YHwQ9m7AV0bpNGFb7pHCjacXOY+tBeVpAXXkZnm6nzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsICBdS4FRBE1fWMA7KfIyeMNKzBizTmVwSU4P1nyuhmnrtPEnlGy4/ju52sGXCjIYFFdmHt7ZE+qonfJiDmQUxwjeRrB0MQldwDBtXFsRx/dklKoQOpiKNPHAyDD/Yjve80ZtMLHVeksM8ZckOLV4CLKetDpanBTdfp/a2We3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so692147276.3;
        Thu, 21 Mar 2024 01:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711010423; x=1711615223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn3mo6s9GVBqtYkFDcUV/e8RFS602uds1P5v/LgMCoI=;
        b=iocmExJzVVpHP6XNihiheh+kFJDl6KAIe9qylAytdMx4Se3jRjFDjC+dQb4z8DfRpM
         EvZW4I+rHu7X42XMyAWjxuolHlyW8OSIY69qWvj3TZm1C2DAUmFprjzREkgMtCuQ5Tf5
         LQQttp/ZqpccMbrbocO36Pa64uDcFmmvwkEAa71HWcMkXjvZxw1ncUuPM5sGZledoqjL
         /vMznynJeZSKumD3HLbDXBa+igltX7kXF4MWUoX/54LKsV1uE6npVBd0LpNPrfxTCNwh
         /HNVc6hrvaM5PFNTh1Qr9GAvXR+Yxo3c6olRZZheABCXTMe519c+i+f1Deod2IOX/3YL
         WC1w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3Dw3brRF58SPhbfx3bkdUhK0b/aCut/8xTLDlLpcnMeEIug9v1zr9KQCclIRQ/1+vb/8T2s3vQQlU96+XyjnKXKp7rf7V+7PB+vpvRzYhjqM3STNt/p/9XoOoPnmrtKYY/N3C9EjkMir+haHxyE=
X-Gm-Message-State: AOJu0YyfkxZ7cqT530475BV7KCvDlm5iwJY4knLaRGuldSO7BpQKyk98
	5vybQBPul+3j6jETy+JTqZmnV7+4K7QnjUWq+VbRODiQvgcaqyu0vqpXRToa4WE=
X-Google-Smtp-Source: AGHT+IE7yLA0Gxs+BPrOc1XxhxrHEK6wMPCCWL/mkles/pOmww9mikfzHRC646tsOyO2390pQzloIQ==
X-Received: by 2002:a25:8e0e:0:b0:dc6:ff32:aae2 with SMTP id p14-20020a258e0e000000b00dc6ff32aae2mr1037739ybl.63.1711010423159;
        Thu, 21 Mar 2024 01:40:23 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id g21-20020a25b115000000b00dcf35be9f51sm1912545ybj.24.2024.03.21.01.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:40:22 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so615978276.1;
        Thu, 21 Mar 2024 01:40:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4Jj5VVQSvqaj2TefHRgckcLEEbYrJFF5uJk42iGbbm1r9Zm+WZ3J49co0kAtmwQmPJzjG9heZifAfoj30Oite7b2Gfu/xmqmj3o/nLcNjLX2/FGBLQpPwgdt9pfMI31iXwRzHxtv9nZ0ebWIkxJ0=
X-Received: by 2002:a5b:49:0:b0:dc7:4ba0:9d24 with SMTP id e9-20020a5b0049000000b00dc74ba09d24mr1024320ybp.59.1711010422055;
 Thu, 21 Mar 2024 01:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd027379713cbaafa21ffe9e848ebb7f475ca0e7.1710930542.git.geert+renesas@glider.be>
 <CAGETcx_KNvY4NyQ+HSfkgVJS625R-LVNh_tsoZMM0or78ryEWg@mail.gmail.com>
In-Reply-To: <CAGETcx_KNvY4NyQ+HSfkgVJS625R-LVNh_tsoZMM0or78ryEWg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Mar 2024 09:40:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXU18iF2fnacbBw9UG6of8CpjbGaNqnB49w044iboWCyQ@mail.gmail.com>
Message-ID: <CAMuHMdXU18iF2fnacbBw9UG6of8CpjbGaNqnB49w044iboWCyQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Avoid reprobe after
 successful early probe
To: Saravana Kannan <saravanak@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	=?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, 
	Paul Cercueil <paul@crapouillou.net>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Wed, Mar 20, 2024 at 9:18=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
> On Wed, Mar 20, 2024 at 3:30=E2=80=AFAM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The Renesas OS Timer (OSTM) driver contains two probe points, of which
> > only one should complete:
> >   1. Early probe, using TIMER_OF_DECLARE(), to provide the sole
> >      clocksource on (arm32) RZ/A1 and RZ/A2 SoCs,
> >   2. Normal probe, using a platform driver, to provide additional timer=
s
> >      on (arm64 + riscv) RZ/G2L and similar SoCs.
> >
> > The latter is needed because using OSTM on RZ/G2L requires manipulation
> > of its reset signal, which is not yet available at the time of early
> > probe, causing early probe to fail with -EPROBE_DEFER.  It is only
> > enabled when building a kernel with support for the RZ/G2L family, so i=
t
> > does not impact RZ/A1 and RZ/A2.  Hence only one probe method can
> > complete on all affected systems.
> >
> > As relying on the order of initialization of subsystems inside the
> > kernel is fragile, set the DT node's OF_POPULATED flag after a succesfu=
l
> > early probe.  This makes sure the platform driver's probe is never
> > called after a successful early probe.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Tested on RZ/A2 (after force-enabling the platform driver probe).
> > Regression-tested on RZ/Five (member of the RZ/G2L family).
> >
> > In between commit 4f41fe386a94639c ("clocksource/drivers/timer-probe:
> > Avoid creating dead devices") and its revert 4479730e9263befb (both in
> > v5.7), the clocksource core took care of this.  Other subsystems[1]
> > still handle this, either minimally (by just setting OF_POPULATED), or
> > fully (by also clearing OF_POPULATED again in case of probe failure).
> >
> > Note that despite the revert in the clocksource core, several
> > clocksource drivers[2] still clear the OF_POPULATED flag manually, to
> > force probing the same device using both TIMER_OF_DECLARE() and standar=
d
> > platform device probing (the latter may be done in a different driver).
> >
> > [1] See of_clk_init(), of_gpiochip_scan_gpios(), of_irq_init().
> > [2] drivers/clocksource/ingenic-sysost.c
> >     drivers/clocksource/ingenic-timer.c
> >     drivers/clocksource/timer-versatile.c
> > ---
> >  drivers/clocksource/renesas-ostm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/r=
enesas-ostm.c
> > index 8da972dc171365bc..37db7e23a4d29135 100644
> > --- a/drivers/clocksource/renesas-ostm.c
> > +++ b/drivers/clocksource/renesas-ostm.c
> > @@ -210,6 +210,7 @@ static int __init ostm_init(struct device_node *np)
> >                 pr_info("%pOF: used for clock events\n", np);
> >         }
> >
> > +       of_node_set_flag(np, OF_POPULATED);
> >         return 0;
>
> Couldn't you also solve this by using the more specific compatible
> strings for the driver and TIMER_OF_DECLARE()?

That's another option, but would considerably grow the number of
compatible values to match against.

Note that the actual OSTM module is (assumed to be) identical. The
differences lie in the integration into the SoC (wiring of the
module's reset). Hence using the compatible value to differentiate
looks wrong to me.  It would be nice if this could be handled
automatically, which is what the reverted commit 4f41fe386a94639c
("clocksource/drivers/timer-probe: Avoid creating dead devices") did...

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

