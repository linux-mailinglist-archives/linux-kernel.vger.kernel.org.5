Return-Path: <linux-kernel+bounces-121391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04088E9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD03B34754
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE615D5A7;
	Wed, 27 Mar 2024 13:51:32 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0215CD6A;
	Wed, 27 Mar 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547491; cv=none; b=hdTIU3GwX407XHOL/CHxRglODzWJt05tZYw0HlutnQtT8JcO0++N3eYaAseWfboxniLFJnxvbUvyORUS3KzZMkmsvC+fMNSjwKhG+kAQ0BBMFvUDrIFopFBQeVKHqNpF4GtyjrMCkHLkk+zt7+CJuus9/gj1YR8amq3c6YDUys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547491; c=relaxed/simple;
	bh=LRh020dt3JvCw/r0YCn85ScWnAbwueBpSbcIgI27W8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz95Gv3/08iTmqvr99mY3+BsB5QVhoTiTsYQJ/W8Cbu4K05UXADwhMNzhs8UdQ7PpJOsM9LnykV1+a5pskDAr0yYHc3kHLLAHhuNlPbgwzrxJV8be/E5VxmWqAvYrqCLYQV/XXFCz/DpOu9El2WqQpZgue4QOfWHXDtrln8bYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso423368766b.2;
        Wed, 27 Mar 2024 06:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711547488; x=1712152288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcKm7eRThoxP9DS6Fq9W4RWZhYw3k695B/yck6NlVFk=;
        b=ACd6FqcedO5j5Sf2JS7eVB9RN1wMt2v7Zul2vOPBrHHHWcYuR0NnxCTnz56KcecEL8
         X4umlsTluLtdu2XNopQJrl1AV6O9LYnis0LIzkxAjXG+oeSGE1T3ejei09BlCM9lNYQ8
         p6VIjx4py9HZabJ2Uc+Q3D0iUKNXaVJbBFDt57kr50UAut92nQ4A2WHIyQHEJm6vjyTE
         p824dtgajCyI8zmESqw+sIKOjWYFZuE+kt5dgI1R8pwciTygbWeDzagp7qtPOk2lqdwW
         hHihYFacNimf5VnoI255vWkjR9H0ezr19NFkXUYwtM260zdvokac8lokgnKU8m6H4Rt3
         gwOw==
X-Forwarded-Encrypted: i=1; AJvYcCWVviFUbHWnIs+YuOta4CWyuyLRFPYOkhjClzsXHjCPeJM4JzFPSohqa+v0u+hNf0WXmvtPMdyefwyJrz9l6lV/gIVJY8cwFnrsiLY2f3w7l0WB79auofChG8ATOPrJ7hpf87KT
X-Gm-Message-State: AOJu0YyP3YOQGivWMAL4Y2faHIuyAVD2Lj35jrwUd21brsrnaeRnWqAJ
	1lld5OQrM2FIps5F6xpcyv2IWRx2PQ2xbPGcVFI/Ghl+ePKWVyQF
X-Google-Smtp-Source: AGHT+IFhjYnrjdbXw7KmaYA4ypD1xuTa8d1VPV3peiZKf+9ZHYiqQFI4Rd7Plj+NeUPbD/snQmEOZA==
X-Received: by 2002:a17:906:8415:b0:a46:22a3:479f with SMTP id n21-20020a170906841500b00a4622a3479fmr1138312ejx.21.1711547488000;
        Wed, 27 Mar 2024 06:51:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id wr12-20020a170907700c00b00a474c3c2f9dsm4597296ejb.38.2024.03.27.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:51:27 -0700 (PDT)
Date: Wed, 27 Mar 2024 06:51:25 -0700
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
Message-ID: <ZgQkXfMd6GIEndXm@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <1711503463.632461-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711503463.632461-1-xuanzhuo@linux.alibaba.com>

Hello Xuan,

On Wed, Mar 27, 2024 at 09:37:43AM +0800, Xuan Zhuo wrote:
> On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> > Do not set virtnet_info->rss_indir_table_size if RSS is not available
> > for the device.
> >
> > Currently, rss_indir_table_size is set if either has_rss or
> > has_rss_hash_report is available, but, it should only be set if has_rss
> > is set.
> >
> > On the virtnet_set_rxfh(), return an invalid command if the request has
> > indirection table set, but virtnet does not support RSS.
> >
> > Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/virtio_net.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..c640fdf28fc5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> >  		return -EOPNOTSUPP;
> >
> > +	if (rxfh->indir && !vi->has_rss)
> > +		return -EINVAL;
> > +
> >  	if (rxfh->indir) {
> 
> Put !vi->has_rss here?

I am not sure I understand the suggestion. Where do you suggest we have
!vi->has_rss?

If we got this far, we either have:

a) rxfh->indir set and vi->has_rss is also set
b) rxfh->indir not set. (vi->has_rss could be set or not).

Thanks for the review,
Breno

