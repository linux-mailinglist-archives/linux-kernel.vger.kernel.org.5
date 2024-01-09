Return-Path: <linux-kernel+bounces-20823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835828285B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC022870DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09997374E9;
	Tue,  9 Jan 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/v6bSmW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C4125A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704801857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X16qIqVOF8g1fUqkHEl3n+iD5dBuN0/dflLEFP0Dxw4=;
	b=V/v6bSmW0oj4tHoaK6nw4E1LGLKv7ibSLt5c9QfAZQs+UMBWFDzN3cuNvVAsGxtynUCWPR
	dmYPJ/Lsf+XVmHuGteS1oW7LmxgDP56euAhqf+MewJpPZ+Bn5EaMqI5/F15zsVl9Jor3bd
	SCfF6Nvww+VUcXYGKtiM0XIN8pZJo1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-u5b0IWuTM1GFMVMUEYx-5g-1; Tue, 09 Jan 2024 07:04:09 -0500
X-MC-Unique: u5b0IWuTM1GFMVMUEYx-5g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4b09aba2so9310845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801848; x=1705406648;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X16qIqVOF8g1fUqkHEl3n+iD5dBuN0/dflLEFP0Dxw4=;
        b=vSabO8U24TCU53ivb1jdzOSlmoYUDawnwi09aefpiebU3RmHMMEHz6LXTt3dYGuTix
         kTh67h1Ddb2I5MBVq8JgYOoLPzhDl7q71pz04xoEViVIEP050wWA7u0vFI9tmm8snEsF
         p1hllg/RHFKJe6+1fjqBwLJzRe6LLcC3d8bEhpwangbX7Md5mfNRYZoG0xFyR0z5JyZJ
         aGF6J3Jxsw2iIN9VYFTKpCb1rVLWIsxyQsFi93Tae8QNoGLiyUF7KSmfkbBex7YPhSBw
         ATDDVM+YUZtYgF6lu5OHIJPiEdfk9BT/qOKzBFklO3qHacGkBg++ZjenCfkWqj4LLyE3
         sjlA==
X-Gm-Message-State: AOJu0YzFEF2hjR/qPb4kQubcCVnY7u0uMdIarSdvXCSLXFyWCDGouVjB
	/XjtDBfSjk5K4CQclev6D2nhcP6A9aw69mXSnEpKb9S7rsiB5WowEWQlX/zs3gC1vjNHfSMaSss
	7iENJ0VuwMQ83wSf6Rx6lyxDPtsrBu8Ee
X-Received: by 2002:a05:600c:3144:b0:40e:4156:6182 with SMTP id h4-20020a05600c314400b0040e41566182mr2629560wmo.34.1704801848670;
        Tue, 09 Jan 2024 04:04:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI0fFOextLeJo5edIxzFrQjmpLd5/dEE7vsvxPaflMKIOS1FvK8Ixzy9h2LEmyUyirYgHrdg==
X-Received: by 2002:a05:600c:3144:b0:40e:4156:6182 with SMTP id h4-20020a05600c314400b0040e41566182mr2629547wmo.34.1704801848238;
        Tue, 09 Jan 2024 04:04:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:9800:9ff6:a15:cd3e:2d4? (p200300cbc73598009ff60a15cd3e02d4.dip0.t-ipconnect.de. [2003:cb:c735:9800:9ff6:a15:cd3e:2d4])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b0040d91930f93sm3297483wmq.11.2024.01.09.04.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 04:04:07 -0800 (PST)
Message-ID: <9eb1edde-fedc-4859-a7ca-bc8d3b968737@redhat.com>
Date: Tue, 9 Jan 2024 13:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION: lockdep warning triggered by 15b9ce7ecd:
 virtio_balloon: stay awake while adjusting balloon
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>, Theodore Ts'o <tytso@mit.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240108215015.GA599905@mit.edu>
 <CAD=HUj4dVm_5yTJG_Ly28-x9mCM5zxg8gb7EGz6ZUoDqV8StsA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAD=HUj4dVm_5yTJG_Ly28-x9mCM5zxg8gb7EGz6ZUoDqV8StsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.01.24 06:50, David Stevens wrote:
> On Tue, Jan 9, 2024 at 6:50 AM Theodore Ts'o <tytso@mit.edu> wrote:
>>
>> Hi, while doing final testing before sending a pull request, I merged
>> in linux-next, and commit 5b9ce7ecd7: virtio_balloon: stay awake while
>> adjusting balloon seems to be causing a lockdep warning (see attached)
>> when running gce-xfstests on a Google Compute Engine e2 VM.  I was not
>> able to trigger it using kvm-xfstests, but the following command:
>> "gce-xfstests -C 10 ext4/4k generic/476) was sufficient to triger the
>> problem.   For more information please see [1] and [2].
>>
>> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
>> [2] https://thunk.org/gce-xfstests
>>
>> I found it by looking at the git logs, and this commit aroused my
>> suspicions, and I further testing showed that the lockdep warning was
>> reproducible with this commit, but not when testing with the
>> immediately preceeding commit (15b9ce7ecd^).
>>
>> Cheers,
>>
>>                                                  - Ted
>>
>>
>> root: ext4/4k run xfstest generic/476
>> systemd[1]: Started fstests-generic-476.scope - /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/476.
>> kernel: [  399.361181] EXT4-fs (dm-1): mounted filesystem 840e25bd-f650-4819-8562-7eded85ef370 r/w with ordered data mode. Quota mode: none.
>> systemd[1]: fstests-generic-476.scope: Deactivated successfully.
>> systemd[1]: fstests-generic-476.scope: Consumed 3min 1.966s CPU time.
>> systemd[1]: xt\x2dvdb.mount: Deactivated successfully.
>> kernel: [  537.085404] EXT4-fs (dm-0): unmounting filesystem d3d7a675-f7b6-4384-abec-2e60d885b6da.
>> systemd[1]: xt\x2dvdc.mount: Deactivated successfully.
>> kernel: [  540.565870]
>> kernel: [  540.567523] ================================
>> kernel: [  540.572007] WARNING: inconsistent lock state
>> kernel: [  540.576407] 6.7.0-rc3-xfstests-lockdep-00012-g5b9ce7ecd715 #318 Not tainted
>> kernel: [  540.583532] --------------------------------
>> kernel: [  540.587928] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>> kernel: [  540.594326] kworker/0:3/329 [HC0[0]:SC0[0]:HE1:SE1] takes:
>> kernel: [  540.599955] ffff90b280a548c0 (&vb->adjustment_lock){?...}-{2:2}, at: update_balloon_size_func+0x33/0x190
>> kernel: [  540.609926] {IN-HARDIRQ-W} state was registered at:
>> kernel: [  540.614935]   __lock_acquire+0x3f2/0xb30
>> kernel: [  540.618992]   lock_acquire+0xbf/0x2b0
>> kernel: [  540.622786]   _raw_spin_lock_irqsave+0x43/0x90
>> kernel: [  540.627366]   virtballoon_changed+0x51/0xd0
>> kernel: [  540.631947]   virtio_config_changed+0x5a/0x70
>> kernel: [  540.636437]   vp_config_changed+0x11/0x20
>> kernel: [  540.640576]   __handle_irq_event_percpu+0x88/0x230
>> kernel: [  540.645500]   handle_irq_event+0x38/0x80
>> kernel: [  540.649558]   handle_edge_irq+0x8f/0x1f0
>> kernel: [  540.653791]   __common_interrupt+0x47/0xf0
>> kernel: [  540.658106]   common_interrupt+0x79/0xa0
>> kernel: [  540.661672] EXT4-fs (dm-1): unmounting filesystem 840e25bd-f650-4819-8562-7eded85ef370.
>> kernel: [  540.663183]   asm_common_interrupt+0x26/0x40
>> kernel: [  540.663190]   acpi_safe_halt+0x1b/0x30
>> kernel: [  540.663196]   acpi_idle_enter+0x7b/0xd0
>> kernel: [  540.663199]   cpuidle_enter_state+0x90/0x4f0
>> kernel: [  540.688723]   cpuidle_enter+0x2d/0x40
>> kernel: [  540.692516]   cpuidle_idle_call+0xe4/0x120
>> kernel: [  540.697036]   do_idle+0x84/0xd0
>> kernel: [  540.700393]   cpu_startup_entry+0x2a/0x30
>> kernel: [  540.704588]   rest_init+0xe9/0x180
>> kernel: [  540.708118]   arch_call_rest_init+0xe/0x30
>> kernel: [  540.712426]   start_kernel+0x41c/0x4b0
>> kernel: [  540.716310]   x86_64_start_reservations+0x18/0x30
>> kernel: [  540.721164]   x86_64_start_kernel+0x8c/0x90
>> kernel: [  540.725737]   secondary_startup_64_no_verify+0x178/0x17b
>> kernel: [  540.731432] irq event stamp: 22681
>> kernel: [  540.734956] hardirqs last  enabled at (22681): [<ffffffff8b4b5158>] _raw_spin_unlock_irq+0x28/0x50
>> kernel: [  540.744564] hardirqs last disabled at (22680): [<ffffffff8b4b4ded>] _raw_spin_lock_irq+0x5d/0x90
>> kernel: [  540.753475] softirqs last  enabled at (22076): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
>> kernel: [  540.762904] softirqs last disabled at (22072): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
>> kernel: [  540.773298]
>> kernel: [  540.773298] other info that might help us debug this:
>> kernel: [  540.780207]  Possible unsafe locking scenario:
>> kernel: [  540.780207]
>> kernel: [  540.786438]        CPU0
>> kernel: [  540.789007]        ----
>> kernel: [  540.791766]   lock(&vb->adjustment_lock);
>> kernel: [  540.796014]   <Interrupt>
>> kernel: [  540.798778]     lock(&vb->adjustment_lock);
>> kernel: [  540.803605]
> 
> Oh, that's embarrassing, I completely whiffed on interactions with
> interrupts. The following patch fixes it, and I've locally repro'ed
> the issue and verified the fix. What's the process for getting this
> fix merged? Does it get merged as a seperatch patch, or squashed into
> the original commit?

Depends on who queued it. Likely MST, so it can be squashed.

If it would be sitting in Andrews stable trees, we wouldn't be able to 
squash it anymore.

> 
>  From a99a1efa6a2b470a98ea2c87e58bebe90ce329a1 Mon Sep 17 00:00:00 2001
> From: David Stevens <stevensd@chromium.org>
> Date: Tue, 9 Jan 2024 14:41:21 +0900
> Subject: [PATCH] virtio_balloon: Fix interrupt context deadlock
> 
> Use _irq spinlock functions with the adjustment_lock, since
> start_update_balloon_size needs to acquire it in an interrupt context.
> 
> Fixes: 5b9ce7ecd715 ("virtio_balloon: stay awake while adjusting balloon")
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/virtio/virtio_balloon.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index aa6a1a649ad6..1f5b3dd31fcf 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -459,12 +459,12 @@ static void start_update_balloon_size(struct
> virtio_balloon *vb)
> 
>   static void end_update_balloon_size(struct virtio_balloon *vb)
>   {
> -       spin_lock(&vb->adjustment_lock);
> +       spin_lock_irq(&vb->adjustment_lock);
>          if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
>                  vb->adjustment_in_progress = false;
>                  pm_relax(vb->vdev->dev.parent);
>          }
> -       spin_unlock(&vb->adjustment_lock);
> +       spin_unlock_irq(&vb->adjustment_lock);
>   }
> 
>   static void virtballoon_changed(struct virtio_device *vdev)
> @@ -506,9 +506,9 @@ static void update_balloon_size_func(struct
> work_struct *work)
>          vb = container_of(work, struct virtio_balloon,
>                            update_balloon_size_work);
> 
> -       spin_lock(&vb->adjustment_lock);
> +       spin_lock_irq(&vb->adjustment_lock);
>          vb->adjustment_signal_pending = false;
> -       spin_unlock(&vb->adjustment_lock);
> +       spin_unlock_irq(&vb->adjustment_lock);
> 
>          diff = towards_target(vb);
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


