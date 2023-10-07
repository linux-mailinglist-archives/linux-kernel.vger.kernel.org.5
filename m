Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCF7BCA78
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjJGXQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:16:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629ABA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 16:16:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c871a095ceso25937415ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696720569; x=1697325369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdaS1Ku58oT7hBQj2wy7aqzyQXwY2IDqg0TDApGz+Gg=;
        b=zTI8c8IRmRVx+/73jqPeEMghfGRc06gbhwZ9hmasRtRAE+6VHvIdawULJvClhLYQnj
         dL1hlhIr3A/UsdjNf0OV6J1eiWAT3BKmdMYJ878HZe6xqwy32qjDn6TBtBvDz4mDCE3P
         8Pcl4R72q+Nri7XwQXNAP2qxuI4Kbg3UOtXtPHpWmiTio+P1x16m8Nr2r+P/UqBNvd/f
         +TeRxnTXlXwzgV+uuGJPtiD7LbH05zuTXMXwMPvy4bhLNr4qUb3sUForHwNuy2EcLlWA
         mOezcDpVEQPqyiKfjgLDyQf9IYrJWsUe+oJaBLIH2VeWgoG9Ty0uD+D0y408L3RRzhYq
         Ej8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696720569; x=1697325369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdaS1Ku58oT7hBQj2wy7aqzyQXwY2IDqg0TDApGz+Gg=;
        b=gmk8u7rf9g6NhwjONKgbEvg53j57CMHM96zlrTVBf+igPr2/n/5OJgHg3SLPRrLh0l
         d+S3CM/9ucwBcTmGNahWPPCWeQ6HykcQdMp3xROaGjen+/4UQeKrPKPTcZatPnzhk7N9
         UxlibgJYwACxzDQBNXCTpIf0CFulsMVf/OmlGPwxFeLIxcyIo9tStQljzYyBRoLxk+IN
         U8vlLE9lqGrc8AYqPt8aQhabZ+Ho7jtytO4rTQGnicjehYc8H/h0IWc9VpPuPKFVZ71b
         MNSPh1PQo/D2J4oiSQsnnK1N8m4rrDOW68wr3sC0NurrLoXTcOllSrGZuZWH6DtgFQyC
         AqcA==
X-Gm-Message-State: AOJu0YywcEsd+5K4b8QqJBJLIn+av6i15GNbg0qqZ9VnJNhpWgNKBSp0
        KiUdOe3D0eEzdTdeApyY5qbl2w==
X-Google-Smtp-Source: AGHT+IE+mGalnvrPBEBSxIeueShVSgWgYt2wZLBJE/k19p8MH5Ve/5hn78r7kqgMBiiJCdSRzSDp5A==
X-Received: by 2002:a05:6a20:7d89:b0:137:23f1:4281 with SMTP id v9-20020a056a207d8900b0013723f14281mr14668305pzj.12.1696720568877;
        Sat, 07 Oct 2023 16:16:08 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001c76fcccee8sm6401853plg.156.2023.10.07.16.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:16:08 -0700 (PDT)
Date:   Sat, 7 Oct 2023 23:16:04 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     gregkh@google.com, gregkh@linuxfoundation.org, surenb@google.com,
        arve@android.com, joel@joelfernandes.org, brauner@kernel.org,
        tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org,
        Sherry Yang <sherryy@android.com>
Subject: Re: [PATCH v3] binder: add mutex_lock for mmap and NULL when free
Message-ID: <ZSHmtLqtNZRAtaZ0@google.com>
References: <20231007122813.84282-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007122813.84282-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 08:28:13PM +0800, Kassey Li wrote:
> - Enforce alloc->mutex in binder_alloc_mmap_handler when add the entry to
>   list.
> 
> - Assign the freed pages/page_ptr to NULL to catch possible use after free
>   with NULL pointer access.
> 
> Fixes: 19c987241ca1 ("binder: separate out binder_alloc functions")
> Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
> CC: Todd Kjos <tkjos@android.com>
> CC: Sherry Yang <sherryy@android.com>
> Link: https://lore.kernel.org/all/20231007034046.2352124-1-quic_yingangl@quicinc.com/
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
> V1 -> V2: Add Fixes info.
> V2 -> V3: Add this history.
> ---
>  drivers/android/binder_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index e3db8297095a..c7d126e04343 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -775,6 +775,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  	}
>  
>  	buffer->user_data = alloc->buffer;
> +	mutex_lock(&alloc->mutex);

At this stage we are already holding the mm->mmap_lock. If you take the
alloc->mutex here you will deadlock. You should see this warning with
lockdep enabled. Also, you don't need the lock here...

>  	list_add(&buffer->entry, &alloc->buffers);
>  	buffer->free = 1;
>  	binder_insert_free_buffer(alloc, buffer);
> @@ -782,7 +783,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  
>  	/* Signal binder_alloc is fully initialized */
>  	binder_alloc_set_vma(alloc, vma);

This barrier will set the alloc->vma pointer. Once set, it signals that
the alloc-> space has been initialized and it is safe to access.

> -
> +	mutex_unlock(&alloc->mutex);
>  	return 0;
>  
>  err_alloc_buf_struct_failed:
> @@ -856,9 +857,11 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  				     __func__, alloc->pid, i, page_addr,
>  				     on_lru ? "on lru" : "active");
>  			__free_page(alloc->pages[i].page_ptr);
> +			alloc->pages[i].page_ptr = NULL;
>  			page_count++;
>  		}
>  		kfree(alloc->pages);
> +		alloc->pages = NULL;

The process is dying and there aren't any more references to it. It is
pointless to mark the pages NULL. No one is or will use them after.

>  	}
>  	mutex_unlock(&alloc->mutex);
>  	if (alloc->mm)
> -- 
> 2.25.1
> 

I see that you reported a crash on the previous thread here:
https://lore.kernel.org/all/26988068-8c9f-8591-db6e-44c8105af638@quicinc.com/
...unfortunately, it doesn't seem to me like setting alloc->pages = NULL
would help fix your issue.

I do agree this sounds like a use-after-free though. Are you able to
reproduce the issue with KASAN enabled? This should tell us where the
actual problem is.

--
Carlos Llamas
