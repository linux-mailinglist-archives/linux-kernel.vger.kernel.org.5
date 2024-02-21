Return-Path: <linux-kernel+bounces-74871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B795A85DE24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2711C2117C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190A7EF03;
	Wed, 21 Feb 2024 14:13:29 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0253CF42;
	Wed, 21 Feb 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524808; cv=none; b=aft/cgyptPEWMBa2DIoaQzWOTqHDS0bAjZoQdHd0hDk5LrBKbk7FR2gx/1eXdpggGnocT6WSQj9UaUblJTauT2FCiXT5RyvTUq+0nJxXcOET7LvAemwx4ukMijOYRlrmtNCCS1pT8TqFRNKWbqXP7jOaqrBp5qzgi3ONllJKoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524808; c=relaxed/simple;
	bh=+0a+Vjm3LEMsvJiU2NZChDhM5R5ZE0wVMUxaZUR8OR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEimFLveVRCsq+PPPHjOw/WimtjW5wAdXO3cESRykJ7NdxiLI6n1sFd4n543+CSGdcTouaMkAHYi1gSgOU/XLbem++XJ4QPSXCz4LyLOXY624CnXuMVsnHsJR1ybvwwvQhXnp9x0Joz2HZoeQqFX6wdgI0+eSqKqWpvyMa7qwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607cd210962so58207877b3.2;
        Wed, 21 Feb 2024 06:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708524804; x=1709129604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WssOhp4wIGct8OS+brvMMaBCr4M5Sjz7aTlXLNRimww=;
        b=FKPziCndm/DRxtC2+qSRyDn6xXDAj75n9RPKkY17kRnUo1xRQ8MJAHNLcAUYWwJ1SP
         QIP8GRkHh4RRQ8bbDao3vbtpta7D3LdsFG9e7V4jSHCvaSYLZoXc1joLYHxZ739DtjBX
         7Ra1J0aFLVxUbzxZ4JxFYIN7GSRKdKD3wrzEe7FFVTtjA6imckR0O5jjHYD33Kfp3hmh
         hSgZ9xm25xpJiq+Fmtdw9ujhgZJ5g7uyMXHkf3EKIpfEZ4Dabw5dPOSO5Oe8r0wGiydo
         /a8grAF66QZ1v5aXonFE9iK0IPTaVOPecuUUHDntVlBkO0xiOirat7nLGAQ1VhisuO2/
         tpJA==
X-Forwarded-Encrypted: i=1; AJvYcCWeNAfN7TicWLqTahtZ3aBeUjuHiS4acz/cnH6rravV/jbG6dRmQ0hJ007kHzpKMQ+m/saeIyWhuo7BpWV+6H7H2j3WZk6KfFvBdKr7lr8JuHISZy3Nvz3KeUs9BM7u1hlGyQOVZZKqiCCLqWjNzAz12KO+LcrDwbGrRzF/Sful1KVafUupeK5AXfFv
X-Gm-Message-State: AOJu0YyyJxXQvAILgLFa8KE913PfNSnSYpPtyBH/aHUWehreFFyyVZOg
	3cxnbmyahgz093GD2nnz8B3rKXKGK3gbaibzRJW+JhiSvHcA8GpGfOwLD4wqT0o=
X-Google-Smtp-Source: AGHT+IFlHvCRYmlBDlCVzZqmsd8a5kmnJanono0HMHjUSQiuXiHNPBimuxkHK2E/u5Gb1yh3twMKYw==
X-Received: by 2002:a0d:eac5:0:b0:608:7c04:d404 with SMTP id t188-20020a0deac5000000b006087c04d404mr2349613ywe.40.1708524804621;
        Wed, 21 Feb 2024 06:13:24 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id dt16-20020a05690c251000b00607c3904416sm2522419ywb.40.2024.02.21.06.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:13:24 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607cd210962so58207497b3.2;
        Wed, 21 Feb 2024 06:13:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfcYwoZsPFzI9zRHBFi9Ii8YBzOYYEIc0dtIVLEVKqR3Y4yfDXkZ0zyEqTlqM7AKB74uCgIrN26hK++XJVaW1xtGMi7G0F64ZHBsVON0Hjx46m+nriwkEM6j1vQq1ufcNLBCehUGNgTxMkUjYeQV0YNo5v22Hb3HpvFJm10CLFcSOdXA7Oo8okCjVF
X-Received: by 2002:a81:9b02:0:b0:5ff:4959:1da8 with SMTP id
 s2-20020a819b02000000b005ff49591da8mr16512998ywg.50.1708524803966; Wed, 21
 Feb 2024 06:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com> <20240215124112.2259103-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240215124112.2259103-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 15:13:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVi5vN5JSf9TAbdyrNa8_7eM=RajH8Mm=Qxhj5chWcK9A@mail.gmail.com>
Message-ID: <CAMuHMdVi5vN5JSf9TAbdyrNa8_7eM=RajH8Mm=Qxhj5chWcK9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: renesas: Select CONFIG_IRQ_DOMAIN_HIERARCHY
 for pinctrl-rzg2l
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
> The pinctrl-rzg2l driver uses APIs that are defined only if
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy (irq_chip_*_parent() APIs). On the ARCH_R=
ZG2L
> CONFIG_IRQ_DOMAIN_HIERARCHY is selected anyway, e.g., by the
> CONFIG_ARM_GIC_V3. Even so, make it explicit at the driver level for a
> clearer view of the dependencies.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Compile-testing on m68k reveals that you also need

    select GPIOLIB_IRQCHIP

So I will add that when queuing in renesas-pinctrl for v6.9.

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

