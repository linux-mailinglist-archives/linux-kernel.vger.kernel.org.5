Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827277B60A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjJCGRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJCGRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:17:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB1B8;
        Mon,  2 Oct 2023 23:16:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c737d61a00so4041315ad.3;
        Mon, 02 Oct 2023 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696313814; x=1696918614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAFuNLRr2SEWFDy639DhvxhF/LMWMyC8GFm6n9GRgVA=;
        b=FofcQJf0h4dS1Bj8XFXnRzbdw/6YbzRowTLvqEBRc9HilRJFCGqMFcHqOxX8jVg0s8
         /xsht9gnwrM8bjYg9HQs/isLyECsobO3NmVTFL38DMc4p6CeSXKX4MJ/USzJWDRRojCz
         CL9/GfHOUwXLTIftoaWzm1OQ/Q0ntaTReCpDlhnTxsvJR6FTdkZQ8Hm4pibEsIsj3DWg
         YNVVjjlqUs9aQx8/yf1VghjoCDRJ/kLR+ZmJqklo0ebP5o6X6yf4CZZarDm70BAXAqlb
         vangqyI03nah+cP6DmA2bTiaKIvkp/Evk1MVauVhhDs98X3u/feqRJEhIg/CcyX+S/Dq
         US9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696313814; x=1696918614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAFuNLRr2SEWFDy639DhvxhF/LMWMyC8GFm6n9GRgVA=;
        b=cqW439iYVQED2k7mW9W7uz9c5oqG+7jE3yBChm8wi3XJXWEa1pi8C7MvQ8t6mvVfSm
         kMKVXin4akcPqW/rPAK8YABG7jvHcSnHodGgz8FR4O2ywU1QSJsjendHhUTptVDBWPNp
         uPVAuDUKi5intCdZfv28wqV8pCDHFQGqOp3k8+X7fBr2ZI+6I6wLjrqFd/yS5Nll7p+G
         vnu1fUUOkmUarG9wLu1y7GCvQ9hqfoayG0K6PmVOMF+ZmD1U72lQvWuP2aEuWApDVEfI
         EB2NhFjMutfvnnR4cP54Sfri5J9v4A7fECFuiXy84tGgJJb+be8n5dKkD69V8wYntF50
         FCCA==
X-Gm-Message-State: AOJu0YyBsFN+onlXkdJi1BnnH78l3sR3YMxKQkggpjs8sPBke14FsLFW
        g+ad2MjgI5gItlr3wxT9brcbhFD+vqHzDQ==
X-Google-Smtp-Source: AGHT+IG9rLWnU4oLgWQBGZDRT3L22uHw8f72t9maVK6aaaaEORSmxpaL5q1UVhiQe5z9cSVjB3VIgw==
X-Received: by 2002:a17:903:26ce:b0:1c6:1928:59b9 with SMTP id jg14-20020a17090326ce00b001c6192859b9mr14102892plb.10.1696313814546;
        Mon, 02 Oct 2023 23:16:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:2da0:9e11:db4d:8adc])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001c611e9a5fdsm546952plg.306.2023.10.02.23.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 23:16:54 -0700 (PDT)
Date:   Mon, 2 Oct 2023 23:16:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: cap11xx - Convert to use maple tree register
 cache
Message-ID: <ZRux0yLPxZGLNF5A@google.com>
References: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
 <20231001-input-maple-v1-2-ed3716051431@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-input-maple-v1-2-ed3716051431@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sun, Oct 01, 2023 at 01:43:39AM +0200, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/input/keyboard/cap11xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 39ed3b9ddc65..77843ad15d4c 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -174,7 +174,7 @@ static const struct regmap_config cap11xx_regmap_config = {
>  	.reg_defaults = cap11xx_reg_defaults,
>  
>  	.num_reg_defaults = ARRAY_SIZE(cap11xx_reg_defaults),
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,

I do not think these driver care much about the cache type. Optimal one
might even depend on the architecture. I wonder if we could have
something like REGCACHE_DEFAULT to signal that whatever is the "best
default" implementation it should be used?

Thanks.

-- 
Dmitry
