Return-Path: <linux-kernel+bounces-5497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A3818B61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B341C246DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA91D157;
	Tue, 19 Dec 2023 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVn8eIcP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C91CAAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703000399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PK+LuygYmhG2CvJvGWMAjuhLlJlhJqXboi52bYDOrnM=;
	b=UVn8eIcPTyI3Sj1LktjNEc7382cYZP7oFBqRTZiIHwwcyDkWCqgiFPdcKnvqSCdvhV+xIa
	0MwW3gNE/gNenL6a8tFdjaeVXbv1/gcCviiPOBGVVb+JSKEJaeh4kJk8q/u4jDJDP79jt7
	UtcuZrlJFucMCRAs5vxztQLuE/jE5LE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-uWJdwv00NyOflJ6NnPOiIA-1; Tue, 19 Dec 2023 10:39:57 -0500
X-MC-Unique: uWJdwv00NyOflJ6NnPOiIA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c348e529fso39239055e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703000396; x=1703605196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK+LuygYmhG2CvJvGWMAjuhLlJlhJqXboi52bYDOrnM=;
        b=HLMeXwHiUKq1gbVG46CR2/YshoH/c8NoEGqYrRbWiOYVB+NDf310PwYWLXcZ/YQQt0
         wHTs1znXXVeBXCCcQC+pLD5cZ0PWpnb4RxeV9J4Dtxh1YNtBUws+VV+HucAjclU3y1Gn
         90Yc5+6wob42KY2eo7zsB/2CK3SykEGOnwjZTZJZjJTVrKb179pHbPf4aEY8XgZWManV
         qqi4DIY1lLhFLr2Y0DKFu8bvyOgi0YnY1GAtuVtHMm2nAyz1GLzl69GN+MpyXbl/hZq/
         +vyjeL5HKm/UeqJowq9TaX4BEYglRxoDHZqeB8loLqnz/0hGcc1pHcaZYvddyzv81FFu
         P4cA==
X-Gm-Message-State: AOJu0Yz/JbpUkl0BW+HLLMlEBIWvcaLkGpQFi6urzGn6Lrv+G9vIabG+
	2PaUxq543Uopj9+CUBwnSzL4ew2pgeq5hEuGtgRjl60Y6n8vVh5dl3jC+G2LExdLSoIaP62hQEA
	3Jim70emj3lMuZsL+oniq0MIH
X-Received: by 2002:a05:600c:154c:b0:40d:30a4:c51 with SMTP id f12-20020a05600c154c00b0040d30a40c51mr41228wmg.11.1703000395877;
        Tue, 19 Dec 2023 07:39:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp1DVxyhAk0i9CV+i/v6SuQdOLBY26mxjgz1WawO4Q7LKSE/AJ2fgyScCtGgKw6oKf5fTjzw==
X-Received: by 2002:a05:600c:154c:b0:40d:30a4:c51 with SMTP id f12-20020a05600c154c00b0040d30a40c51mr41218wmg.11.1703000395497;
        Tue, 19 Dec 2023 07:39:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:400:39cf:76ec:bfd8:fe73? (p200300cbc734040039cf76ecbfd8fe73.dip0.t-ipconnect.de. [2003:cb:c734:400:39cf:76ec:bfd8:fe73])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c4e4700b0040c41846919sm3422569wmq.41.2023.12.19.07.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 07:39:55 -0800 (PST)
Message-ID: <5eae51df-2ac7-41c4-bf3e-7dc299898855@redhat.com>
Date: Tue, 19 Dec 2023 16:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_balloon: stay awake while adjusting balloon
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20231218151842.2756673-1-stevensd@google.com>
 <aae229d7-0675-47c5-9a02-5ba0b6a64906@redhat.com>
 <CAD=HUj4jzxVB3=9kYVr+Y+3Ef2EUVztA4aVOXvha2zsCyzDGQQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAD=HUj4jzxVB3=9kYVr+Y+3Ef2EUVztA4aVOXvha2zsCyzDGQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.12.23 15:37, David Stevens wrote:
> On Mon, Dec 18, 2023 at 12:33 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.12.23 16:18, David Stevens wrote:
>>> From: David Stevens <stevensd@chromium.org>
>>>
>>> A virtio_balloon's parent device may be configured so that a
>>> configuration change interrupt is a wakeup event. Extend the processing
>>> of such a wakeup event until the balloon finishes inflating or deflating
>>> by calling pm_stay_awake/pm_relax in the virtio_balloon driver. Note
>>> that these calls are no-ops if the parent device doesn't support wakeup
>>> events or if the wakeup events are not enabled.
>>>
>>> This change allows the guest to use system power states such as s2idle
>>> without running the risk the virtio_balloon's cooperative memory
>>> management becoming unresponsive to the host's requests.
>>>
>>> Signed-off-by: David Stevens <stevensd@chromium.org>
>>> ---
>>> v1 -> v2:
>>>    - Use adjustment_signal_pending flag instead of a sequence number
>>>    - Call pm_stay_awake/pm_relax on parent device instead of adding a wake
>>>      event to the virtio balloon device
>>>
>>>    drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++------
>>>    1 file changed, 47 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>>> index 1fe93e93f5bc..a3c11159cbe0 100644
>>> --- a/drivers/virtio/virtio_balloon.c
>>> +++ b/drivers/virtio/virtio_balloon.c
>>> @@ -119,6 +119,11 @@ struct virtio_balloon {
>>>        /* Free page reporting device */
>>>        struct virtqueue *reporting_vq;
>>>        struct page_reporting_dev_info pr_dev_info;
>>> +
>>> +     /* State for keeping the wakeup_source active while adjusting the balloon */
>>> +     spinlock_t adjustment_lock;
>>> +     bool adjustment_signal_pending;
>>> +     bool adjustment_in_progress;
>>>    };
>>>
>>>    static const struct virtio_device_id id_table[] = {
>>> @@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
>>>        queue_work(vb->balloon_wq, &vb->report_free_page_work);
>>>    }
>>>
>>> +static void start_update_balloon_size(struct virtio_balloon *vb)
>>> +{
>>> +     unsigned long flags;
>>> +
>>> +     spin_lock_irqsave(&vb->adjustment_lock, flags);
>>> +     vb->adjustment_signal_pending = true;
>>> +     if (!vb->adjustment_in_progress) {
>>> +             vb->adjustment_in_progress = true;
>>> +             pm_stay_awake(vb->vdev->dev.parent);
>>> +     }
>>> +     spin_unlock_irqrestore(&vb->adjustment_lock, flags);
>>> +
>>> +     queue_work(system_freezable_wq, &vb->update_balloon_size_work);
>>> +}
>>> +
>>> +static void end_update_balloon_size(struct virtio_balloon *vb)
>>> +{
>>> +     spin_lock(&vb->adjustment_lock);
>>> +     if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
>>
>> How could vb->adjustment_in_progress ever not be set at this point?
>>
>>> +             vb->adjustment_in_progress = false;
>>> +             pm_relax(vb->vdev->dev.parent);
>>> +     }
>>> +     spin_unlock(&vb->adjustment_lock);
>>> +}
>>> +
>>
>> LGTM, although I wonder what happens when calling pm_stay_awake() etc.
>> on a parent device that is not wakeup-even-capable?
> 
> If the parent device is not wakeup capable or if wakeup isn't enabled,
> then the vb->vdev->dev.parent->power.wakeup pointer will be NULL, so
> the NULL checks in __pm_relax/__pm_stay_awake will immediately return.

Ah, I missed that NULL check, makes sense. Thanks!

-- 
Cheers,

David / dhildenb


