Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF827F9DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjK0KiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjK0KiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:38:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B325A194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:38:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a0b65cbf096so221323566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701081499; x=1701686299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1M3FyjEd1+wYJ9VaDcWQDDFv+gyP4VNkOiJ3KwZCro=;
        b=yqMwMqm0y/unH1A6XWpYrGGkeL6VxWUjAZhwxGCxGAqL6mhmpffrjQ1nxPe6Hoc868
         CVvzgCcfkASOX7UOkqXnVfk7vbMThXHmNqmU7ac1gUUb/gz3dKI/lh0DljcP+rDfTKcM
         6yG4cGIA0mok0E+htbGWk/x5P/8+2OaoYm4dI0fbJgq7T7WgA9qIhqFQv+rRU5tsChPf
         7bUs7xH+JG2Xe6TF4Q4n6Wz6h53P2DlsfVMbZtORbnlzmLUut9JOD68Q122CW/HekJy0
         k5UsxGOamruPvo0Uj2w7lPAU4ewytfBr083jXV2+zYOZhqBkRE1YmO9ph8JnSmcajR5Z
         diqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081499; x=1701686299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1M3FyjEd1+wYJ9VaDcWQDDFv+gyP4VNkOiJ3KwZCro=;
        b=l6h7gL1Osf2OGkDJWFVgXR2psinNUlDidJKBGIQ4x7a/Uo3yv5ZkPu8opzE1mjYOkQ
         IQP1JK+b2plOWEq8P1tizalpct8uWvihUH4L0tPPg0kYQJnZsE6dDOE+t3XIwZe3ad+J
         8xj6vPD2fcsqtyewhhz4I8b47nPY9OcD0BrWP8v1QUG5/QVPXBs3m/MPQ6Dshxhv4Opt
         8fOw9zWbDS3JllZVrRn6sDO1golHtSi3fjGamLWxVRD4g6zkrXuq2suOPUHjm1WMJcQU
         NU9Jm39Jmf+FX940ehsXMdBoC+VvuJxA+xRp+2cyem6+henIlpv88dFyRs+Xtc8rBcn3
         SyrA==
X-Gm-Message-State: AOJu0Yzm0//N4DB9tZ84VQIeCteSsA67SYT5UV0QXJNAmcU9icekWIoS
        docWGps/UaQdfLPn6CF8hZBNDA==
X-Google-Smtp-Source: AGHT+IHyCDEQKt9WcsRJsakMLLaJICDYP2kpu94TcaXHaZX5cfNoR94qpJbzpHMYearEbT5A3aAI+w==
X-Received: by 2002:a17:906:39c9:b0:9f3:18f8:475b with SMTP id i9-20020a17090639c900b009f318f8475bmr7822058eje.62.1701081498848;
        Mon, 27 Nov 2023 02:38:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906080800b009fdc15b5304sm5544618ejd.102.2023.11.27.02.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 02:38:18 -0800 (PST)
Message-ID: <0c35dd80-8062-4f1b-9127-8a5cb2deca40@linaro.org>
Date:   Mon, 27 Nov 2023 11:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nfc: Protect access to nfc_dev in an llcp_sock with a
 rwlock
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
References: <cover.1700943019.git.code@siddh.me>
 <7c198c2aa08b34045b8f9e0afe3d0b3bf5802180.1700943019.git.code@siddh.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7c198c2aa08b34045b8f9e0afe3d0b3bf5802180.1700943019.git.code@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 21:26, Siddh Raman Pant wrote:
> llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame(), which accesses the
> nfc_dev from the llcp_sock for getting the headroom and tailroom needed
> for skb allocation.

This path should have reference to nfc device: nfc_get_device(). Why is
this not sufficient?

> 
> Parallely, the nfc_dev can be freed via the nfc_unregister_device()
> codepath (nfc_release() being called due to the class unregister in
> nfc_exit()), leading to the UAF reported by Syzkaller.
> 
> We have the following call tree before freeing:
> 
> nfc_unregister_device()
> 	-> nfc_llcp_unregister_device()
> 		-> local_cleanup()
> 			-> nfc_llcp_socket_release()
> 
> nfc_llcp_socket_release() sets the state of sockets to LLCP_CLOSED,
> and this is encountered necessarily before any freeing of nfc_dev.

Sorry, I don't understand. What is encountered before freeing?

> 
> Thus, add a rwlock in struct llcp_sock to synchronize access to
> nfc_dev. nfc_dev in an llcp_sock will be NULLed in a write critical
> section when socket state has been set to closed. Thus, we can avoid
> the UAF by bailing out from a read critical section upon seeing NULL.
> 
> Since this is repeated multiple times in nfc_llcp_socket_release(),
> extract the behaviour into a new function.
> 
> Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  net/nfc/llcp.h          |  1 +
>  net/nfc/llcp_commands.c | 27 ++++++++++++++++++++++++---
>  net/nfc/llcp_core.c     | 31 +++++++++++++++++++------------
>  net/nfc/llcp_sock.c     |  2 ++
>  4 files changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
> index d8345ed57c95..800cbe8e3d6b 100644
> --- a/net/nfc/llcp.h
> +++ b/net/nfc/llcp.h
> @@ -102,6 +102,7 @@ struct nfc_llcp_local {
>  struct nfc_llcp_sock {
>  	struct sock sk;
>  	struct nfc_dev *dev;
> +	rwlock_t rw_dev_lock;

I dislike the idea of introducing the third (!!!) lock here. It looks
like a bandaid for this one particular problem.

>  	struct nfc_llcp_local *local;
>  	u32 target_idx;
>  	u32 nfc_protocol;
> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 39c7c59bbf66..b132830bc206 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c
> @@ -315,13 +315,24 @@ static struct sk_buff *llcp_allocate_pdu(struct nfc_llcp_sock *sock,
>  {
>  	struct sk_buff *skb;
>  	int err, headroom, tailroom;
> +	unsigned long irq_flags;
>  
>  	if (sock->ssap == 0)
>  		return NULL;
>  
> +	read_lock_irqsave(&sock->rw_dev_lock, irq_flags);
> +
> +	if (!sock->dev) {
> +		read_unlock_irqrestore(&sock->rw_dev_lock, irq_flags);
> +		pr_err("NFC device does not exit\n");

exist?



Best regards,
Krzysztof

