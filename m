Return-Path: <linux-kernel+bounces-156545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B28B0456
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088731F229C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE715664E;
	Wed, 24 Apr 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="n3HRYxEM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ohi95WNK"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8701CFB2;
	Wed, 24 Apr 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947440; cv=pass; b=eL1yMNaZLD6/B1nwivlYkY4LjEU8y/wyFVSLAT66E70xH4iTbWfZZ4W77qmLucOWQpHz+SOs+feBSWjKPGyUYnhNjuhHjcj8YTZuJufkUe01vtt+ojvMmW3Ytcav+vdSjaCnF0MYBqr2UXKVQcr9NOx/AE7xxNAisEc3EkM0Yg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947440; c=relaxed/simple;
	bh=HZRd5Sji4u0FknZd+UNKw8clHjJbnVk/ortExV5eoLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQEXRfy6Bl2ojJN3+kDbhNdKiKaL+8k4dGzFN2IgkNMBfSJdmyYXdADi/f+EriKOs+xqMYNGx7QeldPaGyXSwhVz2Kq7R6TtCxqUuQj9bZMOJ/7+EZI+Qtan5EcsXwYgqhrXO64nJrredyiZ1k+Gwbb0+xNj6C/Kcik7mexGb1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=n3HRYxEM; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ohi95WNK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4VPXHY4LXXz49PwQ;
	Wed, 24 Apr 2024 11:30:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713947433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2uP0HlkkcYb29qNNXKq5zn2KaY6EI9tc7pBq2JvLWs=;
	b=n3HRYxEMr5gsA6Jse99M59u4CbpdUrsjtCYaDZD1FFPU97S80E1oSXQxrf+rHTnJ3gkTlk
	+luLdjyOMvdc9A9SOS+0YZ6udW1XcuFY7lgWTtra6BYbl+LcYxLAhchjpdoLcLbWnW9Gvy
	HT3sfaxKKL629Sl012EDwOplI1rvtTuyEBzJbwyr7DPE62uwrsqACXbHTjM3ZAmM8YgEDx
	+jMQn5yXxIRdKxZS5tO8+wb/pCAhBWyrEJ42nt3ULilVEC54H9ca4L98PHa9Jast9ezLRf
	sd8GzWWbBDoEkomG6d/pCTaKOnbasbxgcIJD9jWcV6e9NMXeXBzj3Eim0CWOiQ==
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VPXHM3jJwzyRf;
	Wed, 24 Apr 2024 11:30:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1713947425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2uP0HlkkcYb29qNNXKq5zn2KaY6EI9tc7pBq2JvLWs=;
	b=ohi95WNKy80W5wW9eqwfUNGyGFYZcnzuILf9KpCGEk3qN0qVzAr7r3csb6+3Upn2gFMg+0
	J6r+iSFiERY+ZT6sQJrg8qnFFQTMz2YqggZoHxWH8GJmRtqhV2SVutKBXkKh/LrLFypPHH
	u4/iO7KC+8y5sTd1/dfYBWM+8VnLEH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1713947425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2uP0HlkkcYb29qNNXKq5zn2KaY6EI9tc7pBq2JvLWs=;
	b=rW+mDMGuAXr3HfmYkMR+bJcZRdrA6MbFzuxTFcgAfgeG1PjYc9EGw0fIzRhmKKUzpbgRU3
	4H0vBIx3MRWZ5dSR04VYbT7qfi7RuucF1gaJQ0omUfqd/jKn9j/g4acv1TGaFPrdU+0wBt
	N78oyrRZ72L1ZuII97xBLTzuer55k1Y=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1713947425; a=rsa-sha256; cv=none;
	b=AO0Q8clkqabsZbtUXpjAC4q8pFkI66Ilwf64XSo/EoSMnV9QfTmDdEvy2WVHH5b+nm32AP
	GAVY14YgKqvsFnNOWgz1hSWyyIMnKcOldhh7Q6gMKOoyfLlS384VAdZOP3L7J5Gcsd8I35
	K0h7wFDLUgtEZG618mSN74HNqMnELH8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C006F634C96;
	Wed, 24 Apr 2024 11:30:22 +0300 (EEST)
Date: Wed, 24 Apr 2024 08:30:22 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 4/4] media: i2c: add MAX96714 driver
Message-ID: <ZijDHtSa2vACgBjl@valkosipuli.retiisi.eu>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-5-julien.massot@collabora.com>
 <ZhkaR-83uciNFi2b@valkosipuli.retiisi.eu>
 <a70e3792-b938-4c20-840d-5dfa9bdc4b9c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a70e3792-b938-4c20-840d-5dfa9bdc4b9c@collabora.com>

Hi Julien,

On Tue, Apr 23, 2024 at 04:01:16PM +0200, Julien Massot wrote:

..

> > > +static int max96714_enable_streams(struct v4l2_subdev *sd,
> > > +				   struct v4l2_subdev_state *state,
> > > +				   u32 source_pad, u64 streams_mask)
> > > +{
> > > +	struct max96714_priv *priv = sd_to_max96714(sd);
> > > +	u64 sink_streams;
> > > +	int ret;
> > > +
> > > +	if (!priv->enabled_source_streams)
> > > +		max96714_enable_tx_port(priv);
> > > +
> > > +	ret = max96714_apply_patgen(priv, state);
> > > +	if (ret)
> > > +		goto err;
> > > +
> > > +	if (!priv->pattern) {
> > > +		if (!priv->rxport.source.sd) {
> > > +			ret = -ENODEV;
> > > +			goto err;
> > > +		}
> > > +
> > > +		sink_streams =
> > > +			v4l2_subdev_state_xlate_streams(state,
> > > +							MAX96714_PAD_SOURCE,
> > > +							MAX96714_PAD_SINK,
> > > +							&streams_mask);
> > > +
> > > +		ret = v4l2_subdev_enable_streams(priv->rxport.source.sd,
> > > +						 priv->rxport.source.pad,
> > > +						 sink_streams);
> > > +		if (ret)
> > > +			goto err;
> > > +	}
> > > +
> > > +	priv->enabled_source_streams |= streams_mask;
> > > +
> > > +	return 0;
> > > +
> > > +err:
> > > +	if (!priv->enabled_source_streams)
> > > +		max96714_disable_tx_port(priv);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int max96714_disable_streams(struct v4l2_subdev *sd,
> > > +				    struct v4l2_subdev_state *state,
> > > +				    u32 source_pad, u64 streams_mask)
> > > +{
> > > +	struct max96714_priv *priv = sd_to_max96714(sd);
> > > +	u64 sink_streams;
> > > +	int ret;
> > > +
> > > +	if (!priv->pattern && priv->rxport.source.sd) {
> > 
> > When will priv->rxport.source.sd be NULL here?
> 
> Indeed it should not, the priv->rxport.source.sd can only be null if:
> - There is no serializer
> - The stream has been started with pattern generator and the pattern
> generator
> has been disabled while streaming.

It seems priv->rxport.source.sd is also accessed in
max96714_enable_streams() without such a check.

> 
> In V7 I will drop this check and add another one to prevent disabling the
> pattern
> generator while streaming.

Sounds good.

> > > +static void max96714_v4l2_notifier_unregister(struct max96714_priv *priv)
> > > +{
> > > +	v4l2_async_nf_unregister(&priv->notifier);
> > > +	v4l2_async_nf_cleanup(&priv->notifier);
> > 
> > It'd be nicer to call these directly IMO. Maybe we could introduce
> > v4l2_async_nf_unregister_cleanup()? Feel free to post a patch. :-)
> Ok, I will call these directly, and I will do the same for the MAX96717
> serializer.
> 
> I will post a patchset later introducing the
> `v4l2_async_nf_unregister_cleanup`
> and converting all the drivers calling these two functions.

That would be nice. :-) It should be easy to do that with Coccinelle.

..

> > > +	ret = max96714_enable_core_hw(priv);
> > 
> > Please switch to runtime PM.
> 
> Ok, the v7 will use runtime PM and I will use the powerdown gpio
> to poweroff the device. However it implies to move some functions arround
> e.g initialize the tx or the pattern generator ..
> So it it will be done as separate patches.
> 
> Playing with the pm_runtime operation also showed up that the connection
> doesn't always resume properly, I will extra patches to fix that.

Ack.

-- 
Kind regards,

Sakari Ailus

