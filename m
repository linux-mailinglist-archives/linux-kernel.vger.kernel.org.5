Return-Path: <linux-kernel+bounces-20117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59518279D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2AE1C21E58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85655E7E;
	Mon,  8 Jan 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOmFi1b2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D155E52
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-467e4a04086so58000137.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704747642; x=1705352442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jubS28CdqDpXEIN0KSIdOiEoCQYamsfax2OJPyFTjCs=;
        b=aOmFi1b2s0/Cb/bvEyvCAc6gcvj+A8iJC6bvdOY9g21EePN3rYjIjwMNWfjfoGlfyp
         tGvyr5K0XuGn7WcGs4dwqYwBnkEpjljvnkcFLrM8SuSIqesdOHfACynu7Di0+bS7UkCU
         Z8sapT+Th8NYJ1mo/3iOl2l1Arw2jHzohle1nU07xIJOKAWpBfop9VHPH15mcLEYezj1
         SnSlj5AoYy2+zBIZMKqymmsq6kWow0hLDTjNuWE5xcM+wLkBOd79oYFv03/hu5+WVwCN
         iAKGvf/fHGlMSLEYyutzbI3DgJVxhQvcNWXbBH1Un6ntPqxRM0khyj/y42EhwEwwk5vN
         i0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747642; x=1705352442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jubS28CdqDpXEIN0KSIdOiEoCQYamsfax2OJPyFTjCs=;
        b=OIOjMijd7GgmEYbL4SN10D+nG5/uOse2ctXbmz/evhMLWZJx/TwjFCvCsn1WhhNngL
         MREPv253eP+UinMeDSIcfwqKxIUu7C9VcTIlrpP1IiLkE1qU62klKTmdauyz+UWhqkxT
         sk4K5Q/6SEusjullFVdxRmI4ilS1PpDqDvkHlpsGgVlUYNsHWfyBgMgY+HLdzsq+PIqA
         IPjhhPz2X3F6VR5vdvfWgOc43EEnobebhIm4kKVIYprAWDhtZIPEvu6WU/PUnHtWpNKl
         RjjCv3futXP3kbFkXk1nJakhnrZ6LOkPGN7mOnbB/8102rqeujtz83JNV0Xj40P4j04r
         /Tog==
X-Gm-Message-State: AOJu0YzTxD46jEYQjyuvjadP2/16u1o26iXjjUjjwMyWEcKExqxADJHv
	RaXQRbOq4YJRkRJKa21HlUo7uU9desCMCw==
X-Google-Smtp-Source: AGHT+IH40dToo2nxI7FwTwedlD2daT9m4ugP9EnbpbNyHmOKPfxnIIPTzx8QU3W0REgYujqbeqGoMw==
X-Received: by 2002:a05:6102:c89:b0:467:dfed:7c59 with SMTP id f9-20020a0561020c8900b00467dfed7c59mr805426vst.34.1704747642195;
        Mon, 08 Jan 2024 13:00:42 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id j12-20020a0561023e0c00b0046705f8336esm83178vsv.21.2024.01.08.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 13:00:41 -0800 (PST)
Date: Mon, 8 Jan 2024 21:00:37 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 09/10] counter: stm32-timer-cnt: add support for
 overflow events
Message-ID: <ZZxidRueG8H/O7pw@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-10-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2Szsr92fW5ygJV2"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-10-fabrice.gasnier@foss.st.com>


--y2Szsr92fW5ygJV2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:25PM +0100, Fabrice Gasnier wrote:
> Add support overflow events. Also add the related validation and
> configuration routine. Register and enable interrupts to push events.
> STM32 Timers can have either 1 global interrupt, or 4 dedicated interrupt
> lines. Request only the necessary interrupt, e.g. either global interrupt
> that can report all event types, or update interrupt only for overflow
> event.
>=20
> Acked-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi Fabrice,

I've CC'd Will and Peter in case they can provide some suggestions
regarding my atomic_t comment inline below.

> @@ -44,6 +45,9 @@ struct stm32_timer_cnt {
>  	bool has_encoder;
>  	u32 idx;
>  	unsigned int nchannels;
> +	unsigned int nr_irqs;
> +	u32 *irq;

Looks like we only need this 'irq' array for registering the ISR in
stm32_timer_cnt_probe(). Since we won't need it anymore after that,
let's use ddata->irq directly instead of defining priv->irq.

> +	atomic_t nb_ovf;
>  };
> =20
>  static const enum counter_function stm32_count_functions[] =3D {
> @@ -259,6 +263,29 @@ static int stm32_count_prescaler_write(struct counte=
r_device *counter,
>  	return regmap_write(priv->regmap, TIM_PSC, psc);
>  }
> =20
> +static int stm32_count_nb_ovf_read(struct counter_device *counter,
> +				   struct counter_count *count, u64 *val)
> +{
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
> +
> +	*val =3D atomic_read(&priv->nb_ovf);
> +
> +	return 0;
> +}
> +
> +static int stm32_count_nb_ovf_write(struct counter_device *counter,
> +				    struct counter_count *count, u64 val)
> +{
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
> +
> +	if (val !=3D (typeof(priv->nb_ovf.counter))val)
> +		return -ERANGE;
> +
> +	atomic_set(&priv->nb_ovf, val);

So you want to check that the atomic_t 'nb_ovf' is able hold the value
provided by the u64 'val'. My understanding is that atomic_t should be
treated as an opaque type, so I don't think we should be accessing the
'counter' member directly for this test (interrupt-cnt does this but I
believe it's wrong to do so).

I don't know if we have any existing way to check for the value range of
an atomic_t (I don't see anything under include/linux/limits.h
specifically for it). However, you do use atomic_set() which takes an
int parameter, so perhaps we should compare against INT_MAX instead.

> +static int stm32_count_events_configure(struct counter_device *counter)
> +{
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
> +	struct counter_event_node *event_node;
> +	u32 val, dier =3D 0;
> +
> +	list_for_each_entry(event_node, &counter->events_list, l) {
> +		switch (event_node->event) {
> +		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
> +			/* first clear possibly latched UIF before enabling */
> +			regmap_read(priv->regmap, TIM_DIER, &val);
> +			if (!(val & TIM_DIER_UIE))

You can eliminate 'val' and the regmap_read() line like this:

    if (!regmap_test_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE))

> +				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
> +			dier |=3D TIM_DIER_UIE;
> +			break;
> +		default:
> +			/* should never reach this path */
> +			return -EINVAL;
> +		}
> +	}
> +
> +	regmap_write(priv->regmap, TIM_DIER, dier);

Do you want to overwrite TIM_DIER completely, or did you mean to set
only TIM_DIER_UIE and preserve the rest of the register? If the latter,
you could redefine 'dier' as a bool and do:

    regmap_update_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE, dier);

There is also a regmap_update_bits_check() available if you want to
combine the UIF latch check with the update; but I don't know if that
will work in this case because it looks like you want to clear the UIF
latch before enabling.

>  static int stm32_count_clk_get_freq(struct counter_device *counter,
> @@ -418,6 +491,35 @@ static struct counter_count stm32_counts =3D {
>  	.num_ext =3D ARRAY_SIZE(stm32_count_ext)
>  };
> =20
> +static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
> +{
> +	struct counter_device *counter =3D ptr;
> +	struct stm32_timer_cnt *const priv =3D counter_priv(counter);
> +	u32 clr =3D GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr=
 1 has no effect) */
> +	u32 sr, dier;
> +
> +	regmap_read(priv->regmap, TIM_SR, &sr);
> +	regmap_read(priv->regmap, TIM_DIER, &dier);
> +	/*
> +	 * Some status bits in SR don't match with the enable bits in DIER. Onl=
y take care of
> +	 * the possibly enabled bits in DIER (that matches in between SR and DI=
ER).
> +	 */
> +	dier &=3D TIM_DIER_UIE;
> +	sr &=3D dier;
> +
> +	if (sr & TIM_SR_UIF) {

Am I understanding this logic correctly? ANDing TIM_DIER_UIE with 'dier'
will result in just the state of the TIM_DIER_UIE bit. Next, we AND that
state with 'sr'; so sr is 0 when TIM_DIER_UIE state is low, but we get
the respective SR bit when TIM_DIER_UIE state is high. Finally, we check
the TIM_SR_UIF bit state in 'sr'.

If TIM_SR_UIF bit position is expected to match the TIM_DIER_UIE bit
position, then (sr & TIM_SR_UIF) will only be true when the state of
both the TIM_DIER_UIE bit and TIM_SR_UIF bit are high. That means you
can eliminate 'sr', 'dier', and the two regmap_read() operations with
this instead:

    if (regmap_test_bits(priv->regmap, TIM_SR, TIM_SR_UIF) &&
        regmap_test_bits(priv->regmap, TIM_DIER, TIM_DIER_UIE) {

> +		atomic_inc(&priv->nb_ovf);

I wonder what happens when atomic_inc() increments past the atomic_t max
value. Does atomic_read() report back a negative value? Do we need to
guard against that scenario somehow?

> +		counter_push_event(counter, COUNTER_EVENT_OVERFLOW_UNDERFLOW, 0);
> +		dev_dbg(counter->parent, "COUNTER_EVENT_OVERFLOW_UNDERFLOW\n");
> +		/* SR flags can be cleared by writing 0, only clear relevant flag */
> +		clr &=3D ~TIM_SR_UIF;

You can use u32p_replace_bits(&clr, 0, TIM_SR_UIF) instead after
including the include/linux/bitfield.h header.

> @@ -511,6 +615,32 @@ static int stm32_timer_cnt_probe(struct platform_dev=
ice *pdev)
> =20
>  	platform_set_drvdata(pdev, priv);
> =20
> +	/* STM32 Timers can have either 1 global, or 4 dedicated interrupts (op=
tional) */
> +	if (priv->nr_irqs =3D=3D 1) {
> +		/* All events reported through the global interrupt */
> +		ret =3D devm_request_irq(&pdev->dev, priv->irq[0], stm32_timer_cnt_isr,
> +				       0, dev_name(dev), counter);
> +		if (ret) {
> +			dev_err(dev, "Failed to request irq %d (err %d)\n",
> +				priv->irq[i], ret);

This should be irq[0], right?

I would also recommend using ddata->irq instead so we can get rid of
priv->irq outside of this probe function.

> +			return ret;
> +		}
> +	} else {
> +		for (i =3D 0; i < priv->nr_irqs; i++) {
> +			/* Only take care of update IRQ for overflow events */
> +			if (i !=3D STM32_TIMERS_IRQ_UP)
> +				continue;
> +
> +			ret =3D devm_request_irq(&pdev->dev, priv->irq[i], stm32_timer_cnt_is=
r,
> +					       0, dev_name(dev), counter);
> +			if (ret) {
> +				dev_err(dev, "Failed to request irq %d (err %d)\n",
> +					priv->irq[i], ret);
> +				return ret;
> +			}
> +		}

So we only execute the loop body once for this particular
STM32_TIMERS_IRQ_UP iteration? Why have the loop at all rather than
hardcode irq[STM32_TIMERS_IRQ_UP] for devm_request_irq()?

William Breathitt Gray

--y2Szsr92fW5ygJV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZxidQAKCRC1SFbKvhIj
K9DfAP9PSngix81Cc5vJimGdV8ajgN0Cw9FphpH3wV59yvvt7gEA2YNr5+TM93PH
jaNQaey6hNnMEHxefK6M/LZqFLNAzw0=
=oNUg
-----END PGP SIGNATURE-----

--y2Szsr92fW5ygJV2--

