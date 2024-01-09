Return-Path: <linux-kernel+bounces-21526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C08290C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71E11F27A09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFBD3E47A;
	Tue,  9 Jan 2024 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiCe4Lvt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4713E46E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704842364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHVmMNIg/DVwx+LrG/fqarxhc21tkCGhrWRbquNsn9U=;
	b=eiCe4Lvt82zCtqZz0FhAdn0ukMoFW2pJAqc6IWNLKNepM5yE5pCWM8tRU0cZiFNWnefZTx
	XU8Y9IhuMVlOJv8zcao1IWRvvsz4mSePjqEuhMy6fMMP1jt69PWg3ovZAR+SYjcdGrVMtP
	00HnlM6fYHw9y7cW6cDzeDZjx5sOucw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-O3gI1sEPPhqnhWkueODNtA-1; Tue, 09 Jan 2024 18:19:23 -0500
X-MC-Unique: O3gI1sEPPhqnhWkueODNtA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e41740b6eso30237815e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704842362; x=1705447162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHVmMNIg/DVwx+LrG/fqarxhc21tkCGhrWRbquNsn9U=;
        b=XRs20ngVfZQOzkUhzw3i3aoyxJITsB74qkjZ4XnK34aa/QlfpZ8xj2AfQtkfkFHTnZ
         kbYPi+luArQl0oxnaLA7l+8forsqSk3YU2kP5g6HEKTFui+AdzfWcLJEoH7Qv9vKVvJ9
         w0KF1/MoJQsjGZiPjbVHXOF+wzB7kuOeNCE3XCSq0ORKRGer5/cY7vRXfQrF7evE/m3x
         upyN5M7zE3cEdvZVcgTMJ/RXI2IDwaeSpr3HUAEBSbh6BA8tovtbnH/gvSNtvDO2v/PO
         3GlJ6tldfOZZJGqgwsaCqLnrpRVqN6gKDYcm8+4HuLTrOseZXPWe48KH9Pmf0TqvqBOd
         yEKg==
X-Gm-Message-State: AOJu0YyQWfG79Y03r75WMkBmJ5RhFWc4VDh9+SBiVk8U0QzIqtwOz9t5
	mUiq/X7x0zZFXBByykRBv/WIH85yUUMFh7E18iWsSTIJ6jp6wHSEgKvChTK3kmiz4/tZ0BtsXHv
	FEsBwzkCCFwpHeF5DiDNVtgZPE2qvUuL3
X-Received: by 2002:a05:600c:a4c:b0:40e:545b:80e6 with SMTP id c12-20020a05600c0a4c00b0040e545b80e6mr30951wmq.158.1704842361813;
        Tue, 09 Jan 2024 15:19:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHar4XTexIgvBATKUPtUP4fvkCodLwjEIqa21khgBEAmJpVpxCFabBi/+JKYxxEDSZ4iCKRvA==
X-Received: by 2002:a05:600c:a4c:b0:40e:545b:80e6 with SMTP id c12-20020a05600c0a4c00b0040e545b80e6mr30947wmq.158.1704842361435;
        Tue, 09 Jan 2024 15:19:21 -0800 (PST)
Received: from redhat.com ([2.52.133.193])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05600c3d8600b0040e3960f46asm76614wmb.14.2024.01.09.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:19:20 -0800 (PST)
Date: Tue, 9 Jan 2024 18:19:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Cc: Theodore Ts'o <tytso@mit.edu>, David Hildenbrand <david@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: lockdep warning triggered by 15b9ce7ecd:
 virtio_balloon: stay awake while adjusting balloon
Message-ID: <20240109181620-mutt-send-email-mst@kernel.org>
References: <20240108215015.GA599905@mit.edu>
 <CAD=HUj4dVm_5yTJG_Ly28-x9mCM5zxg8gb7EGz6ZUoDqV8StsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=HUj4dVm_5yTJG_Ly28-x9mCM5zxg8gb7EGz6ZUoDqV8StsA@mail.gmail.com>

On Tue, Jan 09, 2024 at 02:50:20PM +0900, David Stevens wrote:
> On Tue, Jan 9, 2024 at 6:50 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Hi, while doing final testing before sending a pull request, I merged
> > in linux-next, and commit 5b9ce7ecd7: virtio_balloon: stay awake while
> > adjusting balloon seems to be causing a lockdep warning (see attached)
> > when running gce-xfstests on a Google Compute Engine e2 VM.  I was not
> > able to trigger it using kvm-xfstests, but the following command:
> > "gce-xfstests -C 10 ext4/4k generic/476) was sufficient to triger the
> > problem.   For more information please see [1] and [2].
> >
> > [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
> > [2] https://thunk.org/gce-xfstests
> >
> > I found it by looking at the git logs, and this commit aroused my
> > suspicions, and I further testing showed that the lockdep warning was
> > reproducible with this commit, but not when testing with the
> > immediately preceeding commit (15b9ce7ecd^).
> >
> > Cheers,
> >
> >                                                 - Ted
> >
> >
> > root: ext4/4k run xfstest generic/476
> > systemd[1]: Started fstests-generic-476.scope - /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/476.
> > kernel: [  399.361181] EXT4-fs (dm-1): mounted filesystem 840e25bd-f650-4819-8562-7eded85ef370 r/w with ordered data mode. Quota mode: none.
> > systemd[1]: fstests-generic-476.scope: Deactivated successfully.
> > systemd[1]: fstests-generic-476.scope: Consumed 3min 1.966s CPU time.
> > systemd[1]: xt\x2dvdb.mount: Deactivated successfully.
> > kernel: [  537.085404] EXT4-fs (dm-0): unmounting filesystem d3d7a675-f7b6-4384-abec-2e60d885b6da.
> > systemd[1]: xt\x2dvdc.mount: Deactivated successfully.
> > kernel: [  540.565870]
> > kernel: [  540.567523] ================================
> > kernel: [  540.572007] WARNING: inconsistent lock state
> > kernel: [  540.576407] 6.7.0-rc3-xfstests-lockdep-00012-g5b9ce7ecd715 #318 Not tainted
> > kernel: [  540.583532] --------------------------------
> > kernel: [  540.587928] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > kernel: [  540.594326] kworker/0:3/329 [HC0[0]:SC0[0]:HE1:SE1] takes:
> > kernel: [  540.599955] ffff90b280a548c0 (&vb->adjustment_lock){?...}-{2:2}, at: update_balloon_size_func+0x33/0x190
> > kernel: [  540.609926] {IN-HARDIRQ-W} state was registered at:
> > kernel: [  540.614935]   __lock_acquire+0x3f2/0xb30
> > kernel: [  540.618992]   lock_acquire+0xbf/0x2b0
> > kernel: [  540.622786]   _raw_spin_lock_irqsave+0x43/0x90
> > kernel: [  540.627366]   virtballoon_changed+0x51/0xd0
> > kernel: [  540.631947]   virtio_config_changed+0x5a/0x70
> > kernel: [  540.636437]   vp_config_changed+0x11/0x20
> > kernel: [  540.640576]   __handle_irq_event_percpu+0x88/0x230
> > kernel: [  540.645500]   handle_irq_event+0x38/0x80
> > kernel: [  540.649558]   handle_edge_irq+0x8f/0x1f0
> > kernel: [  540.653791]   __common_interrupt+0x47/0xf0
> > kernel: [  540.658106]   common_interrupt+0x79/0xa0
> > kernel: [  540.661672] EXT4-fs (dm-1): unmounting filesystem 840e25bd-f650-4819-8562-7eded85ef370.
> > kernel: [  540.663183]   asm_common_interrupt+0x26/0x40
> > kernel: [  540.663190]   acpi_safe_halt+0x1b/0x30
> > kernel: [  540.663196]   acpi_idle_enter+0x7b/0xd0
> > kernel: [  540.663199]   cpuidle_enter_state+0x90/0x4f0
> > kernel: [  540.688723]   cpuidle_enter+0x2d/0x40
> > kernel: [  540.692516]   cpuidle_idle_call+0xe4/0x120
> > kernel: [  540.697036]   do_idle+0x84/0xd0
> > kernel: [  540.700393]   cpu_startup_entry+0x2a/0x30
> > kernel: [  540.704588]   rest_init+0xe9/0x180
> > kernel: [  540.708118]   arch_call_rest_init+0xe/0x30
> > kernel: [  540.712426]   start_kernel+0x41c/0x4b0
> > kernel: [  540.716310]   x86_64_start_reservations+0x18/0x30
> > kernel: [  540.721164]   x86_64_start_kernel+0x8c/0x90
> > kernel: [  540.725737]   secondary_startup_64_no_verify+0x178/0x17b
> > kernel: [  540.731432] irq event stamp: 22681
> > kernel: [  540.734956] hardirqs last  enabled at (22681): [<ffffffff8b4b5158>] _raw_spin_unlock_irq+0x28/0x50
> > kernel: [  540.744564] hardirqs last disabled at (22680): [<ffffffff8b4b4ded>] _raw_spin_lock_irq+0x5d/0x90
> > kernel: [  540.753475] softirqs last  enabled at (22076): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
> > kernel: [  540.762904] softirqs last disabled at (22072): [<ffffffff8a58cfa1>] srcu_invoke_callbacks+0x101/0x1c0
> > kernel: [  540.773298]
> > kernel: [  540.773298] other info that might help us debug this:
> > kernel: [  540.780207]  Possible unsafe locking scenario:
> > kernel: [  540.780207]
> > kernel: [  540.786438]        CPU0
> > kernel: [  540.789007]        ----
> > kernel: [  540.791766]   lock(&vb->adjustment_lock);
> > kernel: [  540.796014]   <Interrupt>
> > kernel: [  540.798778]     lock(&vb->adjustment_lock);
> > kernel: [  540.803605]
> 
> Oh, that's embarrassing, I completely whiffed on interactions with
> interrupts. The following patch fixes it, and I've locally repro'ed
> the issue and verified the fix. What's the process for getting this
> fix merged? Does it get merged as a seperatch patch, or squashed into
> the original commit?
> 
> >From a99a1efa6a2b470a98ea2c87e58bebe90ce329a1 Mon Sep 17 00:00:00 2001
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
>  drivers/virtio/virtio_balloon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index aa6a1a649ad6..1f5b3dd31fcf 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -459,12 +459,12 @@ static void start_update_balloon_size(struct
> virtio_balloon *vb)
> 
>  static void end_update_balloon_size(struct virtio_balloon *vb)
>  {
> -       spin_lock(&vb->adjustment_lock);
> +       spin_lock_irq(&vb->adjustment_lock);
>         if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
>                 vb->adjustment_in_progress = false;
>                 pm_relax(vb->vdev->dev.parent);
>         }
> -       spin_unlock(&vb->adjustment_lock);
> +       spin_unlock_irq(&vb->adjustment_lock);
>  }
> 
>  static void virtballoon_changed(struct virtio_device *vdev)
> @@ -506,9 +506,9 @@ static void update_balloon_size_func(struct
> work_struct *work)
>         vb = container_of(work, struct virtio_balloon,
>                           update_balloon_size_work);
> 
> -       spin_lock(&vb->adjustment_lock);
> +       spin_lock_irq(&vb->adjustment_lock);
>         vb->adjustment_signal_pending = false;
> -       spin_unlock(&vb->adjustment_lock);
> +       spin_unlock_irq(&vb->adjustment_lock);
> 
>         diff = towards_target(vb);


Your patch is damaged (lines wrapped, sha info is wrong). Please post a
new version of the original one I will replace it with the new one.

-- 
MST


