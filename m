Return-Path: <linux-kernel+bounces-72847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D585B970
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CE51C21A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4A64AB3;
	Tue, 20 Feb 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwNz+Mih"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1762178;
	Tue, 20 Feb 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425960; cv=none; b=nsWMzPwALEimDpHqvlTm3FepTwoIE9+t5mBPVUY67zx3GjG89Zs5gQCQGqFgaUefAJHe/sO5uNoHJtNz3uJIv5K9sQcdWJyTFt+kJZvIHGjFN3QC0toNiQ/5b5b/oTDyzYBipNEhm4J7uP4TOxZHb4IoeURfozSqB/qNIOvJz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425960; c=relaxed/simple;
	bh=WLC9A6RG43jvwrhWBB+oSU4f9HEJVPsaXP+dzWiKVLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPOgVIIpaTNK9rV5tKGnMmuQ2ZIvRtQ45Dyw+S4l/VcJwCQvPd7rmODVhb+oXM1/JryXowfJsJtrBX/bpULiPP4ElpbfXmU42DhTflDNyc83NFLUKWPSe49MK4qCuBFcbSrOc4GJu4mx6Gexz6QsYAKZ0MB3Hwk1hhWmlOruqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwNz+Mih; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3394bec856fso3595803f8f.0;
        Tue, 20 Feb 2024 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708425957; x=1709030757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IkAfoQIWrV+GrZl5t56+RUv5w7RyqldnbP9GJ593z8k=;
        b=lwNz+Mihf0FQv6880271A7tmEGR3HI+lRTAo5TQSzmAjeBUvjUcCYufM0fVOr+GjHn
         Z1sHEqNOexk5KlppFaVoc+XiQ/75JRVnC8pubSBE0gF9FQdFF3kKsxBSqV4tyPFqCaWW
         GHA5uIbxzOld9FoVnCZc4V2S1tF4CQn9XL/Pmj+P826Zw176xncN+a/+1LEbm+OwXY3L
         s2NEXIAXOYakOTctqZlhly6Ge+28gavifS3Zy2B74xNUhnFsh1JByG2HCeRNftEORp8j
         f6cgw7mEyRqBGdxDOMZ0t8dwGLQ1+TxUNQLnmGzV7L0V5zpvyhW/GUI4iptmLKnv+xVw
         aEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425957; x=1709030757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkAfoQIWrV+GrZl5t56+RUv5w7RyqldnbP9GJ593z8k=;
        b=RbKx9TS4y5438w2zqjLJuDn0/atJrmglN861k0QaGBTxEwUyRwVpYs9yDpzFBu6LsW
         Iaj+pqR/E138pG/5up5PTYLgf87X3DBPp5x7Szt+bO/n9wOCkbwEq4ZtYjufihB+L+dJ
         7FoBriuhdCxmpHSzRfI22OlCzlxX0mO7MS5mBzJD8MdYz6xYR6FpOL24lwqOLn6w+LXy
         LpGuikOOrxUmN2GNeBSlI2u/ODAFW2LR2Rd05n95qJvjifqRsRyRDvjaMRjUv6uD/nNj
         vtop06a9OsKPBCcr8JuVP5qXl8c+AtM5naiom7GrGN+6hSv1EfSyxH6fXFFW+BfRM2kg
         ggOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbklh+MVlFULpRz4DHxcEC0kDtYWaUPhbsG+odGtg2kkjqVbRqWJOv9bs1skZmWzX7O2tgFxsxah7kwBnDd+hSRzgEugjVE2UFsKj455v6tMd1C3anZ/dtXrAm4hd+kvFTQxN1+2lIUC5wfWz3VAk+nQcI88UMguXHnib2TOLauQ5t
X-Gm-Message-State: AOJu0YxPkRzh3shixT8GDKZJaKHeQIk/o27uhD2K8Ut5/BsW+eSPGl/r
	4OEeNKZAkc07ugdZJdhPjUH95OgmGExAGfx78UhsvLqdUBqGla8H
X-Google-Smtp-Source: AGHT+IGvpc4sNp6r9IeGaZC2+2LohpKWIhDpHi9cDSNvwSikx9oiplcouedvHv+qd+byu76Vkvi/qg==
X-Received: by 2002:a5d:588a:0:b0:33d:3b83:c08 with SMTP id n10-20020a5d588a000000b0033d3b830c08mr7206557wrf.23.1708425956590;
        Tue, 20 Feb 2024 02:45:56 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bce08000000b004107dfa6aebsm13968319wmc.28.2024.02.20.02.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:45:56 -0800 (PST)
Message-ID: <d5fcd8b83f424bc05d8363210632bf8db4c376cb.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] spi: axi-spi-engine: move message compile to
 optimize_message
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander
 <david@protonic.nl>,  Jonathan Cameron <jic23@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-iio@vger.kernel.org, Julien
 Stephan <jstephan@baylibre.com>
Date: Tue, 20 Feb 2024 11:45:55 +0100
In-Reply-To: <20240219-mainline-spi-precook-message-v2-4-4a762c6701b9@baylibre.com>
References: 
	<20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	 <20240219-mainline-spi-precook-message-v2-4-4a762c6701b9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 16:33 -0600, David Lechner wrote:
> In the AXI SPI Engine driver, compiling the message is an expensive
> operation. Previously, it was done per message transfer in the
> prepare_message hook. This patch moves the message compile to the
> optimize_message hook so that it is only done once per message in
> cases where the peripheral driver calls spi_optimize_message().
>=20
> This can be a significant performance improvement for some peripherals.
> For example, the ad7380 driver saw a 13% improvement in throughput
> when using the AXI SPI Engine driver with this patch.
>=20
> Since we now need two message states, one for the optimization stage
> that doesn't change for the lifetime of the message and one that is
> reset on each transfer for managing the current transfer state, the old
> msg->state is split into msg->opt_state and spi_engine->msg_state. The
> latter is included in the driver struct now since there is only one
> current message at a time that can ever use it and it is in a hot path
> so avoiding allocating a new one on each message transfer saves a few
> cpu cycles and lets us get rid of the prepare_message callback.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v2 changes: none
>=20
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 40 +++++++++++++++++------------=
-----------
> =C2=A01 file changed, 17 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-e=
ngine.c
> index ca66d202f0e2..6177c1a8d56e 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -109,6 +109,7 @@ struct spi_engine {
> =C2=A0	spinlock_t lock;
> =C2=A0
> =C2=A0	void __iomem *base;
> +	struct spi_engine_message_state msg_state;
> =C2=A0	struct completion msg_complete;
> =C2=A0	unsigned int int_enable;
> =C2=A0};
> @@ -499,17 +500,11 @@ static irqreturn_t spi_engine_irq(int irq, void *de=
vid)
> =C2=A0	return IRQ_HANDLED;
> =C2=A0}
> =C2=A0
> -static int spi_engine_prepare_message(struct spi_controller *host,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg)
> +static int spi_engine_optimize_message(struct spi_message *msg)
> =C2=A0{
> =C2=A0	struct spi_engine_program p_dry, *p;
> -	struct spi_engine_message_state *st;
> =C2=A0	size_t size;
> =C2=A0
> -	st =3D kzalloc(sizeof(*st), GFP_KERNEL);
> -	if (!st)
> -		return -ENOMEM;
> -
> =C2=A0	spi_engine_precompile_message(msg);
> =C2=A0
> =C2=A0	p_dry.length =3D 0;
> @@ -517,31 +512,22 @@ static int spi_engine_prepare_message(struct spi_co=
ntroller
> *host,
> =C2=A0
> =C2=A0	size =3D sizeof(*p->instructions) * (p_dry.length + 1);
> =C2=A0	p =3D kzalloc(sizeof(*p) + size, GFP_KERNEL);
> -	if (!p) {
> -		kfree(st);
> +	if (!p)
> =C2=A0		return -ENOMEM;
> -	}
> =C2=A0
> =C2=A0	spi_engine_compile_message(msg, false, p);
> =C2=A0
> =C2=A0	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
> =C2=A0						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
> =C2=A0
> -	st->p =3D p;
> -	st->cmd_buf =3D p->instructions;
> -	st->cmd_length =3D p->length;
> -	msg->state =3D st;
> +	msg->opt_state =3D p;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int spi_engine_unprepare_message(struct spi_controller *host,
> -					struct spi_message *msg)
> +static int spi_engine_unoptimize_message(struct spi_message *msg)
> =C2=A0{
> -	struct spi_engine_message_state *st =3D msg->state;
> -
> -	kfree(st->p);
> -	kfree(st);
> +	kfree(msg->opt_state);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -550,10 +536,18 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0	struct spi_message *msg)
> =C2=A0{
> =C2=A0	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host)=
;
> -	struct spi_engine_message_state *st =3D msg->state;
> +	struct spi_engine_message_state *st =3D &spi_engine->msg_state;
> +	struct spi_engine_program *p =3D msg->opt_state;
> =C2=A0	unsigned int int_enable =3D 0;
> =C2=A0	unsigned long flags;
> =C2=A0
> +	/* reinitialize message state for this transfer */
> +	memset(st, 0, sizeof(*st));
> +	st->p =3D p;
> +	st->cmd_buf =3D p->instructions;
> +	st->cmd_length =3D p->length;
> +	msg->state =3D st;
> +
> =C2=A0	reinit_completion(&spi_engine->msg_complete);
> =C2=A0
> =C2=A0	spin_lock_irqsave(&spi_engine->lock, flags);
> @@ -658,8 +652,8 @@ static int spi_engine_probe(struct platform_device *p=
dev)
> =C2=A0	host->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(1, 32);
> =C2=A0	host->max_speed_hz =3D clk_get_rate(spi_engine->ref_clk) / 2;
> =C2=A0	host->transfer_one_message =3D spi_engine_transfer_one_message;
> -	host->prepare_message =3D spi_engine_prepare_message;
> -	host->unprepare_message =3D spi_engine_unprepare_message;
> +	host->optimize_message =3D spi_engine_optimize_message;
> +	host->unoptimize_message =3D spi_engine_unoptimize_message;
> =C2=A0	host->num_chipselect =3D 8;
> =C2=A0
> =C2=A0	if (host->max_speed_hz =3D=3D 0)
>=20


