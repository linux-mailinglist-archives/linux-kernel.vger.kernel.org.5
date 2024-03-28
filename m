Return-Path: <linux-kernel+bounces-123372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7F6890759
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C3C1C2DC17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348F12F38C;
	Thu, 28 Mar 2024 17:40:08 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D53BBCA;
	Thu, 28 Mar 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647608; cv=none; b=pLvkQj/giOPXGymaCpNu4RfTdvxL6L0gKFcMWVfugyhXImAlhI1snA4TlknMPleaGwGOXJHQoF0mi2aG7eKy8t9U1VPNpBzU4kQya0a9SJmD0s0apMIvY0eORzBXykSflOLHmclcFwMBpzob34cuXq1kHNGL6omau1veqDdoBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647608; c=relaxed/simple;
	bh=3FL2cg56mi0tUOik+x+V+muSDSk5F4hhanQoEdRfVio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhIYfEQn+aRgAb4KkMX7s3wyMxmc3hSjuQkkWDG5bZopLJqn0ukWSNjyQLv5x1JHYjftBA49t3fUg6Z8jR1Js6+S7pFJiFxGoARYEoq0GcNSJ2owOgxuFo48H7Xw4E0Rpi1LxegLXbfJdBG2R+YHJJV6Zxs7QfTmRQ9QUT1Soao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46d0a8399aso390751466b.1;
        Thu, 28 Mar 2024 10:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647605; x=1712252405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wa9IhsKmQjL5kSGaWqHXwB+uD1I+s9kF3+/KS9fT14=;
        b=Z7PCmhOlpf1fhxTjXFsX9K+D5ZWl46oqvCOtfWHcO44t6lfdTBDwsVwGt5zgsUzgY8
         HwOMRl1f/FGi2e1f9rEbE8LpRp17MSkVE5C3VoG6uIMzgLawu2L4mQSI+BZEjLyX73vY
         QH8YT0eSudszSW6zV6KRjVcgTsL4cuzWNt3doT8USi+rq/ltbk9xllAcGNacsZDbeWb7
         Q7W5Dduz42qq+mZGzyeva82xMalf5QoINxghaJkkffqn1++qJllo4sOk9trgQHH5BaOy
         MpuhBDKUs5BrBDHatnKMSSU4EHwwtNcWbzryPNxBBpfzzwyKnJKTx0M9drUp7S5kJrqk
         IBBg==
X-Forwarded-Encrypted: i=1; AJvYcCUAggRyQnfyO+oV5btCEiui2laWiTwar3ny8B0Urx4v1AMSd8eX6XI0NGTaRIgHw5mhC/WvpE1HQHbbEQUS+zexIMrp0mwnMf7mlMmWIXNp7v4OdXMW3tV1asPMVPXN7cfxkdR9
X-Gm-Message-State: AOJu0Yzby8M5kn4aXM0I5IismfAv4gOfgfmzbnyCmqwSmW/m1NeQ2JMJ
	Tm5jfoouEUz1/X/Gbd83D+9VzztSNXNcDHFc4qDjjD5Bt9fs7RSb
X-Google-Smtp-Source: AGHT+IH+q7v9ZD3/8A002Fri3cLh4PmD5UpOnnPLHqP2aGkd2/Adr6k59cpPkFgZBIlkbr8Pq73+GQ==
X-Received: by 2002:a17:906:3407:b0:a46:c11d:dd0a with SMTP id c7-20020a170906340700b00a46c11ddd0amr83715ejb.31.1711647604964;
        Thu, 28 Mar 2024 10:40:04 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906714300b00a4650ec48d0sm1001105ejj.140.2024.03.28.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:40:04 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:40:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
Message-ID: <ZgWrcvKyAzDvl/jn@gmail.com>
References: <20240327200809.512867-1-leitao@debian.org>
 <10d89693-21af-4560-a088-d58d16cbb9dd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d89693-21af-4560-a088-d58d16cbb9dd@intel.com>

On Thu, Mar 28, 2024 at 04:02:12PM +0100, Alexander Lobakin wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Wed, 27 Mar 2024 13:08:04 -0700

> > @@ -10991,6 +10998,18 @@ void free_netdev(struct net_device *dev)
> >  }
> >  EXPORT_SYMBOL(free_netdev);
> >  
> > +/**
> > + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> > + * @sizeof_priv: size of private data to allocate space for
> > + * @name: device name format string
> > + */
> > +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name)
> 
> Since the users of init_dummy_netdev embed &net_device into their
> private structures, do we need sizeof_priv here at all? Or maybe we
> could unconditionally pass 0?

We need to have this private size for cases where we need to get the
pointer to their private structure given the dummy device.  in the
embedded case you can use container_of(), but, with a pointer to
net_device, that is not the case anymore, and we should use the dummy private
data pointer back to the private data.

For instance, see the example of iwlwifi: 
https://lore.kernel.org/all/20240307174843.1719130-1-leitao@debian.org/

> > +{
> > +	return alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN,
> > +			    init_dummy_netdev_core);
> > +}
> > +EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
> > +
> >  /**
> >   *	synchronize_net -  Synchronize with packet receive processing
> >   *
> 
> As Jakub mentioned, you need to introduce consumers of the functionality
> you add within the same series. Personally, I'd like to see a series
> with agressive conversion of all the affected drivers from
> init_dummy_netdev() to alloc_dummy_netdev() and final removal of
> init_dummy_netdev() :D
> 
> (and then a followup which converts &net_device to proper flex arrays)

That is the goal in fact, but I personally think this will take a while,
given that we need to rely on maintainers to test the changes to be able
to move forward.

