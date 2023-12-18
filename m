Return-Path: <linux-kernel+bounces-3491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4F7816D02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15345B23337
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3514B14A;
	Mon, 18 Dec 2023 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI/3RCbK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5564B130
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702899684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WIXRJCINLvZkQttuGlfpq8CwCOYv6+yiTtN4pAH9ypg=;
	b=bI/3RCbKL5qZYez11QqwH7CEKAoTdO0FySEu2zVfm5NoFgY5lJZ7MSKpfRYou1LzgO8mv2
	K9oD/EJZEOj8Qj+kJC4yc02NOOnoMLhv9dDqD2smfEcFm0//2agPe2Kpe6LgUR/1ADoZSj
	yCcAjyppH5SkuWyaXFgnkULhQg1NB5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-NxpvXsbiML6AwbyuXVnjlw-1; Mon, 18 Dec 2023 06:41:11 -0500
X-MC-Unique: NxpvXsbiML6AwbyuXVnjlw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c33d8dfceso27576785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702899670; x=1703504470;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIXRJCINLvZkQttuGlfpq8CwCOYv6+yiTtN4pAH9ypg=;
        b=NnuqE3tkKGgPUb5bBQGfmDpJPz5sSuFSJ/bwDcRYvIxB7WOULJSbVoM4rYx7bjHIdn
         s7cXCEDQjFhp5mBGLEaainODwJ95syzUr6dJmVvcmtFMeJWKFDUBQWJhYL7gt7nbZFk9
         98VQraHyxf6g4kH0sI5wtGdvBetasHzeKLPicQwtCfYYth4KrjRoHtLIiLTHpTEx+3kZ
         cBVxyKm8DnkS23okgOpIK4Z9n+DaZKCPcxOYnNXCApPqs+AJjSBWDhHXD7vFBNWvo90R
         jFy9v6quvPigpspzrRXitJwmRjBaGRwW16We+o6gu+8b+XEj65OUd++rfcNA3j7/WGYj
         UX4g==
X-Gm-Message-State: AOJu0YyxZIwNgsSu2DSczV9feVjt9yR2nawdNSOM9qMr3ysiXOza4Ksf
	0burRgHkn/D+P/0Q/96ZkDFgLToGPxIPPA6cJRHrzkQDUvMDupDGooErVLJ7X8rWc4s6N5Ho5eq
	5BfjltQ/RSTBHK2RihqSmXGCz
X-Received: by 2002:a05:600c:4ec6:b0:40d:1b50:a6f4 with SMTP id g6-20020a05600c4ec600b0040d1b50a6f4mr340037wmq.18.1702899670133;
        Mon, 18 Dec 2023 03:41:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeyM7vQQfQl1iySuiiN4Jy53f7AXkDUTAJeHefOW2awpI5KONj/8ovYRYWI8c1EINYbwPLyg==
X-Received: by 2002:a05:600c:4ec6:b0:40d:1b50:a6f4 with SMTP id g6-20020a05600c4ec600b0040d1b50a6f4mr340030wmq.18.1702899669608;
        Mon, 18 Dec 2023 03:41:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0040c1d2c6331sm41915101wms.32.2023.12.18.03.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:41:09 -0800 (PST)
Message-ID: <35f54983-4209-40bd-aad0-f34c97f4a8b1@redhat.com>
Date: Mon, 18 Dec 2023 12:41:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20231208070754.3132339-1-stevensd@chromium.org>
 <9fb51bfc-576a-4c7b-92c2-c161e7f08ae7@redhat.com>
 <CAD=HUj6ZsZo_kxZazDDDUp61pEHupuf0Lf7WqkKBsMOA1CYcNQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAD=HUj6ZsZo_kxZazDDDUp61pEHupuf0Lf7WqkKBsMOA1CYcNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.12.23 02:00, David Stevens wrote:
> On Thu, Dec 14, 2023 at 6:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.12.23 08:07, David Stevens wrote:
>>> If a virtio_pci_device supports native PCI power management and has the
>>> No_Soft_Reset bit set, then skip resetting and reinitializing the device
>>> when suspending and restoring the device. This allows system-wide low
>>> power states like s2idle to be used in systems with stateful virtio
>>> devices that can't simply be re-initialized (e.g. virtio-fs).
>>>
>>> Signed-off-by: David Stevens <stevensd@chromium.org>
>>> ---
>>> v1 -> v2:
>>>    - Check the No_Soft_Reset bit
>>>
>>>    drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
>>>    1 file changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>>> index c2524a7207cf..3a95ecaf12dc 100644
>>> --- a/drivers/virtio/virtio_pci_common.c
>>> +++ b/drivers/virtio/virtio_pci_common.c
>>> @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
>>>        return virtio_device_restore(&vp_dev->vdev);
>>>    }
>>>
>>> +static bool vp_supports_pm_no_reset(struct device *dev)
>>> +{
>>> +     struct pci_dev *pci_dev = to_pci_dev(dev);
>>> +     u16 pmcsr;
>>> +
>>> +     if (!pci_dev->pm_cap)
>>> +             return false;
>>> +
>>> +     pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>> +     if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>> +             dev_err(dev, "Unable to query pmcsr");
>>> +             return false;
>>> +     }
>>> +
>>> +     return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
>>> +}
>>> +
>>> +static int virtio_pci_suspend(struct device *dev)
>>> +{
>>> +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
>>> +}
>>> +
>>> +static int virtio_pci_resume(struct device *dev)
>>> +{
>>> +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
>>> +}
>>> +
>>>    static const struct dev_pm_ops virtio_pci_pm_ops = {
>>> -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
>>> +     .suspend = virtio_pci_suspend,
>>> +     .resume = virtio_pci_resume,
>>> +     .freeze = virtio_pci_freeze,
>>> +     .thaw = virtio_pci_restore,
>>> +     .poweroff = virtio_pci_freeze,
>>> +     .restore = virtio_pci_restore,
>>>    };
>>>    #endif
>>>
>>
>> Am I correct with my assumption that this will make s2idle work with virtio-mem-pci as well?
>>
>> Right now, all suspending is disabled, but really only s4/hibernate is problematic.
>>
>> [root@vm-0 ~]# echo "s2idle" > /sys/power/mem_sleep
>> [root@vm-0 ~]# echo "mem" > /sys/power/state
>> [  101.822991] PM: suspend entry (s2idle)
>> [  101.828978] Filesystems sync: 0.004 seconds
>> [  101.831618] Freezing user space processes
>> [  101.834569] Freezing user space processes completed (elapsed 0.001 seconds)
>> [  101.836915] OOM killer disabled.
>> [  101.838072] Freezing remaining freezable tasks
>> [  101.841054] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [  101.843538] printk: Suspending console(s) (use no_console_suspend to debug)
>> [  101.957676] virtio_mem virtio0: save/restore not supported.
>> [  101.957683] virtio-pci 0000:00:02.0: PM: pci_pm_suspend(): virtio_pci_freeze+0x0/0x50 returns -1
>> [  101.957702] virtio-pci 0000:00:02.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -1
>> [  101.957718] virtio-pci 0000:00:02.0: PM: failed to suspend async: error -1
> 
> QEMU's virtio-pci devices don't advertise no_soft_reset, so this patch
> won't affect vanilla QEMU. But if you add PCI_PM_CTRL_NO_SOFT_RESET to
> the capability, then it should work. I'm working with crosvm, which
> doesn't have virtio-mem implemented, but this patch makes virtio-fs
> work with no extra kernel changes.

Thanks for the explanation, makes sense to me.

-- 
Cheers,

David / dhildenb


