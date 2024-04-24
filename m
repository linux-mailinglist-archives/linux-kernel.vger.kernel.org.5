Return-Path: <linux-kernel+bounces-156658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697B8B0667
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F9A1C228BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB2158DDC;
	Wed, 24 Apr 2024 09:49:15 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB3158DD0;
	Wed, 24 Apr 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952154; cv=none; b=tLe+TohMLjHrxxLTPiDAZLr8V3ZMQvNL4Pr9c2pwqWm2hkFAIYyhDzRJWfoidt1wli2LdA7MJKjWczetIIFjHeMyVIQ46FiuWLLkEuClKPO7wB7SsWT9WFbWg2YLYxZbUJ26eHD6Nka1jSs8LbJmKOXfpT6NvVjlxlBQ7kEqqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952154; c=relaxed/simple;
	bh=u4lx/JULd5SMfiKzIJbC77K4KRfvpML7qMWfMAaioYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2gdxJAKM09qO6j/olhEgNinNv3v++7CBqA6+G6roNS0uWTV4edrrtgwyI0r/uoN9lyN4f8tlf0HfZ4ynFonhsIdu7O25MompuJ0mxwCmj2qgoJ9d56oQhZZnr4FBajRYH0a/vu6+k91MLH6Mk1CAv4oP5XqjONyghOVvirBYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6164d7a02d2so77061907b3.3;
        Wed, 24 Apr 2024 02:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952151; x=1714556951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hEIVy3ACld9hvMVKRp+y3fj+DcJwYS/FFKJpxDdjEk=;
        b=pHKZ4hWJuPcjwcvyjratQ3RaLJgo06y9lX8aYOI1923An0zQHhzOWxMjvyRMTme7np
         44Gfd96Uq+NR++TGXIi5JYZ0an3vvI7faY52tVV6HuKBK6tCPjcYbbJtn25UaHlIpglx
         TMJsUBY4ozFedyErJcxfj+T1OAf2w8UzQBxngxIssT9QpZR5UzSQEEnHKiSd/Fun8LM+
         CA965R8gmVCVttCAqxYzSm8+MQBX3u53eMLMK1AcNhyTNfrY8frq3lSDRrhHOAei5dh9
         2751PEog24WQXSWVCervNd57yX4cnxRJh0M/7mGw/9M/abEC6khK0cPHOCoQKWATFlmv
         7WPw==
X-Forwarded-Encrypted: i=1; AJvYcCUbmiQ3ZVRHP1m/ePvgygKx0517qQibNry2jDvkPEgSITPWNnt9AqUEQn1GFSxambur6L3D0kcMgMiHjLSYEXtcVYSG34oDxCVFq6dPDpGVefWrNZ76HGDJB47a5oHsUTR1fsHYQyUWUXj2
X-Gm-Message-State: AOJu0YyMjZOkyEmfNnnUQARtFeBoRpEWnKe0vVXNl+LrI2b8nhWrz8Hu
	Z+KElyO3l/LA2bmAMNHcr97Gw51G2lbBEJGTvv4eG4aswLFqGB+aUQC79E49
X-Google-Smtp-Source: AGHT+IH1iqlvmzpGDqai+9wt7Uee4X8myKBxX98jbIgMafOaNXdduo1g5zc/B5bvH3eEPvukJrk6DA==
X-Received: by 2002:a05:690c:690f:b0:615:1527:aa2 with SMTP id if15-20020a05690c690f00b0061515270aa2mr2011913ywb.10.1713952151348;
        Wed, 24 Apr 2024 02:49:11 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a6-20020a81bc06000000b0061440b93ce5sm2887954ywi.37.2024.04.24.02.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:49:11 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso7001285276.0;
        Wed, 24 Apr 2024 02:49:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWX51NhinKIz7FdYdVhRj/dv7r9KRpueSI+VXUuboIVfNqmFF9KcWhsIVEz/LoIus9kA4BmLsAXLvVxxFU7raraOtXm3J8aABYesv9gmPKSqz4zpnAqocSrgcS33ZwKkuGqwmBvWHXoUicN
X-Received: by 2002:a25:e30d:0:b0:de5:5089:32b8 with SMTP id
 z13-20020a25e30d000000b00de5508932b8mr1657304ybd.63.1713952150942; Wed, 24
 Apr 2024 02:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416123545.7098-4-wsa+renesas@sang-engineering.com> <20240416123545.7098-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240416123545.7098-6-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 11:48:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEvft0B9WdfZ936ccomZW4Qea8MVNSj-Q-Dyn8EKSUdA@mail.gmail.com>
Message-ID: <CAMuHMdUEvft0B9WdfZ936ccomZW4Qea8MVNSj-Q-Dyn8EKSUdA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] serial: sh-sci: always cancel hrtimer when DMA RX
 is invalidated
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Aleksandar Mitev <amitev@visteon.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Apr 16, 2024 at 2:35=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Clear the timer whenever 'chan_rx' is cleared to avoid an OOPS.
> Currently, the driver only runs the timer when 'chan_rx' is set before.
> However, it is good defensive programming to make sure the hrtimer is
> always stopped before clearing the 'chan_rx' pointer.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/r/ee6c9e16-9f29-450e-81da-4a8dceaa8fc7@de=
bosch.com
> Fixes: 9ab765566086 ("serial: sh-sci: Remove timer on shutdown of port")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> Locking needs to be double-checked here. This patch is mainly calling
> for opinions.

I do think you need to cancel the timer: even when not restarting
the timer in sci_dma_rx_complete() due to a DMA failure, the previous
timer may still be running, and will cause a NULL pointer dereference
on s->chan_rx on timer expiry.

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1262,6 +1262,7 @@ static void sci_dma_rx_chan_invalidate(struct sci_p=
ort *s)
>  {
>         unsigned int i;
>
> +       hrtimer_cancel(&s->rx_timer);

Is it safe to do this unconditionally on shutdown (cfr. the old check
for s->chan_rx_saved)?

>         s->chan_rx =3D NULL;
>         for (i =3D 0; i < ARRAY_SIZE(s->cookie_rx); i++)
>                 s->cookie_rx[i] =3D -EINVAL;
> @@ -2242,14 +2243,6 @@ static void sci_shutdown(struct uart_port *port)
>                        scr & (SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
>         uart_port_unlock_irqrestore(port, flags);
>
> -#ifdef CONFIG_SERIAL_SH_SCI_DMA
> -       if (s->chan_rx_saved) {
> -               dev_dbg(port->dev, "%s(%d) deleting rx_timer\n", __func__=
,
> -                       port->line);
> -               hrtimer_cancel(&s->rx_timer);
> -       }
> -#endif
> -
>         if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0)
>                 del_timer_sync(&s->rx_fifo_timer);
>         sci_free_irq(s);

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

