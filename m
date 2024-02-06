Return-Path: <linux-kernel+bounces-55656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B384BF86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59834B25486
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02491BC26;
	Tue,  6 Feb 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Nq9ZoVbj"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C51B94C;
	Tue,  6 Feb 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256245; cv=none; b=eMqop/Ho22Ar0ji05qWdi3xBOTq6wlLDnXgOQk6BqIBHr/Y+DLjRDxiTrdBmTrHGdOs0YRAVgUU7ONFmCKVY4OIJ5dEUY2Q6RuUbImdGHcoZ9v52AvyoPw8qJqebCzrOalTfihm+wveki2I3cTQ8i18UNgu8m1kPhCLIiX82ISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256245; c=relaxed/simple;
	bh=vojBpdB7dXWi+U3h40tzRjjL6Zt6ey/qpX2zIWiA2Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgS9HFQ2RcjayYqcnA5E4rignmVtGH7Qqq/lqsVVjQUapB/sDUvdIBiUROxZtXYrhbUP5UkjuC8A3nipYs7Ay8WLzUlcKj+ts3NTnlyJYrkKi3ejKGZ3m9jTYI7N8s6HyLX5mppy8aQM9N2RLZFoT64uC3vnyJdQS7pLZW8Nvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Nq9ZoVbj; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id XTKsrOaGI3bwWXTKsrejsb; Tue, 06 Feb 2024 22:50:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707256235;
	bh=5QwwD9KFlLch7qX+8L+lYfwlnDsJ5v9LVoktCWokEZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Nq9ZoVbjiZesVvOjCn9ynvsTT0WxrmP6ZzWubssVjCcO31Dl2Q9PRiNzJmsxOl+T0
	 2um+M9HDFSK3bU4zGj2EHDbqtuZQq1DwyqtBubyFsc6sgjM8I56NzaoA9Yp5eltepP
	 g4zwP9NSeHntiSYYRQZghqLmfMkiJ5nrUvP8Nx+kMFIPO1oAwbrNq8gp3/w+VybqkH
	 sjkJMnne+Q+041pExemIRDJJ/ocyPRmcivNle9N/Vyf5uiX8GC59DwGIUI7fENcqoA
	 l2ET6mhrwagN1/plXDL/EhPQkARVCoVGzxENnSaFozzvQMEahDu6BQ2JESC7sw0nTf
	 59Jv7f7DQj9WA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Feb 2024 22:50:35 +0100
X-ME-IP: 92.140.202.140
Message-ID: <0158a82f-5445-43b9-9da5-8655c3a97c4d@wanadoo.fr>
Date: Tue, 6 Feb 2024 22:50:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: axi-spi-engine: remove use of ida for sync id
Content-Language: en-MW
To: dlechner@baylibre.com
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com
References: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
 <20240206-axi-spi-engine-round-2-1-v1-1-ea6eeb60f4fb@baylibre.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240206-axi-spi-engine-round-2-1-v1-1-ea6eeb60f4fb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/02/2024 à 21:31, David Lechner a écrit :
> Profiling has shown that ida_alloc_range() accounts for about 10% of the
> time spent in spi_sync() when using the AXI SPI Engine controller. This
> call is used to create a unique id for each SPI message to match to an
> IRQ when the message is complete.
> 
> Since the core SPI code serializes messages in a message queue, we can
> only have one message in flight at a time, namely host->cur_msg. This
> means that we can use a fixed value instead of a unique id for each
> message since there can never be more than one message pending at a
> time.
> 
> This patch removes the use of ida...

So, maybe #include <linux/idr.h> can be removed as well?
(untested)



Also, even if unrelated to your changes, spi_engine_prepare_message() 
could use struct_size() in:

	size = sizeof(*p->instructions) * (p_dry.length + 1);
	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);

-->
	p = kzalloc(struct_size(p, instructions, p_dry.length + 1, GFP_KERNEL);

which can be a little safer and less verbose.

CJ

> ...for the sync id and replaces it with a
> constant value. This simplifies the driver and improves performance.
> 
> Signed-off-by: David Lechner <dlechner-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/spi/spi-axi-spi-engine.c | 27 ++++++---------------------
>   1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 6b0c72bf3395..9cc602075c17 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -57,6 +57,9 @@
>   #define SPI_ENGINE_TRANSFER_WRITE		0x1
>   #define SPI_ENGINE_TRANSFER_READ		0x2
>   
> +/* Arbitrary sync ID for use by host->cur_msg */
> +#define AXI_SPI_ENGINE_CUR_MSG_SYNC_ID		0x1
> +
>   #define SPI_ENGINE_CMD(inst, arg1, arg2) \
>   	(((inst) << 12) | ((arg1) << 8) | (arg2))
>   
> @@ -98,8 +101,6 @@ struct spi_engine_message_state {
>   	unsigned int rx_length;
>   	/** @rx_buf: Bytes not yet written to the RX FIFO. */
>   	uint8_t *rx_buf;
> -	/** @sync_id: ID to correlate SYNC interrupts with this message. */
> -	u8 sync_id;
>   };
>   
>   struct spi_engine {
> @@ -109,7 +110,6 @@ struct spi_engine {
>   	spinlock_t lock;
>   
>   	void __iomem *base;
> -	struct ida sync_ida;
>   	struct timer_list watchdog_timer;
>   	struct spi_controller *controller;
>   
> @@ -483,9 +483,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
>   	}
>   
>   	if (pending & SPI_ENGINE_INT_SYNC && msg) {
> -		struct spi_engine_message_state *st = msg->state;
> -
> -		if (completed_id == st->sync_id) {
> +		if (completed_id == AXI_SPI_ENGINE_CUR_MSG_SYNC_ID) {
>   			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
>   				msg->status = 0;
>   				msg->actual_length = msg->frame_length;
> @@ -510,10 +508,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
>   				      struct spi_message *msg)
>   {
>   	struct spi_engine_program p_dry, *p;
> -	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>   	struct spi_engine_message_state *st;
>   	size_t size;
> -	int ret;
>   
>   	st = kzalloc(sizeof(*st), GFP_KERNEL);
>   	if (!st)
> @@ -531,18 +527,10 @@ static int spi_engine_prepare_message(struct spi_controller *host,
>   		return -ENOMEM;
>   	}
>   
> -	ret = ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
> -	if (ret < 0) {
> -		kfree(p);
> -		kfree(st);
> -		return ret;
> -	}
> -
> -	st->sync_id = ret;
> -
>   	spi_engine_compile_message(msg, false, p);
>   
> -	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st->sync_id));
> +	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
> +						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
>   
>   	st->p = p;
>   	st->cmd_buf = p->instructions;
> @@ -555,10 +543,8 @@ static int spi_engine_prepare_message(struct spi_controller *host,
>   static int spi_engine_unprepare_message(struct spi_controller *host,
>   					struct spi_message *msg)
>   {
> -	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>   	struct spi_engine_message_state *st = msg->state;
>   
> -	ida_free(&spi_engine->sync_ida, st->sync_id);
>   	kfree(st->p);
>   	kfree(st);
>   
> @@ -640,7 +626,6 @@ static int spi_engine_probe(struct platform_device *pdev)
>   	spi_engine = spi_controller_get_devdata(host);
>   
>   	spin_lock_init(&spi_engine->lock);
> -	ida_init(&spi_engine->sync_ida);
>   	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout, TIMER_IRQSAFE);
>   	spi_engine->controller = host;
>   
> 


