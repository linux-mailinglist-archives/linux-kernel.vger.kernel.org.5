Return-Path: <linux-kernel+bounces-98437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DB5877A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329AF2821C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209F923A0;
	Mon, 11 Mar 2024 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPTto8Cq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5017D2;
	Mon, 11 Mar 2024 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128809; cv=none; b=Cgcs/phrF7aVgu0PDyGacQoUd7C82BJypkjglpB4fOz6bReamEjRBe87pNh91hHXrmaRlH8JyfUDg7sMqApcZTrjyD2IU6SqBqJ8XkIbwSKP4ZbsFkJMSKhNcARXngovaIJSrWv8bVEQ03VRY9RVtlwD7xDGpV8MQVd2U2kKYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128809; c=relaxed/simple;
	bh=4M49E5RBOZslEbutTMVGYMXeYTJ0D0KOkpYhEZ/x4xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKZKovus0BQhBIp2CGbxhRdgsTK5kglEfD7SL7cVAAIE2jAB0lphsIuBAXFkQN2dsnGb411+IKBUc1D7I5tqUoIfvJWWAk7qbAkA5PsOQbFGQC3aYpWWX2K11x9OEYBBuzNVLfPS6OCqcSwaJL2KPBJ9/6F02QzAueBLXl2g3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPTto8Cq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so1951798b3a.1;
        Sun, 10 Mar 2024 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710128807; x=1710733607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi7CCN4vCmOHYDaTS1I6t6Q+hFwD+FXKGoxAKDwi63g=;
        b=gPTto8CqjeblQuqt5NHqzqAm0CuIYnYVOEd4wWBXGzoen4MGR9wa/qt02+Xr4rX5XF
         p1ADbDmqhhye2Sl7lkxUzgNyZauiWD5wP6JAJsRA9neY6mP/jv8fzZpqQ1x04LYLd5ia
         INJ5ZvZ7T14gBYgGLkcqhL4277TExbxru+4VJJkZV8vc0S5Kiof9QS5lHlSvLTTbYB5X
         D1fHPqAUtw3QjWuBeAgoBp+GyvUe1C98ifyT+jRXCOPohUOD4oIIz3E3+IlwMSkRe6cb
         lGS3940L53o1VK31Cpy38FtFVXZPQpWpkUSKyLaNut1IG+qBkZpmDbOxbpF2R+FjxfwP
         9ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710128807; x=1710733607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi7CCN4vCmOHYDaTS1I6t6Q+hFwD+FXKGoxAKDwi63g=;
        b=uWRYM43dBO4kstMVRrM88xc3ReDA/ftHhinsJWr6PeekrL4vmyIyfP/fZDHTohhYO+
         KLrzvVr9Pc2xGXxrvlvTg2V+c0nALFTd0QxStN6MYZO/+W43mEkRVVjQIMvdPbJybMI0
         L32I2fU5a4aH+M+U0zUhVwQafzSurg2gapuu4erex7HBJ/bjMMS5LU37pDpwxSgz75TG
         R/P0zDgW72DvKoM+4EhnFqJJm/GHR3wr/oJ7NPhPBppNC5sj3H25hrmyDDGDjYb1WmbC
         dsQsk9nQez4/CU7z4ergB81qM21idyCwnYn3d/MeRfay0MY5Uw+nAto++1HKIA9zisSe
         rNWg==
X-Forwarded-Encrypted: i=1; AJvYcCXs4TqLqDdZ9oQZifIijW/2tiFA48PQUkTfk/ckIOfWBy+ElNXr7oHNuOmSHfSfuhe75Jc6KoX/KUsOASKGxU3ohFGn3U54zZeGCzJC
X-Gm-Message-State: AOJu0YwVh2Hpx471CHu4s25RvAB/c2T/GoUnlxDYouT4D2RMxgc1xCew
	7esxacIY/jdqkgcsa/tFvb1klmNnzbwH1WFNzUguTvkFyDUEFEaheeEhKMLdwnc=
X-Google-Smtp-Source: AGHT+IG6TossFkpumnOXt1LIFx73hYCDgJ7MO+pTJiMc+v9QDSF8XNJD6T1r6CFI/EnNAWRRClKWXA==
X-Received: by 2002:a05:6a20:8f04:b0:1a1:6f26:8c1d with SMTP id b4-20020a056a208f0400b001a16f268c1dmr3382087pzk.53.1710128807192;
        Sun, 10 Mar 2024 20:46:47 -0700 (PDT)
Received: from [172.25.138.193] ([203.246.171.161])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b001db81640315sm3473663pla.91.2024.03.10.20.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 20:46:46 -0700 (PDT)
Message-ID: <8b013d18-2568-46d5-a808-ce9cc1b2ff98@gmail.com>
Date: Mon, 11 Mar 2024 12:46:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: amt: Move stats allocation to core
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org
References: <20240308162606.1597287-1-leitao@debian.org>
Content-Language: ko
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <20240308162606.1597287-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/9/24 1:26 AM, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Move amt driver to leverage the core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/amt.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 68e79b1272f6..cb31d1990660 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3063,15 +3063,10 @@ static int amt_dev_init(struct net_device *dev)
>   	int err;
>   
>   	amt->dev = dev;
> -	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> -	if (!dev->tstats)
> -		return -ENOMEM;
>   
>   	err = gro_cells_init(&amt->gro_cells, dev);
> -	if (err) {
> -		free_percpu(dev->tstats);
> +	if (err)
>   		return err;
> -	}
>   
>   	return 0;
>   }
> @@ -3081,7 +3076,6 @@ static void amt_dev_uninit(struct net_device *dev)
>   	struct amt_dev *amt = netdev_priv(dev);
>   
>   	gro_cells_destroy(&amt->gro_cells);
> -	free_percpu(dev->tstats);
>   }
>   
>   static const struct net_device_ops amt_netdev_ops = {
> @@ -3111,6 +3105,7 @@ static void amt_link_setup(struct net_device *dev)
>   	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
>   	dev->hw_features	|= NETIF_F_FRAGLIST | NETIF_F_RXCSUM;
>   	dev->hw_features	|= NETIF_F_GSO_SOFTWARE;
> +	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_TSTATS;
>   	eth_hw_addr_random(dev);
>   	eth_zero_addr(dev->broadcast);
>   	ether_setup(dev);

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

