Return-Path: <linux-kernel+bounces-145440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22918A562A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C01C22716
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF878C73;
	Mon, 15 Apr 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KctaoIzR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4F74400;
	Mon, 15 Apr 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194327; cv=none; b=F+5wEQNPCx/RjnC96eN56XhQXjrUygkC70MGXHDIGnQNHEfD4vsqFq92hWdC5+DA8e82LBbtu0XanxyQAvsB2ujbLCvji4gl9DtUwPN92A/lqXXnJRhOxIc83hDihViNfIlbTU0RFEQqm5+17j41ggn83qpRpUo3rc8iqO20noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194327; c=relaxed/simple;
	bh=vYNESEOUgzTI40faatByfpCU1dT6sZuS9cR0oF8rJaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6OAEI6OfO15f5fghuMMfSTMRKdxkHGOe6MTRcntj8UVekeEVVct6ckl4+W4WLM45tvWnhVFOvGKP4DXxHS2Hz0+rrl01v50+cTe7lPZYhjRSN2qObdwuE8aRUyDkAnjStqSbfIz7bcK1NTUT/feXN2+L3mrIwWHbDxSEGsTR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KctaoIzR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so3147237a12.0;
        Mon, 15 Apr 2024 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713194324; x=1713799124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vpq7QbSflVZxyFAuGvP4r1TwK6fSOB6v15DB0jnFa2U=;
        b=KctaoIzRBIU0gGFjzSqrA3s/VWwegyJ3mGX9ZxQP1W6UzkKT7JOWT3Q7TGnuZqkMKF
         TLreJiFF/Inw37caeZ647Gpzcza3xUprKnU0fdijt1dppGY0IWllBYIDc39d5bez3C3B
         nnEkrq/Y3kCf+7h4W3ouhvMn7/5mLpCh9LmKr0DnlmKWM+tMB5UUcnynWGzx0MPtrsW2
         yNSbEewKo6ZUuBW6wkq+RALUXpzq2oWNlqhcAQpbX7jAM5o0r9BIhNc0g4IjQnckTf7k
         ycaxug6fcvM2ePObpXYf+OiLq2O4ftWDBIbymKOWcS2GPRVJUySkX+ug58mzbYokSPYw
         xwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713194324; x=1713799124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vpq7QbSflVZxyFAuGvP4r1TwK6fSOB6v15DB0jnFa2U=;
        b=suEe2ytKZL9y6YgqzphRA57+rmvQfXWwEtu/qFZCHmvwZfbhDvghU7ADQ0MAhRUl5F
         o17EIubPNvH4rpgOHTNIZiP9s8eD1gTOq/dw2LU7FnRHD82TDXbXp1UG3ORiCdTrKEZ7
         mybqFRMztrmKfs7lS1Z7nw7c3FyfMRKg7LoPXsMnyzmdy0+TO+1jIUQtyX7bjxuNtMPX
         pGp5QYS7k+cX0dF46gO1Fa+Q7LoyXrXtyWYbDTuSbONTR2WptfDsDqVeOas2AssPHSQS
         dwFihMN0QyRPM3UKz7Dk9ToD6YtgjvjUHFsyVD3o/y1tEW+SHvCYU2kpPGsVlDQIEN7W
         hTyg==
X-Forwarded-Encrypted: i=1; AJvYcCWtsu6/NLO4KVvoYbd4TWW0SZEpUDsETIwZ3wr/s2jfPrC8MDECj+dbbBM9pzRf9Lx3Iy8qlfID+Be1gryzuBS1w4p69XpR5qy52Q27oD9cqI6Y52d5u01Q6u/TH09fBNKCsf2ghcYPT24L+g/RaAa3oOITux2/p02DOtnJahI++szHlN3x
X-Gm-Message-State: AOJu0YykJ3fZSESQVjIx3aulSrqjoUVGZfE+FQG/jNbHGh+E0Aohndqs
	XG1OWVojL2vfYp0x9zCkx9/FLWOpcAGqu0GYT26iwPYu0qnE3B31
X-Google-Smtp-Source: AGHT+IEZ37fDv/8PATbDYAXJxrOLvA4hobMxdgnN/ln5UGiqgDS8FX1e15FZfty45LYMSm2C40OJEg==
X-Received: by 2002:a17:907:7283:b0:a52:320a:632f with SMTP id dt3-20020a170907728300b00a52320a632fmr7624800ejc.27.1713194324054;
        Mon, 15 Apr 2024 08:18:44 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id bk5-20020a170907360500b00a53f1303771sm739161ejc.151.2024.04.15.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:18:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:18:41 +0200
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 24/25] media:i2c: imx258: Use v4l2_link_freq_to_bitmap
 helper
Message-ID: <Zh1FUQOt9n/tO3er@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-25-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414203503.18402-25-git@luigi311.com>

Hi Luis,

On Sun, Apr 14, 2024 at 02:35:02PM -0600, git@luigi311.com wrote:
> From: Luis Garcia <git@luigi311.com>
> 
> Use the v4l2_link_freq_to_bitmap() helper to figure out which
> driver-supported link freq can be used on a given system.
> 
> Signed-off-by: Luis Garcia <git@luigi311.com>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/media/i2c/imx258.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index 5de71cb7c1ae..65846dff775e 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -693,6 +693,7 @@ struct imx258 {
>  	/* Current mode */
>  	const struct imx258_mode *cur_mode;
>  
> +	unsigned long link_freq_bitmap;
>  	const struct imx258_link_freq_config *link_freq_configs;
>  	const s64 *link_freq_menu_items;
>  	unsigned int lane_mode_idx;
> @@ -1552,6 +1553,17 @@ static int imx258_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> +	ret = v4l2_link_freq_to_bitmap(&client->dev,
> +				       ep.link_frequencies,
> +				       ep.nr_of_link_frequencies,
> +				       imx258->link_freq_menu_items,
> +				       ARRAY_SIZE(link_freq_menu_items_19_2),
> +				       &imx258->link_freq_bitmap);
> +	if (ret) {
> +		dev_err(&client->dev, "Link frequency not supported\n");
> +		goto error_endpoint_free;
> +	}
> +
>  	/* Get number of data lanes */
>  	switch (ep.bus.mipi_csi2.num_data_lanes) {
>  	case 2:

Looks good to me.

ps:
Maybe a good plan for the future would be to use: dev_err_probe
(instead of dev_err into probe function)

But this I think is somenthing for next improvements. :)

Thanks & Regards,
Tommaso

> -- 
> 2.44.0
> 
> 

