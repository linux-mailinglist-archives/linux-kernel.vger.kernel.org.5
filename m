Return-Path: <linux-kernel+bounces-104301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521987CBDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69947283FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E21B5BF;
	Fri, 15 Mar 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYpFVgkG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BE1B59C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500753; cv=none; b=KByRu8yh5oxonNLP6NNeYfh914vxNgWPUfd9ywkAgwfALJw28Eje6JjheAj2bqaRXxEuld3MEwGUtk+h6wu2kQ3baIduhg8RiPk1V+w1ASIHwXHM3IGHlWiKsz/ZguNB6nwDyXSY+gYEUHcIDyUCIAmAyuoU6WV6K/84ER4gWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500753; c=relaxed/simple;
	bh=8k4NQwu1Jdbju7vD2sndm59Pb5e0t5wPrbFD4kGRYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApsO7NhCw6kL3ltBq3BY1C62YQ3iOgs9zuTMvdxZLn0QYnFW1OFcC1nHIUA7MUEx8vqt0gIgw25AnQvnn1/2zUoABXRrsNoeMR5j51sn1MQfGJVcliuYt7HsvkDFpEZNPYkXooYCsfLcXKdU7SvdcnMblI5Ej6FobhZ0+Z5780g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYpFVgkG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710500750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdfafXqzrRsn1FKJ9mMXQOdYgIbReKWF7CkpfLXCneQ=;
	b=EYpFVgkGo6OCRdWvpV0HexamDm7d7kocZZozrHXpbM40cxIXmwIef2WgN2iY53reIsFBrT
	kMP82FRHOK7t9R1hLAcIF74Hp8I9XFwR655fl7HzDPu56B0zeh5ymKjL36OiScgT39EXY3
	k9Pqpk+5nepqxrgnwSeQ97zPUunVss0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-eKgONUnePxG4s8uacQEpDQ-1; Fri, 15 Mar 2024 07:05:49 -0400
X-MC-Unique: eKgONUnePxG4s8uacQEpDQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e91f9d422so2236824e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710500747; x=1711105547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdfafXqzrRsn1FKJ9mMXQOdYgIbReKWF7CkpfLXCneQ=;
        b=AskcXJxiDCnDiTDCpgXLpu+ZP86EMszxtsKubXGFEzYABHQHdSzUFn7rb1cVSc093U
         9ZomNyoBauHC5SoQHG/TmyD1Wfv5U92VQH3dSosmdWSrYxSuZllil13JTG3U7Ar4GTzQ
         IbrY8KwCfw2Hye4CFtkqtXtNSLwHGmc2pEip7yZV6lMh4RdmPbwiY1aYjf81mgZpx3e7
         4Ns9IOOsFqhrHUvn8m0ocsM72FqPBZgUY/QgDhiEW5Xnjrz4H+4zKPgunkW5M2peQVbP
         9CY5NvjxlQpkDiKYjcMwAv/RCztiJ1xkPW/NBsSwlne8/OfmNn+S4Yyfg9B5wUtOYAXM
         exZg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Gqnlfia+nyafCz9Klig5eEcCNLoPNR6n6ef28j9IjxoOklGhLgW9KrsBj/YWJPXtwnXiHSLGwuPK01X/Kz/QT7f9WuJStblsuGEi
X-Gm-Message-State: AOJu0Yzpp+UpEjMnhb7sD4EBVL4Wz+aJOVH0boecl+cGKB+1yiClTq/M
	CW3j/xgYATew/b+tJrJFA0U+aiV80Xov0fS3ltRx3AtEXyLvhdfVFUqVedqqL8Zf4QXPT3L201b
	W7qUL3OKIdeUyKrh7Ppp/PlEcq25C8aLZMRrv7CnVsc8JGjF9/QnARySzE7xsXPpZs9G9hA==
X-Received: by 2002:a19:7714:0:b0:513:c876:c80a with SMTP id s20-20020a197714000000b00513c876c80amr1911293lfc.34.1710500747155;
        Fri, 15 Mar 2024 04:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFWsJRQk7XHJYjmEtkvbECHs2DVGjqRdHb0RkhCRTIwgfm0hPrrLC2QkCTOQ40AcppCWI6vg==
X-Received: by 2002:a19:7714:0:b0:513:c876:c80a with SMTP id s20-20020a197714000000b00513c876c80amr1911268lfc.34.1710500746572;
        Fri, 15 Mar 2024 04:05:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:3a04:e2ee:42e3:ba74:3b8e])
        by smtp.gmail.com with ESMTPSA id z13-20020a05600c0a0d00b0041402a27c4asm1121766wmp.25.2024.03.15.04.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:05:45 -0700 (PDT)
Date: Fri, 15 Mar 2024 07:05:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240315065318-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
 <20240314085630-mutt-send-email-mst@kernel.org>
 <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63002c24-8117-458f-84c7-fa4f7acd8cc6@redhat.com>

On Fri, Mar 15, 2024 at 08:45:10PM +1000, Gavin Shan wrote:
> 
> + Will, Catalin and Matt from Nvidia
> 
> On 3/14/24 22:59, Michael S. Tsirkin wrote:
> > On Thu, Mar 14, 2024 at 10:50:15PM +1000, Gavin Shan wrote:
> > > On 3/14/24 21:50, Michael S. Tsirkin wrote:
> > > > On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
> > > > > On 3/14/24 18:05, Michael S. Tsirkin wrote:
> > > > > > On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > > > > > > The issue is reported by Yihuang Yu who have 'netperf' test on
> > > > > > > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > > > > > > client is started in the VM hosted by grace-hopper machine,
> > > > > > > while the 'netperf' server is running on grace-grace machine.
> > > > > > > 
> > > > > > > The VM is started with virtio-net and vhost has been enabled.
> > > > > > > We observe a error message spew from VM and then soft-lockup
> > > > > > > report. The error message indicates the data associated with
> > > > > > > the descriptor (index: 135) has been released, and the queue
> > > > > > > is marked as broken. It eventually leads to the endless effort
> > > > > > > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > > > > > > and soft-lockup. The stale index 135 is fetched from the available
> > > > > > > ring and published to the used ring by vhost, meaning we have
> > > > > > > disordred write to the available ring element and available index.
> > > > > > > 
> > > > > > >      /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> > > > > > >      -accel kvm -machine virt,gic-version=host                            \
> > > > > > >         :                                                                 \
> > > > > > >      -netdev tap,id=vnet0,vhost=on                                        \
> > > > > > >      -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > > > > > > 
> > > > > > >      [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > > > > > > 
> > > > > > > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > > > > > > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > > > > > > ARM64. It should work for other architectures, but performance loss is
> > > > > > > expected.
> > > > > > > 
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > > > > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > > > > ---
> > > > > > >     drivers/virtio/virtio_ring.c | 12 +++++++++---
> > > > > > >     1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > > >     	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > > >     	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > > > -	 * new available array entries. */
> > > > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > > > +	/*
> > > > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > > > +	 * architectures, but performance loss is expected.
> > > > > > > +	 */
> > > > > > > +	virtio_mb(false);
> > > > > > 
> > > > > > 
> > > > > > I don't get what is going on here. Any explanation why virtio_wmb is not
> > > > > > enough besides "it does not work"?
> > > > > > 
> > > > > 
> > > > > The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
> > > > > than "dmb" because "dsb" ensures that all memory accesses raised before this
> > > > > instruction is completed when the 'dsb' instruction completes. However, "dmb"
> > > > > doesn't guarantee the order of completion of the memory accesses.
> > > > > 
> > > > > So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> > > > > can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> > > > 
> > > > Completed as observed by which CPU?
> > > > We have 2 writes that we want observed by another CPU in order.
> > > > So if CPU observes a new value of idx we want it to see
> > > > new value in ring.
> > > > This is standard use of smp_wmb()
> > > > How are these 2 writes different?
> > > > 
> > > > What DMB does, is that is seems to ensure that effects
> > > > of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> > > > are observed after effects of
> > > > 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> > > > 
> > > > 
> > > 
> > > Completed as observed by the CPU where vhost worker is running. I don't think DMB
> > > does the work here. If I'm understanding correctly, DMB ensures the order of these
> > > two writes from the local CPU's standpoint.
> > 
> > No this makes no sense at all. All memory accesses are in order from
> > local CPU standpoint.
> > 
> 
> It's true if compiler doesn't reorder the accesses, and light-weight barrier
> like 'dmb' and 'isb' is used. Otherwise, the accesses still can be disordered
> on the local CPU, correct?

Compiler issues aside (you can look at binary and see if they got
reordered) no, the local CPU always observes all writes in the
same way they were initiated, and on all architectures.

> > > The written data can be stored in local
> > > CPU's cache, not flushed to DRAM and propogated to the cache of the far CPU where
> > > vhost worker is running. So DMB isn't ensuring the write data is observed from the
> > > far CPU.
> > 
> > No but it has to ensure *ordering*. So if index is oberved then ring
> > is observed too because there is a MB there when reading.
> > 
> 
> Right. It should work like this way theoretically. I don't know the difference
> between 'dmb' and 'dsb' from the hardware level. The description in ARMv9 spec
> is also ambiguous. Lets see if Matt will have comments. Besides, this issue is
> only reproducible on NVidia's grace-hopper. We don't hit the issue on Ampere's
> CPUs.
> 
> > 
> > > DSB ensures that the written data is observable from the far CPU immediately.
> > > > 
> > > > 
> > > > > The stronger barrier 'dsb' ensures the completion order as we expected.
> > > > > 
> > > > >       virtio_wmb(true)         virt_mb(false)
> > > > >         virt_wmb                 mb
> > > > >           __smp_wmb               __mb
> > > > >             dmb(ishst)              dsb(sy)
> > > > 
> > > > First, why would you want a non smp barrier when you are
> > > > synchronizing with another CPU? This is what smp_ means ...
> > > > 
> > > > 
> > > > > Extraced from ARMv9 specificaton
> > > > > ================================
> > > > > The DMB instruction is a memory barrier instruction that ensures the relative
> > > > > order of memory accesses before the barrier with memory accesses after the
> > > > > barrier. The DMB instruction _does not_ ensure the completion of any of the
> > > > > memory accesses for which it ensures relative order.
> > > > 
> > > > Isn't this exactly what we need?
> > > > 
> > > 
> > > I don't think so. DMB gurantees the order of EXECUTION, but DSB gurantees the
> > > order of COMPLETION. After the data store is executed, the written data can
> > > be stored in local CPU's cache, far from completion. Only the instruction is
> > > completed, the written data is synchronized to the far CPU where vhost worker
> > > is running.
> > > 
> > > Here is another paper talking about the difference between DMB and DSB. It's
> > > explaining the difference between DMB/DSB better than ARMv9 specification.
> > > However, it's hard for us to understand DMB/DSB work from the hardware level
> > > based on the specification and paper.
> > > 
> > > https://ipads.se.sjtu.edu.cn/_media/publications/liuppopp20.pdf
> > > (section 2.2  Order-preserving Options)
> > > (I'm extracting the relevant part as below)
> > > 
> > > Data Memory Barrier (DMB) prevents reordering of memory accesses across the barrier.
> > > Instead of waiting for previous accesses to become observable in the specified domain,
> > > DMB only maintains the relative order between memory accesses. Meanwhile, DMB does
> > > not block any non-memory access operations.
> > > 
> > > Data Synchronization Barrier (DSB) prevents reordering of any instructions across
> > > the barrier. DSB will make sure that all masters in the specified domain can observe
> > > the previous operations before issuing any subsequent instructions.
> > > 
> > 
> > What you are describing is that smp_wmb is buggy on this platform.
> > Poossible but are you sure?
> > Write a small test and check.
> > Leave virtio alone.
> > 
> 
> Yes, I guess smp_wmb() ('dmb') is buggy on NVidia's grace-hopper platform. I tried
> to reproduce it with my own driver where one thread writes to the shared buffer
> and another thread reads from the buffer. I don't hit the out-of-order issue so
> far.

Make sure the 2 areas you are accessing are in different cache lines.


> My driver may be not correct somewhere and I will update if I can reproduce
> the issue with my driver in the future.

Then maybe your change is just making virtio slower and masks the bug
that is actually elsewhere?

You don't really need a driver. Here's a simple test: without barriers
assertion will fail. With barriers it will not.
(Warning: didn't bother testing too much, could be buggy.

---

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define FIRST values[0]
#define SECOND values[64]

volatile int values[100] = {};

void* writer_thread(void* arg) {
	while (1) {
	FIRST++;
	// NEED smp_wmb here
	SECOND++;
	}
}

void* reader_thread(void* arg) {
    while (1) {
	int first = FIRST;
	// NEED smp_rmb here
	int second = SECOND;
	assert(first - second == 1 || first - second == 0);
    }
}

int main() {
    pthread_t writer, reader;

    pthread_create(&writer, NULL, writer_thread, NULL);
    pthread_create(&reader, NULL, reader_thread, NULL);

    pthread_join(writer, NULL);
    pthread_join(reader, NULL);

    return 0;
}

-- 
MST


