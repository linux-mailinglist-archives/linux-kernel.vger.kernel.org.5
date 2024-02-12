Return-Path: <linux-kernel+bounces-61820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8298C8516F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1823B2814F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71C3BB28;
	Mon, 12 Feb 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxxDyZ6s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RDjMVvS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753B3A1D9;
	Mon, 12 Feb 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747676; cv=none; b=sLo68oaGP3Uus6Vz1hZrQ+4hjUBnl0MCGWGtW2Uv/Hgp9gEOkC/vPqEh4hll3lqrGkbN6c/6jscVg6BTnzQn3fr+cgYj9iebp2J1ykFMSAa/1ZzOsm+HM4LMFiY5Wmcc4TRGxeJkTR5IMQT7E0WGIoT9UFhKjvHNcnVvsz5BwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747676; c=relaxed/simple;
	bh=vThySi9neIQTLpUytAdGHFLKD16w73F97w6xFytPiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGw4AAvsjGKeTnmegFbjtjGti5jwvZRUFOJhZjmROKn4IQYtGGsHipm4YW3JQ6ZbM2/rsoUWJLSl8cE5aHlUcTDGogUocr/mCPRziiOhFCP6k0rdrar2mIc+6mR5OllYO1NMh0Lt1Sln0tHa2W5xt+xmN3Xb5uisyc/9K6SdQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxxDyZ6s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RDjMVvS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Feb 2024 15:21:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707747671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny2weh97cRX719A7lyARj33mRaz5HSDASypeDzfOgnk=;
	b=WxxDyZ6sbgAr5aSTjVmXiYCw+HJeATqoAhbTzeM3AKAZPhBKy92F9YxZXTakyHJhCj/OpT
	IXn/u/T7EFGLIGGnjSnl1KKNYdg9zAh3CaniPI1gKQkiEzWT+CaAB39/oQ06QxgvxqwWWR
	MOESawu3R1WnUiOSEdrNPtVyUF3GytwrVoihh9svBNtcuUEWfh00sa4h5dtb4xDpJOK9AK
	DYmx9AU0BunTCgNo8UHg3/0yHkQtee4chg1nJr2T6T5IB0FIyeLwNqKhNEv2IikLMGPp6k
	kBgG8IzRnTD/VZPnjdAy6hbS1m/hG3lUzOmoXK/LCxgpqOd2PKuDKZHUZM+ELA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707747671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny2weh97cRX719A7lyARj33mRaz5HSDASypeDzfOgnk=;
	b=4RDjMVvS6B7v/u74wCZI5nAP0w4lq8GLsp/cmAZsyqJIeAzmo4IlU4t3eWu34FaNitbgyW
	gpvLcQ8z2qpT6IBg==
From: Nam Cao <namcao@linutronix.de>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: marvin24@gmx.de, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: nvec: nvec: fixed two usleep_range is
 preferred over udelay warnings
Message-ID: <20240212152110.4f8fe0e6@namcao>
In-Reply-To: <20240212133645.1836-1-mo.c.weber@gmail.com>
References: <20240212133645.1836-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 12/Feb/2024 Moritz C. Weber wrote:
> Fixed a code style issue raised by checkpatch.
> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 2823cacde..18c5471d5 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  		break;
>  	case 2:		/* first byte after command */
>  		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
> -			udelay(33);
> +			usleep_range(32, 33);
>  			if (nvec->rx->data[0] != 0x01) {
>  				dev_err(nvec->dev,
>  					"Read without prior read command\n");
> @@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  	 * We experience less incomplete messages with this delay than without
>  	 * it, but we don't know why. Help is appreciated.
>  	 */
> -	udelay(100);
> +	usleep_range(99, 100);
>  
>  	return IRQ_HANDLED;
>  }

I have zero knowledge about this driver, but nvec_interrupt() seems to be
a hard interrupt handler, and sleeping in an interrupt handler is a big no
no. So I think this change breaks the driver.

Delaying like the driver is currently doing doesn't break things, but it is
not very nice because this is interrupt handler and the processor cannot
switch to other tasks, so delaying is wasting processor's cycles here. The
better fix would be to figure out how to remove the delay entirely, or
switch to threaded interrupt handler and then we can use usleep_range() in
there, but you need actual hardware to test such changes.

Best regards,
Nam



