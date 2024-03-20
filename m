Return-Path: <linux-kernel+bounces-108952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 283DC88126D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC797B2408A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06D41C85;
	Wed, 20 Mar 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oXDEydtP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC782D79D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941893; cv=none; b=mBoJkC1mt1vtBakvsQtmLiYMq8RWQpZdhQiZl1qvxWjgNIOsZh4DDWYWItNBkqn4lB791MvVVzFTvQ5DyVfOnJ0m2vbZaIXiyHc2QbZIxzIIsJWs+t+gg5SqtsEy7Rg9kIeENgw103+g5U0Qpu9wUCccdzRoN4sXWcQy4W3Kiwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941893; c=relaxed/simple;
	bh=RI5KZMx81gg+b8/ajk+DICM5zDgR1lxlWcKqY/8HJ7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn9dm1UzcfAmP3qqnLgTZKo3J9ownN7Ve185w+E7EwqQDvxZuy3ih1UjxciMwzBBMjAIfbqFT0UOJLey2dULFHKSdFtLYSsJ4c3Z2aiGVC33ZLFo4Ul2SCGciUaYmuYl3WLstAOXw64od6Bf7PyeKIwuAy67Xh82ZlwC5IpHPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oXDEydtP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56b92a8f222so2598524a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710941890; x=1711546690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxVMLy0rFd456KQx8TF/3jyxQy3CEg3Punv2dpTMXs4=;
        b=oXDEydtPG7rHsdXp2fHzSxbgUsw+KGseiyURXvhCEDNXv0AC9N+FR6JpfWSFNlEcMU
         jNcQtjq23ZHahzwO3liZBcLFcWZaqPmLOXwOvu5EFncmA37HUQkFy8bZ8/P+9qT+hZFd
         aS7aPuqqSUAILnA36Ot2TmmjO+Ki0wvF393la8l+tqhCz0by4Cc8JzD+eUJAQYxsdWfL
         kKJlp4GANL1Oy1aQ1WWoh2P66HYGzB4lmC03ukvqNUsYEcPLWu3FP7ngf6JmVMk5Ijev
         y3bm0HMNDQtgWmOIDI/y04PgGxC+eewfFPAv9NcYc8lqeYp//8CvHEZUsHwhD44RTGkU
         gETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941890; x=1711546690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxVMLy0rFd456KQx8TF/3jyxQy3CEg3Punv2dpTMXs4=;
        b=CI75gsaVgZpkSdNmUXDc0o3VDqEEUmB1AVz1YoYyIn29Qv9/DlXWqMl1ElRW1VGtC3
         sVds8P0NbrlDIzJmoasOjBOtbUBHLQLLlV+WsyTsfEMwhNSIyNetdwo4IgN3rY4QyRSU
         cDJptY2CFAzqHWYdL7nfRseqZGrC7j8CxVO4wpUj1bEdyRObqMRLUBldXxU5pcJo+Pen
         SM5XZBiDoourVnVivciJYQu38+/tDwhv1zKpq7FpcZZTsNA1TBtkxjO5ZdgWHy8NiCQ9
         zlBhgdEkLlvZMcRULUInrnjMVqfhy8jdJdCsQeo1aVQZy18iVQU7R2dSeGY+11+0l/Hk
         dw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyXsW7wdsWFyIwXsXFHJ+Dtbh8L06+V7UUQL363laxfnJ/sCI3wLvBjuBhHMckbwZFYgD+UMMgfEZQz/JDTMVB6qPPaIEM/Er/OHFc
X-Gm-Message-State: AOJu0YwAdN1U2nQwJ1b4dJmCVvwow/et+1+fKtArS0RWi+J/+B2DZ1BF
	+AvQ1S0juc4e8YBAKOquS82/HmWV97v2tjltOnvInKfJxnQwVh6LZrD2HHp1APfTR6WcTdqLXeF
	UT9M=
X-Google-Smtp-Source: AGHT+IHx8FRiWQLj1a9vman+PrWsMTEKIuVYmf3W6M9VFNgezYb6jHEVh9SMi0qq+OaS6+t7ZPwqvw==
X-Received: by 2002:a05:6402:3706:b0:56a:2b6b:42cd with SMTP id ek6-20020a056402370600b0056a2b6b42cdmr6063484edb.3.1710941889727;
        Wed, 20 Mar 2024 06:38:09 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e8300b0056b8dcdaca5sm2340236eda.73.2024.03.20.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:38:08 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:38:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <Zfrmv4u0tVcYGS5n@nanopsycho>
References: <20240320125635.1444-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320125635.1444-1-abelova@astralinux.ru>

Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>skb is an optional parameter, so it may be NULL.
>Add check defore dereference in eth_hdr.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.

Either drop this line which provides no value, or attach a link to the
actual report.


>
>Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")

This looks incorrect. I believe that this is the offending commit:
commit 690e36e726d00d2528bc569809048adf61550d80
Author: David S. Miller <davem@davemloft.net>
Date:   Sat Aug 23 12:13:41 2014 -0700

    net: Allow raw buffers to be passed into the flow dissector.



>Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>---
> net/core/flow_dissector.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>index 272f09251343..05db3a8aa771 100644
>--- a/net/core/flow_dissector.c
>+++ b/net/core/flow_dissector.c
>@@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
> 		rcu_read_unlock();
> 	}
> 
>-	if (dissector_uses_key(flow_dissector,
>+	if (skb && dissector_uses_key(flow_dissector,
> 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> 		struct ethhdr *eth = eth_hdr(skb);
> 		struct flow_dissector_key_eth_addrs *key_eth_addrs;

Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?


pw-bot: cr

>-- 
>2.30.2
>

