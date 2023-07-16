Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10862755109
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGPTcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjGPTbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:31:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A94A10DC;
        Sun, 16 Jul 2023 12:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689535899; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bCHJXAWqFrlCz+zWKyqSzG341vQQAp7pBK/qvFxyE20HNC7LZ85wW8ZGCvYoDsdICH
    tNquy81baeGXheSPbAY7WQqtjX0w8e642vbtewjm0cN909qaQ9715OnA7pyEVSFJzDA2
    9GneudrGcTNd8pUUHJjgiNqqAzEQJyw7zjtfWKQ4BoN3vEKs26wFQ9VVdkfOemdJrzRw
    UMka7YU9V1/cmbmlU9TN8lP9+eySErn3U7cOxwMojBwmK+i8CeSx3ni1OpbJsaUu8bZ7
    UrW/L0UxiKDEHQWcZfLaZIwOiKwvfF4pjlmLq477iLp/gtVfG5iQ9CtjDM/U/9ThB7fn
    XhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689535899;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4qg+hm9Oc0pZlsRg2Xzy++2zgRMcEaGBSMIJv8sGLjE=;
    b=T/s76tRn6iLKpCXn/8cVzTRjUZbRuR3wuZoqCE2O5fyMasNfTXRn1z/WIMUQ2AmfrL
    Ilg/PqL6fNCy8OuABFKDSV9PaQS5HPklRUwEkLIgx2u8lQ27z+OSEKK1iVRXUT/eunc2
    h4hxh9019LChG8qzjTmKeHqvqu8df7yGsWKgPwFf1csOLfAZlfexMaO8QWg10zzkwYRJ
    TSYIT7p1qh/n8Epv32QDC+UVr8ils/P+Pr8RyWAFsjaHb0R6Be7Ksi5+R65qfjBJ9Cxc
    ZSCOEeARy5L/EAp0+TdtIvn2VWv8IGPPJNRZZ+kSC+H6bOHtZx7pb1km8DZp9zowcFjX
    xYcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689535899;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4qg+hm9Oc0pZlsRg2Xzy++2zgRMcEaGBSMIJv8sGLjE=;
    b=st4hjwgr8mlL/Tlt1lWz703eRv8JadvLC3JFGrBH2aHtTt96fU9NabSLaltVKPqd78
    V+auYbhEye6vuRud7CTtQi5DuDjFwJPHGrrLDfVm2wIb42QXm+VvzHhpPA9yhU4uOpze
    //bHJw3UqNE2CZMy8TKvcIl43DM2UQ3rDXVlxQWC6CArKyLL0R5w5p6CrdaBnkxQsPqf
    vs8NNTPkwzfzW3vRcQD23Iv34/zgl/FAoS9s3UjWWlBVYroSH4+ganxtygmP1etVh7bZ
    JWg4cA2VbnCCWIACecRB62PdHLW62POG1lpzjbmNY8S2h1nGs+zic5L7vdvD5OnU4cXM
    gIrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689535899;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4qg+hm9Oc0pZlsRg2Xzy++2zgRMcEaGBSMIJv8sGLjE=;
    b=Jmo9YwFC8HXKdIVtm8fjWlwVqBL/7ierbp81dflpfGzP+Lhhn7CDl+EQGqxe0HWO8t
    G3b8lmDtUW0TUAnmm1DA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USMYf18Ur0Ek+pO2hQdvn7YdKBgBg=="
Received: from [IPV6:2a00:6020:4a8e:5000:24a3:79d0:f837:508e]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z6GJVcawm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 16 Jul 2023 21:31:38 +0200 (CEST)
Message-ID: <c229e4ec-83f5-e720-80cf-2f880afb4d2d@hartkopp.net>
Date:   Sun, 16 Jul 2023 21:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] can: bcm: Fix UAF in bcm_proc_show()
To:     YueHaibing <yuehaibing@huawei.com>, mkl@pengutronix.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, urs.thuermann@volkswagen.de
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230715092543.15548-1-yuehaibing@huawei.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230715092543.15548-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello YueHaibing,

thanks for the patch!

Indeed the proc entry can be removed as first action after lock_sock(). 
Good catch!

On 2023-07-15 11:25, YueHaibing wrote:
> BUG: KASAN: slab-use-after-free in bcm_proc_show+0x969/0xa80
> Read of size 8 at addr ffff888155846230 by task cat/7862
> 
> CPU: 1 PID: 7862 Comm: cat Not tainted 6.5.0-rc1-00153-gc8746099c197 #230
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xd5/0x150
>   print_report+0xc1/0x5e0
>   kasan_report+0xba/0xf0
>   bcm_proc_show+0x969/0xa80
>   seq_read_iter+0x4f6/0x1260
>   seq_read+0x165/0x210
>   proc_reg_read+0x227/0x300
>   vfs_read+0x1d5/0x8d0
>   ksys_read+0x11e/0x240
>   do_syscall_64+0x35/0xb0
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Allocated by task 7846:
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x21/0x30
>   __kasan_kmalloc+0x9e/0xa0
>   bcm_sendmsg+0x264b/0x44e0
>   sock_sendmsg+0xda/0x180
>   ____sys_sendmsg+0x735/0x920
>   ___sys_sendmsg+0x11d/0x1b0
>   __sys_sendmsg+0xfa/0x1d0
>   do_syscall_64+0x35/0xb0
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 7846:
>   kasan_save_stack+0x1e/0x40
>   kasan_set_track+0x21/0x30
>   kasan_save_free_info+0x27/0x40
>   ____kasan_slab_free+0x161/0x1c0
>   slab_free_freelist_hook+0x119/0x220
>   __kmem_cache_free+0xb4/0x2e0
>   rcu_core+0x809/0x1bd0
> 
> bcm_op is freed before procfs entry be removed in bcm_release(),
> this lead to bcm_proc_show() may read the freed bcm_op.
> 
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks!

Oliver

> ---
>   net/can/bcm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 9ba35685b043..9168114fc87f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1526,6 +1526,12 @@ static int bcm_release(struct socket *sock)
>   
>   	lock_sock(sk);
>   
> +#if IS_ENABLED(CONFIG_PROC_FS)
> +	/* remove procfs entry */
> +	if (net->can.bcmproc_dir && bo->bcm_proc_read)
> +		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
> +#endif /* CONFIG_PROC_FS */
> +
>   	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
>   		bcm_remove_op(op);
>   
> @@ -1561,12 +1567,6 @@ static int bcm_release(struct socket *sock)
>   	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
>   		bcm_remove_op(op);
>   
> -#if IS_ENABLED(CONFIG_PROC_FS)
> -	/* remove procfs entry */
> -	if (net->can.bcmproc_dir && bo->bcm_proc_read)
> -		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
> -#endif /* CONFIG_PROC_FS */
> -
>   	/* remove device reference */
>   	if (bo->bound) {
>   		bo->bound   = 0;
