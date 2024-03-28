Return-Path: <linux-kernel+bounces-123374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FF890769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D021F261E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4212F588;
	Thu, 28 Mar 2024 17:46:44 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E07171A1;
	Thu, 28 Mar 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648004; cv=none; b=ZeNiCT1oXzwz9Wskxy/Co4Bt/3cJWE2ZU4CTlgMaEuvtR6V5Br+mwR9OYN8Hc8wpUO/yMibz9f+R8tXAryTpyKjmjzo0Fmnn83Vvm9Z/zudB+0x7fxf/0gXOVAVKfjiE+bTGSCJjqM6/sUCtUUu4LEQVFLjetLXv1JxJGHbQj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648004; c=relaxed/simple;
	bh=9pXHYyR5tBuX3O4p6ixDQaABJ3dpYZ5TmNERGWzz1CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUsUXcYUKH5HSy+VfvoITt+DHTvtv73/lkOkiOgxkPBN4oddbll+fK1yFEEgGSt3tlws4UaZrhLscR/k8zuDOed4sKUrx0BiBiASmPDSD4Qoeyw6WxPACWaiAROzCHQP220p3wgrVsBjM2n7uLKVLp+ricjCnoo315q1JBbRHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so2206441a12.0;
        Thu, 28 Mar 2024 10:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648001; x=1712252801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvors8q39VXXaq9ZdPwa40whQzgJb2pO5+vkfKvwSKc=;
        b=Hee7ZLTOLP46e1eNr/6EwvXewYqEnSHj+5eD/FU+R+7BIgGgY1DhUMStyfBkgm2BgZ
         Xq1UJtUP2CTeKV3weVGLraXES3QmPeIhLkARccq5jWQyAcyR7rBaMPBuUkwkb1lCvA1p
         yt1EzuQvdX9m2iB65QXlaUg7Np4iZ0a3bqHlXBqmI25vnUlPjRahfQF84uhvq5OW3AQx
         dnFrhRBR9VABSIB2zgEY6U9QouRN4DcV8rfvT8meG7GmCoG1McWXnR5XCjRH99V+nXNw
         VT2JndQoVTzleBycrpOIRN9vrUXzWblbCUabRkpVLSv/omMGvceGCfgWd9+VURffzHfD
         6S8g==
X-Forwarded-Encrypted: i=1; AJvYcCW62YMoe1bOFANuOjdsiocELjmYZM+iLpBu2Ak1HxFAAxK+iouzimlAcnniG+n1NuzGwuSrwGUzEmW/RBPOjI6Mt6SQPN6Yju9Jg/rm6eHs46VAcGDESrs1Dk8pYd+HCzYgP08X
X-Gm-Message-State: AOJu0YwdSJb4DxZU/r3MZLn7fk8yAM5d22IvfUrH4aF2uBUyupT1wwfe
	8SZTrRARJFrvD1UnsiTtzq4VtAG9VIkg8o/gosWfvzokezH2c1Kd
X-Google-Smtp-Source: AGHT+IF0BeJyTJJ8JTj2sfLsm8ROWVomNPAATFI3EDfA3JpyIWA1lvRFjEf/b0U3Krkct630C/tlzA==
X-Received: by 2002:a50:c019:0:b0:566:6a9d:6147 with SMTP id r25-20020a50c019000000b005666a9d6147mr2847573edb.0.1711648000523;
        Thu, 28 Mar 2024 10:46:40 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7c40a000000b0056be25367absm1082811edq.40.2024.03.28.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:46:40 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:46:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
Message-ID: <ZgWs/Z7d1hgFyytO@gmail.com>
References: <20240327200809.512867-1-leitao@debian.org>
 <10d89693-21af-4560-a088-d58d16cbb9dd@intel.com>
 <20240328101053.69a968ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328101053.69a968ec@kernel.org>

On Thu, Mar 28, 2024 at 10:10:53AM -0700, Jakub Kicinski wrote:
> On Thu, 28 Mar 2024 16:02:12 +0100 Alexander Lobakin wrote:
> > > +/**
> > > + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> > > + * @sizeof_priv: size of private data to allocate space for
> > > + * @name: device name format string
> > > + */
> > > +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name)  
> > 
> > Since the users of init_dummy_netdev embed &net_device into their
> > private structures, do we need sizeof_priv here at all? Or maybe we
> > could unconditionally pass 0?
> 
> FWIW similar thing could be said about @name, if we never intend to
> register the device - it will never have a legitimate (user visible)
> name. So we may be better off naming them "dummy#" or some such.
> No strong preference, tho. Adding params back later may be a bit
> of a pain.

Removing the @name seems to be safer than @sizeof_priv. I can remove it
in v2 if any one has any strong preference.

Unfortunately removing @sizeof_priv might not be possible given cases as
iwlwifi.

> > > +{
> > > +	return alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN,
> > > +			    init_dummy_netdev_core);
> > > +}
> > > +EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
> > > +
> > >  /**
> > >   *	synchronize_net -  Synchronize with packet receive processing
> > >   *  
> > 
> > As Jakub mentioned, you need to introduce consumers of the functionality
> > you add within the same series. Personally, I'd like to see a series
> > with agressive conversion of all the affected drivers from
> > init_dummy_netdev() to alloc_dummy_netdev() and final removal of
> > init_dummy_netdev() :D
> 
> We can, and put it on a shared branch so other trees can also pull in
> the conversions. No preference on my side, tho. I think that Breno
> doesn't have any of the HW in question, so starting with one and making
> sure it works could be more "work conserving", than redoing all
> patches..

I would prefer to do the more conservative approach first and make sure
there is no major regression, and then complete the work once the risk
is low.

