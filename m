Return-Path: <linux-kernel+bounces-98438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B7877A30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C2F1F21F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE1D23A6;
	Mon, 11 Mar 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsdeE7TR"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA517D2;
	Mon, 11 Mar 2024 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128860; cv=none; b=b8JClcnn7kojg8d+MAseKOBT0p9KPJ2DftmnusCo2pgO+JcIwwRlx2l1lCmw2ritEAhvHJrYaWtGIyDsBzckSNtg+kvrTY+nni9GmH/7SCYvedmn1SA49x37OCYKXKqa6xLN7zeFEZ0yvX2hVFC2MHDWluWQLtaRDtsoh4c63ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128860; c=relaxed/simple;
	bh=o+Ro6Csb4bfa8KbJPdc9vupzBdRpY9n9Vn5CibybW/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNZ8LqRD0WCRewPCRfT9Ce8HcH8z9oDEHGo+fX13NmNrKxsgz/05pBvi/72Z2at/4rWMDObDhzAO04Mu0mIQAaB4Tuw8iCvuorKO+Cd0dDJAvTmedYgCpZsG2byzKMuNVG0Og15h+vAkV99qpGKiIvagRwjnU/Ex3CRzUnGJMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsdeE7TR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc29f1956cso14941995ad.0;
        Sun, 10 Mar 2024 20:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710128858; x=1710733658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hht2czhX+1Q9FeZ+0sJkAD72ju8vKKUzrmWsyC3pja4=;
        b=IsdeE7TRTo+YvywNS9t+pYyY3+kj9Wce1ohwMc1GLFAv2XSRTip/dY/o76Jpf+5n0N
         s8xMRpU+BAcoPAloPHYclGlyP8IEcqCOgV/ruzFN8MyU2nL+Ayh1vyvqt7TTddkt51mx
         JfRCvRv0zoK9V6XBAdHk+ZtS7CdrAOskaE4EGaN5EK5L3fJb5Fl2bcG589SSUphvognw
         YO+CC45uR0E8R86wnUDS0a9S8WslFzBwFOLbCtxjA+VuKB2U9PxAbEiXCvUhJe5NYlNs
         FgLQEbQ2jtIga4aqBVv8xHRELAzLhaqm4mnqGimH9KG7UnCe4n4srJ0ILvNa352ksg6j
         Ym+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710128858; x=1710733658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hht2czhX+1Q9FeZ+0sJkAD72ju8vKKUzrmWsyC3pja4=;
        b=D39FsCBNIWAvoQr4g1OD/QMffYqWXVgDBQQcI/T8LFAxbAHBaVl4mgOiuyVYyAhVyG
         8nS2LQ95i3t1yCD3YAY6hokg/HumKEQyhidYRZvgeZALWTl/s/L0mKqdKleYXWnqENXf
         VkNJ6ETBONYADISkLRAew0xEaufrccvcRrwSZ88CYfvBjPFG2N8NYMXpa2SaqyvEThR7
         O+NyKnNNjUc9gPQ7QmTjEArIJtHpV6SXqitP0+THf6X+TegdjLuncgtKLLkCxfmb93Rx
         QGUIyInH5zy0KwOh4rNgNTMvAN4+NjCk0B0gCtBQqKvOLAtzq475+GkZunnKLIsMFKh1
         8v0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3Pn/06v9u2bxlw0rrFoAGaWfSLu9tJZyRPss4GwEq2/EhYjhmgrO7laoHufONgKrle+PzWbNjCx7WDqMaGYrI3rpEs8juVyeBLLEO
X-Gm-Message-State: AOJu0Yzt+BChqWKS9ySUq9RoKKLkmdSXnGjQUteOzZpv2SzVRk6HxPLS
	5YH75H4v4qCOd408k3mvl9VZFWR30rZYem1p/O008kesSSG+2ukm
X-Google-Smtp-Source: AGHT+IFjGnYsnp8eZzvZcALM5YBbKCk0+hFYW5/huHEt1PhBpzl79DoDpzn+/LZRW0A3uYbQTKchxg==
X-Received: by 2002:a17:903:41c1:b0:1db:e494:4b5d with SMTP id u1-20020a17090341c100b001dbe4944b5dmr5019637ple.16.1710128858153;
        Sun, 10 Mar 2024 20:47:38 -0700 (PDT)
Received: from [172.25.138.193] ([203.246.171.161])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b001db81640315sm3473663pla.91.2024.03.10.20.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 20:47:37 -0700 (PDT)
Message-ID: <35bef6a0-26e7-471a-8224-c59b2acdcc1f@gmail.com>
Date: Mon, 11 Mar 2024 12:47:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: amt: Remove generic .ndo_get_stats64
Content-Language: ko
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org
References: <20240308162606.1597287-1-leitao@debian.org>
 <20240308162606.1597287-2-leitao@debian.org>
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <20240308162606.1597287-2-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/9/24 1:26 AM, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/amt.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index cb31d1990660..6d15ab3bfbbc 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -3084,7 +3084,6 @@ static const struct net_device_ops amt_netdev_ops = {
>   	.ndo_open		= amt_dev_open,
>   	.ndo_stop		= amt_dev_stop,
>   	.ndo_start_xmit         = amt_dev_xmit,
> -	.ndo_get_stats64        = dev_get_tstats64,
>   };
>   
>   static void amt_link_setup(struct net_device *dev)

Hi Breno, Thanks a lot for this series!

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

