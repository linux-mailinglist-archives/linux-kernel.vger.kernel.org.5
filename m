Return-Path: <linux-kernel+bounces-103290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0887BD90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A34D1C20E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1D5BAC3;
	Thu, 14 Mar 2024 13:21:52 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B875A11A;
	Thu, 14 Mar 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422512; cv=none; b=bx2ZeHyK2aQ53jGVUd4MHBhGnseyu5c/PPOHnpWFV5qJxlNKGkWWu4MiZ84l7krjjfmDiVug60Q6VImAVhk382R8OZTBCJCzPG+rQvspe0Zu3BOvgSV1kbxXl6pE3PcrVg/6IJcQ3rznVeOfctT3XcAC+SKHHtFwCHdpePRwXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422512; c=relaxed/simple;
	bh=mAQqhpExv5z6FkNqYs0EBzPymQ2Rz/+bGcGssvuBbv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1p5M19iDA6vEvL/ApMWrI07i9zAonDqjxwGboBN6ijyTPmonF6F0dcava3IBRy+ktPo/Sj/MYnX5v6PpCTkFKRYZ9J8kyslAP53koB/IVFJryitRPf7oDBO+fJwqkNXZ8n54EeiN5MqO/Lz/xhn1CjHLawxCPq+EsryJGHrn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a0579a931so9780487b3.0;
        Thu, 14 Mar 2024 06:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710422508; x=1711027308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7XAOxtvk9jTIMeO9XmUcAHnDd/fm39bPev4wL/JHpw=;
        b=lMuNIGfsxS5aeLG+UlWi0e/bRoxCYOfA9VCtvvFGPMp0v/KmwIAX6+JcS/fqW5A98K
         xCv5wYHWZsMxRhlBZyIKoGDiQ65PxotvBsUyzVdsXL2AZA0/R5K3RbVNG5fMRa7Zrrv7
         jgud3PvewBHD9XkKVZiSEr5GFQ3XFYntsCsmb83x5RnejH1GP6X951hJrINzCCDKln1A
         Z+GHPegMuOHba0Ii2Q6+9BAh1S8fj10dXuhHRnlxNc/E+zrqkSWNuNoe2VaXHmUifi8o
         ylerQDZwkzTS2iSA4BK2gywTigOrzQFlIgSLWXmZtv656F222sU6qmW6T8wCEsz+re7f
         HNwA==
X-Forwarded-Encrypted: i=1; AJvYcCVe4MQt0ZyRtwO+12oCDeaM225xplUn6ewNV0kzdyO85uYFJZXTTHc7VgnXe1kG+/bDHvGBHedZKdptF9O2cCf2+XV5hjO1Vmrg5p5tSt/xCUW2sWUz9kJXnheri/3/1df8TUOAiW58DkzW975/uj2FHJFaUg/dpz9bsKjfbDLEvvQiMoxzHtm6yaVu
X-Gm-Message-State: AOJu0YwIJlgDm/dM444F9+kEbmsxrVBiwPQ+F5Oumz29pp8k+0ZPo5s7
	nf0CUSLS74EQvbK12PzJnirdZ5HOUGB7aN6cMGVakadGPFSs/GXwN3gGMnHR1O0=
X-Google-Smtp-Source: AGHT+IGPM7ZSp1O03vFs1AvdeYLpCmxu/7UjXsduu48nm8Q9xds8ghE/La58vYwshcA9Xyl9pBbd+A==
X-Received: by 2002:a5b:9d0:0:b0:dc6:d22e:ef4c with SMTP id y16-20020a5b09d0000000b00dc6d22eef4cmr1612860ybq.17.1710422508075;
        Thu, 14 Mar 2024 06:21:48 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id x200-20020a25e0d1000000b00dcd56356c80sm258562ybg.47.2024.03.14.06.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:21:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so787547276.3;
        Thu, 14 Mar 2024 06:21:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkM06aGyMAb62M6YQjb3/GOvODW/iAyTIi3PrXu67m3/Y4nRkKn56FCXUbKPbMdloPjmAoZJh72+1GI3ELnw3flP+1ugEP2QtnO93V6biulbHRbKVfxt1I6bvGnT6V2MO1aa0FAEUX8i/UIFE5sqjc3DuxiyFtEMzpb4MmLdgf/N2W6MHLCiErX+Kf
X-Received: by 2002:a25:b101:0:b0:dcd:ba5a:8704 with SMTP id
 g1-20020a25b101000000b00dcdba5a8704mr1543398ybj.24.1710422507240; Thu, 14 Mar
 2024 06:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307112452.74220-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307112452.74220-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 14:21:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWwbfem71Q9FE40jqHM2pXWJW9u+w-+NKy3OffFkzu5SQ@mail.gmail.com>
Message-ID: <CAMuHMdWwbfem71Q9FE40jqHM2pXWJW9u+w-+NKy3OffFkzu5SQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Execute atomically the interrupt configuration
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thanks for your patch!

On Thu, Mar 7, 2024 at 12:25=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Lockdep detects a possible deadlock as listed below. This is because it
> detects the IA55 interrupt controller .irq_eoi() API is called from
> interrupt context while configuration-specific API (e.g., .irq_enable())
> could be called from process context on resume path (by calling
> rzg2l_gpio_irq_restore()). To avoid this, protect the call of
> rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore()=
.
> With this the same approach that is available in __setup_irq() is mimicke=
d
> to pinctrl IRQ resume function.

You mean __setup_irq() in kernel/irq/manage.c?
That one uses the raw spinlock methods?

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2063,8 +2063,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pi=
nctrl *pctrl)
>                         continue;
>                 }
>
> -               if (!irqd_irq_disabled(data))
> +               if (!irqd_irq_disabled(data)) {
> +                       unsigned long flags;
> +
> +                       /*
> +                        * This has to be atomically executed to protect =
against a concurrent
> +                        * interrupt.
> +                        */
> +                       spin_lock_irqsave(&pctrl->lock, flags);
>                         rzg2l_gpio_irq_enable(data);
> +                       spin_unlock_irqrestore(&pctrl->lock, flags);
> +               }
>         }
>  }

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

