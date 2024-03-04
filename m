Return-Path: <linux-kernel+bounces-90037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629486F934
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069631F215A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C706FAF;
	Mon,  4 Mar 2024 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jESWj7SN"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AB53A6;
	Mon,  4 Mar 2024 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526594; cv=none; b=h0E9tezcM2TkmbQkEqm6fKG4EUj1fN0yUecJc7NVhOKwa8eqFSdb/0XeA6gxt1AuuCtQuIgsde+dRGWE3BqAXsPSG9uTcezyiuMzQDbwnGHZhuszcb4y7zGCFztofRUTFlwo/jKahozRr6y3t6Ii87gcD8hr1W3+uwvh41h8g6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526594; c=relaxed/simple;
	bh=vg1F76KLLo9ij++70/vcPP1ggO6jUjku8rAQfmzK1RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEmTVjjNmdVvDcWqG/wFiSvgU0GqoaZ3wdquzz/MunBd2fdinES7qz7qh8uEwiYYh6cnKoHelNhyJKaCuYFZLzNsejZjyw6OT5phzIFDNJFvNNfVr8EPNqSMpKzk/rfaJwgKpdDWeLquRt7RkpklQN1NWdAYECrUIg2OixWCzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jESWj7SN; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2936601a12.3;
        Sun, 03 Mar 2024 20:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709526592; x=1710131392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSQXl6NrPtVEUAzn9GiFxnVuDffvcWyxyKsHsetEWkU=;
        b=jESWj7SNVUxzO3O1T3kImSR/7IIT6ywCBCjt3FyOAfmSHhhE2uUDg9+lZcRsU7S1FT
         QwZgu5kykNLTSFlFB15guzsIb1+tk1OsCp/H56wxLpcYchOFFJjXkMPsITvIq7H8YeHn
         c89zGlcViyIqhKcKUUBB7cb0tspXuu/d82P2dsBriKWw7qS06piSl5C894phuk/pgFxl
         Xj1PiZUka+5AOi9GYamd5UwRS0cWAMtXz+Ja6EpTw4Egl3C8NJlL/2jC33OOC+MCbp4r
         1ZIV/d8iKyQTL4hiucMJ+v+suJ4fUcR0NsNea+G0bXsrplWoLAfmVstjWS5RRFPKugy2
         a3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709526592; x=1710131392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSQXl6NrPtVEUAzn9GiFxnVuDffvcWyxyKsHsetEWkU=;
        b=AJG8gxDs/GqtgV8vRx3fyYT0YfTOJllhITf4yJ+FUTf2Ma6e2TjmpMkl17XrKoTY9l
         ywR6fO1TjIJv/ZJ2WhNsJhtnHBNFafYFmqJ7cfAlMdhzs56GipV5OYf1McVKDVelNeg9
         nXV5CGyitbZk8Djq0Cypahwpjx9tTbYmIVhfZsUnffNacJLGq0cvHt4ZFazK/qjD/992
         xGVXt6JQnE3tU2ruUE8m4XStffTRnk4D31VClThe0YWANllUo/iwRJZI6+A6+q7zTXLk
         L5waDcLrHNC6iReNkuC5JPRA+8D5rb4Y5H7K7d/s6rqoKYSxAosarGwMW7LE3fzWeNtd
         Yskw==
X-Forwarded-Encrypted: i=1; AJvYcCUoC/wqkYr3SFK1kwliYLEzmDTdyM8oHmu/MV/bjYNfImklD3tQ5KekFtlDRNok7FV0A9HOuiG7VXVeCrFXZIA2BSOZO67JO+gIIPAu5tvFMqIWTGdCrNokhmGks+EhK8CEYLUX+kFoiQt0HVwB4u+oynjhnzyO2+r1qqiFcXUOsfbkmFw86XxbwqQ=
X-Gm-Message-State: AOJu0YxB3Qh8PYxUPErkzxVOpB7ZSn6IohEexJWKPVFT1NlFuNe248Aq
	84BNqn2uNWm5Tb3kZ+r2sAEpFdpRiMoZ+ZD7NS8V08CfiTNC0SO4
X-Google-Smtp-Source: AGHT+IFeu/kCwR7KRtY+Gh+J4uCgHmxWuDgnHtxPsoVnOHy8NDdM5dFAxzeVySMjj6Bhq0r6F4Ql7A==
X-Received: by 2002:a05:6a20:3545:b0:1a1:4aa0:d593 with SMTP id f5-20020a056a20354500b001a14aa0d593mr1858199pze.47.1709526592166;
        Sun, 03 Mar 2024 20:29:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902dcc500b001d949393c50sm7407382pll.187.2024.03.03.20.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 20:29:51 -0800 (PST)
Date: Sun, 3 Mar 2024 20:29:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeff LaBundy <jeff@labundy.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-input@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: iqs626a - Use common error handling code in
 iqs626_parse_events()
Message-ID: <ZeVOPSt0L1D4BxuZ@google.com>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeU8ENmnPj3sKxAv@nixie71>

On Sun, Mar 03, 2024 at 09:12:16PM -0600, Jeff LaBundy wrote:
> Hi Markus,
> 
> On Sat, Mar 02, 2024 at 12:42:08PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 2 Mar 2024 11:44:17 +0100
> > 
> > Add a jump target so that a bit of exception handling can be better reused
> > at the end of this function implementation.
> > 
> > This issue was transformed by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/input/misc/iqs626a.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
> > index 0dab54d3a060..fa9570755f7b 100644
> > --- a/drivers/input/misc/iqs626a.c
> > +++ b/drivers/input/misc/iqs626a.c
> > @@ -530,8 +530,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> >  					dev_err(&client->dev,
> >  						"Invalid input type: %u\n",
> >  						val);
> > -					fwnode_handle_put(ev_node);
> > -					return -EINVAL;
> > +					goto put_fwnode;
> >  				}
> > 
> >  				iqs626->kp_type[ch_id][i] = val;
> > @@ -545,8 +544,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> >  				dev_err(&client->dev,
> >  					"Invalid %s channel hysteresis: %u\n",
> >  					fwnode_get_name(ch_node), val);
> > -				fwnode_handle_put(ev_node);
> > -				return -EINVAL;
> > +				goto put_fwnode;
> >  			}
> > 
> >  			if (i == IQS626_EVENT_DEEP_DN ||
> > @@ -566,8 +564,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> >  				dev_err(&client->dev,
> >  					"Invalid %s channel threshold: %u\n",
> >  					fwnode_get_name(ch_node), val);
> > -				fwnode_handle_put(ev_node);
> > -				return -EINVAL;
> > +				goto put_fwnode;
> >  			}
> > 
> >  			if (ch_id == IQS626_CH_HALL)
> > @@ -580,6 +577,10 @@ iqs626_parse_events(struct iqs626_private *iqs626,
> >  	}
> > 
> >  	return 0;
> > +
> > +put_fwnode:
> > +	fwnode_handle_put(ev_node);
> > +	return -EINVAL;
> >  }
> > 
> >  static noinline_for_stack int
> > --
> > 2.44.0
> > 
> 
> Thank you for this patch, but it seems like a NAK to me. I think this is
> a matter of personal preference, and according to mine, it is much more
> confusing to insert a goto label after a function's primary return path
> than to have 2-3 calls to fwnode_handle_put().
> 
> If you feel strongly otherwise, then I would suggest a helper function as
> recommended by Dmitry in another thread. However, maybe that helper should
> live in the driver core, as I suspect this driver is not the only place we
> can avoid calling fwnode_handle_put() in an error path that returns an int.

Yes, it should go into include/linux/fwnode.h, something like

DEFINE_FREE(fwnode, struct fwnode_handle *, if (_T) fwnode_hanlde_put(_T));

Then drivers can do:

	struct fwnode_handle *ev_node __free(fwnode) =
		fwnode_get_named_child_node(ch_node, ev_name);

and have it automatically be "put" once execution leaves the variable
scope.

Ah, we actually already have it defined in include/linux/property.h, all
the better.

Thanks.

-- 
Dmitry

