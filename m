Return-Path: <linux-kernel+bounces-129751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE6896F81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1732B28EE9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A09149C4A;
	Wed,  3 Apr 2024 12:53:26 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A361494CE;
	Wed,  3 Apr 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148806; cv=none; b=lCjyI3vkFG/oC2Ah1xgaEN5MI9d2r4UW+7Olg9Iu0UcmVi3R/bhbhbH30NX+VhEqEZIYMidYUHoJAy2uhbV8dPORho2Icllg7dXZ2RChvlYO5cRgwTC7z5rGJlJNym1yE2xBDPgu9y1MyqLS4Ea7IBcbNwfzGvorNBbOVW+5czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148806; c=relaxed/simple;
	bh=UntQTPh+2hrQn/xIlOWJaJgrauzrTj7yswbk+DwsRJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A95FNpqmcXNG1e+AhRokIkx0T79pmZtmoXRwAN/absOaGpZE9zGhmQ/mnVUR0bZIe63IdOZAT+fAy9Zdd8kVwyYSHV9Ct+WPaXCS5ak9kPN6t0oFCH78qEug/wNoq0EFJxGlqW8Pu3OyyM9Ppq0KFr8LDhXnuVzZ16Q6pf+GDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46a7208eedso824936566b.0;
        Wed, 03 Apr 2024 05:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712148803; x=1712753603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4cj6vg+PLMD3bnAnC/7BKVkE+A86qwqaG5PcVTOt18=;
        b=a9G1Uj1tXvk8mKna/klFrPZDWk3MTIXiHofAmeS/kXnCAHX1DJNsox94yzFekHD3hN
         HKwBhkQj30AfKNMFcidPs2Mk/+bHx9UyJ2IZ9PVbJWjNjJJmrFmYxrIxK2P67UR0zKEy
         PO7pW4SAELMqJu0HGjzfUOiBYya+EiGMZ5nMumXYvQyhdAEhd+ipbRB3P48Ygz6nBSCh
         qSMbh6qFzcFP/g1fSR+8/PU1VnmmeBsvoidXPdCeKT64WXxvbnph2ln6QketlF77D+WA
         oHqKhLRDxCcIBKZyy4YsqFAdjDue7Q59u2X6Q1Ekb2ZgRuJg3P4nEQ1bRynYG9dv6LzI
         Sgiw==
X-Forwarded-Encrypted: i=1; AJvYcCXGLDhsG0YQlcAQXlahybcvDTcB+DqPmdbWXAzIzhT1Av8liaLceCjzug3cTSCDTsIN/J6bHtN6CrpzE0C5q/dkIxpSOunq/mWWOixJ6vNqwAicPXgIms8PYYHKX1L8H/YXeMXP+1+9wUaSAXPUqGKilJHOahCf7F9/S3RM
X-Gm-Message-State: AOJu0YymaYaD9FcIJ+eGwabKMzk7lvQQzueGAe/tw3IwbyqO9kgxNmKS
	m1KC+qNxPISMx16mz+eO5DYAeI+jOpK/6eguVJBnLn3FJAnaS/n3
X-Google-Smtp-Source: AGHT+IG/LZvkvkvKke8uVXcXbrYjZ9FSvr+Pm5+/tdlPUCoe15E1D9VDt24wooC2fGJfQa9Hdwxe2A==
X-Received: by 2002:a17:906:2284:b0:a4e:39f1:6374 with SMTP id p4-20020a170906228400b00a4e39f16374mr1812470eja.24.1712148803105;
        Wed, 03 Apr 2024 05:53:23 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a4e7c2b2070sm2694127ejc.8.2024.04.03.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:53:16 -0700 (PDT)
Date: Wed, 3 Apr 2024 05:53:12 -0700
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
	riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <Zg1ROBmnY0jaKvsf@gmail.com>
References: <20240329171641.366520-1-leitao@debian.org>
 <20240331160618-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331160618-mutt-send-email-mst@kernel.org>

On Sun, Mar 31, 2024 at 04:20:30PM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
> > @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  		return -EOPNOTSUPP;
> >  
> >  	if (rxfh->indir) {
> > +		if (!vi->has_rss)
> > +			return -EOPNOTSUPP;
> > +
> >  		for (i = 0; i < vi->rss_indir_table_size; ++i)
> >  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> > +		update = true;
> >  	}
> > -	if (rxfh->key)
> > +
> > +	if (rxfh->key) {
> > +		if (!vi->has_rss && !vi->has_rss_hash_report)
> > +			return -EOPNOTSUPP;
> 
> 
> What's the logic here? Is it || or &&? A comment can't hurt.

If txfh carries a key, then the device needs to has either has_rss or
has_rss_hash_report "features".

These are basically virtio features VIRTIO_NET_F_HASH_REPORT and
VIRTIO_NET_F_RSS that are set at virtio_probe.

I will add the comment and respin the series.

