Return-Path: <linux-kernel+bounces-130892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0BF897F08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E171C268D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246640879;
	Thu,  4 Apr 2024 05:05:40 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD9405F9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207139; cv=none; b=Y/Tfk7tjP2Dq/fXLm5xL9v9YBk2FG140sktth/dEXdFnml4firhiq7m2oO6oCs94TZ2LFEIQpgUIsE6/tWmfElKc7RNbUloMLs++BOwb9wnTTHG3qk2fC77zk8EqEG0NhnC/xdVHcSXmYaMELy5UvRU/EPuTxcGtZgYawpDtkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207139; c=relaxed/simple;
	bh=abMEw0FTxYw4OfCoClmRJi0T46YZjCXPIzl8Pt6mUCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjTtwvErW/ZlHcet+rNPi57m7bQgeg379ZR3TPlS+gED9wk73y+0hdE11rDRPoKeGDPkr2GtoRhp0lB9Q3oaR5KXh/wwGw/pX+AFcApq49NCYWbESEO9tXRe3cx0lGlKsFE//DuvxfO3XmKaQjSrYDq/DqQb4y2qfcVH84mOook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4162a6a1f84so2697565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 22:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712207136; x=1712811936;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me4Obssr66zaQg2v15sp2gTtTxv/0MU8O5zS07cD7rI=;
        b=Kp1XIW+wMo6x5kU432zGjSi0s6YwG15CJ8i/ojq8bYUiVjnKr8KzHzEiMUReOX1jHj
         mwWFtjiYXmBH/r7HpuH0vOMuFE4eokHpVNRJT8X6xikEmRVhiIMyQWMkYQd7YNVgviHL
         c8ty8cGLc9rlzMlJgrHBkrLaY4JiK8y7xJIpeoQ53pExfn55JhxMMm5i1R4s0L3HY1qx
         fNSGcXc1FBVTcdmK6dkAVFR99eAq7TtD2z41xPiZS8grHk2wSUbhs3T1q1sZrP2M7aif
         CNbIzI1pb53Zn0uIjgIqiGJKwfUJPA04eiaBbF8HB0CLIABXRLXzsE0y9aG3bV1cSMv0
         bVfg==
X-Forwarded-Encrypted: i=1; AJvYcCWUw5k2WgMUqEbQd1lwauyGxLg9reiQTmB3ou0T3Rq7ZsQJvF/kaOsxCt2d95pVh9FEpPAN5yPioyMaHgK3MgQhCiUBcKGTMcOiearu
X-Gm-Message-State: AOJu0YyKATMzGiF0wdc5hUjLn9hsOIA4/Gg5rNQGXWXRzmmOHsnz3BC7
	lVZjyKr+TjpyFRsYw5XQopFgY8iQWS3Cfid9XpLfXTRnUkXWCtLn
X-Google-Smtp-Source: AGHT+IFPrxyeMOu4bLYNiz3ZcYi+u2tymls9JMHeK9nwV4n86y69Qm1Iz3SA/NXgcWpFgQShbb4fpA==
X-Received: by 2002:a05:600c:1f8e:b0:415:6cf3:ef17 with SMTP id je14-20020a05600c1f8e00b004156cf3ef17mr1106448wmb.39.1712207136230;
        Wed, 03 Apr 2024 22:05:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b004156c501e24sm1226543wms.12.2024.04.03.22.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 22:05:35 -0700 (PDT)
Message-ID: <fba2102e-aefc-4be4-905a-57061c1f8cce@kernel.org>
Date: Thu, 4 Apr 2024 07:05:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: xtensa/iss: Use umin() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>, Chris Zankel
 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
References: <20240403234729.175168-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240403234729.175168-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 04. 24, 1:47, Thorsten Blum wrote:
> Use unsigned size_t to improve len data type and umin() to fix the
> following Coccinelle/coccicheck warning reported by minmax.cocci:
> 
> 	WARNING opportunity for min()
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   arch/xtensa/platforms/iss/console.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
> index 8896e691c051..b493fc50933d 100644
> --- a/arch/xtensa/platforms/iss/console.c
> +++ b/arch/xtensa/platforms/iss/console.c
> @@ -167,8 +167,9 @@ late_initcall(rs_init);
>   static void iss_console_write(struct console *co, const char *s, unsigned count)
>   {
>   	if (s && *s != 0) {
> -		int len = strlen(s);
> -		simc_write(1, s, count < len ? count : len);
> +		size_t len = strlen(s);
> +
> +		simc_write(1, s, umin(count, len));

The cast to unsigned (ie. umin()) is now not necessary. You should have 
used min() as was suggested, right?

>   	}
>   }
>   

thanks,
-- 
js
suse labs


