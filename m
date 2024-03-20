Return-Path: <linux-kernel+bounces-109166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C938815A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280BB281194
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B022B54FAD;
	Wed, 20 Mar 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+jJayUs"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273F4E1D5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952088; cv=none; b=I9Tduems/0tWqgNfMS1PsbvRDY3rtoNAEVXqIYJOuWQ+gjdSrfogyHoVDG3tSYIGBcurIvh4fYqyFZxcp5/X/oda5r270HEUC0QHa+UgIvcZwmRBRhIFhLIqNSL6dgPf910ba0g8OuYDPprFlceV5P0m4pLgAAHQ/MYMVeLxGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952088; c=relaxed/simple;
	bh=yTzaE6ut/W8ahZ+/Mz5Xw5xcnS3KSBlLVAjk9v6eLtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAUP8vy+uEK8mE2OEfTSBjOwYEpls+DBbo7NAElyNbsEo5Ie48IL7v3K48Hl+kUbsWBlbjB4FacrD1IHkmquC9nVMwyDlRE+JX1U7+wKBe1upEjYiEvpaHHzaB0hZklNwv/h9Mc23f6Q8kAOVl7LRV1ruOtxgYCZqheIsYpFzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+jJayUs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso2506836f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710952085; x=1711556885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=msB9F7QOeQwvM5EEEp7pk58WHiFSBilQq0veDXMN8ik=;
        b=v+jJayUsCzfwwMNnWVBxrApMS2WwY53jUPISYEktrNJDMCU6gd1iABKITYnhfdefxN
         /WOvZH8I9VGeY7H7VO3VqTh28XJz1/257EriFlH6geHpuNCPhwrSwfk9Er0iTjxCX0Ua
         bNrVIORCxTnmIvhWd1YGe1oX1Uz/3b/Frl6CYqRrSkMM4PvzWVekSFyUWJSfOfK0aP4P
         GlL2PrG91liyPm2vERxHgnZyyNOj01GpA0UnHgtPz4ZLb5FxcfAnIjO1sf90HsFYktXn
         0ZlwITZJrJlhTSvk8rc+yBKx/aMUWx4l4VtpvMRO/gXMZNBkun6grk2AU7JT6WajrAQ3
         iHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952085; x=1711556885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msB9F7QOeQwvM5EEEp7pk58WHiFSBilQq0veDXMN8ik=;
        b=Rx4U/NYNC0BRuCzSdGqFk+Oq57eFeVy4Y0iVn4wwtz9srYggDNARWlKgkHHQ95amKy
         sVwXF1AFd//InW5MZMXnG3NGfIMoAIJI9HYg19PdAdqYSB7bjLLom4dE/Rv5gAfh817p
         5q7s1FREe3/31eDFdaA+N4/k1knvzdoaLnePtvIr7dX4HYBSEnkSrcOeDfzPvS81Z2oB
         Lheq3XMVKKcSeJflrKMLvgGGmT6Tf7Y3lYcwX2aHh3r6grDO4vMaBe/kdhO/BCFO9r90
         L7KIVqlQSMdeIhMIGKyNSvQDhPGTu/l7+y8EWBfzRRXAQTrtd8pDkdbWF4FdbLRBxGch
         mfbg==
X-Forwarded-Encrypted: i=1; AJvYcCXuwbP0SaOd7IQgkSrvL5GqakamqCO4yvYeTWmj55BR7oraZ2g2TRCKCERwjCTDruo8BgVkTIJlyp3GwiIl6dA4cThwgrWqrE1lOcgu
X-Gm-Message-State: AOJu0Yzw1I6XX2hfQPqnCGyVMWlztvquzZndFPm6kD1VbO7AkONc0hp9
	KtEJM87XxiYdBhT1IosdcKx4G+nqFrtyClVY36XjxUBgIwdSrxndBz38Obfj838=
X-Google-Smtp-Source: AGHT+IHstSVEPL+xvtOXSxEs1vKRqfJRf0BWqW/KLyPo8TIErjY7+CyoRIq2xlo5N0rNxiR2Se/3NA==
X-Received: by 2002:a5d:64ab:0:b0:33e:781e:da57 with SMTP id m11-20020a5d64ab000000b0033e781eda57mr1983079wrp.53.1710952084670;
        Wed, 20 Mar 2024 09:28:04 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m10-20020adffe4a000000b0033de10c9efcsm14961571wrs.114.2024.03.20.09.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:28:04 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:28:02 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: liu.yec@h3c.com
Cc: dianders@chromium.org, gregkh@linuxfoundation.org,
	jason.wessel@windriver.com, jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <20240320162802.GA22198@aspen.lan>
References: <20240314130916.GE202685@aspen.lan>
 <20240316023443.101169-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316023443.101169-1-liu.yec@h3c.com>

^^^ This is v2 isn't it?

On Sat, Mar 16, 2024 at 10:34:43AM +0800, liu.yec@h3c.com wrote:
> From: LiuYe <liu.yeC@h3c.com>
>
> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
>   attempt to use schedule_work() to provoke a keyboard reset when transitioning out

Please format the description correctly.


> of the debugger and back to normal operation. This can cause
> deadlock because schedule_work() is not NMI-safe.

Wasn't there another paragraph to go here?

: The stack trace below shows an example of the problem. In this
: case the master cpu is not running from NMI but it has parked
: the slave CPUs using an NMI and the parked CPUs is holding
: spinlocks needed by schedule_work().


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
> Suggested-by: daniel.thompson@linaro.org

Thanks for the credit but I think the following is probably a better way
to express it:

Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

