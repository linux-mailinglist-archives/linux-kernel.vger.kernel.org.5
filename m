Return-Path: <linux-kernel+bounces-87628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC486D6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3050D1C22AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19174BF6;
	Thu, 29 Feb 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="e0yP1pzt"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B46D535
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244920; cv=none; b=SfuUo0Fln8FT4ljilxx4k/MiBE39mMy/KFHZKUMi4ZOqRGYnDgexfw1M1YvSlWb63bdApKMqDGffdbHXbhoo3wdynyxNLuBh1vbWV9EtG14/x21mycKJtX9/WU6JpUjQ1cQrklIUEBqkZLu5nw+zJCPS2FAcAwmNAZ7xjDe+pwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244920; c=relaxed/simple;
	bh=5FSiTuqHmDsjXTZPDXr3lj4oUQySDL+fFiia69OcWH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwgticShBNWF0tt084fF8X9OadXoIHe0RN60D7kvFi9ZMV3qBb+MXHQZ6+flz+Y4+rpUgMmJl0lqZ0oN+kX9mQJevICtvKf6EiHUip461jUhN8KFMSDF2MvwM/iezURP3YIVDz8RfPoVUDXA1BwM77KkMe9nFRsv1Ps4iIC/ZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=e0yP1pzt; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id fnAwrKH91HXmAfogPrdLXD; Thu, 29 Feb 2024 22:15:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fogOrRKWy2l0ifogOreC0A; Thu, 29 Feb 2024 22:15:16 +0000
X-Authority-Analysis: v=2.4 cv=fPk/34ae c=1 sm=1 tr=0 ts=65e101f4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=xfJypzPxiScX5pcAhuAA:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cf1DZ2erRbMxD8JvVLJPv18i9Hg6aww57G4W3t9Oeoc=; b=e0yP1pztbkxkhpcJxYDiCSOm9p
	fihMzZKmaTkeqIBnkZZupDuJlp5aNCxO2ey9rO97gUBe4WSG8LzztnW4JPppdUM6t1XjnLPbt1CLP
	bWp+VnMM7SkP+NJpbTAmj6GdeKiGJU69QxgmuFo4zx4EPNUDjrhSXLipqVR7anVOJdv9OOLDjtbDG
	xu3x7Ww1m0CEEA1WCr5l0lDJxqPh99MM5R7NpSOKYbs4drDgFiWxObM2b2SL8JobMShCccoSZ/rc+
	iVH/f3WVNC4K9jVImTVChD53aiFwo3zDZfX/oLxl2aD/4xQC8HIhRIX9AZ3/jdrBgBDIMelq8rgX2
	M8Az3Fzw==;
Received: from [201.172.172.225] (port=53434 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rfogM-002d6M-1s;
	Thu, 29 Feb 2024 16:15:14 -0600
Message-ID: <93cbd0a3-60cf-400f-a05c-f81dc3d8c75d@embeddedor.com>
Date: Thu, 29 Feb 2024 16:15:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>,
 Coco Li <lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240229213018.work.556-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240229213018.work.556-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rfogM-002d6M-1s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:53434
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHiOeYWfrPDCxfGwqkTIPftgYSQ0ePEzGtTq9mHHaH6HmlCmhH5DbqLF7Roys/T4bAD0jlt9jNjIbUVkAN/tRQIO7ce5F15iII2CioWgBFyp2p8/3co8
 7kQ6afnXEyWceb/e5dsLGevbUk1ExQ+/thjSusg375ltImxu+EJHPAEZDqELF8UvNZGd6XgSMa50TV1P5to2gcqE7/cXPgWglKQ0mIc1JulAl3mAlGd1VwB5



On 2/29/24 15:30, Kees Cook wrote:
> Introduce a new struct net_device_priv that contains struct net_device
> but also accounts for the commonly trailing bytes through the "size" and
> "data" members. As many dummy struct net_device instances exist still,
> it is non-trivial to but this flexible array inside struct net_device
> itself. But we can add a sanity check in netdev_priv() to catch any
> attempts to access the private data of a dummy struct.
> 
> Adjust allocation logic to use the new full structure.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
[for the flex `struct net_device_priv`, `struct_size()`, `__counted_by()`,
and the use of `container_of()` to retrieve a pointer to the flex struct
and return pointer to flex-array member `data` in `netdev_priv()`]

Thanks
--
Gustavo

> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   include/linux/netdevice.h | 21 ++++++++++++++++++---
>   net/core/dev.c            | 12 ++++--------
>   2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 118c40258d07..b476809d0bae 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
>   	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>   };
>   
> +#define	NETDEV_ALIGN		32
> +
>   /**
>    *	struct net_device - The DEVICE structure.
>    *
> @@ -2476,6 +2478,14 @@ struct net_device {
>   	struct hlist_head	page_pools;
>   #endif
>   };
> +
> +struct net_device_priv {
> +	struct net_device	dev;
> +	u32			size;
> +	u8			data[] __counted_by(size)
> +				       __aligned(NETDEV_ALIGN);
> +};
> +
>   #define to_net_dev(d) container_of(d, struct net_device, dev)
>   
>   /*
> @@ -2496,8 +2506,6 @@ static inline bool netif_elide_gro(const struct net_device *dev)
>   	return false;
>   }
>   
> -#define	NETDEV_ALIGN		32
> -
>   static inline
>   int netdev_get_prio_tc_map(const struct net_device *dev, u32 prio)
>   {
> @@ -2665,7 +2673,14 @@ void dev_net_set(struct net_device *dev, struct net *net)
>    */
>   static inline void *netdev_priv(const struct net_device *dev)
>   {
> -	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> +	struct net_device_priv *priv;
> +
> +	/* Dummy struct net_device have no trailing data. */
> +	if (WARN_ON_ONCE(dev->reg_state == NETREG_DUMMY))
> +		return NULL;
> +
> +	priv = container_of(dev, struct net_device_priv, dev);
> +	return (u8 *)priv->data;
>   }
>   
>   /* Set the sysfs physical device reference for the network logical device
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cb2dab0feee0..0fcaf6ae8486 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10800,7 +10800,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>   {
>   	struct net_device *dev;
>   	unsigned int alloc_size;
> -	struct net_device *p;
> +	struct net_device_priv *p;
>   
>   	BUG_ON(strlen(name) >= sizeof(dev->name));
>   
> @@ -10814,20 +10814,16 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>   		return NULL;
>   	}
>   
> -	alloc_size = sizeof(struct net_device);
> -	if (sizeof_priv) {
> -		/* ensure 32-byte alignment of private area */
> -		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
> -		alloc_size += sizeof_priv;
> -	}
> +	alloc_size = struct_size(p, data, sizeof_priv);
>   	/* ensure 32-byte alignment of whole construct */
>   	alloc_size += NETDEV_ALIGN - 1;
>   
>   	p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>   	if (!p)
>   		return NULL;
> +	p->size = sizeof_priv;
>   
> -	dev = PTR_ALIGN(p, NETDEV_ALIGN);
> +	dev = &PTR_ALIGN(p, NETDEV_ALIGN)->dev;
>   	dev->padded = (char *)dev - (char *)p;
>   
>   	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);

