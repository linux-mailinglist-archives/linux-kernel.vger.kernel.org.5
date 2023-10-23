Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A447D34E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjJWLnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjJWLnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:43:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562010C7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:43:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so4623611a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698061393; x=1698666193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lK2Os4ki3ybOrLldklG2GHNhaGnXGVR5XIYnYtMlps=;
        b=At2P8Uxxzv6GI6YeQtOqwWEEtGW7rpN+HK5vowzXObtwm1phbFN8RTQzN0JAUI7ui9
         6bu0hDr+YIOvp6vhkNWaVKzfG3jIzduVH9cKsBQyefNKj3eBHU8mYht5BHrH6tCg9hLn
         bUJiP9X/LZy8B6m5URFKaoSTpTM4oDbOY+s9EqjBa48+U3dvItekLOtmDxr/qT96F3dD
         59q1SYJYk/lRmBez6MhdqMdzMzaP5YP/3BcwgSfu2aguyS/IcXWNJPn0VzFSrQmWbzft
         iaF2JXeQ6GiA9xDrZ7gQvZ6kOas0lwIYrz5Fvh4JqDQLb82y2iYXuM1ZkP3pTE2zC1ni
         drvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061393; x=1698666193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lK2Os4ki3ybOrLldklG2GHNhaGnXGVR5XIYnYtMlps=;
        b=JO+QjS12ORs4cqGA3UgG7j1fEeotN2uRlZvFQmpUukXaplCwvp9/6QFyxO65CGYuCe
         BTB94HgaAWBO4H2zgqLEBv9WQEOTD1tBC6NQz5pKHGXzt1b6sEoosIGXaxYeKGUNTjJn
         ZOb/8GhFCfThxhdcqYjaq6ys+kByRpUNRoXYo+wJQgqyEars81D4qQrAQKA1kKBwEDfS
         XcEYymiE05blVTTD8i6WHdqgCRShgx/S+kfmTVkaovNUPKNC0H0yX4i7iyKitYvCF9qg
         LIxIwS73f9FlAvfSeAN8NnWInbK8nQtc2hFSX6cPVQkh4ZyTi39F0oQ1W/vv2Js+i6XT
         GcIg==
X-Gm-Message-State: AOJu0YzqDfUNnUV4jeymD/1/ZkAz6asqk5/jVoGGYBU5cajrsaCYUfSh
        OS/xYLMJdxRm6Dd6ZmV/ibHQVw==
X-Google-Smtp-Source: AGHT+IHaDNA1PlbIvGMsp8KrQL7HEt0juPuIGQjc61yTnJpKaLFvghgW32JA5h2Rqz7s/BmlD8HzRg==
X-Received: by 2002:a05:6402:5114:b0:53f:efbc:e42b with SMTP id m20-20020a056402511400b0053fefbce42bmr5172581edd.34.1698061393557;
        Mon, 23 Oct 2023 04:43:13 -0700 (PDT)
Received: from hades (ppp046103219117.access.hol.gr. [46.103.219.117])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7d51a000000b0053dda7926fcsm6146215edq.60.2023.10.23.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:43:13 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:43:10 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v12 1/5] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
Message-ID: <ZTZcTrTy9ulPast5@hades>
References: <20231020095952.11055-1-linyunsheng@huawei.com>
 <20231020095952.11055-2-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020095952.11055-2-linyunsheng@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunsheng, 

[...]

> +	 * 1. 'n == 1': no need to actually overwrite it.
> +	 * 2. 'n != 1': overwrite it with one, which is the rare case
> +	 *              for pp_frag_count draining.
>  	 *
> -	 * The main advantage to doing this is that an atomic_read is
> -	 * generally a much cheaper operation than an atomic update,
> -	 * especially when dealing with a page that may be partitioned
> -	 * into only 2 or 3 pieces.
> +	 * The main advantage to doing this is that not only we avoid a atomic
> +	 * update, as an atomic_read is generally a much cheaper operation than
> +	 * an atomic update, especially when dealing with a page that may be
> +	 * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
> +	 * handling by ensuring all pages have partitioned into only 1 piece
> +	 * initially, and only overwrite it when the page is partitioned into
> +	 * more than one piece.
>  	 */
> -	if (atomic_long_read(&page->pp_frag_count) == nr)
> +	if (atomic_long_read(&page->pp_frag_count) == nr) {
> +		/* As we have ensured nr is always one for constant case using
> +		 * the BUILD_BUG_ON(), only need to handle the non-constant case
> +		 * here for pp_frag_count draining, which is a rare case.
> +		 */
> +		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
> +		if (!__builtin_constant_p(nr))
> +			atomic_long_set(&page->pp_frag_count, 1);

Aren't we changing the behaviour of the current code here? IIRC is
atomic_long_read(&page->pp_frag_count) == nr we never updated the atomic
pp_frag_count and the reasoning was that the next caller can set it
properly. 

> +
>  		return 0;
> +	}
>  
>  	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
>  	WARN_ON(ret < 0);
> +
> +	/* We are the last user here too, reset pp_frag_count back to 1 to
> +	 * ensure all pages have been partitioned into 1 piece initially,
> +	 * this should be the rare case when the last two fragment users call
> +	 * page_pool_defrag_page() currently.
> +	 */
> +	if (unlikely(!ret))
> +		atomic_long_set(&page->pp_frag_count, 1);
> +
>  	return ret;
>  }
>  
 
 [....]

 Thanks
 /Ilias
