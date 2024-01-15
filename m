Return-Path: <linux-kernel+bounces-26520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE982E2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788FA283B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE861B7F1;
	Mon, 15 Jan 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b34SvOSf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC41B5B1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705357955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eP0VxXSEEil+R0UNdZpa6aVY75gYpHAxm/3u1ydWXpo=;
	b=b34SvOSfG922P84297/sD9KEjCH1AImm3GvBtbgeZwPTPqViaWwlH3vHFede7peqQxtz7P
	kK4e2hSf5LBJLHTBbcdMagjkW06YzMF3YMfcgxjNO3TioEbBhRXOngIWA7CNV6Js5c4sEU
	+aiYf73K3RYsKpI+VudSo1NQ+amnzdk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-NZoR3yuQMRWCMolG-AZ_wg-1; Mon, 15 Jan 2024 17:32:27 -0500
X-MC-Unique: NZoR3yuQMRWCMolG-AZ_wg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e6e3c46bfso20014085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705357946; x=1705962746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP0VxXSEEil+R0UNdZpa6aVY75gYpHAxm/3u1ydWXpo=;
        b=cqVhJ/GYxcfqJAQBN50RlVicvfS3AEVUB2nqiKbg5Qump5CWqRbx6OaPgOgMFR9RTV
         UsmlIT1Igd9+hxy0yCqnq1YFXTy5czveP9rIANFTthHXc7BcS9kdYLBaxKwlKQb08dvZ
         pZHKd+BCUksBZhHVdDW+Frby85QvkKS+//DuWeDoC4fQ2YwtykPNtHPMe+Ndm3CqvoAb
         zIdIqbXKRg4Gt9YMznoQM5HUbyUm/fAy8CkFLgjMqfxpkGgYmeHZPIclmBY+l2SE0p/c
         IrQ7Ww30LozX2YC2/f7OfL/vGJ3f+JZOpH1dabhgRTSJfU/QteHbXZ2jWeKVCmASpqNt
         xPhA==
X-Gm-Message-State: AOJu0YyxdTaWfUUoY+c6HFMEDIwBec3GV3P52cLm5xyVd4luZ7527wyK
	lwH0koFN5xmXqcYA+w0gWa5a6MH9e1ynsI/E7xhL+bfUW0ykVBXinZ/cnbq4vyjz+2UMPTgnOMe
	5zK82z3uVH3CM6c249kk5Eg1zInBVmfWy
X-Received: by 2002:a05:600c:4a9b:b0:40e:57f2:5948 with SMTP id b27-20020a05600c4a9b00b0040e57f25948mr2946996wmp.72.1705357946073;
        Mon, 15 Jan 2024 14:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkeJKqYDhM/whQk/nCZZw+VXl4wzetnaox4MjVkcLxDiSEjq0eYyRMgzXTkyhuF5WMBxlqJQ==
X-Received: by 2002:a05:600c:4a9b:b0:40e:57f2:5948 with SMTP id b27-20020a05600c4a9b00b0040e57f25948mr2946992wmp.72.1705357945790;
        Mon, 15 Jan 2024 14:32:25 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe948000000b00336710ddea0sm12980913wrn.59.2024.01.15.14.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 14:32:25 -0800 (PST)
Date: Mon, 15 Jan 2024 17:32:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Message-ID: <20240115172837-mutt-send-email-mst@kernel.org>
References: <20240115194840.1183077-1-andrew@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115194840.1183077-1-andrew@daynix.com>

On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
> 
> Qemu options:
>   -netdev tap,vhost=on,vnet_hdr=off,...
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  	hdr = buf;
>  	gso = &hdr->gso;
>  
> +	if (!sock_hlen)
> +		memset(buf, 0, pad);
> +
>  	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>  	    vhost16_to_cpu(vq, gso->csum_start) +
>  	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >


Hmm need to analyse it to make sure there are no cases where we leak
some data to guest here in case where sock_hlen is set ...
> -- 
> 2.43.0


