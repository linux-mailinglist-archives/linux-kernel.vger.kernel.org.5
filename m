Return-Path: <linux-kernel+bounces-17726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73638251A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7058E1F212EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255F2E3E8;
	Fri,  5 Jan 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K02D7SeK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7C2DF65
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704449648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cc52LaptPrYh6Z5cf7eSO+K3bI2pANK5fWlsASyxWFY=;
	b=K02D7SeKADGb3noQAKnAZrmkzZ6ekzzc3gJDJxZ3j5huaPYn3RUeoCQByMjcE0UWssykJ2
	14dh5YRA/O3QlBrc9QJ02SL9D07oM+xTTRH1I/5MBzXccAy9vv4YMTWBHYt3fE5hm0rJqd
	bj96DLARl6bczB7ieuex4Oeo6nWW78s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-h4Y868EaNuqojFgIKxBzFQ-1; Fri, 05 Jan 2024 05:14:05 -0500
X-MC-Unique: h4Y868EaNuqojFgIKxBzFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27C4C86F122;
	Fri,  5 Jan 2024 10:14:05 +0000 (UTC)
Received: from [10.39.208.29] (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E1CBD51D5;
	Fri,  5 Jan 2024 10:14:02 +0000 (UTC)
Message-ID: <0322ee9e-f6db-45ed-855f-9ebcdfca30a9@redhat.com>
Date: Fri, 5 Jan 2024 11:14:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] vduse: Temporarily fail if control queue features
 requested
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 david.marchand@redhat.com, lulu@redhat.com
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
 <20240104153753.2931026-3-maxime.coquelin@redhat.com>
 <CACGkMEtmTY0ux8pw8VQ8SAdgGty=rM1VRkh6c-qBVSaqhYuURw@mail.gmail.com>
 <888255d7-e45b-44db-8561-5e9f386603c3@redhat.com>
 <CAJaqyWfrO3c9GD2k+aX=fA8OQLg2aQPHHb4WyTbE09KkmoOesA@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <CAJaqyWfrO3c9GD2k+aX=fA8OQLg2aQPHHb4WyTbE09KkmoOesA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5



On 1/5/24 10:59, Eugenio Perez Martin wrote:
> On Fri, Jan 5, 2024 at 9:12 AM Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
>>
>>
>>
>> On 1/5/24 03:45, Jason Wang wrote:
>>> On Thu, Jan 4, 2024 at 11:38 PM Maxime Coquelin
>>> <maxime.coquelin@redhat.com> wrote:
>>>>
>>>> Virtio-net driver control queue implementation is not safe
>>>> when used with VDUSE. If the VDUSE application does not
>>>> reply to control queue messages, it currently ends up
>>>> hanging the kernel thread sending this command.
>>>>
>>>> Some work is on-going to make the control queue
>>>> implementation robust with VDUSE. Until it is completed,
>>>> let's fail features check if any control-queue related
>>>> feature is requested.
>>>>
>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>> ---
>>>>    drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>>>> index 0486ff672408..94f54ea2eb06 100644
>>>> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>>> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>>> @@ -28,6 +28,7 @@
>>>>    #include <uapi/linux/virtio_config.h>
>>>>    #include <uapi/linux/virtio_ids.h>
>>>>    #include <uapi/linux/virtio_blk.h>
>>>> +#include <uapi/linux/virtio_ring.h>
>>>>    #include <linux/mod_devicetable.h>
>>>>
>>>>    #include "iova_domain.h"
>>>> @@ -46,6 +47,15 @@
>>>>
>>>>    #define IRQ_UNBOUND -1
>>>>
>>>> +#define VDUSE_NET_INVALID_FEATURES_MASK         \
>>>> +       (BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |        \
>>>> +        BIT_ULL(VIRTIO_NET_F_CTRL_RX)   |      \
>>>> +        BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |      \
>>>> +        BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) | \
>>>> +        BIT_ULL(VIRTIO_NET_F_MQ) |             \
>>>> +        BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |  \
>>>> +        BIT_ULL(VIRTIO_NET_F_RSS))
>>>
>>> We need to make this as well:
>>>
>>> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>>
>> I missed it, and see others have been added in the Virtio spec
>> repository (BTW, I see this specific one is missing in the dependency
>> list [0], I will submit a patch).
>>
>> I wonder if it is not just simpler to just check for
>> VIRTIO_NET_F_CTRL_VQ is requested. As we fail instead of masking out,
>> the VDUSE driver won't be the one violating the spec so it should be
>> good?
>>
>> It will avoid having to update the mask if new features depending on it
>> are added (or forgetting to update it).
>>
>> WDYT?
>>
> 
> I think it is safer to work with a whitelist, instead of a blacklist.
> As any new feature might require code changes in QEMU. Is that
> possible?

Well, that's how it was done in previous revision. :)

I changed to a blacklist for consistency with block device's WCE feature
check after Jason's comment.

I'm not sure moving back to a whitelist brings much advantages when
compared to the effort of keeping it up to date. Just blacklisting
VIRTIO_NET_F_CTRL_VQ is enough in my opinion.

Thanks,
Maxime

>> Thanks,
>> Maxime
>>
>> [0]:
>> https://github.com/oasis-tcs/virtio-spec/blob/5fc35a7efb903fc352da81a6d2be5c01810b68d3/device-types/net/description.tex#L129
>>> Other than this,
>>>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>
>>> Thanks
>>>
>>>> +
>>>>    struct vduse_virtqueue {
>>>>           u16 index;
>>>>           u16 num_max;
>>>> @@ -1680,6 +1690,9 @@ static bool features_is_valid(struct vduse_dev_config *config)
>>>>           if ((config->device_id == VIRTIO_ID_BLOCK) &&
>>>>                           (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
>>>>                   return false;
>>>> +       else if ((config->device_id == VIRTIO_ID_NET) &&
>>>> +                       (config->features & VDUSE_NET_INVALID_FEATURES_MASK))
>>>> +               return false;
>>>>
>>>>           return true;
>>>>    }
>>>> --
>>>> 2.43.0
>>>>
>>>
>>
>>
> 


