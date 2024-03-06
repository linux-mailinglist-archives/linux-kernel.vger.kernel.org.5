Return-Path: <linux-kernel+bounces-93962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBB87378C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4607F1C2262A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD7130E23;
	Wed,  6 Mar 2024 13:16:23 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062F7FBAA;
	Wed,  6 Mar 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730983; cv=none; b=hInI7OaA/HHKN2z6REn6neHUdBGg7o8SarNiSGgHnD1zrO6q2QqfyQDzYGXg7QeOLmoGa8Wqqxdi2m2VWP9FN7YworXcp9DoB6uXS3Erhgnd3+gOQd2U4gzyC+r9IpO+MUs3dRbKqMhgFfActasL7o3GMtCdRxD0VyM+1Iptp/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730983; c=relaxed/simple;
	bh=UN5GxUcdpytO2U2Ldms6mARi4xRRCE3E9Hta9POhZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjINBt1OtV7fXtK3CkaP0t3XJ3fQZY13iazPg3ZntdP8vsLpSkR4HILLBWmclHqFd1fg0EasczI1UXWCXKAPEsRWyQzb0/QA8XSoH0Vyzm8b/AZ6WNmH19FNnbmdoy5I8GI9thIvMMChSkr1LS5u/DMLOEXwhU14KZSGB5G+gCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso151513166b.1;
        Wed, 06 Mar 2024 05:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730980; x=1710335780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/tWs4fwCFAZTFAAtDBZh8EOdci0pgq2gOC8rOm/wUU=;
        b=WXm1vZPoK4l4oN79kgOiioPM8WcqbpiBWALVMq3iSEMtkqq+E6sNv0XPpTifs8Mrre
         ZTrVak9EnpMVpbqaMDeughU22zqrbJ6Hp1dSqmjR14BKTJ8RMFL2oQ6L0T9FRTwjEvnz
         h45I1KmJbE5Hab2TJYiylbt72iKoo9o9D5zVd1HncMkcJm2LZGNHitjXeah9QL4fHp+q
         JgcuMziSNHYSepo4nrFjq3qI5s/grfjYmp+gcVyj02Vuv0LltT5kHObJLedxUCYxpvTB
         LgyV0QycFwlwzNOOIBHsDweZzKdBZ5N6EJyo7W9cV7ljZJbYBuWgHj9jYGmF9pK6SZHG
         yAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ2v129hMhBWInqAjOHSe4fHPHHva5lU7F6Je/nDGO2BUXHeo6M5JeSGk4VKGDKSSIuLhnHI17H8F1lQ4kej/1rTlfDJQmB0hy28qHmcAyJZ2z9moyuOJOP264mB7Zk1kZbYmFosO+1f2AfUQp+QCcqKzy57D7Yi8InG6lAQNGQobpFwdZ
X-Gm-Message-State: AOJu0YwJmPP82Xe9s4GWjGHoTV/pl65cMnft8jQuH6zu0pLrZ0HGJAyx
	4WJnBf17slJJiUxJVDDbHuB9tz25RlpTtHwiJuqNX/rf3STcJTjS
X-Google-Smtp-Source: AGHT+IEIJgWZ+UxwNt0E0FsQRxJuaM40G5bRPgHAbMZdVYsXZGcRQxWwzTl9LNOtD+BeAqHsNuqevw==
X-Received: by 2002:a17:906:57d4:b0:a45:a2cc:eb93 with SMTP id u20-20020a17090657d400b00a45a2cceb93mr5652823ejr.4.1709730979709;
        Wed, 06 Mar 2024 05:16:19 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709063e0e00b00a45beabb104sm499441eji.159.2024.03.06.05.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:16:19 -0800 (PST)
Date: Wed, 6 Mar 2024 05:16:16 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, keescook@chromium.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Coco Li <lixiaoyan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <ZehsoPb/WZzUcFHa@gmail.com>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229225910.79e224cf@kernel.org>

On Thu, Feb 29, 2024 at 10:59:10PM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
> > Introduce a new struct net_device_priv that contains struct net_device
> > but also accounts for the commonly trailing bytes through the "size" and
> > "data" members.
> 
> I'm a bit unclear on the benefit. Perhaps I'm unaccustomed to "safe C".
> 
> > As many dummy struct net_device instances exist still,
> > it is non-trivial to but this flexible array inside struct net_device
> 
> put
> 
> Non-trivial, meaning what's the challenge?
> We also do somewhat silly things with netdev lifetime, because we can't
> assume netdev gets freed by netdev_free(). Cleaning up the "embedders"
> would be beneficial for multiple reasons.

I've been looking at some of these embedders as reported by Kees[1], and
most of them are for dummy interfaces. I.e, they are basically used for
schedule NAPI poll.

From that list[1], most of the driver matches with:

	# git grep init_dummy_netdev

That said, do you think it is still worth cleaning up embedders for
dummy net_devices?

[1] https://lore.kernel.org/all/202402281554.C1CEEF744@keescook/

