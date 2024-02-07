Return-Path: <linux-kernel+bounces-56207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B184C75C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06711C24DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870621112;
	Wed,  7 Feb 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjL/+eZH"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080720B37;
	Wed,  7 Feb 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298198; cv=none; b=bJ6pERYyNJKnlp6yrjuG2B9vmyVx2ImUohdTkQcJdhDlqAkyBtrMB2blNe5PTPtdcBcR1SCQhAuthOp2t5zCnXgXFmmhtvIjmTSvvFmxQyzpHaSt8uwkM5BW6s9d2R7UzAWtqre8I+TT6jCHhh8q/bTDvsEI8buAFqUtgaUzV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298198; c=relaxed/simple;
	bh=MiIUUkgOurUD6m7nycDs8ZFVTmYyIlFn3pQokgM0Fiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNWSMUlA19KpSDTcW7ZAD3C4whlJRGB4mU+3slGPK2qyY6SvEKIzdvsSMie7OGp7qUYCR8jeOftqeMsVgguRR1g41To8mIogDtBSBO7zvkiojDX5gLIXqOEEVs8IV9cdWpVhNse7XfRjgmk7g6AiJpRMBluVeE5LDXZLh+O7Yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjL/+eZH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a370e63835cso47345866b.1;
        Wed, 07 Feb 2024 01:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707298193; x=1707902993; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1ZzVwcYFWNZCpenXU++NhwKm0k1ManT0kvG1W9T6Lc=;
        b=cjL/+eZHnE0TJHU3VshiRfify8S7T+fgHbgZRoUsen/jxJhnysKKwLtXXHcRw9NR73
         VqWEM9y7/lO8Q+c4exNa/KoL+OepM475zsDozNAC6CbSbLP6n8yew9zQ3W1zUhDh7y7H
         duKueR3N1m9z2sI2vh66KKqG384egCjXlPNYJliXaqJ0RwdPTOAupchByxz/T4pzPABp
         47EhbNkunSjc8l9jcqPOolNkuIcx1KrEcIjEvySj6e020X3EzyRvwO92yhicnNThRNMV
         j7qx+GF9jau0awmXCjhsfMDnL7FPsLsoXeX9iJbgmRd2hcZoNa9U1dKjNrNfGbkwzqNa
         dPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298193; x=1707902993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1ZzVwcYFWNZCpenXU++NhwKm0k1ManT0kvG1W9T6Lc=;
        b=injTh1TmQd6Lvy8dIzKq/LW5aAdl7E6r00Rmt887cZDvSog/hx4numH8voE8KFnjpP
         X2S4tcAphzgiDLRZmwp2IlHm1gsYP/UBz00QXg0XRwn7s2YTDhsXKY73Pz/Yl6BJCtRF
         g+0NMixho2Sa+zdSsJ1QXOx+OIrB6wBHjkUW8dUkn9Tey7QiJMFoFxk6JDA5mNoU4mWp
         jR9bERQlXSyhxBJ6dEIxRuWSOFViC9/6lmkLVHGsDgsAWgc5O3lXTZ9/+jqcDmZq6nSl
         NA13NDmOjuftXBbPgF4D/2qUooNsoMOXDv8wPOCNJUu1SMKJiIX/KxTC4baoiiN6PLC6
         BUbw==
X-Gm-Message-State: AOJu0YxXuwaef/F0k61w5b2gTId4z7rNAX716bLhzN29XViPLYCuexwi
	wayv+fXiBbms+m+suqLarDmCzWvr4YaH4rnRWkhAeUrdPHHa2pd1
X-Google-Smtp-Source: AGHT+IGIVTu8jI5zC4yFz4+oApJFcqTFJIDJcFbMbEQbX7rhLyWEGagntNKaOHTgeQyk/Ty+RpMHKQ==
X-Received: by 2002:a17:906:bc94:b0:a37:87e1:5929 with SMTP id lv20-20020a170906bc9400b00a3787e15929mr3856705ejb.54.1707298192178;
        Wed, 07 Feb 2024 01:29:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXwSUdRyCG3/PyNResm95wk1K06K3IOtBxNwZa0LW5uWpW+xRjglBL7YNSKHpbLLCZL4qUk4Du+gpOUys25eEcucda0hMlQGlstxuL/ztMEGNcAvgpW+fZDQkahbXM5GqpEF8YTEJEHYHXhLQmbwbhzKKXMJcjFZ0ZWeSWpik5CwjDIlDS43OjP1bOzSZIw0D9N/3Du2eU0lI=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906131800b00a3826954486sm549138ejb.53.2024.02.07.01.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:29:51 -0800 (PST)
Message-ID: <07371805d3ec96d803a98b5735a114b3af56365a.camel@gmail.com>
Subject: Re: [PATCH 2/2] spi: axi-spi-engine: move msg finalization out of
 irq handler
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 10:33:11 +0100
In-Reply-To: <20240206-axi-spi-engine-round-2-1-v1-2-ea6eeb60f4fb@baylibre.com>
References: 
	<20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
	 <20240206-axi-spi-engine-round-2-1-v1-2-ea6eeb60f4fb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 14:31 -0600, David Lechner wrote:
> As a general principal, it is best to do as little as possible in an
> interrupt handler. This patch reworks the AXI SPI Engine driver to move
> timer_delete_sync() and spi_finalize_current_message() out of the
> interrupt handler. Instead, spi_finalize_current_message() is moved to
> the transfer_one_message function (similar to nearly all other SPI
> controllers). A completion is now used to wait for the sync interrupt
> that indicates that the message is complete. The watchdog timer is no
> longer needed since we can use the wait_for_completion_timeout()
> function to wait for the message to complete with the same effect.
>=20
> As a bonus, these changes also improve throughput of the SPI controller.
> For example, this was tested on a ZynqMP with a 80MHz SCLK reading 4
> byte samples from an ADC. The max measured throughput increased from
> 26k to 28k samples per second.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Nice one...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/spi/spi-axi-spi-engine.c | 40 +++++++++++++++--------------=
----------
> -
> =C2=A01 file changed, 15 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> engine.c
> index 9cc602075c17..3c96aa9232b3 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -6,6 +6,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/clk.h>
> +#include <linux/completion.h>
> =C2=A0#include <linux/fpga/adi-axi-common.h>
> =C2=A0#include <linux/idr.h>
> =C2=A0#include <linux/interrupt.h>
> @@ -14,7 +15,6 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/spi/spi.h>
> -#include <linux/timer.h>
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_RESET			0x40
> =C2=A0
> @@ -110,9 +110,7 @@ struct spi_engine {
> =C2=A0	spinlock_t lock;
> =C2=A0
> =C2=A0	void __iomem *base;
> -	struct timer_list watchdog_timer;
> -	struct spi_controller *controller;
> -
> +	struct completion msg_complete;
> =C2=A0	unsigned int int_enable;
> =C2=A0};
> =C2=A0
> @@ -484,11 +482,9 @@ static irqreturn_t spi_engine_irq(int irq, void *dev=
id)
> =C2=A0
> =C2=A0	if (pending & SPI_ENGINE_INT_SYNC && msg) {
> =C2=A0		if (completed_id =3D=3D AXI_SPI_ENGINE_CUR_MSG_SYNC_ID) {
> -			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
> -				msg->status =3D 0;
> -				msg->actual_length =3D msg->frame_length;
> -				spi_finalize_current_message(host);
> -			}
> +			msg->status =3D 0;
> +			msg->actual_length =3D msg->frame_length;
> +			complete(&spi_engine->msg_complete);
> =C2=A0			disable_int |=3D SPI_ENGINE_INT_SYNC;
> =C2=A0		}
> =C2=A0	}
> @@ -559,7 +555,7 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0	unsigned int int_enable =3D 0;
> =C2=A0	unsigned long flags;
> =C2=A0
> -	mod_timer(&spi_engine->watchdog_timer, jiffies +
> msecs_to_jiffies(5000));
> +	reinit_completion(&spi_engine->msg_complete);
> =C2=A0
> =C2=A0	spin_lock_irqsave(&spi_engine->lock, flags);
> =C2=A0
> @@ -581,21 +577,16 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0	spi_engine->int_enable =3D int_enable;
> =C2=A0	spin_unlock_irqrestore(&spi_engine->lock, flags);
> =C2=A0
> -	return 0;
> -}
> -
> -static void spi_engine_timeout(struct timer_list *timer)
> -{
> -	struct spi_engine *spi_engine =3D from_timer(spi_engine, timer,
> watchdog_timer);
> -	struct spi_controller *host =3D spi_engine->controller;
> -
> -	if (WARN_ON(!host->cur_msg))
> -		return;
> +	if (!wait_for_completion_timeout(&spi_engine->msg_complete,
> +					 msecs_to_jiffies(5000))) {
> +		dev_err(&host->dev,
> +			"Timeout occurred while waiting for transfer to
> complete. Hardware is probably broken.\n");
> +		msg->status =3D -ETIMEDOUT;
> +	}
> =C2=A0
> -	dev_err(&host->dev,
> -		"Timeout occurred while waiting for transfer to complete.
> Hardware is probably broken.\n");
> -	host->cur_msg->status =3D -ETIMEDOUT;
> =C2=A0	spi_finalize_current_message(host);
> +
> +	return msg->status;
> =C2=A0}
> =C2=A0
> =C2=A0static void spi_engine_release_hw(void *p)
> @@ -626,8 +617,7 @@ static int spi_engine_probe(struct platform_device *p=
dev)
> =C2=A0	spi_engine =3D spi_controller_get_devdata(host);
> =C2=A0
> =C2=A0	spin_lock_init(&spi_engine->lock);
> -	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout,
> TIMER_IRQSAFE);
> -	spi_engine->controller =3D host;
> +	init_completion(&spi_engine->msg_complete);
> =C2=A0
> =C2=A0	spi_engine->clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk")=
;
> =C2=A0	if (IS_ERR(spi_engine->clk))
>=20


