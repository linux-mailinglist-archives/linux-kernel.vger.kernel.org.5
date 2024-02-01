Return-Path: <linux-kernel+bounces-48467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4B845C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F71B330E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528D312FF79;
	Thu,  1 Feb 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iEdHyO8D"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257977A08
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803345; cv=none; b=NFBj+8Le1TspEChI+nhrX0aIlbqQn/VMYmZyor9z93vhovWUDdGjK22AA9Xe8lRaNjcda3VOcnfH8YqXtryGy1XeoH+olL+K4j8a2KF4ZKNl/ZXdxCsJbQkcYKNbcw8OxIf+meUixQJ//8aI+O24QPh6romw1kTyAY69bf2gNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803345; c=relaxed/simple;
	bh=U24fXnRqD3dOh5+P6dppxxAVP72lv89006UrPUI/kuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnNVKFenDRBKzlZpShSVrCWOdRrXaAaU6JkRy5QKR9tJdh9imzX1nK28kc2Rf1K8Y76C280MriOD8n3S0kx9kaToBoUlfwSLz+/PkUybgfiT/Evga29+EKFjN9mXS4UuXyDuj55MKRMcq1Krr32VQJ8nhfLI1ZMaqPMR3shXUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iEdHyO8D; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394bec856fso1443404f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706803342; x=1707408142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOnhFau+Mczj5sTvCdYfAZH4E5T76nRZ5OXsZ+LtuLo=;
        b=iEdHyO8DvStN1nUNrAXFbkzwD6UcZxqect9x1/R5GqJUnmCRe9N+iCKRhyc8iY5RT4
         yvoBhM2nZbNCk/b29bjNjQilU/ifvkeJI7G14XxQtZqQ5TPv6tbRlG6Rr/14a9J4NnXS
         7GS+GSMFSQTemix2+SUSiHf0f4vVIfduGaQlkaYpwYSu5J0SgpKSE02uy61hkM0EJ+6+
         oulBPRfTdNhyGTBXRZyzlX3CL8XvjgUKRkY0XNuGLU330kxNhQ+c4Uts26OFrujuZsjA
         jJDYIVWt0Ed14YWaC6VOimymt+iVyqZLAdYVECX5Cre5+N2l5VcqIafR7cr6LDJJYEP7
         6QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803342; x=1707408142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOnhFau+Mczj5sTvCdYfAZH4E5T76nRZ5OXsZ+LtuLo=;
        b=q6ZDSfE9QqQb6LOQw1s3uyo/koHKtLT1mpm9Xa9wFsASTeLYBT49qBmFVcSImOfQVa
         R+LLmKLqERCtyLwY8U+9/xc2xejFSBl7LW1+AzQBJj0LdOvr1HGZ1MabJergMmtzzbGL
         aliY7nbvQDBDRAVqi8zdsgqFBn3oT1Wjw0jxZnR/NrFQBV4Z2tu3amLZAd/lYe4pZSJh
         UfxqBuuap8udCNcd0UlBDzYZxC9m5MMR69Mj9TGn9i+3S53ISwGIHI4yCNqQiPZjDnE5
         6Yq67NdcCfWRQWxzaz1zWNpTwblIxLHASUjF7ytSsz2/re488aDkMV5HtOyFTQPolBKm
         DrkQ==
X-Gm-Message-State: AOJu0Yz8NNyzh0QGHvB4pOM8dVRTGivtOAk39IMWL22zMiyUFTVVutoS
	uuLKZCwJvTMV3KwJSwWXWhtOYi7PPBxOV+70AboguwSM3HIdy3lGj76EKxJAq5w=
X-Google-Smtp-Source: AGHT+IEhPCyMcjo+bIKLNhPT2rEIpC1fE3T0Xn3OKMkuAbGB4/W1gfryxjECtWwFqOrjrczet4m2Xw==
X-Received: by 2002:adf:e8c2:0:b0:33a:f277:8f6 with SMTP id k2-20020adfe8c2000000b0033af27708f6mr7541335wrn.14.1706803342109;
        Thu, 01 Feb 2024 08:02:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUso9ydzZ8gdGjO73/U9lNujpuXhy9lYTJ0tvKFLzKScdRJ59qLqPz3BRG1QmpivZubMtbuPqGiOV9GCr9PP0keXKnO2a/r0iuHtRDzfDLZ4jVd2FD3yqiWJu0gB06CrB70Aei8IR2WWs3mmLqhZMT+jRL4md5AXF9I0pfW2xBLrXfnJbzGwKaSCPJhTFb6arOtbn51Qm/zwtEb8B2jnppE8Jy4YAQmloiRO0/7weh8dIl0KcuNu7VUweWKFHhKlfGTF0K5LWFMPnWQT9jC8axiDhhFu2oxfssczbuCVL2D9CveZotUpLdhktQkCKb4Smt7bzCYSnjeYb11Jfn8Go04xYi9t+syVd+NSFx4Y+8zirJZkv7hPZqvHMJbl6OUfg0osFtV
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00337d5cd0d8asm16469273wrb.90.2024.02.01.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:02:21 -0800 (PST)
Date: Thu, 1 Feb 2024 17:02:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Andrew Morton <akpm@linux-foundation.org>,
	Mahesh Bandewar <maheshb@google.com>, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, andrew@lunn.ch, leit@fb.com
Subject: Re: [PATCH] blackhole_dev: Fix buil warning
Message-ID: <ZbvAigcKvxTLjHrr@nanopsycho>
References: <20240201133238.3089363-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201133238.3089363-1-leitao@debian.org>

s/buil/build/ in the subject.

Also, indicate which tree are you targetting. In this case, should be:
[patch net-next] xxx


Thu, Feb 01, 2024 at 02:32:37PM CET, leitao@debian.org wrote:
>lib/test_blackhole_dev.c sets a variable that is never read, causing
>this following building warning:
>
>	lib/test_blackhole_dev.c:32:17: warning: variable 'ethh' set but not used [-Wunused-but-set-variable]
>
>Remove the variable struct ethhdr *ethh, which is unused.
>
>Fixes: 509e56b37cc3 ("blackhole_dev: add a selftest")
>Signed-off-by: Breno Leitao <leitao@debian.org>

The patch itself looks good. Feel free to attach
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
with the v2 with fixed subject. Thanks!


>---
> lib/test_blackhole_dev.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/lib/test_blackhole_dev.c b/lib/test_blackhole_dev.c
>index 4c40580a99a3..f247089d63c0 100644
>--- a/lib/test_blackhole_dev.c
>+++ b/lib/test_blackhole_dev.c
>@@ -29,7 +29,6 @@ static int __init test_blackholedev_init(void)
> {
> 	struct ipv6hdr *ip6h;
> 	struct sk_buff *skb;
>-	struct ethhdr *ethh;
> 	struct udphdr *uh;
> 	int data_len;
> 	int ret;
>@@ -61,7 +60,7 @@ static int __init test_blackholedev_init(void)
> 	ip6h->saddr = in6addr_loopback;
> 	ip6h->daddr = in6addr_loopback;
> 	/* Ether */
>-	ethh = (struct ethhdr *)skb_push(skb, sizeof(struct ethhdr));
>+	skb_push(skb, sizeof(struct ethhdr));
> 	skb_set_mac_header(skb, 0);
> 
> 	skb->protocol = htons(ETH_P_IPV6);
>-- 
>2.39.3
>
>

