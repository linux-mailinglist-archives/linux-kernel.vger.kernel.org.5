Return-Path: <linux-kernel+bounces-46886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496298445CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0461328D8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D70D12CD9D;
	Wed, 31 Jan 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WgUObyZ/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B77EF1B;
	Wed, 31 Jan 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721294; cv=none; b=OxQW1EKMp5oZqW8Ff2zkjTVWVgW/KES/GusB7qLYggQYnkTY8fWG7iAGBNMgzcsAn/Gia0QE8g5TvJpi7LPjELI5weYFx/bfxsCgkkLVVjbVgCsJXdNbYZ+ikN6F2vL+rM0jJFVEUX0b/Ryc9xv1al/fibOHBguiTarNHrvglnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721294; c=relaxed/simple;
	bh=umMTfbavV5anbbuvqaxrldcGPNeK3mMqhy5S46iPOGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNtYICpkzP61+mtbbqYs+BJOxusydV5QRdkCbmHoap9x3xAhD3GqEKdIe5Mr4lhZtNEa9iYjIafd+fEQvc7N+en+tGNIdlo0a6W8ZtDjahIcis1qFmLgfnjtw8WwdHJdWDa/dXC+jnbn7eprceULmu3dJOxG9tuGHjIlkydrXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WgUObyZ/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 094211C0008;
	Wed, 31 Jan 2024 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706721284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lTRq8lZT7hitaFYIXz5SPSPzis0fVqQJM+pMRYZ704=;
	b=WgUObyZ/9pP6ARuPtDDuoCxJPd9co0I0PlUUhWF71vCyZeBfWeR8Ss2Y+MI8LZGFF8xGlz
	bsssTGy5GTkjZ5ISpRColNqsS+03eXLoQUs2cKzaxdZSzjL79o3Ila6FyUzsMJQ6wu6MP5
	RDlNIOTa8ikbVSJWA1mfgTkZA6QKQC7D4aUXlkWzuJ+be8Gl/Lre2TS6UFdppqVBOiJQ8m
	YBpeSA9DHN5llY89e9rWYl/zwHZPdgjFFyb5Bc6BOr7SPHd3A3/K07llty9wC/CG4gD5Wz
	VCl4pwBraurh0JzRu/edmfyVcNxiePIYSxn50JjqrOkxzthQQSI+vWBYMIfqgA==
Date: Wed, 31 Jan 2024 18:14:41 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Jeff LaBundy <jeff@labundy.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
	hannah.rossiter@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20240131171441.GA3005@kb-xps>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-4-kamel.bouhara@bootlin.com>
 <ZY5An58Rffrcpfpn@nixie71>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY5An58Rffrcpfpn@nixie71>
X-GND-Sasl: kamel.bouhara@bootlin.com

On Thu, Dec 28, 2023 at 09:44:31PM -0600, Jeff LaBundy wrote:
> Hi Kamel,
>

Hello Jeff,

[...]

> > +
> > +/*
> > + * Support function to axiom_process_u41_report.
> > + * Generates input-subsystem events for every target.
> > + * After calling this function the caller shall issue
> > + * a Sync to the input sub-system.
> > + */
> > +static bool axiom_process_u41_report_target(struct axiom_data *ts,
> > +					    struct axiom_target_report *target)
> > +{
> > +	struct input_dev *input_dev = ts->input_dev;
> > +	struct axiom_u41_target *target_prev_state;
> > +	enum axiom_target_state current_state;
> > +	bool update = false;
> > +	int slot;
> > +
> > +	/* Verify the target index */
> > +	if (target->index >= AXIOM_U41_MAX_TARGETS) {
> > +		dev_dbg(ts->dev, "Invalid target index! %u\n", target->index);
>
> Should this be dev_err()?
>
> > +		return false;
> > +	}
> > +
> > +	target_prev_state = &ts->targets[target->index];
> > +
> > +	current_state = AXIOM_TARGET_STATE_NOT_PRESENT;
> > +
> > +	if (target->present) {
> > +		if (target->z >= 0)
> > +			current_state = AXIOM_TARGET_STATE_TOUCHING;
> > +		else if (target->z > AXIOM_PROX_LEVEL && target->z < 0)
> > +			current_state = AXIOM_TARGET_STATE_HOVER;
> > +		else if (target->z == AXIOM_PROX_LEVEL)
> > +			current_state = AXIOM_TARGET_STATE_PROX;
> > +	}
> > +
> > +	if (target_prev_state->state == current_state &&
> > +	    target_prev_state->x == target->x &&
> > +	    target_prev_state->y == target->y &&
> > +	    target_prev_state->z == target->z) {
> > +		return false;
> > +	}
>
> No need for curly braces here; please refer to the kernel style guidelines.
>
> > +
> > +	slot = target->index;
> > +
> > +	dev_dbg(ts->dev, "U41 Target T%u, slot:%u present:%u, x:%u, y:%u, z:%d\n",
> > +		target->index, slot, target->present,
> > +		target->x, target->y, target->z);
> > +
> > +	switch (current_state) {
> > +	case AXIOM_TARGET_STATE_NOT_PRESENT:
> > +	case AXIOM_TARGET_STATE_PROX:
> > +		if (!target_prev_state->insert)
> > +			break;
> > +		update = true;
> > +		target_prev_state->insert = false;
> > +		input_mt_slot(input_dev, slot);
> > +
> > +		if (!slot)
> > +			input_report_key(input_dev, BTN_TOUCH, 0);
> > +
> > +		input_mt_report_slot_inactive(input_dev);
> > +		/*
> > +		 * make sure the previous coordinates are
> > +		 * all off screen when the finger comes back
> > +		 */
> > +		target->x = 65535;
> > +		target->y = 65535;
> > +		target->z = AXIOM_PROX_LEVEL;
> > +		break;
> > +	case AXIOM_TARGET_STATE_HOVER:
> > +	case AXIOM_TARGET_STATE_TOUCHING:
> > +		target_prev_state->insert = true;
> > +		update = true;
> > +		input_mt_slot(input_dev, slot);
> > +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, slot);
> > +		input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
> > +		input_report_abs(input_dev, ABS_X, target->x);
>
> You do not need to explicitly report ABS_X and ABS_Y values, as calling
> input_mt_sync_frame() effectively takes care of this by way of pointer
> emulation.
>

After double checking/testing this, it doesn't seems to
report ABS_X/Y values anymore, are you sure about this ? Maybe I missed
some extra flag in input_mt_init_slots() for that ?

Regards,

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

