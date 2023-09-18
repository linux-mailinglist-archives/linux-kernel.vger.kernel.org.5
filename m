Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92D7A4388
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbjIRHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjIRHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:52:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E31AA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:48:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c576d35feso3881248b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695023330; x=1695628130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmPJUeRmGlrr7ZOL7yO07ODjPeIo7fJ0V72dQGfG3EE=;
        b=TLz+wWb6QjPaC20tJdpt2w5/ODGLJkdRUMwkxqsbRXDhC6uVzpRTg8ZOkdmhvtF15X
         bsDBF6qIysEqpvjvD/Jv8fxX5ErSArs2NU+tJceWDmzWuuZMnmrmexrp6zBruChRmn8c
         o2/fSH1+xFmw0okvvW9yOtcSSmE9mpLbUxp9xnbPRC5thLJY9TtpHU5i84kQk0kj2oDY
         4kBU2iNZAt589b2LFptEmUiOUyBKNjsN8tb+azEiYpyQRX0P17r4dyG8uQDxPhttATNI
         L8R03Wsebn4SJrCusJ5unBMz7gp08MBMDSYEV9QhLB4ryLefWFe3KhgEJV/eOwZDgVet
         iqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695023330; x=1695628130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmPJUeRmGlrr7ZOL7yO07ODjPeIo7fJ0V72dQGfG3EE=;
        b=s5Io32io9kT+jb6MqAu74tDIRz3V6I0AO4inM9aznJlUC/a6zQBEzAuJJMW49JZZFX
         csCNHxZFQh7MokLNVBUPyu0AK1A+6fCQ1eW+PAmGVysO7rC0AR7UdKFnbZ7QdptXZSVn
         elO5KivKpRn/w5J40PCbsoeTnxniT/i/kyEqlM/czQVkXh1QE4BKQunCHE3jbTkW6SJw
         4yK11L5xOmtO6wsLUD/YK4Gbe5IiGCxT/94TduZKymUxh3aVu0AT+EVdg/Gq66/C+rJJ
         091Sor4oEOklbRUYad04SeMbmyEt4jjH8tO8zQSlnmaGwZtZwPjoJi8mmUBXh0gs7ZFO
         D2dg==
X-Gm-Message-State: AOJu0YzqMygxjNayc6hTXY1Mzmklm+MDBJYn4SPYQtJXiCnXNx/J099K
        cWe9+A6rCau8vL9cs7VMht6FbQ==
X-Google-Smtp-Source: AGHT+IFOar8uTivRcaTdmiCu7ECbgRQSP1xI2cWroqrLtu3MSOVG0cnFtJK1UrO+j+9nXaWVod2Iaw==
X-Received: by 2002:a05:6a20:6a1a:b0:137:a08b:8bef with SMTP id p26-20020a056a206a1a00b00137a08b8befmr10484697pzk.44.1695023330281;
        Mon, 18 Sep 2023 00:48:50 -0700 (PDT)
Received: from [10.254.1.7] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b001c474d6a408sm2238768plb.201.2023.09.18.00.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 00:48:49 -0700 (PDT)
Message-ID: <8c470d4d-b972-3f43-9b0a-712ee882a402@bytedance.com>
Date:   Mon, 18 Sep 2023 15:48:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware sockets
 under pressure
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <20230901062141.51972-4-wuyun.abel@bytedance.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230901062141.51972-4-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 2:21 PM, Abel Wu wrote:
> @@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>   	if (sk_has_memory_pressure(sk)) {
>   		u64 alloc;
>   
> -		if (!sk_under_memory_pressure(sk))
> +		/* Be more conservative if the socket's memcg (or its
> +		 * parents) is under reclaim pressure, try to possibly
> +		 * avoid further memstall.
> +		 */
> +		if (under_memcg_pressure)
> +			goto suppress_allocation;
> +
> +		if (!sk_under_global_memory_pressure(sk))
>   			return 1;
> +
> +		/* Trying to be fair among all the sockets of same
> +		 * protocal under global memory pressure, by allowing
> +		 * the ones that under average usage to raise.
> +		 */
>   		alloc = sk_sockets_allocated_read_positive(sk);
>   		if (sk_prot_mem_limits(sk, 2) > alloc *
>   		    sk_mem_pages(sk->sk_wmem_queued +

I totally agree with what Shakeel said in last reply and will try ebpf-
based solution to let userspace inject proper strategies. But IMHO the
above hunk is irrelevant to the idea of this patchset, and is the right
thing to do, so maybe worth a separate patch?

This hunk originally passes the allocation when this socket is below
average usage even under global and/or memcg pressure. It makes sense
to do so under global pressure, as the 'average' is in the scope of
global, but it's really weird from a memcg's point of view. Actually
this pass condition was present before memcg pressure was introduced.

Please correct me if I missed something, thanks!

Best,
	Abel
