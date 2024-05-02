Return-Path: <linux-kernel+bounces-165906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60648B9337
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382F51F2281E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF71643D;
	Thu,  2 May 2024 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzq9Y7pT"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5211718;
	Thu,  2 May 2024 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614690; cv=none; b=p1npjCft4vK22HvtMWh7JnUytKCMWEVL3zewlgGJHNJiMmoV55dTTtj6aDWRNkTNlmS8eMwth5QBiHuYkw5+GORIzbKH+sW8fz2Ft8RdOR5Og6mx/xZ0+SzscKUzNsaLqtAY36fu26PvBjfGezwIVPa/qN8bgiiC1sqbILVMQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614690; c=relaxed/simple;
	bh=Qd7fp3ZOsCVxP7wAvk7Z7lJwmDOOi4xwnIodkxXm/8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esFTY/5/1/yiLL+xSn+T8AYwL9R2t3imW0G5iZPVGyMKvG0BX6Yqw4FRTEdLVBtbZzMfuWoPi8A3RS2g+cBhwK65e62n6QHIFlxaRx6ew1JgbyjfF4f0DGW9qQ0vBfTBh3AyBxtdfEhRnpY5s4wwszDx70eOLEAjt3Gm6q445qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzq9Y7pT; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23dd94111cfso158659fac.2;
        Wed, 01 May 2024 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714614688; x=1715219488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qORUWv5D6+1+UIRZSmB9lavr47EFQrkjCj3lO1RnJ8E=;
        b=Pzq9Y7pT1eBaaOeUaduSQkC13BVUkUXiEVVZAvIU9DC65w2mcAO/vnouuaDYIuRq5/
         53Uu9TzFbfq+nQDEngYxHi3deeB/OySLmnR7KBsDl/hEZfSkBQhTn2KOLDmO9c8FITkz
         uXyBSzAkPpkN/WIg4eob7SXqCMVulVHu+dshqgD8MQuBcGwxep7waw9HS5FrvHJYbVOu
         zH+Be6I3TXHBt1T9/RFuEpsO1CzT/JjgueeZh/wHvmmZ2iXV+BCdZueh6iwhZEEysT2a
         Rr1mvRSlb+XOoS0pdumFGZ5i9wXGmufR8AY5RX/CDDWgWWXvEO5CFASapRYPcNOoNPG3
         SaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714614688; x=1715219488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qORUWv5D6+1+UIRZSmB9lavr47EFQrkjCj3lO1RnJ8E=;
        b=p4h3MLb78rSqHFHqZfTxzDuUg0k7R89ncofGNgpPdGy1H8GMGRKmTsMT9ozXBNfr81
         Ej42Ty7HrRSMiFRjKSLz9/QMC3d84d/rS9ihYAMpHXqd+/IXNy2VkbuEcKalUxyfSpuq
         CuA4uFQ4UrJzQJakc6Qw2aGnu8Iooa2D/TIA9zyUPdWXdfTokf0Q5S1kRjzhUtpzrIS6
         UxP20icDR2dpOwQ1sd1+W4duul6BSAG7RIb0fxdZP032qz/pcpc/hHigNZ/t4F8a4Ytz
         1Imw2C1qkjZs1wAaF1PovxwMfJEvv/uvW1xQKRqOSrmSA5Q1mokpuodGiftfVy3cjmSu
         emkw==
X-Forwarded-Encrypted: i=1; AJvYcCUeGB4fB8u6LlKDP/X/xdJkVC/T2bgfKgEVHNDavoWzNDqSd97ABF9+znbPDKvRVALi/9CrVVTs7NaLuN+/Yg5k2M/BdWEgo3+/wsxs37gFYFnCkLtx1Yxa9fG450kw28uoxws3qBx+Gw==
X-Gm-Message-State: AOJu0YwPIzq9eUNBXgpfuUHrRQvkFdjaAAo5r5RIHmb+yUYgvEXL1Wem
	xHjO//X2k2vtgoIUmXOrLiYiUqW0XfRP72vE4UOoHhGslKlyoTzoljpN8w==
X-Google-Smtp-Source: AGHT+IFtQX0rWZfVzqtuisTUys6PMKmkf8+FTK6Ba5niAmWbwx2TnYqH9JbXf8LXyoHNnvqPl3gWvw==
X-Received: by 2002:a05:6870:9690:b0:22a:6ce3:d57 with SMTP id o16-20020a056870969000b0022a6ce30d57mr4661106oaq.25.1714614688279;
        Wed, 01 May 2024 18:51:28 -0700 (PDT)
Received: from rigel (14-200-166-65.static.tpgi.com.au. [14.200.166.65])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b006e4e93f4f17sm48076pfu.117.2024.05.01.18.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:51:27 -0700 (PDT)
Date: Thu, 2 May 2024 09:51:22 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: brgl@bgdev.pl, linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: Fix use after free in
 lineinfo_changed_notify
Message-ID: <20240502015122.GA15967@rigel>
References: <20240501022612.1787143-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501022612.1787143-1-quic_zhonhan@quicinc.com>

On Wed, May 01, 2024 at 10:26:12AM +0800, Zhongqiu Han wrote:
> The use-after-free issue occurs when userspace closes the GPIO chip device
> file (e.g., "/dev/gpiochip0") by invoking gpio_chrdev_release(), while one
> of its GPIO lines is simultaneously being released. In a stress test
> scenario, stress-ng tool starts multi stress-ng-dev threads to continuously
> open and close device file in the /dev, the use-after-free issue will occur
> with a low reproducibility.

This could be clearer.  Use-after-free of what?  We don't find out it is
the watched_lines bitmap until much later...

>
> Here is the typical stack when issue happened:
>

This stack trace is excessive [1].

> BUG: KASAN: slab-use-after-free in lineinfo_changed_notify+0x84/0x1bc
> Read of size 8 at addr ffffff803c06e840 by task stress-ng-dev/5437
> Call trace:
>  dump_backtrace
>  show_stack
>  dump_stack_lvl
>  print_report
>  kasan_report
>  __asan_load8
>  lineinfo_changed_notify
>  notifier_call_chain
>  blocking_notifier_call_chain
>  gpiod_free_commit
>  gpiod_free
>  gpio_free
>  st54spi_gpio_dev_release
>  __fput
>  __fput_sync
>  __arm64_sys_close
>  invoke_syscall
>  el0_svc_common
>  do_el0_svc
>  el0_svc
>  el0t_64_sync_handler
>  el0t_64_sync
> Allocated by task 5425:
>  kasan_set_track
>  kasan_save_alloc_info
>  __kasan_kmalloc
>  __kmalloc
>  bitmap_zalloc
>  gpio_chrdev_open
>  chrdev_open
>  do_dentry_open
>  vfs_open
>  path_openat
>  do_filp_open
>  do_sys_openat2
>  __arm64_sys_openat
>  invoke_syscall
>  el0_svc_common
>  do_el0_svc
>  el0_svc
>  el0t_64_sync_handler
>  el0t_64_sync
> Freed by task 5425:
>  kasan_set_track
>  kasan_save_free_info
>  ____kasan_slab_free
>  __kasan_slab_free
>  slab_free_freelist_hook
>  __kmem_cache_free
>  kfree
>  bitmap_free
>  gpio_chrdev_release
>  __fput
>  __fput_sync
>  __arm64_sys_close
>  invoke_syscall
>  el0_svc_common
>  do_el0_svc
>  el0_svc
>  el0t_64_sync_handler
>  el0t_64_sync
>
> The use-after-free issue occurs as follows: watched_lines is freed by
> bitmap_free(), but the lineinfo_changed_nb notifier chain cannot be
> successfully unregistered due to waiting write rwsem when closing the
> GPIO chip device file. Additionally, one of the GPIO chip's lines is
> also in the release process and holds the notifier chain's read rwsem.
> Consequently, a race condition leads to the use-after-free of
> watched_lines.
>

Drop the stack trace above and rework this paragraph into the opening
paragraph.

Might be good to note the side effects of the use-after-free.
AFAICT it may only result in an event being generated for userspace where
it shouldn't.  But, as the chrdev is being closed, userspace wont have the
chance to read that event anyway, so no appreciable difference?

> [free]
> gpio_chrdev_release()
>   --> bitmap_free(cdev->watched_lines)                  <-- freed
>   --> blocking_notifier_chain_unregister()
>     --> down_write(&nh->rwsem)                          <-- waiting rwsem
>           --> __down_write_common()
>             --> rwsem_down_write_slowpath()
>                   --> schedule_preempt_disabled()
>                     --> schedule()
>
> [use]
> st54spi_gpio_dev_release()
>   --> gpio_free()
>     --> gpiod_free()
>       --> gpiod_free_commit()
>         --> gpiod_line_state_notify()
>           --> blocking_notifier_call_chain()
>             --> down_read(&nh->rwsem);                  <-- held rwsem
>             --> notifier_call_chain()
>               --> lineinfo_changed_notify()
>                 --> test_bit(xxxx, cdev->watched_lines) <-- use after free
>
> To fix this issue, call the bitmap_free() function after successfully

"successfully" is confusing here as there is no unsuccessfully.

> unregistering the notifier chain. This prevents lineinfo_changed_notify()
> from being called, thus avoiding the use-after-free race condition.

The final sentence doesn't add anything - the reorder fixing the problem
is clear enough.

>
> Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index d09c7d728365..6b3a43e3ba47 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -2799,11 +2799,11 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
>  	struct gpio_chardev_data *cdev = file->private_data;
>  	struct gpio_device *gdev = cdev->gdev;
>
> -	bitmap_free(cdev->watched_lines);
>  	blocking_notifier_chain_unregister(&gdev->device_notifier,
>  					   &cdev->device_unregistered_nb);
>  	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
>  					   &cdev->lineinfo_changed_nb);
> +	bitmap_free(cdev->watched_lines);
>  	gpio_device_put(gdev);
>  	kfree(cdev);
>

No problem with the code change - makes total sense.

Cheers,
Kent.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages

