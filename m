Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314DE7E1099
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 19:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjKDS2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 14:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjKDS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 14:28:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649951BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 11:28:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c10f098a27so2632857b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699122512; x=1699727312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Raflo2MBCaVxBeRy7GF6tekllGnegpXQwpqv2rpEa4=;
        b=ScwqdFiHbXZNgbXoMVlLHyOWjkB3JCmJGcSM1LgTY1yV3eOfjh0d7ddz0j74dkmzGp
         xQHsfNaSo7NW+aSpEV0GV7/H4XAHxPjN/ZxqhlI3ACUhkiWgI1+PkzyueL1yMM1gkq2J
         S2UZBkIwbFO7sNJYOz9XivhzOkvLm47TrjhcWt5NVuX0/XAkO8R57XmCTXKxZLNSC0zW
         FCfGnHlJClnbdX79VS2+azRCS0eqY9oMSz34+IDKZ4H+sZaG8J8ZWbPIIsxpCgbdgu5T
         9Q5rPh21kJ+6FwfB6JUPBS5YC9TJsLDGc9z+e5SXy3szoiANAZwhEBXuulcyQzCRvNkL
         aeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699122512; x=1699727312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Raflo2MBCaVxBeRy7GF6tekllGnegpXQwpqv2rpEa4=;
        b=Em1p21SPWa6zUTc1q5/mqwEw66JmWz/6pfifR/A+EDsAxoIv5AZ+uQ4IGW13WatuYi
         jmmoti9pUlkVvGle77kA7OjZKWrlSnF6z35gqgboDJr1OmGoeBjf7Vj9fUr7cKPaXohU
         ee8IDueQTuKlLQBg5uUIxggdg4tXxtCNVWTbN/WEwjFORj2MHaIJ/UD7hYlxe2MB/56W
         spCd7Pbo9dclgHRHV6ghLw2KEAEHonqBsOuyLUX3oAXD42UFWRa65mQWMiFWuwl882ME
         ls9UQuKcYlkWQqFHBlDfS8lrduYlwQH3lwOcLXGS87KtqT801oWlGIeceH9FFf0y8oU3
         fGDw==
X-Gm-Message-State: AOJu0YxxYc9PjVvQPSby1Vo3RiK00ftjxOTQ/umqeNhmq6FxDdcxyZig
        fujofdAhYq1SaevTZmjdSyvb2Q==
X-Google-Smtp-Source: AGHT+IGaDGG/WtGKuZ1zNNq+ppYZY512/uaLCsfdkoU+LYbpvTT3T/3A11TecaxZQDaizKJ+OJEyaA==
X-Received: by 2002:a05:6a00:3a0e:b0:6c3:402a:d54d with SMTP id fj14-20020a056a003a0e00b006c3402ad54dmr6843336pfb.11.1699122511816;
        Sat, 04 Nov 2023 11:28:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::1052? ([2620:10d:c090:400::4:56eb])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00230100b006889511ab14sm3187642pfh.37.2023.11.04.11.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 11:28:31 -0700 (PDT)
Message-ID: <67c45ff3-4f98-4ca5-bd68-2d90cc52a775@davidwei.uk>
Date:   Sat, 4 Nov 2023 11:28:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
To:     Shigeru Yoshida <syoshida@redhat.com>, stefanha@redhat.com,
        sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
References: <20231104150531.257952-1-syoshida@redhat.com>
Content-Language: en-GB
From:   David Wei <dw@davidwei.uk>
In-Reply-To: <20231104150531.257952-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-04 08:05, Shigeru Yoshida wrote:
> KMSAN reported the following uninit-value access issue:
> 
> =====================================================
> BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
>  virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
>  vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
>  worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
>  kthread+0x3cc/0x520 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> Uninit was stored to memory at:
>  virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
>  virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
>  vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
>  worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
>  kthread+0x3cc/0x520 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
>  __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
>  virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
>  virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
>  virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
>  vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
>  process_one_work kernel/workqueue.c:2630 [inline]
>  process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
>  worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
>  kthread+0x3cc/0x520 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> Workqueue: vsock-loopback vsock_loopback_work
> =====================================================
> 
> The following simple reproducer can cause the issue described above:
> 
> int main(void)
> {
>   int sock;
>   struct sockaddr_vm addr = {
>     .svm_family = AF_VSOCK,
>     .svm_cid = VMADDR_CID_ANY,
>     .svm_port = 1234,
>   };
> 
>   sock = socket(AF_VSOCK, SOCK_STREAM, 0);
>   connect(sock, (struct sockaddr *)&addr, sizeof(addr));
>   return 0;
> }
> 
> This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
> `struct virtio_vsock_hdr` are not initialized when a new skb is allocated
> in `virtio_transport_init_hdr()`. This patch resolves the issue by
> initializing these fields during allocation.
> 
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
> Reported-and-tested-by: syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0c8ce1da0ac31abbadcd
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
> v1->v2:
> - Rebase on the latest net tree
> https://lore.kernel.org/all/20231026150154.3536433-1-syoshida@redhat.com/
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e22c81435ef7..dc65dd4d26df 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -130,6 +130,8 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
>  	hdr->dst_port	= cpu_to_le32(dst_port);
>  	hdr->flags	= cpu_to_le32(info->flags);
>  	hdr->len	= cpu_to_le32(payload_len);
> +	hdr->buf_alloc	= cpu_to_le32(0);
> +	hdr->fwd_cnt	= cpu_to_le32(0);

This change looks good to me.

I did notice that payload_len in virtio_transport_init_hdr is size_t but
len in struct virtio_vsock_hdr is __le32. But I don't think this is an
issue other than wasting some stack space, though.

>  }
>  
>  static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
