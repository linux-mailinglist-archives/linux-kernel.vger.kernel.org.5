Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2C7DC97A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjJaJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343867AbjJaJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:28:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5EB7;
        Tue, 31 Oct 2023 02:28:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso42479475e9.3;
        Tue, 31 Oct 2023 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698744511; x=1699349311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpuRphvrVf3Tpf7glDCxXzY38aB78+VCSilpy3ruTaY=;
        b=YBr4mz3YcPmGMEAEE6tat5OIzAh2b1/UbbvPf++xXgXT70PLHASArOlI+/bqp2jvai
         tFeevx+v2Qf0bGPTSByK4iUtRN1c2eACxQdLJoHmSUJ7goZZNjaIwmYJPyFzhASRf/gh
         GczK90sCmpdFLnE6Gz5fN9+aag+yVaeRqkgTNF7jdbKRBuYn8yxk+TQV5qhtwxbQc2Rp
         l4oFFp5QOYBJ20qb/97knE03pnH8CmwUOGVu7SYrem+d+trio1MDuP4r2mPkF8U5BgnA
         00fcOBZWD305u0Bn2qWNaRnuqqGo8OlBvbg245R+LA/WyiGNFgj3CWY/QV/mSOF06qxG
         a4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698744511; x=1699349311;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuRphvrVf3Tpf7glDCxXzY38aB78+VCSilpy3ruTaY=;
        b=ELKV/2DlQvSCjOo5XegBHJ4f8R40OKXB0DfHFu6k8R980xj4YegprzwUKaoes8Rvme
         AjiGFBAtrauTcyi2Xi1Ns5a2w6hcgaqi7tz+TqqWiFpK+gW/0SXpvIIoMYejEBwocmaY
         KTSkYcRfoApJFv02l/2GNyj7jSnXQrKaX76J85wDV4S3bvg0NqOJ20Kj/MY43TVlQw08
         jUnfGoJVqbTsC+Y+QqsVvFLtBnZgetI6uT6DH4TWRfSPy0XTpmRWJ7mYPnmv9nVZ6wb9
         HkDtbElqLpmO1u8brvkeD/EC7r9ab7IpFmz4AaTOlzdNAmXPgu9L75gFG6hScZS+2YPR
         hUfA==
X-Gm-Message-State: AOJu0YwRE4vEAR7i9AqMXhdFK71dc0txv9qtci25DVUCmTxjXuEhAYiI
        /Lq5JPOvjI/2LrB+ntAekRI=
X-Google-Smtp-Source: AGHT+IG9sjyORQpnyRpUZGDbIloDngb7K78xGL29SX64bRU+POWXPr1HNK0FPT2EiIefUXqaesYC2Q==
X-Received: by 2002:a5d:690c:0:b0:32d:8da0:48d0 with SMTP id t12-20020a5d690c000000b0032d8da048d0mr8072746wru.68.1698744510694;
        Tue, 31 Oct 2023 02:28:30 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d63c8000000b0032f7cfac0fesm1042299wrw.51.2023.10.31.02.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:28:30 -0700 (PDT)
Date:   Tue, 31 Oct 2023 09:28:30 +0000
From:   Martin Habets <habetsm.xilinx@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     richardcochran@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <20231031092830.GA20431@gmail.com>
Mail-Followup-To: Edward Adam Davis <eadavis@qq.com>,
        richardcochran@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <ZT65J4mvFe1yx5_3@hoboy.vegasvil.org>
 <tencent_24C96E7894D0EBA2EDD2CFB87BB66EC02D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_24C96E7894D0EBA2EDD2CFB87BB66EC02D0A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use a separate mail thread for a new patch revision.
See the section "Resending after review" in
Documentation/process/maintainer-netdev.rst.

Martin

On Tue, Oct 31, 2023 at 05:07:08AM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption, use mutex lock to avoid this 
> issue.
> 
> Moreover, ptp_release() should not be used to release the queue in ptp_read(),
> and it should be deleted together.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  drivers/ptp/ptp_chardev.c | 11 +++++++++--
>  drivers/ptp/ptp_clock.c   |  3 +++
>  drivers/ptp/ptp_private.h |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 282cd7d24077..e31551d2697d 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -109,6 +109,9 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	struct timestamp_event_queue *queue;
>  	char debugfsname[32];
>  
> +	if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +		return -ERESTARTSYS;
> +
>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>  	if (!queue)
>  		return -EINVAL;
> @@ -132,15 +135,20 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	debugfs_create_u32_array("mask", 0444, queue->debugfs_instance,
>  				 &queue->dfs_bitmap);
>  
> +	mutex_unlock(&ptp->tsevq_mux);
>  	return 0;
>  }
>  
>  int ptp_release(struct posix_clock_context *pccontext)
>  {
>  	struct timestamp_event_queue *queue = pccontext->private_clkdata;
> +	struct ptp_clock *ptp =
> +		container_of(pccontext->clk, struct ptp_clock, clock);
>  	unsigned long flags;
>  
>  	if (queue) {
> +		if (mutex_lock_interruptible(&ptp->tsevq_mux)) 
> +			return -ERESTARTSYS;
>  		debugfs_remove(queue->debugfs_instance);
>  		pccontext->private_clkdata = NULL;
>  		spin_lock_irqsave(&queue->lock, flags);
> @@ -148,6 +156,7 @@ int ptp_release(struct posix_clock_context *pccontext)
>  		spin_unlock_irqrestore(&queue->lock, flags);
>  		bitmap_free(queue->mask);
>  		kfree(queue);
> +		mutex_unlock(&ptp->tsevq_mux);
>  	}
>  	return 0;
>  }
> @@ -585,7 +594,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>  free_event:
>  	kfree(event);
>  exit:
> -	if (result < 0)
> -		ptp_release(pccontext);
>  	return result;
>  }
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 3d1b0a97301c..7930db6ec18d 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -176,6 +176,7 @@ static void ptp_clock_release(struct device *dev)
>  
>  	ptp_cleanup_pin_groups(ptp);
>  	kfree(ptp->vclock_index);
> +	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
>  	/* Delete first entry */
> @@ -247,6 +248,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (!queue)
>  		goto no_memory_queue;
>  	list_add_tail(&queue->qlist, &ptp->tsevqs);
> +	mutex_init(&ptp->tsevq_mux);
>  	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
>  	if (!queue->mask)
>  		goto no_memory_bitmap;
> @@ -356,6 +358,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (ptp->kworker)
>  		kthread_destroy_worker(ptp->kworker);
>  kworker_err:
> +	mutex_destroy(&ptp->tsevq_mux);
>  	mutex_destroy(&ptp->pincfg_mux);
>  	mutex_destroy(&ptp->n_vclocks_mux);
>  	bitmap_free(queue->mask);
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 52f87e394aa6..1525bd2059ba 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -44,6 +44,7 @@ struct ptp_clock {
>  	struct pps_device *pps_source;
>  	long dialed_frequency; /* remembers the frequency adjustment */
>  	struct list_head tsevqs; /* timestamp fifo list */
> +	struct mutex tsevq_mux; /* one process at a time reading the fifo */
>  	struct mutex pincfg_mux; /* protect concurrent info->pin_config access */
>  	wait_queue_head_t tsev_wq;
>  	int defunct; /* tells readers to go away when clock is being removed */
> -- 
> 2.25.1
> 
