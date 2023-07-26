Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D606B763FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGZThq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGZTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:37:44 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B41BD6;
        Wed, 26 Jul 2023 12:37:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78360b822abso5002139f.2;
        Wed, 26 Jul 2023 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690400262; x=1691005062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrJGrxEAP7eaauI+6CZSMeVgAKxwElVpsCCTJPBsNHM=;
        b=QJTlVT7E2T8qVnUonw3PSbJX+A7B1q+SNrmp2MQcG658IuG+mfKth/n6N37x5Fu1UO
         2QrbRQQ14JsDrFIsTQ+8dqgUQlMWPY3dICBmvQa+5MdVoKAvLxFZ/kIBeesB/4NcLQTC
         uDr47XrhC7QMHEMAU60XQ/Q47j3qnx/qxrODJRnECyxDiqK2+YXBOSAhZlVNPlGbLPze
         Cq5S5xF9mombQhgOBkypogR0+QmwvxqsM+Y1whJUaaYw4YODfh6yGSb0tfnz6ZhrPlr+
         BkMM2quYhYBbmG8q3WnDpXNN3c+cm5vlDP9xUesvdDPQ0CKrGoPmbSMQ5fS7gVU2zwOb
         5/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400262; x=1691005062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrJGrxEAP7eaauI+6CZSMeVgAKxwElVpsCCTJPBsNHM=;
        b=H6S3hXprUBITPmJTIwsxRmobXLMK+8HT1itXfGMTSY32Npsu1ChkbikkmnzQVJgGo8
         /QafmMm/ON+exVXyPvN3woTknZRDu46U8H9Z1BT5ad+L4yLHvvGe/427nMgQeSsAs9Py
         e4CjdXCVtDX99VtjmXguDbbr6GSPKsWCWNhPJj992Qp7FSXpcL+PemTlz3ILCi373c5I
         PCylC1GbGcw6ysBnyZE2VFXn47VeAoEi6P0ctwRZv1aSfPR3ksvnOtutAoHqBv7FnKqh
         YKX5PlbctOt14R+zbG7cnwXZFDZ3Ln79tkzxfrx32bdoGddOQ7Lppnx418xnc487vcX6
         KSRg==
X-Gm-Message-State: ABy/qLbA7GeVnrnY9HjK0LD04r45LREe4XsGjaeIAzAaE+qNlHjZPaHS
        SIwh6ngt167L00csawERFrg=
X-Google-Smtp-Source: APBJJlFbwmAk3lw1hX4Cmcj+s6vABmChQ0DLw/LFf37ey+U/gscJZxXYRBqheVGjgGmGxeAhAtM7pg==
X-Received: by 2002:a5d:84d8:0:b0:76c:56fb:3c59 with SMTP id z24-20020a5d84d8000000b0076c56fb3c59mr3288332ior.10.1690400261991;
        Wed, 26 Jul 2023 12:37:41 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:bd1d:fe8d:d220:8378? ([2601:282:800:7ed0:bd1d:fe8d:d220:8378])
        by smtp.googlemail.com with ESMTPSA id z21-20020a6b5c15000000b007836e9ff198sm4996858ioh.55.2023.07.26.12.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 12:37:41 -0700 (PDT)
Message-ID: <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
Date:   Wed, 26 Jul 2023 13:37:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
Content-Language: en-US
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Kanner <andrew.kanner@gmail.com>
Cc:     brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
> Cc. John and Ahern
> 
> On 26/07/2023 04.09, Jason Wang wrote:
>> On Tue, Jul 25, 2023 at 11:54 PM Andrew Kanner
>> <andrew.kanner@gmail.com> wrote:
>>>
>>> Syzkaller reported the following issue:
>>> =======================================
>>> Too BIG xdp->frame_sz = 131072
> 
> Is this a contiguous physical memory allocation?
> 
> 131072 bytes equal order 5 page.
> 
> Looking at tun.c code I cannot find a code path that could create
> order-5 skb->data, but only SKB with order-0 fragments.  But I guess it
> is the netif_receive_generic_xdp() what will realloc to make this linear
> (via skb_linearize())


get_tun_user is passed an iov_iter with a single segment of 65007
total_len. The alloc_skb path is hit with an align size of only 64. That
is insufficient for XDP so the netif_receive_generic_xdp hits the
pskb_expand_head path. Something is off in the math in
netif_receive_generic_xdp resulting in the skb markers being off. That
causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.


> 
>>> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>>>    ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
>>> WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
>>>    bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
>>> ...
>>> Call Trace:
>>>   <TASK>
>>>   bpf_prog_4add87e5301a4105+0x1a/0x1c
>>>   __bpf_prog_run include/linux/filter.h:600 [inline]
>>>   bpf_prog_run_xdp include/linux/filter.h:775 [inline]
>>>   bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
>>>   netif_receive_generic_xdp net/core/dev.c:4807 [inline]
>>>   do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
>>>   tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
>>>   tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
>>>   call_write_iter include/linux/fs.h:1871 [inline]
>>>   new_sync_write fs/read_write.c:491 [inline]
>>>   vfs_write+0x650/0xe40 fs/read_write.c:584
>>>   ksys_write+0x12f/0x250 fs/read_write.c:637
>>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
>>> ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But
>>> tun_get_user() still provides an execution path with do_xdp_generic()
>>> and exceed XDP limits for packet size.
> 
> I added this check and maybe it is too strict. XDP can work on higher
> order pages, as long as this is contiguous physical memory (e.g. a
> page).  And
> 
> An order 5 page (131072 bytes) seems excessive, but maybe TUN have a
> use-case for having such large packets? (Question to Ahern?)
> 
> I'm considering we should change the size-limit to order-2 (16384) or
> order-3 (32768).
> 
> Order-3 because netstack have:
>   #define SKB_FRAG_PAGE_ORDER get_order(32768)
> 
> And order-2 because netstack have: SKB_MAX_ALLOC (16KiB)
>  - See discussion in commit 6306c1189e77 ("bpf: Remove MTU check in
> __bpf_skb_max_len").
>  - https://git.kernel.org/torvalds/c/6306c1189e77
> 
> 
>>>
>>> Using the syzkaller repro with reduced packet size it was also
>>> discovered that XDP_PACKET_HEADROOM is not checked in
>>> tun_can_build_skb(), although pad may be incremented in
>>> tun_build_skb().
>>>
>>> If we move the limit check from tun_can_build_skb() to tun_build_skb()
>>> we will make xdp to be used only in tun_build_skb(), without falling
>>> in tun_alloc_skb(), etc. And moreover we will drop the packet which
>>> can't be processed in tun_build_skb().
> 
> Looking at tun_build_skb() is uses the page_frag system, and can thus
> create up-to SKB_FRAG_PAGE_ORDER (size 32768 / order-3).
> 
>>>
>>> Reported-and-tested-by:
>>> syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
>>> Closes:
>>> https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
>>> Link:
>>> https://syzkaller.appspot.com/bug?id=5335c7c62bfff89bbb1c8f14cdabebe91909060f
>>> Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
>>> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
>>> ---
>>>
>>> Notes:
>>>      V2 -> V3:
>>>      * attach the forgotten changelog
>>>      V1 -> V2:
>>>      * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
>>>        syzkaller repro and missing XDP_PACKET_HEADROOM in pad
>>>      * changed the title and description of the execution path,
>>> suggested
>>>        by Jason Wang <jasowang@redhat.com>
>>>      * move the limit check from tun_can_build_skb() to
>>> tun_build_skb() to
>>>        remove duplication and locking issue, and also drop the packet in
>>>        case of a failed check - noted by Jason Wang
>>> <jasowang@redhat.com>
>>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>>
>> Thanks
>>
>>>
>>>   drivers/net/tun.c | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index d75456adc62a..7c2b05ce0421 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -1594,10 +1594,6 @@ static bool tun_can_build_skb(struct
>>> tun_struct *tun, struct tun_file *tfile,
>>>          if (zerocopy)
>>>                  return false;
>>>
>>> -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
>>> -           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
>>> -               return false;
>>> -
>>>          return true;
>>>   }
>>>
>>> @@ -1673,6 +1669,9 @@ static struct sk_buff *tun_build_skb(struct
>>> tun_struct *tun,
>>>          buflen += SKB_DATA_ALIGN(len + pad);
>>>          rcu_read_unlock();
>>>
>>> +       if (buflen > PAGE_SIZE)
>>> +               return ERR_PTR(-EFAULT);
> 
> Concretely I'm saying maybe use SKB_FRAG_PAGE_ORDER "size" here?
> 
> e.g. create SKB_FRAG_PAGE_SIZE define as below.
>  if (buflen > SKB_FRAG_PAGE_SIZE)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 656ea89f60ff..4c4b3c257b52 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2886,7 +2886,8 @@ extern int sysctl_optmem_max;
>  extern __u32 sysctl_wmem_default;
>  extern __u32 sysctl_rmem_default;
> 
> -#define SKB_FRAG_PAGE_ORDER    get_order(32768)
> +#define SKB_FRAG_PAGE_SIZE     32768
> +#define SKB_FRAG_PAGE_ORDER    get_order(SKB_FRAG_PAGE_SIZE)
>  DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
> 
>>> +
>>>          alloc_frag->offset = ALIGN((u64)alloc_frag->offset,
>>> SMP_CACHE_BYTES);
>>>          if (unlikely(!skb_page_frag_refill(buflen, alloc_frag,
>>> GFP_KERNEL)))
>>>                  return ERR_PTR(-ENOMEM);
> 
> --Jesper
> 

