Return-Path: <linux-kernel+bounces-123092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAD890208
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4661C2D41C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACA128369;
	Thu, 28 Mar 2024 14:37:21 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FEFC11;
	Thu, 28 Mar 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636641; cv=none; b=afkNNk3qlELafXmCdKYaH/CGxyVLIXiZVgqY2aoWlRfjgVFQrhb/GOKbJa+ALACwxvoWV3R5BMQs8vq5i4DIQfhvO5k8A1WWCvMX08j9DQRpQAWmhtK1BpFLPeAfLvh+pbqQ1DNxzb5GxX/9vN/3OXYv7l5h5kXPLXYy3H5iuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636641; c=relaxed/simple;
	bh=i7jFpT3SlY+C5YpRF/nwGu5Tl5UvMVM0Giak+wc/aEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1S2wVvIuIeS6XxLZ1MWUKHnNW7pQdrLNsRfwt+34ofNZBBUHJx1b96fRMIK/RyqY8jpgjYHBRTy3sNJ3Xx26pxLFP0XNfiijU3bFfrLyfi73J1y5BtkFj9OFeJuP3SU1U2+AEXmzsD8IY1vTxzB6tSBTsRDLjbrFs35Nf3tMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a470d7f77eeso135435966b.3;
        Thu, 28 Mar 2024 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636637; x=1712241437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRMMyiWkeqTEpdcUJkKviRGWqg83eHB0joKkjU2QhOQ=;
        b=QiM2tpgpyMK1N61KUQmRYWGI1bkd9cn85xn+5dmG32ZFI45iNATSU3WTrxzKihcmMU
         HZlNNIQ73JnzgB/fuWQgM+daYdTbzRtyZrKBM1hO83ER1Yi7GcYSclzFfkut4GShaOlm
         FkJs85Prx+pgjqBT0eJ20xuv6/9xYux5b2EvhZAjC7U9/XTk4UAQfmCw3QQxg2ab1qNy
         XNreDLMkP/+adSIod6G+T9tNCrR3J724Ii2BF3r+jTHIfOrvqEvtqOvaO7U4tkKPwZrF
         4Rk22U2wApf4C+xWMcOMqaYxbbz9KJoYgt/fT422EvtDhp9dmNwnaK9VCvebkuir1Nvy
         CMmg==
X-Forwarded-Encrypted: i=1; AJvYcCVGsKjXqopEOvelcnp3jMyzAk/q0hekw3Pd2+EAZLrwV4X9nIHtbdypRFDzE4XwStdocLmkH7wuEqjYhKW4RtljU6pTviBLGal509cCVCJig0B6fHD9sB7NTvTLQFukxdYf3Ruw
X-Gm-Message-State: AOJu0YyCTpZtpw9+W7Jyo/mfGYClnT9zTIK/RF28CEkaa1QIJGS4nh59
	kj8XSSFg0lFmcEId3k6k6SlW0F90rl0tziM4yWeDdFMyTKwFO1h8
X-Google-Smtp-Source: AGHT+IHF+TMUaDmJ1lsrsQ8KYkot3eOluabfodUPxJ/mwfrIC03qj8U9JnQ3QW/z96AbIL35qUEHfQ==
X-Received: by 2002:a17:906:d156:b0:a46:954a:aa14 with SMTP id br22-20020a170906d15600b00a46954aaa14mr2152846ejb.67.1711636637084;
        Thu, 28 Mar 2024 07:37:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b00a469e55767dsm816421ejj.214.2024.03.28.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:37:16 -0700 (PDT)
Date: Thu, 28 Mar 2024 07:37:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: rbc@meta.com, riel@surriel.com,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, hengqi@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is
 not supported
Message-ID: <ZgWAmsB4vTXE66uJ@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <1711503463.632461-1-xuanzhuo@linux.alibaba.com>
 <ZgQkXfMd6GIEndXm@gmail.com>
 <1711589335.4973893-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711589335.4973893-1-xuanzhuo@linux.alibaba.com>

> > On Wed, Mar 27, 2024 at 09:37:43AM +0800, Xuan Zhuo wrote:
> > > On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> > > > Do not set virtnet_info->rss_indir_table_size if RSS is not available
> > > > for the device.
> > > >
> > > > Currently, rss_indir_table_size is set if either has_rss or
> > > > has_rss_hash_report is available, but, it should only be set if has_rss
> > > > is set.
> > > >
> > > > On the virtnet_set_rxfh(), return an invalid command if the request has
> > > > indirection table set, but virtnet does not support RSS.
> > > >
> > > > Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > ---
> > > >  drivers/net/virtio_net.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index c22d1118a133..c640fdf28fc5 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> > > >  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> > > >  		return -EOPNOTSUPP;
> > > >
> > > > +	if (rxfh->indir && !vi->has_rss)
> > > > +		return -EINVAL;
> > > > +
> > > >  	if (rxfh->indir) {
> > >
> > > Put !vi->has_rss here?
> >
> > I am not sure I understand the suggestion. Where do you suggest we have
> > !vi->has_rss?
> >
> > If we got this far, we either have:
> >
> > a) rxfh->indir set and vi->has_rss is also set
> > b) rxfh->indir not set. (vi->has_rss could be set or not).
> 
> 
> This function does two tasks.
> 1. update indir table
> 2. update rss key
> 
> #1 only for has_rss
> #2 for has_rss or has_rss_hash_report
> 
> 
> So I would code:
> 
> 	bool update = false
> 
> 	if (rxfh->indir) {
> 		if (!vi->has_rss)
> 			return -EINVAL;
> 
> 		for (i = 0; i < vi->rss_indir_table_size; ++i)
> 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> 
> 		update = true
> 	}
> 
> 	if (rxfh->key) {
> 		if (!vi->has_rss && !vi->has_rss_hash_report)
> 			return -EINVAL;
> 
> 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> 		update = true
> 	}
> 
> 
> 	if (update)
> 		virtnet_commit_rss_command(vi);
> 
> Thanks.

This is a bit different from the previous proposal, but, I like this one
approach better. It makes the code easier to read.

How does the full patch looks like?


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..180f342f1898 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,20 +3807,35 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
+	if (!vi->has_rss && !vi->has_rss_hash_report)
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
+		if (!vi->has_rss)
+			return -EINVAL;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+		update = true;
 	}
-	if (rxfh->key)
+
+	if (rxfh->key) {
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EINVAL;
+
 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4729,13 +4744,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 

