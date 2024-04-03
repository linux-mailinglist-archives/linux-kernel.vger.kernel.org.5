Return-Path: <linux-kernel+bounces-129964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2323D897297
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F20281238
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460801494B7;
	Wed,  3 Apr 2024 14:27:36 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23024148844;
	Wed,  3 Apr 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154455; cv=none; b=SdKNxoKq1SAH3lJEb6qbJjT9zaqMtn5YHQZUUNHg6puJjAWFN1j/jjRVDjoCIFbKqvWKQ7pYjnIsJs6FPVRxJ6EVp2qzIvIm2JEsfKK3bESTOh4uD1z2OWN1ZmxG0h6prEZhZx8nReI8IwexdRoLJaiRMtz8NEbXp74VwvonxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154455; c=relaxed/simple;
	bh=PrVKZP0ECRi5hkZdvwFBUwq8+6VR73QDYDWDIAK/pz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSlMagzFJQfbsdYDKfehIFE3CCO7qDSev2Z4SiNKaYOCih7lK7vGkoq5TxkNwqbP3E3N3ZNsQBRkwaVokVkeKJ42/d6OXYqCNMvrL4tYI18xXLoWVvBl6wj3qPHLb2+WRt7E4O7zPXpRMkuJ+QvubSkB3xEraTYJJ+u+L5JxpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a517a492055so38935366b.1;
        Wed, 03 Apr 2024 07:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154452; x=1712759252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXtIAxbSC9GoA27XTlgfDuz/R5J5HXUwOuHua6cg6cA=;
        b=jFcKIeKl3FREGWbue4fJ5CC5PQqmqj9MhhWybyT8cgF/gzRsidp95YMX+HvkWMy5fH
         xbGqmaYW/FGiXrUaT+xCOU+FowkaeuH1Lwpq0gNUrlh4Dj213Fvo4RLI1SIRnIEAGKgb
         +uyuVnIZfcPzK53yaVJWYes7Tdt39Rpz+MnKn71qHNog+OCM53AfE2sq+uo6/MyhOjTz
         qA2W9YpZdSbgAgHoRfidCd7poqEiekE6WrmH8/bCjfNJFNtSVkx6NLlDrehE2oxqGrvz
         XM2yuq1tM0qXrPB5GJqUBW0s4Y95lHdYP9zu9U9v4PHQtYppovodXg/X2wlLTYJFgea3
         8n0w==
X-Forwarded-Encrypted: i=1; AJvYcCUafphpMztLkT4nh9Hzq2j1t7sOP6uDGl43vw2wrWrLtmK2jtbqW93wIfRjJXp+6WoN7PaB29UPO8Ba54KtEnGkViA0OzenKkCn8jx/QYdZKVnHa2dnQSP/WCJgc0wY5KBTbCxx
X-Gm-Message-State: AOJu0Yw1kLzjTUETiLe8Czvbx+alMVZUXL71PUxMoyJuBk526sjroAjS
	GdWjXi7d6+6uFs3djzDWxMi7N/KrJSI3JcNIkx4W1SZGNZ/V8Mtd
X-Google-Smtp-Source: AGHT+IHJ3M9QjM6bMH4k6EdFbKCIuH9qXwf1eJY9cEkfC7/72aQMP4QkcScmZNQ7bWfPIKwNhz1bJg==
X-Received: by 2002:a17:906:a059:b0:a4e:7b62:9480 with SMTP id bg25-20020a170906a05900b00a4e7b629480mr1854323ejb.17.1712154452296;
        Wed, 03 Apr 2024 07:27:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id bv3-20020a170907934300b00a517995c070sm297675ejc.33.2024.04.03.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:27:31 -0700 (PDT)
Date: Wed, 3 Apr 2024 07:27:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: marvell: prestera: allocate dummy
 net_device dynamically
Message-ID: <Zg1nUR0Xb8LgKE9f@gmail.com>
References: <20240328235214.4079063-1-leitao@debian.org>
 <20240328235214.4079063-3-leitao@debian.org>
 <20240331085438.GA26556@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331085438.GA26556@kernel.org>

On Sun, Mar 31, 2024 at 09:54:38AM +0100, Simon Horman wrote:
> On Thu, Mar 28, 2024 at 04:52:02PM -0700, Breno Leitao wrote:
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> > 
> > Un-embed the net_device from the private struct by converting it
> > into a pointer. Then use the leverage the new alloc_netdev_dummy()
> > helper to allocate and initialize dummy devices.
> > 
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  .../net/ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c b/drivers/net/ethernet/marvell/prestera/prestera_rxtx.c
> 
> ...
> 
> > @@ -654,13 +654,21 @@ static int prestera_sdma_switch_init(struct prestera_switch *sw)
> >  	if (err)
> >  		goto err_evt_register;
> >  
> > -	init_dummy_netdev(&sdma->napi_dev);
> > +	sdma->napi_dev = alloc_netdev_dummy(0);
> > +	if (!sdma->napi_dev) {
> > +		dev_err(dev, "not able to initialize dummy device\n");
> > +		goto err_alloc_dummy;
> 
> Hi Breno,
> 
> This goto will result in the function returning err.
> But err is 0 here. Perhaps it should be set to a negative error value
> instead?

Definitely, that was a good catch.

> Flagged by Smatch.

I am curious how you are running Smatch. I tried to run it here
according to[1] , and I found different and valid errors also, that I
will fix soon. For instance:

   drivers/net/ethernet/marvell/prestera/prestera_main.c:433 prestera_port_sfp_bind() error: uninitialized symbol 'err'.
   drivers/net/ethernet/marvell/prestera/prestera_main.c:861 prestera_switch_set_base_mac_addr() error: uninitialized symbol 'ret'.

[1] https://rajanvaja.wordpress.com/2021/02/06/how-to-run-smatch-on-linux-kernel/

Thanks

