Return-Path: <linux-kernel+bounces-39898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F883D738
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A5729AB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBA65BDA;
	Fri, 26 Jan 2024 09:11:28 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEECC65BCC;
	Fri, 26 Jan 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260288; cv=none; b=YTA60IGbC8gssiUHM8Ftm2qeM/nXrz6gLak0pJhZYxLzWYatFJvNCLWT/ksSrukb3tvz2XuOGRecoTI+bYqGdvauzQMfUaLmtxhQt9lTKlneioNTIz2cQ4PFxo3JQ235wmxikDo2t6ML/5hOKmABdwbiNxLR43UnSOjjKLwS5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260288; c=relaxed/simple;
	bh=2x4cSzioymkD/L+R0j5Pu+P0Q4GeUXl1uInp6KPmnJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKgemd6jRfIjm33s86lMngPe7v9iTph0cfTFRoRlOcmLPbRJ3CUCaQS5x/vZKj0cKHsKu2spaLVThKv/EqCiAWyXr1OuocaLZu4WPHDHR3KmKoMqKnjY6tnIHCyCf1xHVK/+gC/JPg6gGMWuhiNSlKcrUzH89HNv49CAipwFcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ee0ace64fso2028905e9.1;
        Fri, 26 Jan 2024 01:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706260285; x=1706865085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLYPRg+9DjNrUyzQEzc73suRoE2UEDKX6vuwl1jCCnY=;
        b=N3Ab/VhELNR8SRYNZ1l4c4QEtvP4xtf8XLC+IwqUkUtG5slTidLe7/O3LnL9g+/cHZ
         jpT+GOV3gY7+zVlU1HOWRHMeih6gF4Z1aqAkyGW54FYcpFQA8pf647x7cfYIvW2XTA9s
         k2wKqPq+OGfCoy5n1vwFKQw2Tm+8TIPQeTnX3ecmbrpMS+aTmPpLDCINf5YLQnmzhmw6
         WvSOrj73KubzAB9qg6AT68WuB9vOKwBEALyNpk9NwywvlcjvpXRguItNiIBkcWjNVMod
         pwU+P3MIBcn5LhbI9eCYo6rK6sPgEBR9PFE2K4PI5SQzQywJNepfhAyjiZfSorvocCw5
         Tyjw==
X-Gm-Message-State: AOJu0YwQLy1UlGx5QpR+Smjz0MAPVUX+Swu1Qqi8Rk5o3MyPYzIxtwKQ
	RnymCunSs+lk6E67SRJ1HckH/XkGwROA0DhqdvBdCVeszd4M8puL
X-Google-Smtp-Source: AGHT+IEORubeMvZPghYE7WmqSGMZNquD+aOYMD1F6Dg5FfIKiRQcZ4tA1AtiyJZLTEbj3cb9nDXHVw==
X-Received: by 2002:a05:600c:4514:b0:40e:549b:340e with SMTP id t20-20020a05600c451400b0040e549b340emr596056wmo.110.1706260284818;
        Fri, 26 Jan 2024 01:11:24 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id js18-20020a17090797d200b00a331d6c0c70sm405427ejc.71.2024.01.26.01.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:11:24 -0800 (PST)
Date: Fri, 26 Jan 2024 01:11:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	dhowells@redhat.com, alexander@mihalicyn.com,
	wuyun.abel@bytedance.com, kuniyu@amazon.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net
Subject: Re: [PATCH net-next] net: print error if SO_BUSY_POLL_BUDGET is large
Message-ID: <ZbN3Oh6+i34mGRLp@gmail.com>
References: <20240125191840.6740-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125191840.6740-1-jdamato@fastly.com>

Hi Joe,

On Thu, Jan 25, 2024 at 07:18:40PM +0000, Joe Damato wrote:
> When drivers call netif_napi_add_weight with a weight that is larger
> than NAPI_POLL_WEIGHT, the networking code allows the larger weight, but
> prints an error.
> 
> Replicate this check for SO_BUSY_POLL_BUDGET; check if the user
> specified amount exceeds NAPI_POLL_WEIGHT, allow it anyway, but print an
> error.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  net/core/sock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a..ed243bd0dd77 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1153,6 +1153,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  			return -EPERM;
>  		if (val < 0 || val > U16_MAX)
>  			return -EINVAL;
> +		if (val > NAPI_POLL_WEIGHT)
> +			pr_err("SO_BUSY_POLL_BUDGET %u exceeds suggested maximum %u\n", val,
> +			       NAPI_POLL_WEIGHT);

'val' is a signed value variable. I suspect it will never be negative given
the line above (val < 0 || val > U16_MAX), but, I am wondering if you
should still print it as signed integer (%d) to keep it consistent.

