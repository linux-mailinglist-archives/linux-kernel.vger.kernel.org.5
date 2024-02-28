Return-Path: <linux-kernel+bounces-85225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62386B27B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3459A1F2890E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754315B984;
	Wed, 28 Feb 2024 14:56:26 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DF15B96D;
	Wed, 28 Feb 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132186; cv=none; b=jUxiwxV9TDRKTT1ZjgbsBckEzHX3WC+NKyk4uLYUGe9yXlmR6Hu38RhokeqsyPzwONjKof9NAaY/e7cCPif60/Ifomu+V6KhRMoNwjc1JPr25pTQIoM79FrbILg5v5ZiYcZiNjzP5HKvWnowFMVgHoFlGFwLhpl/6EUaaDwqMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132186; c=relaxed/simple;
	bh=tvMMFT7IKjYWtuCyDMSxTCVQ+1ldB6waLn5e3CF/u9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE+xQv8NM2qOnFizW9BiVLb1gugkw95JWspRsFNwI4bJ6CQRAo1bu5qe/4f4z6FJgqjNkjwzBZFjsgvqPoUJWvdTosQxRspoArVH2Xldgvs/5JdhW+stGw7YAD9ETHpiZ25VALpAtuFgyrOeKwP23YMxJdPFANSsrgzGGnrzSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412ae15b06fso13146495e9.1;
        Wed, 28 Feb 2024 06:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132183; x=1709736983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj0JnoSewVwlVSZlHt4DT/SaUpGZF5EhEmAbDbXm/cA=;
        b=hTUk7Bkp8AaUhTFWN/q+Kuh+G6wjM/P/Ct0Y9KYtzgOT92afszZDRL55JMBdVKPNqk
         JBMmPsGxk8WSjSuOPdepfKIfEGB3DDClVdcUgvmCqzkyADUnZ0VYIV3TmtM1sZkecFAp
         zxFWAMOItljSV0+MPrZloZIIpw1p412kz0i9uzw2OpOKVF185N95z9S/K1LdrfFEUSC/
         tCfBlBj+mkS/n4856mcwGsbozPwyj1UGwyF28SBVfoelIh2aGFpo57nx9JGymz8GLzWJ
         wEUCb9BB8tN2R6oWxs03CtHrpdV9BYqDcTEcTeZAX8tiFCnuXEAkvPnpYMNzyeUknw0G
         bw8A==
X-Forwarded-Encrypted: i=1; AJvYcCWIA0aNMjlzzKE/k0IvSvkgX/WVQ/NkERN9bvEiNQN7joLBZugAStOiN/cvMweubfkrlZuY6d+9s7b+LVWXJJXf6E9Q5gf77fTHIrFjPisWEAH1nN8NDJA8kVcZxE5uILer75sy
X-Gm-Message-State: AOJu0YzRTeNy/5afz3NhP1rWEnnIZpT5W4MOxRUASksZ1u7OHcgHwD1J
	s34sxFDQkTnElxO+FWfGe0dL+i2WUTQcyp5gu5k5n5aNB6+hroWim3L5rpzs
X-Google-Smtp-Source: AGHT+IHYIZAmnC6Q7trl4ZYacWDPB4uF2FtswzOgRpJrRuwBbuoiJsTzWGpC3FtxMTqdQQYwJ0ijoQ==
X-Received: by 2002:a05:600c:a05:b0:412:8fde:ac46 with SMTP id z5-20020a05600c0a0500b004128fdeac46mr10838502wmp.21.1709132182442;
        Wed, 28 Feb 2024 06:56:22 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c00c600b0041253d0acd6sm2305404wmm.47.2024.02.28.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:56:21 -0800 (PST)
Date: Wed, 28 Feb 2024 06:56:19 -0800
From: Breno Leitao <leitao@debian.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-qos: fix non-bql configs
Message-ID: <Zd9Jk5d99h0CeM9z@gmail.com>
References: <20240228140413.1862310-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228140413.1862310-1-arnd@kernel.org>

On Wed, Feb 28, 2024 at 03:03:10PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> It is now possible to disable BQL, but that causes cpsw to break:
> 
> drivers/net/ethernet/ti/am65-cpsw-nuss.c:297:28: error: no member named 'dql' in 'struct netdev_queue'
>   297 |                    dql_avail(&netif_txq->dql),
> 
> Add an #ifdef check for CONFIG_BQL around this usage.

I confirmed that all other cases where queue->dql is accessed, it is
inside a #ifdef CONFIG_BQL block, so, seems appropriate doing the same
here.

> Fixes: ea7f3cfaa588 ("net: bql: allow the config to be disabled")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviwed-by: Breno Leitao <leitao@debian.org>

