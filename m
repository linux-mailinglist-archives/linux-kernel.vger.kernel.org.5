Return-Path: <linux-kernel+bounces-3918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA181751C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01071F24AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68342395;
	Mon, 18 Dec 2023 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe2187Gl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA093A1B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702912690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jtx/wzMZ1hRWUVGblVa5mU4I3sco2aMsq+3DdgGhKG4=;
	b=Pe2187GlMSC9347NTC3G2LN/CyX31okIeoMQyrJVwGH+qGTLaNo9mGUmeP6FiJK4Pu6YRf
	gRiS9mbQIG+CClFNBmCFQQDlsfqHxwTVJPkelZ8EUNIHFkjlom4XkcSS2wfDr6G2iSgRbL
	ac9Hlti6t43U0abPxDHkRbzwSNhUsHE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ZfxPmA_JNISaP6nIRzcoMA-1; Mon, 18 Dec 2023 10:18:04 -0500
X-MC-Unique: ZfxPmA_JNISaP6nIRzcoMA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c6e330554so19393465e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912683; x=1703517483;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtx/wzMZ1hRWUVGblVa5mU4I3sco2aMsq+3DdgGhKG4=;
        b=ij/B0gyVfzyYKdfyRK7WmQcVvMkqd+DyUWqxK2zLT9l5S5MHxppVPGajGxSG9gZSRx
         B/82KvdLtTq8FAwQQdZJySBMVvS8zdd4lmKyoMDDGPCBmGuMzRJ3/RUxXeq+Me+1k/FS
         nKkDtu98PZ68M0pHXevMDSw0/l9GOsgdPslkNspBipfK1swIS0+m12w5VbEI2GE7IvWh
         YGJ5m1WguKONIRMWLoLhv1Xn5jraEqrsxZ5sOZQ8Ar1i0WfS8nGzvOd2WTvSM7aYQlg2
         XWjbkJAr3xvkWhcZNE5zFUN5tbzgnKWhGv0eC3tzTD54aPum2BXyDUzVDiJw+urOKKi7
         0klQ==
X-Gm-Message-State: AOJu0YyXB+IFTacPMrCUM4rQCujMrmBDDJhLmdkui7hcgqBMaZXveO2f
	V+xPoE48BxYf1OffFPBgvPr8zBnoWbiSlvAXMsLJ+Gw+aCHW1vCSjiVO+wLHHNMd0CfwpXvhV67
	WJA9LsJ6/LLU0CGCKfGd2PSmD
X-Received: by 2002:a05:600c:444c:b0:40b:5e1b:54a0 with SMTP id v12-20020a05600c444c00b0040b5e1b54a0mr8980503wmn.44.1702912683282;
        Mon, 18 Dec 2023 07:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ1IiQx/5r+arm/glRHhXBjDFvDJMeKLz9ZNsXYbilc/1w5KSKyCkuFhzzMq7jNhHvTF3mJQ==
X-Received: by 2002:a05:600c:444c:b0:40b:5e1b:54a0 with SMTP id v12-20020a05600c444c00b0040b5e1b54a0mr8980495wmn.44.1702912682841;
        Mon, 18 Dec 2023 07:18:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm35987625wmq.26.2023.12.18.07.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 07:18:02 -0800 (PST)
Message-ID: <2b8f4855-98f4-4515-bd5f-f93983d45714@redhat.com>
Date: Mon, 18 Dec 2023 16:18:01 +0100
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
 <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com>
 <CAD=HUj7h-cF929AbSL0bmZE7J=G1aQjZuYSgChPBkSGJ+wfoyQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAD=HUj7h-cF929AbSL0bmZE7J=G1aQjZuYSgChPBkSGJ+wfoyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.12.23 16:16, David Stevens wrote:
> On Mon, Dec 18, 2023 at 6:37 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.12.23 05:13, David Stevens wrote:
>>> On Wed, Dec 13, 2023 at 5:44 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 11.12.23 12:43, David Stevens wrote:
>>>>> From: David Stevens <stevensd@chromium.org>
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>>> Add a wakeup event for when the balloon is inflating or deflating.
>>>>> Userspace can enable this wakeup event to prevent the system from
>>>>> suspending while the balloon is being adjusted. This allows
>>>>> /sys/power/wakeup_count to be used without breaking virtio_balloon's
>>>>> cooperative memory management.
>>>>
>>>> Can you add/share some more details
>>>
>>> I'm working on enabling support for Linux s2Idle in our Android
>>> virtual machine, to restrict apps from running in the background
>>> without holding an Android partial wakelock. With the patch I recently
>>> sent out [1], since crosvm advertises native PCI power management for
>>> virtio devices, the Android guest can properly enter s2idle, and it
>>> can be woken up by incoming IO. However, one of the remaining problems
>>> is that when the host needs to reclaim memory from the guest via the
>>> virtio-balloon, there is nothing preventing the guest from entering
>>> s2idle before the balloon driver finishes returning memory to the
>>> host.
>>
>> Thanks for the information. So you also want to wakeup the VM when
>> wanting to get more memory from the VM?
>>
>> Using which mechanism would that wakeup happen? Likely not the device
>> itself?
> 
> The wakeup would happen via the parent device's interrupt. I've sent a
> new version of this patch that uses the parent device's wakeup event
> instead of adding a new one.
> 
>>>
>>> One alternative to this approach would be to add a virtballoon_suspend
>>> callback to abort suspend if the balloon is inflating/adjusting.
>>> However, it seems cleaner to just prevent suspend in the first place.
>>
>> Also, the PM notifier could also be used with very high priority, so the
>> device would respond early to PM_SUSPEND_PREPARE.
> 
> One drawback of blocking suspend via a PM notifier is that the
> behavior isn't configurable by userspace, whereas wakeup events can be
> enabled/disabled by userspace.

The question is if that behavior for the balloon is really worth it 
being configured by user space?

-- 
Cheers,

David / dhildenb


