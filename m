Return-Path: <linux-kernel+bounces-132008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA04898E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C79B2B19A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBE1332B8;
	Thu,  4 Apr 2024 19:03:43 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76517997;
	Thu,  4 Apr 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257423; cv=none; b=SLLTb5XDDszYrlktu0Fqhsq1NF018150WtZiJIBAXcbm8FFgiIHXDl3zApIgiJ+jurRFr1Z6ye7gVyhQ0U4aWpylcfCUp/ijIUeWMqfMvkYgeTs0Cvgd5vfN4JZz4Y5Wzd+IN5aRlCulJLuuoGqWIpQHQRvC4JSHVUQBWylAM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257423; c=relaxed/simple;
	bh=we79JR2ByEiMz9MNQ+mgKubXeXXnHTyCDoqlq7Vfzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUFMlbhPLhShHyq1mTYsi6MoNwiktwsBBbZkJbXb4opf+tEmro2uWgmbGSR0d5KBdAFoLuaguSsLoy0saKqZGfOkmkwfXroTe+zlXyErOX7jrfyPVcugHUa/lPKurWQlQ4x16LhjBRy0VEatHXa2AjviRlaXPlcNNP1QbxQ3Gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a519eae91d1so24032266b.3;
        Thu, 04 Apr 2024 12:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257420; x=1712862220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+CbQTA2iSYs41dobAl4Mn03s52UBZLR03o420g0nXE=;
        b=Eg8aKp2jK3xG1Lwu3Pf9tjDyv6FLs3KuTSjJEyA20d7aebi/OeAe5q5fg7WjcDqOfQ
         5BgY8/qOMzKBA+OhyedvLiCjVkQe1GELKY7VkTfx3ZkBb5/XeVi3mXWZAE9yGKsEVW4k
         hdCV8YSyBg8L5UIsJLzC5CfThyPP8AmIohVjYZN9JVlE1v4DwL7jbxSDD2MhMAFSJJtu
         waQsTgsULTMJxwnRINND4rVl/WnQU/8O8Tps+BlNGbXZYDbSdUh7aqLJd2UnaK1re7QS
         Q1R2OCYNqkKNp5v4A37ArC1ML3dsA1LSgQpOD96mUKfdNG5KTbsl/YuecKiyOrRMO+4F
         +eVA==
X-Forwarded-Encrypted: i=1; AJvYcCXfy3U2x1FTKw4leHKbW2TjTYcFbysBSONmXXP756jcMHBvKXX3VuQDKJc1YIllk8Appm4CGWFrrE5kDAH8l6rug/LGGzjdfbUjYPX8u0ZfGq5XVVhmNH4zI0Q/i9NVRsk5Ye3d4a/snCby3Bm/dWSu7mnFWL7eVRyM
X-Gm-Message-State: AOJu0YyCo2iLfFKkIO0FA7nm8Z/v/FSgtrC48/dLNHvLgRW8Fc2k1nTr
	W1k12XpcsHCzy7C3qOtlBpR+d6YgLcNEaUWvzlx8ozHrlgp0j4jP
X-Google-Smtp-Source: AGHT+IHmvFcFisUvqZnNo8wPKYtf8P8HNEXIVh2KGY7KWKzBSyC21xcVPnv1zgUB7h6HBBv0BS0kWA==
X-Received: by 2002:a17:907:10c2:b0:a4e:21e0:2e6e with SMTP id rv2-20020a17090710c200b00a4e21e02e6emr2104481ejb.5.1712257419825;
        Thu, 04 Apr 2024 12:03:39 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id q6-20020a170906388600b00a4576dd5a8csm9326341ejd.201.2024.04.04.12.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 12:03:39 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:03:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, taras.chornyi@plvision.eu,
	quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v3 1/5] net: create a dummy net_device allocator
Message-ID: <Zg75iK8VtzZL9/G+@gmail.com>
References: <20240404114854.2498663-1-leitao@debian.org>
 <20240404114854.2498663-2-leitao@debian.org>
 <1b1dfe1f-57ed-416d-a9c0-408aafa69583@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1dfe1f-57ed-416d-a9c0-408aafa69583@intel.com>

Hello Alexander,

On Thu, Apr 04, 2024 at 06:40:33PM +0200, Alexander Lobakin wrote:
> > @@ -11063,6 +11070,17 @@ void free_netdev(struct net_device *dev)
> >  }
> >  EXPORT_SYMBOL(free_netdev);
> >  
> > +/**
> > + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> > + * @sizeof_priv: size of private data to allocate space for
> > + */
> > +struct net_device *alloc_netdev_dummy(int sizeof_priv)
> 
> Repeating my question from the previous thread: I see that in your
> series you always pass 0 as @sizeof_priv, does it make sense to have
> this argument or we can just pass 0 here to alloc_netdev() unconditionally?
> Drivers that have &net_device embedded can't have any private data there
> anyway.

Sorry, I answered you this question in the previous thread, and gave you an
example why we need the @sizeof_priv.

	https://lore.kernel.org/all/ZgWrcvKyAzDvl%2Fjn@gmail.com/

I didn't see any reply from you, so, I suppose you were OK with it, but
maybe you missed it?!

Anyway, let me paste what I've sent there here, so, we can continue the
discussion in this thread, which might make the reviewing process here.

This is what I wrote in the thread/message above:

  We need to have this private size for cases where we need to get the
pointer to their private structure given the dummy device.  In the
embedded case you can use container_of(), but, with a pointer to
net_device, that is not the case anymore, and we should use the dummy private
data pointer back to the private data.

For instance, see the example of iwlwifi:
https://lore.kernel.org/all/20240307174843.1719130-1-leitao@debian.org/

