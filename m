Return-Path: <linux-kernel+bounces-32690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDA835EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283282889BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17BE3A1C2;
	Mon, 22 Jan 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpRh68VT"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243F3A1C4;
	Mon, 22 Jan 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917692; cv=none; b=Vwx1MaTsjDjovGElRtKSKULhhnR2DiOn+s6YlK4+VnTxkD+ZiD0pNsfsbji2iBTncIQiDfiSTGRfjiosJeXCpixTKgxk7Z0wFeRGIJ+s1BTZlBB2uyWC2GkwyjfSSrwtlu9B7D7leVjZFSo/HKC1S3tRQNvUdKn44CSUMEOzuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917692; c=relaxed/simple;
	bh=par0s2/VB3PZb6zfUVdv76/hqB2EQCB+kqfg2eI327g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcjs1uLSNmQPpIrAROW8+t5Mh7xsCHWg5MLa5anXnJWPedfo8Zm8DY+bEw+T0JYOj0jypduSHtAnx2h4/JO7J8wmZzGx9Hhd+yiXz2uJwsPy6yf1oi8E/D9rirVkMINctfXf4pN7DlFoVMCp9StMhW2NTObdRwdJRO2fZg7/5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpRh68VT; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd6581bc66so2435140b6e.1;
        Mon, 22 Jan 2024 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705917689; x=1706522489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmK0iTzIamZUy8Q6FsKiVw6nKFNkw/aS4IZNRbQfRFc=;
        b=NpRh68VTBxu0OcuNWbLwIhtf4InM8t8+7UEvRpakwzxiYlEUTFZTjS8HflVjGysoqx
         Dy04r/TgEFhi9YQNmyyV6Ko3E2oz4fElbhQKirAPVBAws5kQpEZFiJa/MXq1gMJwjP07
         s8a5SkKvb7Kusvk7pNAoHboPpgk1qHDLr+8H6d7D7OScazleWs1ZKmrYn87wWAuiwtWI
         xoHbKfCirxAXDHY7f5J8dRf07iO2y8OUIIKkruFzz8LIP62A9xfjD+ny0T90pgRsjocq
         k5S8DFNvlpstGxa9C66yyLCfQZNp33Og4vENDBluBiI53hhpHt+zbTKe0KUX2oW5kiV0
         29jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917689; x=1706522489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmK0iTzIamZUy8Q6FsKiVw6nKFNkw/aS4IZNRbQfRFc=;
        b=TKr9An3cZfspRqMb7BRQtsInD9vnUz3dXWVVeLFN+BE6k5JZBimsSMk38RzT4HkHcB
         iQ3aOybSIVcBCpPQW9dTvUBPUSzbRs1lSqdSM9h8T7RatCqtQcJBNkfMbRi37KtfcOLz
         RH7cNvH4XjpYXn4khO6VHWwRRaBfEC+4+BqXABVq56+hKFy1uLYnvBwue2SaEHpxf1/E
         g5oeCP/gvkSqKEI0xcxdeTgjYs1qwaHaky9r6SImDiMs2s4f0DzhTQAFJu9BO+gGogdq
         YpUDrqGdpU7Ox/rJ/JuGQusK6+roWzXLXC/PP+tdzRcqF6VFLkFA6hN0wAdHYhSbRzQr
         v+4g==
X-Gm-Message-State: AOJu0Yybgn265SMER4Tnyb7xpnPdW72dO2pQlmyNKsTTPkzeZK5MWNAe
	5q6R93B2g7bU1E229iT6f8aOcWkilaAlj/CwjKbDRCSDJe2U4CXmgcGkTr8xkahOr20KTUUL4+H
	rPrqY70qEkBUeYH7nX/TeaM4Y7rY=
X-Google-Smtp-Source: AGHT+IEnx+9HBMlMHgYt1FrpDghvFoADHVcnNxW17UhbjUjQT15Yksx2eGyggNy0P2RCYjudvuc+q96sw6VcjQ5MfUU=
X-Received: by 2002:a05:6870:a90a:b0:205:c4d8:155a with SMTP id
 eq10-20020a056870a90a00b00205c4d8155amr4334867oab.62.1705917689514; Mon, 22
 Jan 2024 02:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109073849.10791-1-Wenhua.Lin@unisoc.com> <20240109073849.10791-2-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240109073849.10791-2-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 22 Jan 2024 18:00:52 +0800
Message-ID: <CAAfSe-sVfZ8YNnxK4e1CphnxXOgEZaEfWZFV_CrSZA0nmBrZjA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] gpio: eic-sprd: Clear interrupt after set the
 interrupt type
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 15:39, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> The raw interrupt status of eic maybe set before the interrupt is enabled,
> since the eic interrupt has a latch function, which would trigger the
> interrupt event once enabled it from user side. To solve this problem,
> interrupts generated before setting the interrupt trigger type are ignored.
>
> Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/gpio/gpio-eic-sprd.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index be7f2fa5aa7b..806b88d8dfb7 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -330,20 +330,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>                 switch (flow_type) {
>                 case IRQ_TYPE_LEVEL_HIGH:
>                         sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
>                         break;
>                 case IRQ_TYPE_LEVEL_LOW:
>                         sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
>                         break;
>                 case IRQ_TYPE_EDGE_RISING:
>                 case IRQ_TYPE_EDGE_FALLING:
>                 case IRQ_TYPE_EDGE_BOTH:
>                         state = sprd_eic_get(chip, offset);
> -                       if (state)
> +                       if (state) {
>                                 sprd_eic_update(chip, offset,
>                                                 SPRD_EIC_DBNC_IEV, 0);
> -                       else
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_DBNC_IC, 1);
> +                       } else {
>                                 sprd_eic_update(chip, offset,
>                                                 SPRD_EIC_DBNC_IEV, 1);
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_DBNC_IC, 1);
> +                       }
>                         break;
>                 default:
>                         return -ENOTSUPP;
> @@ -355,20 +362,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>                 switch (flow_type) {
>                 case IRQ_TYPE_LEVEL_HIGH:
>                         sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
>                         break;
>                 case IRQ_TYPE_LEVEL_LOW:
>                         sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
>                         break;
>                 case IRQ_TYPE_EDGE_RISING:
>                 case IRQ_TYPE_EDGE_FALLING:
>                 case IRQ_TYPE_EDGE_BOTH:
>                         state = sprd_eic_get(chip, offset);
> -                       if (state)
> +                       if (state) {
>                                 sprd_eic_update(chip, offset,
>                                                 SPRD_EIC_LATCH_INTPOL, 0);
> -                       else
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_LATCH_INTCLR, 1);
> +                       } else {
>                                 sprd_eic_update(chip, offset,
>                                                 SPRD_EIC_LATCH_INTPOL, 1);
> +                               sprd_eic_update(chip, offset,
> +                                               SPRD_EIC_LATCH_INTCLR, 1);
> +                       }
>                         break;
>                 default:
>                         return -ENOTSUPP;
> @@ -382,29 +396,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_edge_irq);
>                         break;
>                 case IRQ_TYPE_EDGE_FALLING:
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_edge_irq);
>                         break;
>                 case IRQ_TYPE_EDGE_BOTH:
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_edge_irq);
>                         break;
>                 case IRQ_TYPE_LEVEL_HIGH:
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_level_irq);
>                         break;
>                 case IRQ_TYPE_LEVEL_LOW:
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
>                         sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_level_irq);
>                         break;
>                 default:
> @@ -417,29 +436,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_edge_irq);
>                         break;
>                 case IRQ_TYPE_EDGE_FALLING:
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_edge_irq);
>                         break;
>                 case IRQ_TYPE_EDGE_BOTH:
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_edge_irq);
>                         break;
>                 case IRQ_TYPE_LEVEL_HIGH:
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_level_irq);
>                         break;
>                 case IRQ_TYPE_LEVEL_LOW:
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
>                         sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
> +                       sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
>                         irq_set_handler_locked(data, handle_level_irq);
>                         break;
>                 default:
> --
> 2.17.1
>

