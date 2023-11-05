Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9787E13B6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjKENgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjKENgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:36:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8432CA;
        Sun,  5 Nov 2023 05:36:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27fe16e8e02so572477a91.0;
        Sun, 05 Nov 2023 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699191404; x=1699796204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2jAj5sYDtWpP4saEAb+BaMouDW7PQzuo3xBxPi2ywM=;
        b=SKtCfxkomgiPbnnCE2Y6Z+i1xnCA3qD3QQOcP6gNviedC7FHzv0NgOlriHrKMCgHuq
         LwxymtMss+iWajmC7ZXXJOAC9/oSw10pkCD9PCb6FGlobzbVcORGOz+M7QLapFzYltP3
         HJYl8BpoQbyYUOi3CTpOEwGUZMFAzcLzG7azeDAuU7ny0Kbr5tpWTWOU5KMqfRGM1+yZ
         FEDR13WEzLC0jeJHy7Q+G3hzY5zHUm6DJdUK+/Hb5bGo8+GSZcBA7sa+kWBUhLdDRhMx
         LLmzD/EAtCT2BODGDG7HCDm1dpbzy52PG+1JbHuBXx3ClHNt607JN8qljg2ExuyuM0q5
         38TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699191404; x=1699796204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2jAj5sYDtWpP4saEAb+BaMouDW7PQzuo3xBxPi2ywM=;
        b=XWOEMx3k2zgnYGXzCq14hy9LiuzHntV6UvVp6w03OXZCr5JnoWLcPZNu7vMqfv6kyd
         OYKiwDFF1ebdOQ2UiVB5TyDJ7TP/hgJ78mxjY83R+KM++X4t+iYxvhrg+svxhz0hMzqB
         h21TcVSd7uFulnTReBSMTyQhUS7KIWhNhexr5Su7UuZrZ6CfHhm8qtQxoqmF8f7qNXxD
         HsMY74OpIhnyuSTIaJWuNBlwcfzaBB87CBpxidAnUXGBkz9hdlN6jKOQaJVSblZQ0gEE
         4HwLiswjQNm50NyPOZ+jrMh+3jfkMxtyuM+rYm9RY+z5biUTfNACDfrmT8+ksdNpsM2v
         lGWg==
X-Gm-Message-State: AOJu0YxWep+gGwQgzCnpTH0MzNjBEAavOcGbwI7UUGY2Bkbs2dDj6rii
        +3UUpzqF2oRL4meqT+Z81W5VRF6K3aE=
X-Google-Smtp-Source: AGHT+IEmf3anqwkh9FIocMU4NjQRNG8f2nfgZa+KPOs9EQlI7fo5I9ZWuEdSyH89jgVXHNEUmjLnTA==
X-Received: by 2002:a17:902:f214:b0:1cc:27fa:1fb7 with SMTP id m20-20020a170902f21400b001cc27fa1fb7mr23843729plc.5.1699191404181;
        Sun, 05 Nov 2023 05:36:44 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170903279800b001c9cb2fb8d8sm4234025plb.49.2023.11.05.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 05:36:43 -0800 (PST)
Date:   Sun, 5 Nov 2023 05:36:41 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V6] ptp: fix corrupted list in ptp_open
Message-ID: <ZUeaaVHlYCaq2NwG@hoboy.vegasvil.org>
References: <tencent_856E1C97CCE9E2ED66CC087B526CD42ED50A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_856E1C97CCE9E2ED66CC087B526CD42ED50A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edward!

On Sun, Nov 05, 2023 at 10:12:08AM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open() and
> ptp_release(), which can cause data corruption, use spin lock to avoid this
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted together.

Change to:  "it should be deleted altogether"
 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/ptp/ptp_chardev.c | 11 +++++++----
>  drivers/ptp/ptp_clock.c   |  1 +
>  drivers/ptp/ptp_private.h |  1 +
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..31594f40a21e 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -108,6 +108,7 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  		container_of(pccontext->clk, struct ptp_clock, clock);
>  	struct timestamp_event_queue *queue;
>  	char debugfsname[32];
> +	unsigned long flags;
>  
>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>  	if (!queue)
> @@ -119,8 +120,10 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	}
>  	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
>  	spin_lock_init(&queue->lock);
> +	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
>  	list_add_tail(&queue->qlist, &ptp->tsevqs);
>  	pccontext->private_clkdata = queue;

Move this assignment outside of locked region, i.e. after spin_unlock_irqrestore().

> +	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
>  
>  	/* Debugfs contents */
>  	sprintf(debugfsname, "0x%p", queue);
> @@ -139,13 +142,15 @@ int ptp_release(struct posix_clock_context *pccontext)
>  {
>  	struct timestamp_event_queue *queue = pccontext->private_clkdata;
>  	unsigned long flags;
> +	struct ptp_clock *ptp =
> +		container_of(pccontext->clk, struct ptp_clock, clock);
>  
>  	if (queue) {

Please remove this test.  Since you removed ptp_release() from
ptp_read(), the queue cannot be NULL.

>  		debugfs_remove(queue->debugfs_instance);
> +		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
>  		pccontext->private_clkdata = NULL;

Move this assignment outside of locked region.

> -		spin_lock_irqsave(&queue->lock, flags);
>  		list_del(&queue->qlist);
> -		spin_unlock_irqrestore(&queue->lock, flags);
> +		spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
>  		bitmap_free(queue->mask);
>  		kfree(queue);
>  	}
> @@ -585,7 +590,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>  free_event:
>  	kfree(event);
>  exit:
> -	if (result < 0)
> -		ptp_release(pccontext);

This is good, but please put it into a separate patch, along with the
removal of the bogus "if (queue)" test in ptp_release().

>  	return result;
>  }
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 3d1b0a97301c..ea82648ad557 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (!queue)
>  		goto no_memory_queue;
>  	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +	spin_lock_init(&ptp->tsevqs_lock);
>  	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
>  	if (!queue->mask)
>  		goto no_memory_bitmap;
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 52f87e394aa6..63af246f17eb 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -44,6 +44,7 @@ struct ptp_clock {
>  	struct pps_device *pps_source;
>  	long dialed_frequency; /* remembers the frequency adjustment */
>  	struct list_head tsevqs; /* timestamp fifo list */
> +	spinlock_t tsevqs_lock; /* one process at a time writing the timestamp fifo list*/

Please change this comment to "protects tsevqs from concurrent access"

>  	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
>  	wait_queue_head_t tsev_wq;
>  	int defunct; /* tells readers to go away when clock is being removed */
> -- 
> 2.25.1
> 

Since v6.6 now contains the original commit, please change subject to [net].

Thanks,
Richard
