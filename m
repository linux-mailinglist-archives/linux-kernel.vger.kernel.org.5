Return-Path: <linux-kernel+bounces-127988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7489541E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C871F23696
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23383CC8;
	Tue,  2 Apr 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0xwaJ3v"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CA7F7FD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062688; cv=none; b=QRtoYhIAfC57aargx9XkBjvzBBN9SbfPf/3IrUNiS9cGVULxc8pzx4WwtfwByDK960qg+PMJIG+PJsNU5UnsNivpmnI97QGOtOxxS3eBIF4OASnoLdEg0pq7R2kySY7TLGwzjn2Quce73dypsOQeR9L8UoKRz599pWOxtUHu544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062688; c=relaxed/simple;
	bh=mdY4dxhz2UTdQG4t+FrFFk3AOW100nipdCoXDUX5fj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbw+cYqTHT5tPN5gJqxMKJ2YhBbag60/2XnKwxqQ0VhTsnZrqYDcaYIu5MU8NUzuevcftPHh8jqBX886jjTrTZZAjEkBKR/eGnjie4Kh1gBcaoOZIkAx7XDhGG7Z4MUtwtUaLvcj3XLcyBNIwuNsiGbe1QmKZuVNmy6NAcCJRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0xwaJ3v; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515a68d45faso5712625e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712062685; x=1712667485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFx6hP8hvOPeUdfct+YUNkXorKxd3sUiyEh1lx2j5Y0=;
        b=f0xwaJ3v74A7f887w6JazJTx2qnAKWjrvMEFrgNIzd0zR46OpINQUUQnmwtkL+Qsge
         h9yXIU+61M2FPOAVDnCFK1AOesUV0szXajUnft1liuM1KbZa8uVFFD/gsA/mn3pXjZFQ
         nhAW7NeXvlSFi1oVmelMtG4b0JvL2xacCD4CG/5HGSRI0F36MpoBcUfzYhgbizhCmy1s
         zZZ84ax7yrR/DBHtrbJSTv/fcWuLkG0zrWzqCq3RgIqw7/Sp/aTa0sdSlwjWJ7Uo6eGe
         m3VzdY55pcC0V/FghB2duqyZ/4a7ULGlHL/8uUXDISeTsKC5q/i6OKxQk3RU7nXN6+b6
         c7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062685; x=1712667485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFx6hP8hvOPeUdfct+YUNkXorKxd3sUiyEh1lx2j5Y0=;
        b=lLAysOJVxihGOj5i1f4xDR1PqZoj9ZMhc2TgqMfueBFnbKurrvwxk596DRKR0useQg
         +QfIxNfUd6JAXeDsjJtJwLt3+qtgCyT007t6TeYjqtz9/ELeIbnL4iau1edAJIi8Ofgb
         Yf2Ya1DxpBkGjE4jb9nLrP/DEKQZrkLF6PuDxre0EUFVX1FCdoqJC5kVnRiNkXJs0ojA
         wGIkiR/y8XT7phM7N8nD/YCcanjWDfSr+9Isi2yZT0ZO+luQPlf23vfboOsSefBU7iGH
         skxLIX82GqP3boiOvmeGjtEnzBKOAbq2VtACgofW+WAGHAIkwPLdNAa8vH4FX9JYRRVb
         JveA==
X-Forwarded-Encrypted: i=1; AJvYcCUoPVvfkzYyQXMCBdM1ZiDda71QQt2NsuoK/+YLy88w5K8HjEloA3xlyltECRiQJ8BAMvIbHdOlCkWVlISRg5UEQ/xqyIfhcTHn6czf
X-Gm-Message-State: AOJu0Yx9aXERYL/qmrx5Qdy3vyu6IiJenbeJ4WHsInNG5+BjfG7xc+jn
	eKeR8BCD7U4rNX0VqEgFrntw+wlVQRFhc8p8Th90tZEn1gfBF5rSrJz/pox3k3Q=
X-Google-Smtp-Source: AGHT+IHWR0hLdOL78yMVv8MFgfNCo7t7ygA9mH2c/bUuGc7SlEtcmgj1HbUwD+5oLppZJcBjJKZHDQ==
X-Received: by 2002:a05:6512:2815:b0:515:d198:694d with SMTP id cf21-20020a056512281500b00515d198694dmr10154546lfb.26.1712062684514;
        Tue, 02 Apr 2024 05:58:04 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c500700b00415870e1e88sm2728986wmr.29.2024.04.02.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:58:04 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:58:02 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: liu.yec@h3c.com
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, dianders@chromium.org,
	jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH V7] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240402125802.GC25200@aspen.lan>
References: <2024032630-croon-consuming-6ef9@gregkh>
 <20240326085407.1970686-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326085407.1970686-1-liu.yec@h3c.com>

On Tue, Mar 26, 2024 at 04:54:07PM +0800, liu.yec@h3c.com wrote:
> From: LiuYe <liu.yeC@h3c.com>
>
> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
> attempt to use schedule_work() to provoke a keyboard reset when
> transitioning out of the debugger and back to normal operation.
> This can cause deadlock because schedule_work() is not NMI-safe.
>
> The stack trace below shows an example of the problem. In this
> case the master cpu is not running from NMI but it has parked
> the slave CPUs using an NMI and the parked CPUs is holding
> spinlocks needed by schedule_work().
>
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
> We fix the problem by using irq_work to call schedule_work()
> instead of calling it directly. irq_work is an NMI-safe deferred work
> framework that performs the requested work from a hardirq context
> (usually an IPI but it can be timer interrupt on some
> architectures).
>
> Note that we still need to a workqueue since we cannot resync
> the keyboard state from the hardirq context provided by irq_work.
> That must be done from task context for the calls into the input
> subystem. Hence we must defer the work twice. First to safely
> switch from the debug trap (NMI-like context) to hardirq and
> then, secondly, to get from hardirq to the system workqueue.
>
> Signed-off-by: LiuYe <liu.yeC@h3c.com>
> Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> ---
> V6 -> V7: Add comments in the code.
> V5 -> V6: Replace with a more professional and accurate answer.
> V4 -> V5: Answer why schedule another work in the irq_work and not do the job directly.
> V3 -> V4: Add changelogs
> V2 -> V3: Add description information
> V1 -> V2: using irq_work to solve this properly.
> ---
> ---
>  drivers/tty/serial/kgdboc.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb164..750ed66d2 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> +#include <linux/irq_work.h>
>
>  #define MAX_CONFIG_LEN		40
>
> @@ -98,11 +99,29 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
>  }
>
>  static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
> +/*
> + * We fix the problem by using irq_work to call schedule_work()
> + * instead of calling it directly.

What problem?

Put another way this text has been copy-pasted from
the commit message without any editing to make it make sense. Text in
the C file needs to be standalone!

More like:
--- cut here ---
This code ensures that the keyboard state, which is changed during kdb
execution, is resynchronized when we leave the debug trap. The resync
logic calls into the input subsystem to force a reset. The calls into
the input subsystem must be executed from normal task context.

We need to trigger the resync from the debug trap, which executes in an
NMI (or similar) context. To make it safe to call into the input
subsystem we end up having use two deferred execution techniques.
Firstly, we use irq_work, which is NMI-safe, to provoke a callback from
hardirq context. Then, from the hardirq callback we use the system
workqueue to provoke the callback that actually performs the resync.
--- cut here ---

>                                     irq_work is an NMI-safe deferred work
> + * framework that performs the requested work from a hardirq context
> + * (usually an IPI but it can be timer interrupt on some
> + * architectures). Note that we still need to a workqueue since we cannot resync
> + * the keyboard state from the hardirq context provided by irq_work.
> + * That must be done from task context for the calls into the input
> + * subystem. Hence we must defer the work twice. First to safely
> + * switch from the debug trap (NMI-like context) to hardirq and
> + * then, secondly, to get from hardirq to the system workqueue.
> + */

Please find a better place to anchor the comment. It should be further
up in the file when the first bit of deferred work appears, perhaps near
kgdboc_restore_input_helper().


> +static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
> +{
> +	schedule_work(&kgdboc_restore_input_work);
> +}
> +
> +static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);


Daniel.

