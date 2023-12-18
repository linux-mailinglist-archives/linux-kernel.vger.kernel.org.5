Return-Path: <linux-kernel+bounces-3455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA9816C95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEE1F22BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90C23778;
	Mon, 18 Dec 2023 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if1vzRPj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31C22328
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702899453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AusT7ZPnhk1twpCXoviM0u2LF3pOgqSfSWmSoggvTFg=;
	b=if1vzRPjc36d1qEjWpvkWwE41OYjH8VGXQADVK1dOzRupAfByvl6ciIJMHUMr9UAfMwRWD
	zTUxRo6OfR1upxFE44CNEOWtGolZoMMIccP/iavNGOqWgI6n3PEc8BMRe1S8odWFxF96BI
	PlXYwXv9Gq8rwC2OHJu/SfMOJlV0V68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-VGukcxvDNAShS8YsQdBogg-1; Mon, 18 Dec 2023 06:37:32 -0500
X-MC-Unique: VGukcxvDNAShS8YsQdBogg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c348e529fso26464975e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702899451; x=1703504251;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AusT7ZPnhk1twpCXoviM0u2LF3pOgqSfSWmSoggvTFg=;
        b=VWzvkwL6nygVk+uGEM4KLKOcD6CAXneJ1ZHS7SlipgcE9lg1ICqczl0HORhG2laSar
         Mb21qpE6fIDICJaWpSd89sGa6XnAfiMEGqUHl5FqNTcM7fh7Re82U13X7bMDxS1NozlE
         cipk7ehn60dyqMX/qz0uAMsda7IgKt1x6dXq+UsTag1460tsoQm8vWNXbC3Tp1Jv/uXx
         oz8o+8Hc3+S2EGvOkSst9KqApm/ybVsdPW17EraNIMcXrP+yNkEQd45OwQCFaNRTJOPb
         wZaUNpUW560dRFAADs2VXGl43OHtn71q0WA2C5pI+aKxespBDvKWl2+4VX/DE1CfD8mK
         MAAg==
X-Gm-Message-State: AOJu0Yx9rRsrT5Zf88FWAZiIC/2Tp3htzWQbZVia5l30xORkNjsRKhHO
	vTQbt6YMTbqQdhjBAn6ppbtYfofk1fQwMT+jGDSBwELRrLhh4RQv+Z5edtYCbukMQLxLJNme4UM
	r9E4owWB3aIXrIGZifM+Ov7nm
X-Received: by 2002:a05:600c:511f:b0:40b:4a7f:c9ca with SMTP id o31-20020a05600c511f00b0040b4a7fc9camr6723981wms.34.1702899450800;
        Mon, 18 Dec 2023 03:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGggtJ15K5/v6P+TsCmiqaxZBNEu5dAquIiCeunbWkZdPRu8lWojdarINpy3D8vtJzaM61gA==
X-Received: by 2002:a05:600c:511f:b0:40b:4a7f:c9ca with SMTP id o31-20020a05600c511f00b0040b4a7fc9camr6723973wms.34.1702899450385;
        Mon, 18 Dec 2023 03:37:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm41662488wmo.35.2023.12.18.03.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:37:30 -0800 (PST)
Message-ID: <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com>
Date: Mon, 18 Dec 2023 12:37:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20231211114346.1132386-1-stevensd@google.com>
 <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
 <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.12.23 05:13, David Stevens wrote:
> On Wed, Dec 13, 2023 at 5:44 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 11.12.23 12:43, David Stevens wrote:
>>> From: David Stevens <stevensd@chromium.org>
>>>
>>
>> Hi David,
>>
>>> Add a wakeup event for when the balloon is inflating or deflating.
>>> Userspace can enable this wakeup event to prevent the system from
>>> suspending while the balloon is being adjusted. This allows
>>> /sys/power/wakeup_count to be used without breaking virtio_balloon's
>>> cooperative memory management.
>>
>> Can you add/share some more details
> 
> I'm working on enabling support for Linux s2Idle in our Android
> virtual machine, to restrict apps from running in the background
> without holding an Android partial wakelock. With the patch I recently
> sent out [1], since crosvm advertises native PCI power management for
> virtio devices, the Android guest can properly enter s2idle, and it
> can be woken up by incoming IO. However, one of the remaining problems
> is that when the host needs to reclaim memory from the guest via the
> virtio-balloon, there is nothing preventing the guest from entering
> s2idle before the balloon driver finishes returning memory to the
> host.

Thanks for the information. So you also want to wakeup the VM when 
wanting to get more memory from the VM?

Using which mechanism would that wakeup happen? Likely not the device 
itself?

> 
> One alternative to this approach would be to add a virtballoon_suspend
> callback to abort suspend if the balloon is inflating/adjusting.
> However, it seems cleaner to just prevent suspend in the first place.

Also, the PM notifier could also be used with very high priority, so the 
device would respond early to PM_SUSPEND_PREPARE.

[...]

>>>                queue_work(system_freezable_wq, work);
>>> +     else
>>> +             end_update_balloon_size(vb, seqno);
>>
>> What if we stop the workqueue and unload the driver -- see
>> remove_common() -- won't you leave pm_stay_awake() wrongly set?
> 
> When a device gets removed, its wakeup source is destroyed, which
> automatically calls __pm_relax.

Ah, thanks.

> 
>>>    }
>>>
>>>    static int init_vqs(struct virtio_balloon *vb)
>>> @@ -992,6 +1028,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>>                        goto out_unregister_oom;
>>>        }
>>>
>>> +     spin_lock_init(&vb->adjustment_lock);
>>> +     device_set_wakeup_capable(&vb->vdev->dev, true);
>>
>>
>> I'm a bit confused: Documentation/driver-api/pm/devices.rst documents
>>
>> "
>> The :c:member:`power.can_wakeup` flag just records whether the device
>> (and its driver) can physically support wakeup events.  The
>> :c:func:`device_set_wakeup_capable()` routine affects this flag.
>> "
>>
>> ...
>>
>> "
>> Whether or not a device is capable of issuing wakeup events is a
>> hardware matter, and the kernel is responsible for keeping track of it.
>> "
>>
>> But how is the virtio-balloon device capable of waking up the machine?
>> Your patch merely implies that the virtio-baloon device is capable to
>> prohbit going to sleep.
>>
>> What am I missing?
> 
> The underlying virtio_pci_device is capable of waking up the machine,
> if it supports PCI power management. The core PCI code will keep the
> machine awake while processing the interrupt (i.e. during
> virtballoon_changed), but after processing is handed off to the
> virtio-balloon driver, the virtio-balloon driver needs to keep the
> machine awake until the processing is actually completed.
> 
> An alternative to making vb->vdev->dev wakeup capable is to plumb the
> pm_stay_awake/pm_relax calls to the underlying virtio_pci_device. Would
> that be a preferable approach?

The way you describe it, it rather belongs into the PCI code, because 
that's what actually makes the device PM-capable (i.e., would not apply 
to virtio-ccw or virtio-mmio). The virtio-balloon itself is not 
PM-capable. But how hard is it to move that handling into PCI specific code?

-- 
Cheers,

David / dhildenb


