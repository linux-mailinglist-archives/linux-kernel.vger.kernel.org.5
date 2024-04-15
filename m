Return-Path: <linux-kernel+bounces-145556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0A8A57D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807691C211DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D782C7E;
	Mon, 15 Apr 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWlKY4BV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69F81ABB;
	Mon, 15 Apr 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198748; cv=none; b=LtujKb9eH/vD4wdhcqpyvSznmdp1gmBAFoVNuUbEsQQ+2pfiLpdgNjHoLot3juIIqQeqIquwESmgohIsVKlRfdpSxt24sMGOwsjNqdYVEs+aT11cbSpMqZoId0xXJ/ug99T+eQ0CBD882k/5vaxoW+N1okog4a5aMMcDL9HxS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198748; c=relaxed/simple;
	bh=w+Jli2gXAqNrzzibOM83RHV530usC/LNM9MmjJsycxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyYECExCsn3gLockILxTxMikSjdplrHSVlCBtVLn41+H8nxb8DdKODwyPUEeEhd4Tx9nBvgy1zZ66IxdPq9SjHcxp1K36xwPkQLDq0+4t+TmL40TOe1M//RuGMi18d87LNFeHm4XaKBufA73GBReuIyidw3uTHuy0PfHzbhJa9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWlKY4BV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso4300706a12.2;
        Mon, 15 Apr 2024 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713198744; x=1713803544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdPVT4G73fiqd7vz1POECcHJyXspCSMnftfniwcZUds=;
        b=TWlKY4BV2MYC0QXLd/Yo6fNVYuRRn+fLV1oVy3d4eSgCloj3C1Y9d3YNJfC2KdAtYU
         Xx/hIUCFWV1zLl2XXE74kCmBxJltxRzLRKOgzTy1PbZaqf1TeV1RkQio+ShpBq/0SzS+
         TVfEgyy3Uxa9mcKoc3mxvDJBfoqQRSdekMWRMVnzRk/V+94gK7UFLHci6YZz6GxgVZQY
         VIhi0kOuIsAtm7LfbENbzVOwMVlas36BZ+0iOHm2yeQ/U/KCz0WawN3NUt5QdJB5cCkv
         oEmEbltkRAmbZadhEdMtxkEN7wDk6Yvp8AJA7czXHCTSz3y3NnaByb+1bN9h6ngTSA1I
         pJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198744; x=1713803544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdPVT4G73fiqd7vz1POECcHJyXspCSMnftfniwcZUds=;
        b=wMgkSxPzAZoDVVN28l2n6n84wznNEfOgXT/B2Hiw9TCj/75CyUrr71sxAkqxkBC+Y7
         ERyTup5aFtR9YBELo6+NTbHF6stxMrkWqZJBv0iLRjqNBOrBfzI4lzD5zC9tqOPlDQnx
         JtXmzfz0Ma9jjk1liL4zw1/49KBYnRuPbEofNz17h6bYC5bQ9t2SNPZYy9L4cw5VYuLG
         VtEzgudbGHgjKBaj7xexscBnfVL7G6EpR+RTE/p89KsLZFKdK8itQ+tNh1eZs25ZmLhb
         NFdq7bNGJT85IjsWoRGRnIx3h+w2gTaJPD34M9+tt+36oKKdknktC9SHEJ50c22q72/6
         Vjag==
X-Forwarded-Encrypted: i=1; AJvYcCV4VUAERRojZgbTUt+J2HJ+4P+E+kxCWZU8TsZuoAkfoJo/5s5Gs7Ky/mTVwdZ6lRF+Dbjd6cRANYQQjBkE0hVUdpiOaS8U+eU+cgUdL2012sKREFj3n2xG4xaIA9x718MlXBygiNopD8tG4s/bYCtRgMVX5fyFxslfALd4r3L3d9w5+1O5
X-Gm-Message-State: AOJu0Yz+BwYWhvJg4cMut6zUb8fNGJpsaL9a7CnSx/7M+FFL4lsDU+2m
	C172LmyctRn00sylA3OeyRhXdcMiSbCA7S9s7HKbj9z/ec9Z/o10
X-Google-Smtp-Source: AGHT+IG5111kErqtJ99UjxO28TBAoZDOYxc/kBLxTnhDOu7fNh4ku3mWNP1JtarGpo0eoVrqG9aHSw==
X-Received: by 2002:a50:8a88:0:b0:56d:f7ce:e879 with SMTP id j8-20020a508a88000000b0056df7cee879mr7558482edj.37.1713198744290;
        Mon, 15 Apr 2024 09:32:24 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id y24-20020aa7d518000000b0056e68b14986sm4975937edq.29.2024.04.15.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:32:23 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:32:21 +0200
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Luis Garcia <git@luigi311.com>
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
Message-ID: <Zh1WlamoDoFbvEMv@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-25-git@luigi311.com>
 <Zh1FUQOt9n/tO3er@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <656bf349-38bf-44b7-936c-58f424613a49@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656bf349-38bf-44b7-936c-58f424613a49@luigi311.com>

On Mon, Apr 15, 2024 at 10:27:28AM -0600, Luis Garcia wrote:
> On 4/15/24 09:18, Tommaso Merciai wrote:
> > Hi Luis,
> > 
> > On Sun, Apr 14, 2024 at 02:35:02PM -0600, git@luigi311.com wrote:
> >> From: Luis Garcia <git@luigi311.com>
> >>
> >> Use the v4l2_link_freq_to_bitmap() helper to figure out which
> >> driver-supported link freq can be used on a given system.
> >>
> >> Signed-off-by: Luis Garcia <git@luigi311.com>
> >> Reviewed-by: Pavel Machek <pavel@ucw.cz>
> >> ---
> >>  drivers/media/i2c/imx258.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> >> index 5de71cb7c1ae..65846dff775e 100644
> >> --- a/drivers/media/i2c/imx258.c
> >> +++ b/drivers/media/i2c/imx258.c
> >> @@ -693,6 +693,7 @@ struct imx258 {
> >>  	/* Current mode */
> >>  	const struct imx258_mode *cur_mode;
> >>  
> >> +	unsigned long link_freq_bitmap;
> >>  	const struct imx258_link_freq_config *link_freq_configs;
> >>  	const s64 *link_freq_menu_items;
> >>  	unsigned int lane_mode_idx;
> >> @@ -1552,6 +1553,17 @@ static int imx258_probe(struct i2c_client *client)
> >>  		return ret;
> >>  	}
> >>  
> >> +	ret = v4l2_link_freq_to_bitmap(&client->dev,
> >> +				       ep.link_frequencies,
> >> +				       ep.nr_of_link_frequencies,
> >> +				       imx258->link_freq_menu_items,
> >> +				       ARRAY_SIZE(link_freq_menu_items_19_2),
> >> +				       &imx258->link_freq_bitmap);
> >> +	if (ret) {
> >> +		dev_err(&client->dev, "Link frequency not supported\n");
> >> +		goto error_endpoint_free;
> >> +	}
> >> +
> >>  	/* Get number of data lanes */
> >>  	switch (ep.bus.mipi_csi2.num_data_lanes) {
> >>  	case 2:
> > 
> > Looks good to me.
> > 
> > ps:
> > Maybe a good plan for the future would be to use: dev_err_probe
> > (instead of dev_err into probe function)
> > 
> > But this I think is somenthing for next improvements. :)
> > 
> > Thanks & Regards,
> > Tommaso
> > 
> 
> Perfect, can i go ahead and add in your reviewed by looks like
> you didnt add it here.

Yep sorry I miss that. :'(

Thanks & Regards,
Tommaso

> 
> >> -- 
> >> 2.44.0
> >>
> >>
> 

