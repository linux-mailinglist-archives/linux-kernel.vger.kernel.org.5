Return-Path: <linux-kernel+bounces-18655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9DC82609C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F7AB21FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42A8831;
	Sat,  6 Jan 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apQodEKR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA5C120
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso412911a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704558591; x=1705163391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmYHoCjhNTaJ6RBnojFmrzyN02x16gJPksqO7MXISzo=;
        b=apQodEKRECn2CcRLw/pmK0moFlq6b86vn5SYujFwxudq/YnssIGfKOKi5yIlj383rn
         Oa7sPbZHXHGSW4x4mFywq5LLDYN5zX3fdTd7ZSP9BmbpgUOcM3ufPHDX4mOfJzkY0ouN
         gZ2UYFcbiYazpOgdv76axYeCtDYrw7IkvyG5hHmsU+5Jc9FRsqoIrnmu4FkKFPG07vyW
         UPZd20T6+0bM93K9orfmEpp3WKhkE3Vh+FAw3vy2AQQ55fOdgkpu2gxF5/nDnq5FxmgW
         3nA820kVrjJc2QIdLiuH+KHjGu1KjYwsoE9C+GVZ/u+I4js2iFh77SE2Obe0o0sGh0JZ
         R8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704558591; x=1705163391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmYHoCjhNTaJ6RBnojFmrzyN02x16gJPksqO7MXISzo=;
        b=NKw2jjS6oQQZ3iMYNavxGJi29Ify1lSBHx6oLNagGF8qn6vzKQJNzIzdxbr8oxrptp
         mpLmNKlcAFmiq68alceAm9nQ4meQzmCZYqCVjnwsllMljBwZBmlxM3idix8TJSHwikNV
         u03rBVTDAT6J53AaEhjfsmD/SvuyqyRmcbe9ktpFZyWKtOYl8PW5yU7Ttr8sr8K+4A+g
         9YU8Mhf8EMaLacuaNmddwB5wlEQJkRUPI2W4fcDbq4/fKHTyoWYLRMVBc8x6vAxF9nbv
         PhmewxaT9OHprosuSY7C2K9q1mtvkUdfg136JWsCNuIL7AcoE/TQlbvuofY1ydCQ5Ctq
         IkHQ==
X-Gm-Message-State: AOJu0YywaB3WkQU20LTFKzEd1RBQzed1PGGjOwwbNyi17dRHp2hDq5pA
	h0U+M7j+4SrfFaOo4tiVu17w56FdeRLy
X-Google-Smtp-Source: AGHT+IFlCl3R3yPlY5+P1uytEVC3+XnfeSY3L/bF5U4kbBSdYfwiiMYzywdqYWqdyS0vX69QFede1g==
X-Received: by 2002:a05:6a20:7492:b0:199:144b:35f2 with SMTP id p18-20020a056a20749200b00199144b35f2mr1210423pzd.90.1704558591212;
        Sat, 06 Jan 2024 08:29:51 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b006da0372200asm3254428pfk.184.2024.01.06.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 08:29:49 -0800 (PST)
Date: Sat, 6 Jan 2024 16:29:45 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] binder: remove redundant variable page_addr
Message-ID: <ZZl_-XGd-WJ0juz9@google.com>
References: <20240106150457.53423-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106150457.53423-1-colin.i.king@gmail.com>

On Sat, Jan 06, 2024 at 03:04:57PM +0000, Colin Ian King wrote:
> From: Colin Ian King <colin.i.king@intel.com>
> 
> Variable page_addr is being assigned a value that is never read. The
> variable is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> warning: Value stored to 'page_addr' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@intel.com>
> ---
>  drivers/android/binder_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index ea5e1ba2d0d7..ed4ca6689c75 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -925,7 +925,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  		int i;
>  
>  		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> -			unsigned long page_addr;
>  			bool on_lru;
>  
>  			if (!alloc->pages[i].page_ptr)
> @@ -933,7 +932,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  
>  			on_lru = list_lru_del_obj(&binder_freelist,
>  					      &alloc->pages[i].lru);
> -			page_addr = alloc->buffer + i * PAGE_SIZE;
>  			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
>  				     "%s: %d: page %d %s\n",
>  				     __func__, alloc->pid, i,
> -- 
> 2.43.0
> 

Thanks Colin. I was waiting for this warning to hit mainline so that I
could add the following tags to the fix:

  Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
  Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202312060851.cudv98wG-lkp@intel.com/

Feel free to take them for a v2 if you'd like. Either way,
Acked-by: Carlos Llamas <cmllamas@google.com>

--
Carlos Llamas

