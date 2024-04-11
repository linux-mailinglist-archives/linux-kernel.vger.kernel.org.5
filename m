Return-Path: <linux-kernel+bounces-139634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52D8A0599
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3F61C21109
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CC62144;
	Thu, 11 Apr 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1TH+013"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E360605CD;
	Thu, 11 Apr 2024 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799388; cv=none; b=SW2Pgy2peTTT/6Opt4im2hBXM6W6hR/Q1kxwLF6+e32MO2p+9kBi3+oq3/YCl5A5CiMPq8aopigcC2tceweYvJkNILXzXKbqtl4ZnkwRurdMwdcxsAIP8HYyEqhfso6mf3H4qF3XH6J5zwYDiusSiWPT/VbHHXqVdPRQRVHCJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799388; c=relaxed/simple;
	bh=Bv17sivQjVSRil5/m7NyguLXoC8iZa+4bbs4tHa3P+4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k2GM7mdvS4qPykwl8H1bQ5ceJaZk8Fzbg8iP7F20jkO6SJq0boRuZoSf9pn3jo74lV7x868ueFJOMVgxc8WOd8YH3X/jkIsnXQSc/lWJ5Z7aEzLx5Qfub4TjtH77Ol8ngoHI6M6tI1nfg3AKdDQqQCwbgSrLsIYjZU3PT3p488s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1TH+013; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d57bd577dso364691285a.2;
        Wed, 10 Apr 2024 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712799386; x=1713404186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbSovFXxhV1ZzfQY3zmzSZkZK0djY0/pPM92ABTCFDY=;
        b=m1TH+013lFtunm8g8489gm7HbX3DfRTVXgAFquxUWnxtX43spZ9WA7g5AXo/QgQ8yz
         53IyGIwQhJVecCfm2OcfsLDfqvbfhlLTsq8ruMddPqLQtWlv3fEcemCXZz6lIbdOYrt8
         sMW0kh7+BhM+Y1kHHhjaeRlqIVGtDgj7P/mcQfwBYGFqtLCi1g3UwMg6XcfNtEcXODJP
         l2gDuYgEzydcAQnEpzcHE92NgNnP1bmXO1wQ009Gk1HFQ0mFK7w5lLDXw68ww2vVLxUt
         rGQ3zIs+OQIPle7BVAdxHXtwQM4wo9daoFwznplRId1F2S7t61zSuMeRZrZMGUl1friY
         9Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712799386; x=1713404186;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tbSovFXxhV1ZzfQY3zmzSZkZK0djY0/pPM92ABTCFDY=;
        b=KiGJnhRYrm5cu7sO2nfSbV/X6UgB2lUoNVytnlHxT5TfmK5dwXI9zFFp8skxA+CtkN
         wiNZJ2zAD/6McrffeWhn+58QY0/gUB+N9LcgITTEt7XIH3xbQ4OLUSS9ByPoW9tfjscb
         hGPsTgU4cnZvrwz0jL434HsJO7AzzFZNqk+Cq95daZ/3C+MXI8UBO83CVMR6X/f/rxOb
         DjGfMPNwxc6sToNoXm+iIhfiwUhRhQmijmvPneKEoLmcHA6308Krqe/mwRDwlDY1gYbP
         cca7AfQuIOKQzbcpdq4/c0kzSrQQjs/Cp5to8i915JfCmAA4BH1M7YUjVi9MMT5sFh5S
         e/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Rv8bsnzEFVYDt0oK4Q3faycANoK49rFdMfH36pPj9RVYuGNxYSrPaH1bon8wkiPFTWTbxkEgrVHS89qyC6ZHVcUGf12vKCrmUAnjzRTLnu7AqxNRzENZ9o0XxyOoJ9H6zto9
X-Gm-Message-State: AOJu0YwUXRGNaD716OfwNy0VizFa6VjMSnJb7hIevhNyYX2ghr3F2V+2
	KlLkUbQou36fO2epmz2odgt1jV7gABgfvc1xV4knlIgUDwY8FzmM
X-Google-Smtp-Source: AGHT+IE/blMsmh23x6zYnhsQngea6jAiJ2NdK39aQR7Qy6pMA6O44kVEKfUmCGuK9qqW0iH1NUUj1A==
X-Received: by 2002:a05:620a:ec8:b0:78d:68de:e3ac with SMTP id x8-20020a05620a0ec800b0078d68dee3acmr3397684qkm.76.1712799385975;
        Wed, 10 Apr 2024 18:36:25 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id l25-20020a05620a211900b0078d67d40c49sm334328qkl.70.2024.04.10.18.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:36:25 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:36:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 John Fraker <jfraker@google.com>, 
 netdev@vger.kernel.org, 
 Praveen  Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Willem de  Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Junfeng Guo <junfeng.guo@intel.com>, 
 Ziwei Xiao <ziweixiao@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 linux-kernel@vger.kernel.org, 
 kory.maincent@bootlin.com, 
 andrew@lunn.ch, 
 richardcochran@gmail.com
Message-ID: <66173e9972287_2d6bc6294d1@willemb.c.googlers.com.notmuch>
In-Reply-To: <874jc8ww68.fsf@nvidia.com>
References: <20240408180918.2773238-1-jfraker@google.com>
 <661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
 <20240409172838.247738f3@kernel.org>
 <87jzl5akh5.fsf@nvidia.com>
 <20240410061928.712ff9a3@kernel.org>
 <6616e92cbcca_2bfabf294c5@willemb.c.googlers.com.notmuch>
 <874jc8ww68.fsf@nvidia.com>
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rahul Rameshbabu wrote:
> 
> On Wed, 10 Apr, 2024 15:31:56 -0400 Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > Jakub Kicinski wrote:
> >> On Tue, 09 Apr 2024 21:40:46 -0700 Rahul Rameshbabu wrote:
> >> > > My gut tells me we force drivers to set the ethtool op because
> >> > > while at it they will probably also implement tx stamping.  
> >> > 
> >> > I think the logic should be the other way (in terms of the
> >> > relationship). A call to skb_tx_timestamp should throw a warning if the
> >> > driver does not advertise its timestamping capabilities. This way, a
> >> > naive netdev driver for some lightweight device does not need to worry
> >> > about this. I agree that anyone implementing tx timestamping should have
> >> > this operation defined. An skb does not contain any mechanism to
> >> > reference the driver's ethtool callback. Maybe the right choice is to
> >> > have a ts capability function registered for each netdev that can be
> >> > used by the core stack and that powers the ethtool operation as well
> >> > instead of the existing callback for ethtool?
> >> 
> >> Adding a check which only need to runs once in the lifetime of
> >> the driver to the fastpath may be a little awkward. Another option
> >> would be a sufficiently intelligent grep, which would understand
> >> which files constitute a driver. At which point grepping for 
> >> the ethtool op and skb_tx_timestamp would be trivial?
> >
> > Many may not define the flags themselves, but defer this to
> > ethtool_op_get_ts_info.
> >
> > A not so much intelligent, but sufficiently ugly, grep indicates
> > not a a massive amount of many missing entries among ethernet
> > drivers. But this first attempt is definitely lossy.
> >
> > $ for symbol in skb_tx_timestamp get_ts_info SOF_TIMESTAMPING_TX_SOFTWARE ethtool_op_get_ts_info "(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info)"; do
> >     echo -n "$symbol: ";
> >     for i in `grep -nrIE "$symbol" drivers/net/ethernet/ | awk '{print $1}' | xargs dirname | uniq`; do echo $i; done | wc -l;
> >   done
> >
> > skb_tx_timestamp: 69
> > get_ts_info: 66
> > SOF_TIMESTAMPING_TX_SOFTWARE: 33
> > ethtool_op_get_ts_info: 40
> > (SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info): 59
> >
> > This does not add up, but that's because some drivers share prefixes,
> > and some drivers have different paths where one open codes and the
> > other calls ethtool_op_get_ts_info. Marvell is a good example of both:
> >
> > $ grep -nrIE '(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info)' drivers/net/ethernet
> > /marvell
> > drivers/net/ethernet/marvell/pxa168_eth.c:1367: .get_ts_info    = ethtool_op_get_ts_info,
> > drivers/net/ethernet/marvell/mv643xx_eth.c:1756:        .get_ts_info            = ethtool_op_get_ts_info,
> > drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:5266:   info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:962:          return ethtool_op_get_ts_info(netdev, info);
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:964:  info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> 
> If there is a desire to enforce all drivers need to implement
> .get_is_info, would the following make sense?

The only reason to enforce this is if we want to enforce them to also
implement tx software timestamping. Generally, these features are opt
in.

> My biggest objection to
> this idea was mainly my concern that the drivers would miss setting
> info->so_timestamping with SOF_TIMESTAMPING_RX_SOFTWARE |
> SOF_TIMESTAMPING_SOFTWARE, which I do not think should be a
> responsibility of the driver author since this is happening in the core
> stack.
> 
> So maybe something like this (taking Willem's proposal for
> __ethtool_get_ts_info and modifying it a bit)?
> 
>         int err = 0;
> 
>         ...
> 
>         info->phc_index = -1;
> 
>         if (phy_has_tsinfo(phydev))
>                 err = phy_ts_info(phydev, info);
>         else
>                 err = ops->get_ts_info(dev, info);
> 
>         info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
>                                  SOF_TIMESTAMPING_SOFTWARE;
> 
>         return err;

Yes, this is what I meant as well. (the code I showed was just copied
verbatim from net-next as context, not a suggested change.)

> >
> > One more aside, no driver should have to advertise
> > SOF_TIMESTAMPING_SOFTWARE or SOF_TIMESTAMPING_RAW_HARDWARE. Per
> > Documentation/networking/timestamping.rst these are reporting flags,
> > not recording flags. Devices only optionall record a timestamp.
> 
> I think this view aligns with my opinion above (though good point about
> timestamping reporting bits in general should be deduced based on the
> timestamp generation bits set rather than needing to be set as well).


