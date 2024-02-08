Return-Path: <linux-kernel+bounces-58136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B373584E1CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AB5285358
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977D7B3E7;
	Thu,  8 Feb 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="v6wGuT0P"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F557B3EB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398064; cv=none; b=jI2J/LxAB1sDxX/X22D5BrDySjvfWdl1TIV9ZOVx0mreKoz0uXt75fDHEmZ/jvGTtbEOiP4ykugmkTfkVMeKAcD9f1qBQKq+CzMcmuL2wZgsbpMhzdVi5cuMUIegI11XfKTwKBnLqHECY7IP0DniQHKPYFkwiolQI5WMc+Max3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398064; c=relaxed/simple;
	bh=QuMQWAnwWU8Jg8k+fqlUw7v0lstHGn7kXNGqQQEKh0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/nYHwFibGKaY8IOVBAddA/MH/gzxKuAiyyORF3sxon5xPmt8WZmsiwv7TAbMGffaYXW4CxQDfOx+OOiCZ9UYdsDO9gDht3SdJdukN2Zb+hcJj/qlG6FbNpri5kvQTYKf8TIZQcT1bHRw3DlTRFkZb5mR8oeqNhCmfibtcRXUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=v6wGuT0P; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3bbb8a0cf6so47783766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707398059; x=1708002859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ntukh3iLbboob5RjSi1RGWl1ttcbv304nzNTDlBnME=;
        b=v6wGuT0PJ+N4hzmt8UaBTDv7z6pYtEDr/OMrGZNxLyrZCsSKuWL5yNRmfPSDoQy3vX
         ZiXNNunlaPVoGRQB7Aih7Im6QtCpimTY+Nvn1HXrMNOU0IBMOyq/Ah3q2+wJJCUgXpF2
         OTYKxr1/tQKW2q4uafhwE2CW2LAYDmGuT7NOetWEc7tyDBDsQGueTUkEh/OrklW3JC/S
         m5/NRlI9u6qVbJVnc2NCSHScWqY5h8b2e/q7YNbGvFEEdN4IcUI1a8UmX7hOl33cmSPd
         vf2Fo8xtKcueUt7kBD3arum/26q3DaSJ/13Fa8ytRnEfRWbLZFA5Yk7XLQcHGdImsjyT
         iuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707398059; x=1708002859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ntukh3iLbboob5RjSi1RGWl1ttcbv304nzNTDlBnME=;
        b=HJJWmKVjvr/sQNxMvE4Buj2WeMh5ts+NkAhy0Dg1J8KrLsq0ioWzi+Di7xbAtBTPZ/
         4suOEZzUPcUSj2CWpUvHWNeADzb20kmYK9JwerFZyUkOd8AiEvj8VDrKyP4r67GOHUWb
         PzJvyXjyY3YHQbTpgysgogLU5eXkToZJNq1XTeGzrimO4KbM8o5Ts4AlUmldN4iW0Qyh
         vbbMFXOWaWE5tckEo1OyDc90joio9h3Habc5DCV6Js+ekjtrO3X5swelrImkfLECDRVo
         xvKEpqIc4ITedIPRk+i66s09tGc2jSewzHU3o91C3mUUwQero70lrEJgASu6kGPTQiE3
         SPTw==
X-Forwarded-Encrypted: i=1; AJvYcCWyFTCHfNc/wSL0OXqIYZawwJhkmFKX6O8XyWDGuq4kfZHwY3qaSYr/krr/PcGUOmCjYiVC4+dL2uKEoR9gF16HXdcmkR9AEWD+zoEo
X-Gm-Message-State: AOJu0YwVkBKYBh9mBy4q/KI9E7dln6G17nkmdvSruvxQbtSDfU5l/Bxh
	JCtmoB7OZ+h41r2VadS22BtAuc9Xv1eABqc7bnMvXpeyFWWQwCmL9kbMrBfa/rE=
X-Google-Smtp-Source: AGHT+IFxbsmI0ElM1ZdD7KC6y7qcHLiINyUO2uqTJm0NGN+KRXLzE11VCkTZ7fcDVi5+DjtPt7PW0g==
X-Received: by 2002:a17:906:80d3:b0:a38:4b2c:8178 with SMTP id a19-20020a17090680d300b00a384b2c8178mr4613591ejx.19.1707398059311;
        Thu, 08 Feb 2024 05:14:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVug2VZ27JP6E4LkCDJegC+o/d4kAvgYornjfSyauOCXVlrxA/UD7zr8dqlDJSKtVwbL2zFzOGQp3y3dmjN4bhkknQ3BNy2Z1ZenwsiKzeSrPlPRnx/UkIsoO8Umni4njI72tzxecdB8kUQVEOK5uSM0mAN/ulw5WJtjVNghnu1uD5M1MKzZLcBGkBwMAk6ZPvcuJvebPsczrnn8PcoxxF8UPtS/9ImrEp/3IxhypYE0reubPRtmf8vQpuqdqs+Ncydn7A=
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906669600b00a3543718f5bsm24304ejo.221.2024.02.08.05.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:14:18 -0800 (PST)
Date: Thu, 8 Feb 2024 14:14:14 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: chengming.zhou@linux.dev
Cc: yosryahmed@google.com, nphamcs@gmail.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable] mm/zswap: invalidate duplicate
 entry when !zswap_enabled
Message-ID: <20240208131414.GA224435@cmpxchg.org>
References: <20240207154308.bc275f3e72ec1c1fd06cf5a2@linux-foundation.org>
 <20240208023254.3873823-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208023254.3873823-1-chengming.zhou@linux.dev>

On Thu, Feb 08, 2024 at 02:32:54AM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> We have to invalidate any duplicate entry even when !zswap_enabled
> since zswap can be disabled anytime. If the folio store success before,
> then got dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback may
> overwrite the new data in swapfile.
> 
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Nice, this is easier to backport and should be less disruptive to
mm-unstable as well. It makes sense to me to put the optimization and
cleanup that was cut out into a separate patch on top of mm-unstable.

>  mm/zswap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fe7ee2640c69..32633d0597dc 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1516,7 +1516,7 @@ bool zswap_store(struct folio *folio)
>  	if (folio_test_large(folio))
>  		return false;
>  
> -	if (!zswap_enabled || !tree)
> +	if (!tree)
>  		return false;
>  
>  	/*
> @@ -1531,6 +1531,10 @@ bool zswap_store(struct folio *folio)
>  		zswap_invalidate_entry(tree, dupentry);
>  	}
>  	spin_unlock(&tree->lock);
> +
> +	if (!zswap_enabled)
> +		return false;
> +
>  	objcg = get_obj_cgroup_from_folio(folio);
>  	if (objcg && !obj_cgroup_may_zswap(objcg)) {
>  		memcg = get_mem_cgroup_from_objcg(objcg);

