Return-Path: <linux-kernel+bounces-74877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A785DE79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A3A1F24688
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141687C0BA;
	Wed, 21 Feb 2024 14:18:36 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F63D981;
	Wed, 21 Feb 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525115; cv=none; b=M5TpDptOk+6D3hKGV/WiYhSO+djrUQL+BP4JYu8DGHLpvcDo25glW4SYGRlokm3KysXa9QjTS4d8qNN/jP+3jBrrsgFHJr5VvxfRJVkXCi54u/xXf8xGfZJ804qJVvvqkDDOOrz/IuCTCznpMp/7s52E4nSxcWjYdaytByE+XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525115; c=relaxed/simple;
	bh=hFnaWpt2J44fWSGAXSUbaxkRbOCTlYWOL+3hH2Mpin8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI7XjqgpaUsbnQ1hZX997yqqqPkMMr3sQeQSbnhbklE8VJrcmsVrcsHIAHDY5yKmI3eapvRO84Eq/Jv3n20qFlHzut0VMX8+StZagsi/UaFlqttj5ltfZxCPdf/zcOHUgvmla/vO/sLIPzpmuZQVzvAmPejWTBFI2uqb5czAUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6002317a427so55664857b3.2;
        Wed, 21 Feb 2024 06:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525112; x=1709129912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12g2lyoIyLhB142LFaLUwjI1mZtgaY41ezqOHNni8bA=;
        b=r20m3AXxqKj6i8zUAUo7KjPtgThF81BFRkRelSznvQywyCKugOzuejdDKadUMNt83c
         f7B4sLQx1ky9k8LJre3kE92VEJFe9AbhvFvH4AbR1zxBCLi25jggeQhIiA15yStPqeC9
         Twv20Vd5ByEjgvLHfeKofp5oP6ev3DoAMZsSe5GPhvkAEULlEzAc33mX+4Eb8hbMMZSb
         YJ5YbVC/NGj/QqATkf9SBrdkrfIDzKBdcYKZFiP0szMGMwzkAnCxqxj3gsA7Oitw0bh6
         9E3hDYtVinHf34DgeaGbo0tH8M2aeWeXCH2mGv6YYZGj7PNhQ8FegJmuRjpHGtLYJK6B
         R5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXJZQ0tnM6mgBT5cnR1NgbdAWUB+0B/aMR/4hd6vzSJo1qS4NNJD2E3DRNP9ZneyNE1yHAK01CuFMT3QVyYp+xL7xrHx7LB1ItPUUtVVCL+cOqGiiLh3exMN8h9VTPdfHDPo2QhV2CSfp6Lit7L29zjhaXnnVFHIi/arurumSC8utvXujFd/1MqYLzC
X-Gm-Message-State: AOJu0YzIWYEezh66LTYTMqJdOPzs8lc4j49o64+vlJsmDid5gZ5eGyhq
	+JHWzbhr9MBBZelHzX+j/E5dlwjWwRs2K0DYf/ekkIVbTWb55mGXhAZFbEFd7GU=
X-Google-Smtp-Source: AGHT+IEp5UB2oREq9FrW/7qNtAlJ913YDd5xC5jnQuOwn2ZpoylDXLMYQUmptRODLNaNPD8LDI1OWw==
X-Received: by 2002:a81:a0d7:0:b0:608:5af9:b486 with SMTP id x206-20020a81a0d7000000b006085af9b486mr5490613ywg.11.1708525111845;
        Wed, 21 Feb 2024 06:18:31 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id y79-20020a81a152000000b006079055cc56sm2607587ywg.78.2024.02.21.06.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:18:31 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so5924368276.0;
        Wed, 21 Feb 2024 06:18:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVocVu5PknUozIpsWFnKaeLnzON1VXDPAwPYfhwFcexFHGApVC6x43t9f023GEarJW1Y44kErdWMFHcc8KcB2d1YjGNEUj3KpV0rRT96E2j/df8z+MiE27C8aDq58hsy0eNM9GRePHYVR7+RK8M/0ZM+Rqad1LTmQU4Q+bQFfF6kdlLyfaD4ccMYkg0
X-Received: by 2002:a25:2bc2:0:b0:dc2:4f34:c964 with SMTP id
 r185-20020a252bc2000000b00dc24f34c964mr16422317ybr.23.1708525111140; Wed, 21
 Feb 2024 06:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com> <20240215124112.2259103-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240215124112.2259103-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 15:18:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXenTZWS5NsOS_rwXp5+4K6zK3cv8z7ev46Sp4nTLTMMQ@mail.gmail.com>
Message-ID: <CAMuHMdXenTZWS5NsOS_rwXp5+4K6zK3cv8z7ev46Sp4nTLTMMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: renesas: rzg2l: Add suspend/resume support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 15, 2024 at 1:41=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> pinctrl-rzg2l driver is used on RZ/G3S which support deep sleep states
> where power to most of the SoC components is turned off.
>
> For this add suspend/resume support. This involves saving and restoring
> configured registers along with disabling clock in case there is no pin
> configured as wakeup sources.
>
> To save/restore registers 2 caches were allocated: one for GPIO pins and
> one for dedicated pins.
>
> On suspend path the pin controller registers are saved and if none of the
> pins are configured as wakeup sources the pinctrl clock is disabled.
> Otherwise it remains on.
>
> On resume path the configuration is done as follows:
> 1/ setup PFCs by writing to registers on pin based accesses
> 2/ setup GPIOs by writing to registers on port based accesses and
>    following configuration steps specified in hardware manual
> 3/ setup dedicated pins by writing to registers on port based accesses
> 4/ setup interrupts.
>
> Because interrupt signals are routed to IA55 interrupt controller and
> IA55 interrupt controller resumes before pin controller, patch restores
> also the configured interrupts just after pin settings are restored to
> avoid invalid interrupts while resuming.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - use u8 for sd_ch, eth_poc, eth_mode, qspi members of
>   struct rzg2l_pinctrl_reg_cache and readb()/writeb() where necessary
> - s/wakeup_source/wakeup_path/g
> - call device_set_wakeup_path() on suspend
> - call irq_chip_set_wake_parent() on rzg2l_gpio_irq_set_wake()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.9.

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

