Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0E7D067B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbjJTC3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbjJTC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:29:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E021A8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:28:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca6809fb8aso2630085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697768890; x=1698373690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ozb5PuMIZdsqagwbp/IYOMYWWOwC8ObSgQZuuvWYiSM=;
        b=je5PtmdiXoFhlg0YcBVeo7UvuUI/tifjb6UgMRDnhFF6/tOJT5NQtjv4LpodA7eVMa
         r+tyLaW3BBLTBXSx6jr2V1mHcOeHilhc/i8i64z8hUo+yoRkFl1yuP564p7e++5VrSmi
         9IOm3+aOLyOUNFPO1b2mXwkoRrcjsr+hSgTBAOdBjVBEAHIg14P9VY584r4zm1G20842
         aRDm34OCAO4VUY0pMxONyCTZP7iYN0fmYvfxPHlm+kHBCcanRSMmzLFbiXGmkCq+w71q
         OYAtAKtKxh73NyqJK7tjfXR5+ytRWDuJoHE4FSNX4uMgRTUvTaIZOgoLdO37kborLh1o
         dJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697768890; x=1698373690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozb5PuMIZdsqagwbp/IYOMYWWOwC8ObSgQZuuvWYiSM=;
        b=tvWag+mJB7S/78ydw8A/dVhfR5rsRwJVu0UrsDo2XFDGW1EVeeDpMa8mxjzQQPhdLm
         jaI1jGVftxhtdEFCNNNhmr5AKHaIfHSEJyywjNjoej5cLYoxdHhatcBqxEOobLfDsIjo
         yd/d185LXKy3Tyu/tALeomCeobWtx5veoDXjd/Ui2OEnJIHeXf4/gLoDQRexV+vZ+XH8
         Ha/p7GtXs1MBlZhThen/K3VBgXenQBpUqLJ3meRWg8Da9vwvTmjM9HWI/88+MIDLeP6g
         6Dr+SeDg9sBhWdK+jP4WlhgZSudAO463jDMD7Set+o4CNLxOJLxOMRbaCa93YM/WXYB1
         98fg==
X-Gm-Message-State: AOJu0YyxNA242m1oIkcXnS56SKK1zypHm9eC1Fkmq4Qz1xSdAynidnw/
        cr7+1ZWxxJm2MhMPc8y6AmEyRFnDFkPVeAiFt+w=
X-Google-Smtp-Source: AGHT+IGPzSu8z7N8BOvXmKb71n1EXEIifbc7KWTuWe0hibEZb8vTw4C5raH1U6Tb9c8pVDjjjnyIJg==
X-Received: by 2002:a17:902:ea09:b0:1c5:de06:9e5a with SMTP id s9-20020a170902ea0900b001c5de069e5amr606142plg.21.1697768890168;
        Thu, 19 Oct 2023 19:28:10 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001c5fc11c085sm384506plb.264.2023.10.19.19.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 19:28:09 -0700 (PDT)
Message-ID: <f1795a37-d615-4260-ac29-97f0d0ad3c8f@bytedance.com>
Date:   Fri, 20 Oct 2023 10:23:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: PING: [PATCH] virtio-blk: fix implicit overflow on
 virtio_max_dma_size
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-block@vger.kernel.org
References: <20230904061045.510460-1-pizhenwei@bytedance.com>
 <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
 <20231019055134-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20231019055134-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Paolo, Stefan, Xuan and linux-block.

On 10/19/23 17:52, Michael S. Tsirkin wrote:
> On Thu, Oct 19, 2023 at 05:43:55PM +0800, zhenwei pi wrote:
>> Hi Michael,
>>
>> This seems to have been ignored as you suggested.
>>
>> LINK: https://www.spinics.net/lists/linux-virtualization/msg63015.html
> 
> Pls Cc more widely then:
> 
> Paolo Bonzini <pbonzini@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
> Stefan Hajnoczi <stefanha@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
> Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
> linux-block@vger.kernel.org (open list:BLOCK LAYER)
> 
> would all be good people to ask to review this.
> 
> 
>> On 9/4/23 14:10, zhenwei pi wrote:
>>> The following codes have an implicit conversion from size_t to u32:
>>> (u32)max_size = (size_t)virtio_max_dma_size(vdev);
>>>
>>> This may lead overflow, Ex (size_t)4G -> (u32)0. Once
>>> virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
>>> instead.
>>>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 1fe011676d07..4a4b9bad551e 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>    	u16 min_io_size;
>>>    	u8 physical_block_exp, alignment_offset;
>>>    	unsigned int queue_depth;
>>> +	size_t max_dma_size;
>>>    	if (!vdev->config->get) {
>>>    		dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> @@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>    	/* No real sector limit. */
>>>    	blk_queue_max_hw_sectors(q, UINT_MAX);
>>> -	max_size = virtio_max_dma_size(vdev);
>>> +	max_dma_size = virtio_max_dma_size(vdev);
>>> +	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
>>>    	/* Host can optionally specify maximum segment size and number of
>>>    	 * segments. */
>>
>> -- 
>> zhenwei pi
> 

-- 
zhenwei pi
