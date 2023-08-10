Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3123777619
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjHJKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjHJKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:41:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D52720;
        Thu, 10 Aug 2023 03:41:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9b6e943ebso21963231fa.1;
        Thu, 10 Aug 2023 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691664089; x=1692268889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8sDZ5IUJkTx+O3oWwbTDQAJM2hqa7MawEyJCwCqZhC0=;
        b=Rd5sZMDGywAH33+SWcF2vo0qrXT+ANO744tyte3tM+UprDLFJazaHiwBc41NFE/tRa
         AmQW0r+dvwaoNshZMyE3dJkR1QasYBV9mD9rt6pRWdq2HEjpXF1KYdwR9epMfWrtBpHV
         Qv2Kry46XjY9jaLQ1ugcJixCXjXiQWrZNw0zL1TBJrJAt//o63E4g7dR6uwf2cMA0Ilv
         YK5GjabFkP7ElRr6HNdRvO/W6dMHSqaZh93RcXtFwDLjlNWaaBKm3HBTmwY/z9L2r2zp
         oQ9cXwYur7sltNVkuYjcOtVHvPU7Tl5OXKyarIE72md3eTR0hSCDOBnhv1wUnwyFdU1R
         /M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664089; x=1692268889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sDZ5IUJkTx+O3oWwbTDQAJM2hqa7MawEyJCwCqZhC0=;
        b=MIn9woCNzsaRmTK0pdKI7V2W312gHd6rhULIwFjn5B/cLijXnJz8iLgpAWlTP0y9gI
         pDB/VGpNpf61zpxuCzSCBgi5e1vihmymkGJgstbn5tJ2GubhRvDXAjRfB2UeEpPAiYXR
         4ArVVaO3BOiiXU3qcpDXHO6/BizUtegQVCk+BIcZudwIBqwFxH1w55QVK+RQJqLsdFeI
         6NTNqX4ikGOzhT/MX6UBqrkERYKBMzk3Z1rOmEDZ99nHxMuH7LBHGSlAocIUwo0re873
         P+JGyujuM7yeHz+8+ZYOjFI3kxtUxYE6GjYjBGj2WMauh/yvhuYs5CdJVGwH7aLMcJH/
         ko2g==
X-Gm-Message-State: AOJu0YyTLG2SP2nYr3EVGbkNEs1Du2Dxg5vVn9s/fVhakcSe6xan6L7l
        H8yp90bEkUemcf203ZGRvFMlwZUiTuo5z+ALReCPVGI5/Lci5/VC
X-Google-Smtp-Source: AGHT+IF80XsNIXDrfC3HiWwz+n83VAeXS57ZQ4ljXBYh7USyQwRX5PBAKXFczuuhI8Hva8g89WUbLC1X+vyBlaIU6y0=
X-Received: by 2002:a2e:b04b:0:b0:2b9:a9d8:16a7 with SMTP id
 d11-20020a2eb04b000000b002b9a9d816a7mr722740ljl.8.1691664088114; Thu, 10 Aug
 2023 03:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230810031557.135557-1-yin31149@gmail.com> <20230810045106-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810045106-mutt-send-email-mst@kernel.org>
From:   Hawkins Jiawei <yin31149@gmail.com>
Date:   Thu, 10 Aug 2023 18:41:16 +0800
Message-ID: <CAKrof1PH3vDGesZpt2LO7xakV16FYyg3nKL_sStZ41Ka+oK_Sw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG
 case
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, eperezma@redhat.com,
        18801353760@163.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/10 16:51, Michael S. Tsirkin wrote:
> On Thu, Aug 10, 2023 at 11:15:57AM +0800, Hawkins Jiawei wrote:
>> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
>> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
>>
>> According to the VirtIO standard, "Field reserved MUST contain zeroes.
>> It is defined to make the structure to match the layout of
>> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>>
>> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
>> field in struct virtio_net_ctrl_rss, which corresponds to the
>> `reserved` field in struct virtio_net_hash_config, is not zeroed,
>> thereby violating the VirtIO standard.
>>
>> This patch solves this problem by zeroing this field in
>> virtnet_init_default_rss().
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>
>
>
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Cc: Andrew Melnychenko <andrew@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> And this is stable material I believe.

Hi Michael,

Thank you for the reminder, I will send the v2 patch with all these tags
included.

Thanks!


>
>
>
>> ---
>>
>> TestStep
>> ========
>> 1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
>> feature on, command line like:
>>        -netdev tap,vhost=off,...
>>        -device virtio-net-pci,mq=on,hash=on,...
>>
>> 2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
>> line like:
>>      ethtool -K eth0 rxhash on
>>
>> Without this patch, in virtnet_commit_rss_command(), we can see the
>> `max_tx_vq` field is 1 in gdb like below:
>>
>>      pwndbg> p vi->ctrl->rss
>>      $1 = {
>>        hash_types = 63,
>>        indirection_table_mask = 0,
>>        unclassified_queue = 0,
>>        indirection_table = {0 <repeats 128 times>},
>>        max_tx_vq = 1,
>>        hash_key_length = 40 '(',
>>        ...
>>      }
>>
>> With this patch, in virtnet_commit_rss_command(), we can see the
>> `max_tx_vq` field is 0 in gdb like below:
>>
>>      pwndbg> p vi->ctrl->rss
>>      $1 = {
>>        hash_types = 63,
>>        indirection_table_mask = 0,
>>        unclassified_queue = 0,
>>        indirection_table = {0 <repeats 128 times>},
>>        max_tx_vq = 0,
>>        hash_key_length = 40 '(',
>>        ...
>>      }
>>
>>   drivers/net/virtio_net.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1270c8d23463..8db38634ae82 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
>>              vi->ctrl->rss.indirection_table[i] = indir_val;
>>      }
>>
>> -    vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
>> +    vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
>>      vi->ctrl->rss.hash_key_length = vi->rss_key_size;
>>
>>      netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
>> --
>> 2.34.1
>
