Return-Path: <linux-kernel+bounces-56234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8CF84C7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3951C20399
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556731755;
	Wed,  7 Feb 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTdePYTw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DD2E856;
	Wed,  7 Feb 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298636; cv=none; b=W9jhRV3clhPPGRSB7Xk36ZZt6BYhXZJZTUeuycZCALQlbg+jyVPrJj1s3HzJlpMHI8Yvytf/3ALlEskgwJEV0VIiO/8me7W2/r0yVJoaZnDxAw3KIwSRz3atMl/dlJei9dJYYPYQVt+4GoYqYkqrLjwI9cj5zyKJu5Y4+QgqPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298636; c=relaxed/simple;
	bh=jD74/OXe2zoUqZqyp9ScLDZlnXW/T1pmCEKlnedAd9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hcsy15oLyO5oRXHXObyK+VKZOwhMM18kULyJGl5nP0rI0RGSZ0vQPGAF1WMdfHsZns7afNP2szvZFGrV6GRAk+unww8ReccGXulf7w8dYnEyuKtQMv6DDVk7WVnGEILBdPjS8dkZlPavlI76XQWt1luKgu3vnSjbTAX4d9Q9uIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTdePYTw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so447910a12.1;
        Wed, 07 Feb 2024 01:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707298632; x=1707903432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JfXvvu+HsovAZLw8GvNlR1k3mnZ7saMLC2BakLo8+0I=;
        b=cTdePYTw8y8aiDRjiycIwkux5mW3r6rzWoalcjntWSq52s/G7Sxy8LCdKqyb9EllwE
         NoXPcX7emtq+sApZ4969ilLH/uJeVS/Z47wk4Vw6e9ZymV0inSvjN3nBoOQwrkQdl8au
         S1euTzvBPW11S1SabONvm+jolHUoBlYC95RJhL9bxyIV13BsULZ3gboFIOfW/ktgPQb8
         /hLvcGptuuZv6VlUU9W/9XhJC09sESfE9oS0EI8RSJRUTFwPYc8F3jvNUg6YysEnMi89
         gfyxjzyL73FBY+pF/tVehlhYVp6rcz8MgLsjEAjj9Qq5pMMSwDsiE0anxmBMg84Uicd3
         OP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298632; x=1707903432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfXvvu+HsovAZLw8GvNlR1k3mnZ7saMLC2BakLo8+0I=;
        b=ayiF/cp8ld6Z4k41MReu2lAUJDHxklHEMqP37OozWAgrw3SPHJfKQdGGY6VaZEK667
         no6K8b1V+/AJoNg7TVuurTP4xq+OGRkcFZjQ8svnW7YPpOhhsV8heKhovAtmNEa7Hb/M
         dbabYzcTDYsqdnl8LKu1NrV0kWPq/3Xt9reQ9Z6AZCJQDf45X3TthV1xwhrimPkb3PRn
         RGcq3XWOMbXFtdwKzCFWuePKtOEj0ttGinsxe4PLRpnEHjk9UGpNVIDoCvt8F60RC4pX
         T1FljYBlhfMXAVWnLzjpnHchBFoJD7FvKjWDGFrXiyPCbFBUfMbS9etv5g0rBSRP88AN
         jWiQ==
X-Gm-Message-State: AOJu0Yw+mGNwn8cLArbj7RGRgPTUpFh8HcOUJ9MHbCV/u3gbGpMaoug/
	JF5zBSH6k20gQfy6JcrUZcOv94ajZ1AVX6Xr/HkAn2k1RkdLxqgC
X-Google-Smtp-Source: AGHT+IHJ77QRT+A4Xc8pHqy2VfI7nvEopUvLe6bg5EpPwQ+W8xodbh+MjDR1PSOdTnIU9BxpKIzypw==
X-Received: by 2002:aa7:dcc5:0:b0:560:e66b:7934 with SMTP id w5-20020aa7dcc5000000b00560e66b7934mr347145edu.24.1707298632302;
        Wed, 07 Feb 2024 01:37:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKqjjpYD+kkGe07UKGU8TfY7QLyrstUeRX8zMbhv3tZPSkv9RM3yaD3TQ+oe6SNJZwHWENV5PFkkbVkxmZzyuU0jMlJt0JYrt+ajGNme6+MVoYZsXXYFVu7HRDGEaBEzk2hjnkIq+fumhhNjQ6h4rizN9IHk0qE6LsdtyNgFEGejXBdHSMfFWde8DiM1H2i+eNRnsPrIgdHNs=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id dk4-20020a0564021d8400b0056038077ffasm484036edb.38.2024.02.07.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:37:12 -0800 (PST)
Message-ID: <8bce57857a1fc45f7b80b99f9d0839bf18e7fbd5.camel@gmail.com>
Subject: Re: [PATCH 1/2] spi: axi-spi-engine: remove use of ida for sync id
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 10:40:31 +0100
In-Reply-To: <20240206-axi-spi-engine-round-2-1-v1-1-ea6eeb60f4fb@baylibre.com>
References: 
	<20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
	 <20240206-axi-spi-engine-round-2-1-v1-1-ea6eeb60f4fb@baylibre.com>
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
> Profiling has shown that ida_alloc_range() accounts for about 10% of the
> time spent in spi_sync() when using the AXI SPI Engine controller. This
> call is used to create a unique id for each SPI message to match to an
> IRQ when the message is complete.
>=20
> Since the core SPI code serializes messages in a message queue, we can
> only have one message in flight at a time, namely host->cur_msg. This
> means that we can use a fixed value instead of a unique id for each
> message since there can never be more than one message pending at a
> time.
>=20
> This patch removes the use of ida for the sync id and replaces it with a
> constant value. This simplifies the driver and improves performance.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

With the removed header:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

(Christophe suggestion is also pretty good but I would likely do it in a
different patch - maybe we could even annotate the flex array with __counte=
d_by)

- Nuno S=C3=A1

> =C2=A0drivers/spi/spi-axi-spi-engine.c | 27 ++++++---------------------
> =C2=A01 file changed, 6 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> engine.c
> index 6b0c72bf3395..9cc602075c17 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -57,6 +57,9 @@
> =C2=A0#define SPI_ENGINE_TRANSFER_WRITE		0x1
> =C2=A0#define SPI_ENGINE_TRANSFER_READ		0x2
> =C2=A0
> +/* Arbitrary sync ID for use by host->cur_msg */
> +#define AXI_SPI_ENGINE_CUR_MSG_SYNC_ID		0x1
> +
> =C2=A0#define SPI_ENGINE_CMD(inst, arg1, arg2) \
> =C2=A0	(((inst) << 12) | ((arg1) << 8) | (arg2))
> =C2=A0
> @@ -98,8 +101,6 @@ struct spi_engine_message_state {
> =C2=A0	unsigned int rx_length;
> =C2=A0	/** @rx_buf: Bytes not yet written to the RX FIFO. */
> =C2=A0	uint8_t *rx_buf;
> -	/** @sync_id: ID to correlate SYNC interrupts with this message. */
> -	u8 sync_id;
> =C2=A0};
> =C2=A0
> =C2=A0struct spi_engine {
> @@ -109,7 +110,6 @@ struct spi_engine {
> =C2=A0	spinlock_t lock;
> =C2=A0
> =C2=A0	void __iomem *base;
> -	struct ida sync_ida;
> =C2=A0	struct timer_list watchdog_timer;
> =C2=A0	struct spi_controller *controller;
> =C2=A0
> @@ -483,9 +483,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devi=
d)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (pending & SPI_ENGINE_INT_SYNC && msg) {
> -		struct spi_engine_message_state *st =3D msg->state;
> -
> -		if (completed_id =3D=3D st->sync_id) {
> +		if (completed_id =3D=3D AXI_SPI_ENGINE_CUR_MSG_SYNC_ID) {
> =C2=A0			if (timer_delete_sync(&spi_engine->watchdog_timer)) {
> =C2=A0				msg->status =3D 0;
> =C2=A0				msg->actual_length =3D msg->frame_length;
> @@ -510,10 +508,8 @@ static int spi_engine_prepare_message(struct
> spi_controller *host,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg)
> =C2=A0{
> =C2=A0	struct spi_engine_program p_dry, *p;
> -	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> =C2=A0	struct spi_engine_message_state *st;
> =C2=A0	size_t size;
> -	int ret;
> =C2=A0
> =C2=A0	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
> =C2=A0	if (!st)
> @@ -531,18 +527,10 @@ static int spi_engine_prepare_message(struct
> spi_controller *host,
> =C2=A0		return -ENOMEM;
> =C2=A0	}
> =C2=A0
> -	ret =3D ida_alloc_range(&spi_engine->sync_ida, 0, U8_MAX, GFP_KERNEL);
> -	if (ret < 0) {
> -		kfree(p);
> -		kfree(st);
> -		return ret;
> -	}
> -
> -	st->sync_id =3D ret;
> -
> =C2=A0	spi_engine_compile_message(msg, false, p);
> =C2=A0
> -	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(st-
> >sync_id));
> +	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
> +						AXI_SPI_ENGINE_CUR_MSG_SYNC_I
> D));
> =C2=A0
> =C2=A0	st->p =3D p;
> =C2=A0	st->cmd_buf =3D p->instructions;
> @@ -555,10 +543,8 @@ static int spi_engine_prepare_message(struct
> spi_controller *host,
> =C2=A0static int spi_engine_unprepare_message(struct spi_controller *host=
,
> =C2=A0					struct spi_message *msg)
> =C2=A0{
> -	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> =C2=A0	struct spi_engine_message_state *st =3D msg->state;
> =C2=A0
> -	ida_free(&spi_engine->sync_ida, st->sync_id);
> =C2=A0	kfree(st->p);
> =C2=A0	kfree(st);
> =C2=A0
> @@ -640,7 +626,6 @@ static int spi_engine_probe(struct platform_device *p=
dev)
> =C2=A0	spi_engine =3D spi_controller_get_devdata(host);
> =C2=A0
> =C2=A0	spin_lock_init(&spi_engine->lock);
> -	ida_init(&spi_engine->sync_ida);
> =C2=A0	timer_setup(&spi_engine->watchdog_timer, spi_engine_timeout,
> TIMER_IRQSAFE);
> =C2=A0	spi_engine->controller =3D host;
> =C2=A0
>=20


