Return-Path: <linux-kernel+bounces-90190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F59486FB90
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E421C21B69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D2617BA8;
	Mon,  4 Mar 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9FcpVwy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157DA179B8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540334; cv=none; b=jJg5MezZQ4nMMcWMbS+KtvaTVCTYWdD9WAOQsm7jYeZxgZ5U2fTtbm37/o0Ahh0wZjOfaclFUbrfWsbgIjfw5BwkCQ4cIa+cyrvssnut8SsOZNK+tHGd6NWgVIcwSy0y+C8pGQTT+iILDciXWH4wn0BaiiLb3DM/opNy86FGyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540334; c=relaxed/simple;
	bh=lf4QbrTdyQGbsfhBE4a4VPnu/JGFsWbiqabuasROWBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiVfOoDGBtrBsndI5QNhvAkwndBoEE8QMU7x71/87EVpnSPXuYYJx3bPtLZuxfDpEZBi05zmQr3YdMRItTed0gSeoK2vIVP+bLCEevqQg6QDPql7iycYZWm9rTWTP9OdXwglSwfKWQ5NDEG5WGYglhsijXxz6xsXFzr507Pd5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9FcpVwy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412e84e6d2fso20755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709540330; x=1710145130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+Wz3vSqADvCmRUr41ggthQrfscNeOqtvo32hpAdQrU=;
        b=U9FcpVwy5ni2jVlNJvOlBgmRDA2f8YDpTGVpaC7QD/UnNcTb++1BG6j+Il88f2sZH4
         FNny5sfQkIQO1m7fo+WoO5ikXpOSxNHMNQuu95T8EJbBewxDB8GL53iU94MzMwXvFvXm
         lqMSmANTLEBZ2zz/e+0HRYjatEcU2LZo4KwUseeRTbW+XKycxT7F/IOOGvXMGTPamfgL
         4zo79l2I8bF3FOZ5Zg+Z0cNZuGy8elQ35Uv/LXT2IjR4KM7fj6+h+s5jZDOgrXfnLWY6
         XEmdRxYO9QTSX0jHdp1svbmSGFdTGnjLBmLlEDQAsGaAA6ldQoSvYhPn/pon/PJWnkMd
         AC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540330; x=1710145130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Wz3vSqADvCmRUr41ggthQrfscNeOqtvo32hpAdQrU=;
        b=dovBGCCeGK7d+txx+7KKkvXopWxhaUjp8ith3wU0buZb2FcYOhW1PROSbM2hsqeRAV
         EQFVMTdsapoWP0QoBa2qPsKYThSjd4NhVUo50WJi+gRslaofk305h7spWVp4vDn76WLk
         DEBHkkdsT/wNXo6gtnOaAAPPscKzm+IuvL8xNnI8RmJWGHB0vMUxRB1jKo2D65Dtjuqr
         X0uODd6uLXuMV6ffip6odLRaVllJrD+RIaHS7TxnmWgbYVxljgS8of3nwHOjW67i6t6S
         m1cAbkcvNXfviwoOCYQ2uUniL22xlfoJam4JdISUPbGcRI+E/jS/H6enXkeLgBA+2lXK
         Da9w==
X-Forwarded-Encrypted: i=1; AJvYcCVaTR5U2CCIU49WYnoADPKhZ1xKEb+yYJ65HOSOubYi3oCF14ln6jeoHd+aP10tomRGxh1LB6G9MUYebgYAFKbkAGqh2+pL9HSSp7Mw
X-Gm-Message-State: AOJu0YxheTUFwukwkZ9rxJopoqA0ApxBykD55g7ly+/TuwxAhj7Sol/C
	RRmpmqzkoN0Mbd1SelZGpegPlskyQjgZLzgPLMIQPmKYcqIOEiY9jDpVhJOzZ5c=
X-Google-Smtp-Source: AGHT+IEEACqniaOv1TiY0H6kWmP529cCDflhJo/tAnZFMaI+Uhz12qFbHINc222Iumefyt2EZD63nw==
X-Received: by 2002:a5d:650b:0:b0:33d:f3cc:1f8a with SMTP id x11-20020a5d650b000000b0033df3cc1f8amr5370378wru.55.1709540330225;
        Mon, 04 Mar 2024 00:18:50 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v13-20020adfd04d000000b0033d202abf01sm11477083wrh.28.2024.03.04.00.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:18:49 -0800 (PST)
Date: Mon, 4 Mar 2024 11:18:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeff LaBundy <jeff@labundy.com>, Markus Elfring <Markus.Elfring@web.de>,
	linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: iqs626a - Use common error handling code in
 iqs626_parse_events()
Message-ID: <11e5db31-2a8f-458d-a249-7205e37aa20f@moroto.mountain>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71>
 <ZeVOPSt0L1D4BxuZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeVOPSt0L1D4BxuZ@google.com>

On Sun, Mar 03, 2024 at 08:29:49PM -0800, Dmitry Torokhov wrote:
> On Sun, Mar 03, 2024 at 09:12:16PM -0600, Jeff LaBundy wrote:
> > Hi Markus,
> > 
> > On Sat, Mar 02, 2024 at 12:42:08PM +0100, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Sat, 2 Mar 2024 11:44:17 +0100
> > > 
> > > Add a jump target so that a bit of exception handling can be better reused
> > > at the end of this function implementation.
> > > 
> > > This issue was transformed by using the Coccinelle software.
> > > 
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  drivers/input/misc/iqs626a.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
> > > index 0dab54d3a060..fa9570755f7b 100644
> > > --- a/drivers/input/misc/iqs626a.c
> > > +++ b/drivers/input/misc/iqs626a.c
> > > @@ -530,8 +530,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> > >  					dev_err(&client->dev,
> > >  						"Invalid input type: %u\n",
> > >  						val);
> > > -					fwnode_handle_put(ev_node);
> > > -					return -EINVAL;
> > > +					goto put_fwnode;
> > >  				}
> > > 
> > >  				iqs626->kp_type[ch_id][i] = val;
> > > @@ -545,8 +544,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> > >  				dev_err(&client->dev,
> > >  					"Invalid %s channel hysteresis: %u\n",
> > >  					fwnode_get_name(ch_node), val);
> > > -				fwnode_handle_put(ev_node);
> > > -				return -EINVAL;
> > > +				goto put_fwnode;
> > >  			}
> > > 
> > >  			if (i == IQS626_EVENT_DEEP_DN ||
> > > @@ -566,8 +564,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> > >  				dev_err(&client->dev,
> > >  					"Invalid %s channel threshold: %u\n",
> > >  					fwnode_get_name(ch_node), val);
> > > -				fwnode_handle_put(ev_node);
> > > -				return -EINVAL;
> > > +				goto put_fwnode;
> > >  			}
> > > 
> > >  			if (ch_id == IQS626_CH_HALL)
> > > @@ -580,6 +577,10 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> > >  	}
> > > 
> > >  	return 0;
> > > +
> > > +put_fwnode:
> > > +	fwnode_handle_put(ev_node);
> > > +	return -EINVAL;
> > >  }
> > > 
> > >  static noinline_for_stack int
> > > --
> > > 2.44.0
> > > 
> > 
> > Thank you for this patch, but it seems like a NAK to me. I think this is
> > a matter of personal preference, and according to mine, it is much more
> > confusing to insert a goto label after a function's primary return path
> > than to have 2-3 calls to fwnode_handle_put().
> > 
> > If you feel strongly otherwise, then I would suggest a helper function as
> > recommended by Dmitry in another thread. However, maybe that helper should
> > live in the driver core, as I suspect this driver is not the only place we
> > can avoid calling fwnode_handle_put() in an error path that returns an int.
> 
> Yes, it should go into include/linux/fwnode.h, something like
> 
> DEFINE_FREE(fwnode, struct fwnode_handle *, if (_T) fwnode_hanlde_put(_T));
> 
> Then drivers can do:
> 
> 	struct fwnode_handle *ev_node __free(fwnode) =
> 		fwnode_get_named_child_node(ch_node, ev_name);
> 
> and have it automatically be "put" once execution leaves the variable
> scope.
> 
> Ah, we actually already have it defined in include/linux/property.h, all
> the better.

It's already there.

DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T))

I can send a patch for this.  You need to be a bit carefull to move
the declaration into the correct scope for this to work.  I should write
some Smatch rules for this...

regards,
dan carpenter


