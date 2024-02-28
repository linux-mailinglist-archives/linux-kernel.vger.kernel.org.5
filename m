Return-Path: <linux-kernel+bounces-84993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB57586AEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D95F283991
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604773527;
	Wed, 28 Feb 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBakFKtY"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7573501
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121922; cv=none; b=iyDcLQ5T/zg9o40xd0EXhUUdVsV+S386wgVlQ5mCXzm0GxGBl64DTr6kGgTUgbtpsotD1pAMgX0MqAmoOoCiU6cXm0Ch9X6MvxUpd1rAjgYbqnYD72GzoV564/l7tmNR1eOl8xeDJYpuE5K+NVjBqH37pQD/nk3yEhqFQQat4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121922; c=relaxed/simple;
	bh=9tWLl7stDS/wMVXAi4o5lfP2199c9GwTcbXY/JsSKHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIK7yDVwuqsOgsTMLkY51m+MLrc0WmEDI4Bl8QMKYbQrYcg/KvdP3ASR9TG1HrHtktJswz1p5hriFMKEPfFlWYHMJm9jsJi78vZPQc2Rl7sSVKrc0O0qvo/Em7hLRkNB1dvlNJrgUe0ppUacFRucfJrvC5Il0oEn8h5abxT1Gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBakFKtY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso3292018f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709121919; x=1709726719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PzqyTr5X+aYREyJTGjIbzkTXpuehiLhDk3JwLwQ/6fk=;
        b=gBakFKtYWvfkw/DrNnh4gv6jMVIljdhR3vboZbMyjOzi3ddxOrT8HkUTOKW/8CsIPa
         GesDusIWaAPF4OY+/22RV3necZDWNnTSgy7QPOnOfEgH6Y2CZCd8s8DbWwfmDOwZJ9aC
         Oy4YaaLkzCKFbgN7hXuzAJVM38hbr3b/058ntNJXrKF8/JEK9GwWjH3YnOzGGphy+tGS
         u15pivOnb9+1CennhcZNCKSrtmhStqeL3QE8HNknu6b8D3Vn/qVka3H7Esc4BHAp/69X
         ybqEhQIK4Lz73mexGtXN4Rx+l/J7dT/jXP9RtfHTzpuWYIzcxLPE0x5x25bC5mveUcnP
         WigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121919; x=1709726719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzqyTr5X+aYREyJTGjIbzkTXpuehiLhDk3JwLwQ/6fk=;
        b=kYWeb0s4t4xyms+2vT9ZXnLkKDVfZxUwTfzDUADetY/fV2LjeIGE5PyKSPZuMG78Fp
         NY9tRnZ2SPgEYQAM5SFxNsAJmQG0PvEHKEGNE6pxUUeeJp+w8ClZyaKVxQViTQkdx6XI
         I9ClaTbQJQ9/BC66SUdOC1kSzEEsWwNxz8lov/GLErrBAYb+akWUHQUG4fGAUwsqR1re
         b8tbrLE/Pr3wabYr6i8DNigwhsUox29oX1//dWw+L+fhnTclZ/oxw3hnzHoJ/cYUkPif
         rDhMlCw9TRt2xWKhXByx0gwJzZQsVhs27UXYIe4pCzC/4UgBcmauYw4CLVoDOs7A1WXP
         zzPA==
X-Forwarded-Encrypted: i=1; AJvYcCXTrQ4Wccjspl4J7Hd62dspPWlTSmC80DsdJJIS7FN/ZwjKLRAcZ4XDrqHIgamypxHysqakWal3x7vDOYH4Oa1T/z/cYohaz7VfhTtc
X-Gm-Message-State: AOJu0YyfXPExUmVxSenSDnnVXW6KkGh2prV+46q716GynuSovQekcx+r
	xqEkMrRX4ArDzjDNS78dBkuLg2uPBymfp9ueJN/x/2L5UexlR58QNCp2a3mqhgM=
X-Google-Smtp-Source: AGHT+IGzDI2CfjF+ZrK4HMu6I+33GKctiF8gxjlQv7RCYlslkD+rRN0WYOsloPznRjtf3XKHGUlwOA==
X-Received: by 2002:a5d:52cb:0:b0:33d:89a8:6b99 with SMTP id r11-20020a5d52cb000000b0033d89a86b99mr7802213wrv.70.1709121919242;
        Wed, 28 Feb 2024 04:05:19 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id by15-20020a056000098f00b0033e02f181f7sm1248178wrb.89.2024.02.28.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:05:18 -0800 (PST)
Date: Wed, 28 Feb 2024 12:05:16 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: LiuYe <liu.yeC@h3c.com>
Cc: jason.wessel@windriver.com, dianders@chromium.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240228120516.GA22898@aspen.lan>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228025602.3087748-1-liu.yeC@h3c.com>

On Wed, Feb 28, 2024 at 10:56:02AM +0800, LiuYe wrote:
> master cpu : After executing the go command, a deadlock occurs.
> slave cpu: may be performing thread migration,
>         acquiring the running queue lock of master CPU.
>         Then it was interrupted by kdb NMI and entered the nmi_handler process.
>         (nmi_handle-> kgdb_nmicallback-> kgdb_cpu_enter
>         while(1){ touch wathcdog}.)

I think this description is a little short and doesn't clearly explain
the cause. How about:

Currently, if kgdboc includes 'kdb', then kgdboc will attempt to
use schedule_work() to provoke a keyboard reset when transitioning out
of the debugger and back to normal operation. This can cause
deadlock because schedule_work() is not NMI-safe.

The stack trace below shows an example of the problem. In this
case the master cpu is not running from NMI but it has parked
the slace CPUs using an NMI and the parked CPUs is holding
spinlocks needed by schedule_work().


> example:
>  BUG: spinlock lockup suspected on CPU#0, namex/10450
>  lock: 0xffff881ffe823980, .magic: dead4ead, .owner: namexx/21888, .owner_cpu: 1
>  ffff881741d00000 ffff881741c01000 0000000000000000 0000000000000000
>  ffff881740f58e78 ffff881741cffdd0 ffffffff8147a7fc ffff881740f58f20
> Call Trace:
>  [<ffffffff81479e6d>] ? __schedule+0x16d/0xac0
>  [<ffffffff8147a7fc>] ? schedule+0x3c/0x90
>  [<ffffffff8147e71a>] ? schedule_hrtimeout_range_clock+0x10a/0x120
>  [<ffffffff8147d22e>] ? mutex_unlock+0xe/0x10
>  [<ffffffff811c839b>] ? ep_scan_ready_list+0x1db/0x1e0
>  [<ffffffff8147e743>] ? schedule_hrtimeout_range+0x13/0x20
>  [<ffffffff811c864a>] ? ep_poll+0x27a/0x3b0
>  [<ffffffff8108c540>] ? wake_up_q+0x70/0x70
>  [<ffffffff811c99a8>] ? SyS_epoll_wait+0xb8/0xd0
>  [<ffffffff8147f296>] ? entry_SYSCALL_64_fastpath+0x12/0x75
>  CPU: 0 PID: 10450 Comm: namex Tainted: G           O    4.4.65 #1
>  Hardware name: Insyde Purley/Type2 - Board Product Name1, BIOS 05.21.51.0036 07/19/2019
>   0000000000000000 ffff881ffe813c10 ffffffff8124e883 ffff881741c01000
>   ffff881ffe823980 ffff881ffe813c38 ffffffff810a7f7f ffff881ffe823980
>   000000007d2b7cd0 0000000000000001 ffff881ffe813c68 ffffffff810a80e0
>   Call Trace:
>   <#DB>  [<ffffffff8124e883>] dump_stack+0x85/0xc2
>   [<ffffffff810a7f7f>] spin_dump+0x7f/0x100
>   [<ffffffff810a80e0>] do_raw_spin_lock+0xa0/0x150
>   [<ffffffff8147eb55>] _raw_spin_lock+0x15/0x20
>   [<ffffffff8108c256>] try_to_wake_up+0x176/0x3d0
>   [<ffffffff8108c4c5>] wake_up_process+0x15/0x20
>   [<ffffffff8107b371>] insert_work+0x81/0xc0
>   [<ffffffff8107b4e5>] __queue_work+0x135/0x390
>   [<ffffffff8107b786>] queue_work_on+0x46/0x90
>   [<ffffffff81313d28>] kgdboc_post_exp_handler+0x48/0x70
>   [<ffffffff810ed488>] kgdb_cpu_enter+0x598/0x610
>   [<ffffffff810ed6e2>] kgdb_handle_exception+0xf2/0x1f0
>   [<ffffffff81054e21>] __kgdb_notify+0x71/0xd0
>   [<ffffffff81054eb5>] kgdb_notify+0x35/0x70
>   [<ffffffff81082e6a>] notifier_call_chain+0x4a/0x70
>   [<ffffffff8108304d>] notify_die+0x3d/0x50
>   [<ffffffff81017219>] do_int3+0x89/0x120
>   [<ffffffff81480fb4>] int3+0x44/0x80
>
> Signed-off-by: LiuYe <liu.yeC@h3c.com>
> ---
>  drivers/tty/serial/kgdboc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb164..945318ef1 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -22,6 +22,9 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> +#include <linux/smp.h>
> +
> +#include "../kernel/sched/sched.h"
>
>  #define MAX_CONFIG_LEN         40
>
> @@ -399,7 +402,8 @@ static void kgdboc_post_exp_handler(void)
>                 dbg_restore_graphics = 0;
>                 con_debug_leave();
>         }
> -       kgdboc_restore_input();
> +       if (!raw_spin_is_locked(&(cpu_rq(smp_processor_id())->lock)))
> +               kgdboc_restore_input();

I don't think solving this by access internal scheduler state is the
right approach .

The description I wrote above perhaps already suggests why. The
deadlock occurs because it is unsafe to call schedule_work() from
the debug trap handler. The debug trap handler in your stack trace is not
running from an NMI but it certainly has NMI-like properties. Therefore
a better fix is not to call schedule_work() at all from the debug trap
handler.

Instead we need to use an NMI-safe API such as irq_work_queue() and that
irq_work can call schedule_work() and trigger the keyboard reset.


Daniel.

