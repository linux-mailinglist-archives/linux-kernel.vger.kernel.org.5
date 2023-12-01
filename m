Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A008012EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379357AbjLASli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjLASlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:41:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40A1A4;
        Fri,  1 Dec 2023 10:41:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ce3084c2d1so7550845ad.3;
        Fri, 01 Dec 2023 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701456101; x=1702060901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTk3l7fJ0YyK9LiTzqj/CkwfO59coSl4jyO6pTu6AKo=;
        b=TYqZAYcjpYU8wDgpEpigmwJgOj0Fq0BxuT2fJy+4PWDx+3RTRGZrEYUh4YsxDtZQz6
         +ZFd5ZkGl0BbNjD+ypRFlBl5bFvYX+oobtRq2ae1hTd0tycpaaef4jGcP3q/f5GiqzqW
         Zs/vE4cFfVA8Ixs3iA/G1e6n1rteI3wI9anmiulU8G8bmSwIkR8m+kdYKdron/2xwVmC
         AkQd3V6LWE4AI+QnIkyw7u7z18+osTQUFjvCCMlMvKY0H7abC4v0+BHBDVqN3cT2ViSW
         Ivdz/cqoaR7k+nVAho3LkyRfB8avQK19Wibg0v1u3ZeRGFf9YgQ1UGytUA5uduJytJgK
         haZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456101; x=1702060901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTk3l7fJ0YyK9LiTzqj/CkwfO59coSl4jyO6pTu6AKo=;
        b=DeqDHFvPnCZLKuGVZcpfm3zrqZBT6lW2WVaqSPMFQ5TKqScbA2WxkbBLAzCbvdF8Ks
         LMsg/6d0bPHjf6tpT2YVXsgNDvYuHi7KTXYUIoq7Nta8Q/VinfCHTnjqcbg7aU2wN8M1
         UDaULOI0cITKhS0bCht/g5h9WZ6B+NEUThW+oOBEkq38jcBkJgfQTwYNXBFDffc+4zaE
         MYdy5hrXbteQdr3J3rcp2eo/KsqMlSN0mWfZ6CjhjeJOXNVRBlr+nAd5QBik09+q0eJq
         fbm3NswGNl8WKwVFz1h62T8O4BUuBbJVyy2lt6IN6SM5jkxt5A4SGdWV/UahwytoI+Sj
         sruw==
X-Gm-Message-State: AOJu0Ywf873hPUu5aPesoEC8FYjlBGCh2sUldySRcTik7KW7+x2uIqZW
        4Ox0xfXcnCRKftxupaJw0T8=
X-Google-Smtp-Source: AGHT+IH8uuVyy0xQcI2Dtm+XIq2vpPWkRjB/VzMHGSFrcGn5ya/+GGU7blbsl0Q+mlj6sB8F5MeXPQ==
X-Received: by 2002:a17:903:183:b0:1cf:6590:70 with SMTP id z3-20020a170903018300b001cf65900070mr32676849plg.23.1701456101173;
        Fri, 01 Dec 2023 10:41:41 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:affa:609d:2701:8e46])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ea8c00b001c736b0037fsm1855643plb.231.2023.12.01.10.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:41:40 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 1 Dec 2023 10:41:38 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Dongyun Liu <dongyun.liu3@gmail.com>
Cc:     senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        lincheng.yang@transsion.com, jiajun.ling@transsion.com,
        ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
Message-ID: <ZWoo4tbvN99LH7Fs@google.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130152047.200169-1-dongyun.liu@transsion.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:20:47PM +0800, Dongyun Liu wrote:
> We encountered a deadlock issue when using zram on kernel version 5.10.
> The reason is that the backing_dev_store will first hold the
> zram->init_lock, and then it will allocate memory with kvmalloc_node. At
> this moment, the system may be in a state of memory shortage, so it will
> enter the memory swapping process. In zram_bvec_write, we will trigger
> our own thread to move data from zram to the backing device to free up
> more available memory, which is the work done in the
> try_wakeup_zram_wbd. In this function, zram->init_lock will be acquired
> again to read zram->bd_wb_limit, which causes a deadlock as follow call
> trace.

Isn't it your custom feature instead of upstream?

> 
> The latest version of Linux does not have the bug, but a potential risk
> in future.If we try to acquire zram->init_lock again in the zram process
> (for example, when we need to read zram->bd_wb_limit), there is a risk
> of deadlock. The bug is quite elusive, and it only appears with low

It would be very helpful if you show how the zram in the upstream could
cause the deadlock instead of your custom feature.

> probability after conducting a week-long stress test using 50 devices.
> Therefore, I suggest passing the GFP_ATOMIC flag to allocate memory in
> the backing_dev_store, to avoid similar issues we encountered. Please
> consider it, Thank you.
> 
> INFO: task init:331 blocked for more than 120 seconds.  "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:init   state:D stack:    0 pid:    1 ppid:     0 flags:0x04000000
> Call trace:
>   __switch_to+0x244/0x4e4
>   __schedule+0x5bc/0xc48
>   schedule+0x80/0x164
>   rwsem_down_read_slowpath+0x4fc/0xf9c
>   __down_read+0x140/0x188
>   down_read+0x14/0x24
>   try_wakeup_wbd_thread+0x78/0x1ec [zram]
>   __zram_bvec_write+0x720/0x878 [zram]
>   zram_bvec_rw+0xa8/0x234 [zram]
>   zram_submit_bio+0x16c/0x268 [zram]
>   submit_bio_noacct+0x128/0x3c8
>   submit_bio+0x1cc/0x3d0
>   __swap_writepage+0x5c4/0xd4c
>   swap_writepage+0x130/0x158
>   pageout+0x1f4/0x478
>   shrink_page_list+0x9b4/0x1eb8
>   shrink_inactive_list+0x2f4/0xaa8
>   shrink_lruvec+0x184/0x340
>   shrink_node_memcgs+0x84/0x3a0
>   shrink_node+0x2c4/0x6c4
>   shrink_zones+0x16c/0x29c
>   do_try_to_free_pages+0xe4/0x2b4
>   try_to_free_pages+0x388/0x7b4
>   __alloc_pages_direct_reclaim+0x88/0x278
>   __alloc_pages_slowpath+0x4ec/0xf6c
>   __alloc_pages_nodemask+0x1f4/0x3dc
>   kmalloc_order+0x54/0x338
>   kmalloc_order_trace+0x34/0x1bc
>   __kmalloc+0x5e8/0x9c0
>   kvmalloc_node+0xa8/0x264
>   backing_dev_store+0x1a4/0x818 [zram]
>   dev_attr_store+0x38/0x8c
>   sysfs_kf_write+0x64/0xc4
>   kernfs_fop_write_iter+0x168/0x2ac
>   vfs_write+0x300/0x37c
>   ksys_write+0x7c/0xf0
>   __arm64_sys_write+0x20/0x30
>   el0_svc_common+0xd4/0x270
>   el0_svc+0x28/0x98
>   el0_sync_handler+0x8c/0xf0
>   el0_sync+0x1b4/0x1c0
> 
> Signed-off-by: Dongyun Liu <dongyun.liu@transsion.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index d77d3664ca08..ee6c22c50e09 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -514,7 +514,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  
>  	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
>  	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
> -	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
> +	bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
>  	if (!bitmap) {
>  		err = -ENOMEM;
>  		goto out;
> -- 
> 2.25.1
> 
