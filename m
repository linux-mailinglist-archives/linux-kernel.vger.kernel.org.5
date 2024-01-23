Return-Path: <linux-kernel+bounces-35467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A383919A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEACB1F262DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA325FBB2;
	Tue, 23 Jan 2024 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy9RxXA2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5145FBAA;
	Tue, 23 Jan 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020921; cv=none; b=pdmiTf/fl2iC+4/Sc/CHk9cnvT7f1gXQPQgRyB4/5tWfEVSpnGtojUC3ww2uaxCIIR1G3YYKVLKgYkLqVCjkTjGmtn3Vp4usMcS5IX5m7Kl9XxiqAuAGrZMuFdGhVDCNv9gEmomTiJUAD8JVgMCvBv2yCCtDLNdLDp+dnozKNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020921; c=relaxed/simple;
	bh=/G/0DNSlCdvQHDjA0E5XMdtuoUCzLwstX3BIGOhPQl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVo28lTS25BzN42Obtv51tBfq2QkGEAQMrst0GQe419JcGenF4YuvRk0p9oGKXLvTmczf+7S44yvQZ193lyVuCyktF0WMvNILn9fIzlVZ0vRbteLAS2Y1Ia1P3IWssWyXBrs/mSMSAZpU4OntjFH/4bTY4VlK3px/95TRxAlgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy9RxXA2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d427518d52so31287115ad.0;
        Tue, 23 Jan 2024 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706020919; x=1706625719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kiH7/X/jWCZvnjGCpz1ct/EafnIRL4KUlTVwPeC5kXc=;
        b=Fy9RxXA29YWp7YcmFjzWm/yrp+g8Hkp0fMeqUHyLw+6AJFqVy9Q93lXSsmeTiDYUtO
         6FdEk9UU0cGnSBQlSEMeq+LaTPlxjMptvJADYgHX7G6i81B3prraEXtu2s+WCKT5KX3X
         mp0zYvUYCgy+ebSEFOdhqNx4+8SAxWmPvT06cHFKytCe0O36ZJPKazw/1tqBGqYR61az
         oT75yAsvLIBZ/4kHGvBfXt/w/EW/7G2UZvpevE7Uh1esRwH0C0s4yIthoUkqM9HnCOjB
         SqOKbAEBRhjpvybWXmRTRvoAqgj94Onv34rTrG0FeWSgA0oEiuPPTjl7rF+hP5o/DBWQ
         OgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706020919; x=1706625719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiH7/X/jWCZvnjGCpz1ct/EafnIRL4KUlTVwPeC5kXc=;
        b=BxfileRAIsj8tNLedCsdqJuU/Ho5VsawYf3m4J4zaJdUVYlPURoTijsNe1KDOtA5zb
         biXmXy3FlnWUIIWJ4It/HSrXWmb9nrR9OMTgL5dnlrM2U67cVoG8oHoP/MmBCVaWrkUf
         Qs8Z/MN9JCgmX0FFyBSHtAI8eJ/ZzcpoFgmNtTp9QMbSisYk/B0z0vsWHanhmgiBggc8
         7GmkFPugBGAOAuJMsAjn0x1XDXtICZ+IXJVsf9l1tg/1YAY9pvLRjuhEOh+v7wjQlatr
         OmCvzRpsOMe1pQOK4K9hE8NmbIZZhYxeHucdcYcIvEOPdpFJELLLpB9w+aFc4WkJvrxa
         WzYw==
X-Gm-Message-State: AOJu0Yx44Mp6Ao25YAxh++sFJoil5GOPJ8IAHjKgP9e+PdvJHATeBpSb
	0QNYi5fz0s7WGgYfTLouR3u66f5moFsSd59RKLVrK8Pq40+6rNYZx/irjgAqmwF55/TFot5F9+B
	bqRIAfUvY0hQA8u29DRLGWfVMuekNJD2pBKXzYQ==
X-Google-Smtp-Source: AGHT+IFqcQVVXIOGxEde9nKQOVJLFr0nsF4kQA4MI03XIpNWrNav+3WLZsBWHt24yINft6CkgPzrT3ljF42PTbD/aAQ=
X-Received: by 2002:a17:902:b18a:b0:1d7:323a:ecd6 with SMTP id
 s10-20020a170902b18a00b001d7323aecd6mr5333712plr.42.1706020919094; Tue, 23
 Jan 2024 06:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123040817.200542-1-f.fainelli@gmail.com>
In-Reply-To: <20240123040817.200542-1-f.fainelli@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 23 Jan 2024 15:41:47 +0100
Message-ID: <CAOiHx=mgNB5V178vNQM0oePd9uhDsz7bnqKRCcbfc22WxZm1jQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM63XX: Fix missing prototypes
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 23 Jan 2024 at 05:08, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> We have a number of missing prototypes warnings for the BCM63XX machine,
> fix those by providing adequate function prototypes.

None of these prototypes should be needed, most functions are never
called outside of their units and are just missing a static
annotation, and one already has a prototype in a different header.

>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h    | 8 ++++++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h  | 1 +
>  arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h | 2 ++
>  arch/mips/include/asm/mach-bcm63xx/irq.h            | 3 +++
>  4 files changed, 14 insertions(+)
>
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> index 1cad18e6681d..b9ab5ee1c7b2 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
> @@ -1065,4 +1065,12 @@ void bcm63xx_machine_halt(void);
>
>  void bcm63xx_machine_reboot(void);
>
> +int bcm63xx_register_devices(void);

defined and used only in arch/mips/bcm63xx/setup.c

> +
> +int bcm63xx_rng_register(void);

defined and used only in arch/mips/bcm63xx/dev-rng.c

> +
> +int bcm63xx_uart_register(unsigned int id);

This one already has a prototype in bcm63xx_dev_uart.h,
arch/mips/bcm63xx/dev-uart.c just needs to include that header file.

> +
> +int bcm63xx_wdt_register(void);

defined and used only in arch/mips/bcm63xx/dev-wdt.c

> +
>  #endif /* !BCM63XX_CPU_H_ */
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
> index bcbece793fd8..f920c7274f5e 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_timer.h
> @@ -8,5 +8,6 @@ int bcm63xx_timer_set(int id, int monotonic, unsigned int countdown_us);
>  int bcm63xx_timer_enable(int id);
>  int bcm63xx_timer_disable(int id);
>  unsigned int bcm63xx_timer_countdown(unsigned int countdown_us);
> +int bcm63xx_timer_init(void);

defined and used only in arch/mips/bcm63xx/timer.c

>
>  #endif /* !BCM63XX_TIMER_H_ */
> diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
> index 830f53f28e3f..7b905c8a424d 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
> @@ -51,4 +51,6 @@ struct board_info {
>         unsigned long ephy_reset_gpio_flags;
>  };
>
> +int bcm63xx_get_fallback_sprom(struct ssb_bus *bus, struct ssb_sprom *out);

defined and used only in arch/mips/bcm63xx/boards/board_bcm963xx.c

> +
>  #endif /* ! BOARD_BCM963XX_H_ */
> diff --git a/arch/mips/include/asm/mach-bcm63xx/irq.h b/arch/mips/include/asm/mach-bcm63xx/irq.h
> index b016f0615d5f..cbb92a609835 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/irq.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/irq.h
> @@ -5,4 +5,7 @@
>  #define NR_IRQS 128
>  #define MIPS_CPU_IRQ_BASE 0
>
> +void __dispatch_internal_32(int cpu);
> +void __dispatch_internal_64(int cpu);

dispatch __dispatch_internal_32()/__dispatch_internal_64() are defined
and used only in arch/mips/bcm63xx/irq.c

Best Regards,
Jonas

