Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A462A788142
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbjHYHuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjHYHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:50:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E991FCA;
        Fri, 25 Aug 2023 00:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692949797; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gOuYORsRB7CedjL1wjPZJgtcTAMd2bl6h0FG1tMn90CKKxFVoTfbMqvoRpHBHw09fG
    xGJzVodlYN/TbFBUeW1aUGEyg8qQm2ow0u6tCZUTLGXf7CwjNpEp9YEwBMAD9sznCzJ0
    kBcFscFoi1AT8DBDez3fMzDEKTTnRirve4X1idhd0RDPmrCrQTfdAFFmCGGr9St0Dbq6
    hyYhuRSiGunEEeUSkDJYAsQAk8kxnsI/a8XAOyO7keNOwcu8VgIxi8U5lf7qxeuI9XZX
    jbu0vOcmJOGLW6mWwhSOw1g37cMC2y5HxVbOWWX/sw5B65BQUeG0l6qSiL8eJb3zW6MC
    xFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692949797;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w4kyC5c7zU+LrIlqHlb7dttD/XkGKQimL4Hv99ZYv6M=;
    b=G6caw6dzhaQ9yklQYgL+2JfaBOuhakMHS2TWdIsLRSid22c+CeTyTgl+uJ6dapybOV
    grY3j3VLoehontr+pnZM2BhMtfHwuustzzoQyHGM8VDCVcxRP864R5LtC4ULESK1Lk4b
    TzbTpatAw/2enpHf8oOS7j1lqCD8bQSK1XGuLwGfQvom6rPzDvNCnp86L5AsDRhDmaxc
    ydD4XxxUP91Wk6WAfJQOQJ2+He1I8QfmzG909f5bTMPf4Q/9+UPXea71/YVY1tXNvE4f
    XQ4DvlZqmbccAaCbMxb8WgoI7HeHeAxlDe/pqyijdxwzWn9Mi6bDrz1REFbFd8qyAMXo
    msAg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692949797;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w4kyC5c7zU+LrIlqHlb7dttD/XkGKQimL4Hv99ZYv6M=;
    b=L9LsaqYOwuUJBLfrluk4pPt+hZO2NBPnEa1KPA6g76Qeji8CkwbKhNwMi2xe4V1uOl
    GcGL/l6C/3pV7PaBE7YZaDYKaLj7PwOj0liALEVEsqvzd7zAd6plOyQaQZfLt/TzMc7B
    GhXxYfXfNLYxXCg9aYEbYwmRlcwbTIXW+LLbRtu1QoWQShsiCTZaSuC3HtovzW3tkVh4
    9WpjzttA6XghRNkvMGWRWY/7GyHpVJ4Whp5zad0NiGPsLxWZaGz0n7Hkfr/EqWaA2wOP
    fOSnCQSvqTKeOMITh7ZL0PxOjXsJPEaZaTKQDFrI1H8W41jHsxcU3JbXhB+YRxJUYXT5
    Vl0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692949797;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w4kyC5c7zU+LrIlqHlb7dttD/XkGKQimL4Hv99ZYv6M=;
    b=fdp5v2JcgHsWI+SQz5HqifLR+o4XaaccQkSqDu/9Uwq6yy/8WAnDcuIDQWNHUMj7S5
    1Q/yPnsj+YDgTaCDHnDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id K723f1z7P7nvC03
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 25 Aug 2023 09:49:57 +0200 (CEST)
Message-ID: <b9843df2-8a31-8578-0dd3-17686d31a8f9@hartkopp.net>
Date:   Fri, 25 Aug 2023 09:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] can: raw: Remove NULL check before dev_{put, hold}
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Simon Horman <horms@kernel.org>
References: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to hurry!

This improvement has already been reported by Simon Horman, see this 
discussion:

https://lore.kernel.org/linux-can/20230822200804.GC3523530@kernel.org/

Reported-by: Simon Horman <horms@kernel.org>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@Marc Kleine-Budde: Can you please take this patch via can-next tree?

Thanks,
Oliver


On 25.08.23 08:46, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
> 
> ./net/can/raw.c:497:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6231
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   net/can/raw.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index d50c3f3d892f..ff7797c37018 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -493,8 +493,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   
>   out_put_dev:
>   	/* remove potential reference from dev_get_by_index() */
> -	if (dev)
> -		dev_put(dev);
> +	dev_put(dev);
>   out:
>   	release_sock(sk);
>   	rtnl_unlock();
