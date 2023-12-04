Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5E803B23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjLDRIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDRIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:08:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1DCD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:08:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so49443305e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701709702; x=1702314502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eM2Bf2WoC1yvqXGfr4khi6TDVXFpyxPzOUHleHrubpg=;
        b=W1Hp4fyVhOpqZS8p3cF5mIFuDz6mEbLDXeLzHaub3VV6UMDKtTVKyro0BgOH0+NuRe
         uadbFzvxY5hDvwX13GifbmGiqGSSk9D/vQ6DWpzoNdY3MqUXdkwjYoAQUt8Mh/V1G5TX
         3x2aj10HT1RUfMoPYnBrtgh6gfbPG4rV0M+29molgPq5GwezjOm710S8WWvLgfj/eC/8
         gxLUenkjAlSn3q1I3thxZ7YoFuS7XVgBXkszOAG4j3dGizbd+fXTHR5cMpaMFDIlWf5X
         t8FzN0DgtERGHyjrmvmkU1aZSmptLB5pYRT8UZxAFky8hR7Ythf8U/5/BrrQQ7dpIccK
         BiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701709702; x=1702314502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM2Bf2WoC1yvqXGfr4khi6TDVXFpyxPzOUHleHrubpg=;
        b=ZENW3NbOsUh7LuGLoi+Fu4U7OTt/OtYrM2ZvW5pgO5pIURsftjsnC5TMC6Xq9lLjuK
         Kfp9EU1lWzH3IzmFY25VnHMRYUj/2QPVqiQnDAHUjfqIzvpdY3H29eNOTDFUOTQMhrA0
         BwScvpQ6LktLnd4bY1deb323cHNXuChlm/22xvsxJ9O5+BLHxitUZ9AQ5hr3oHPL0orj
         3g/xsgjxbbMkFlInSHKTLA54O0jd+x/NExrZ4gHc3aacmykjxj3PNjZiyub8ZHRebMqe
         G+lX3962bz1dXjRHt+6aTwIgJaJ82HQ5Uf/J4wNoqt9zZwuwU/Tiq4s8QP1KHOv6OFbr
         WlCw==
X-Gm-Message-State: AOJu0Yw7JZ1PAUODGK61YXGobG241LQLQUG6c4/X16yuQk6uyNZayeag
        AEYQx+BpCalfs8v9sH+95BPynA==
X-Google-Smtp-Source: AGHT+IHsbfqa9QPkIow4yLzsiSHbNp9DKxut6KL9bOx2g6HB59PsiIezFgw/f5llkoaX6xiR1Zr9/A==
X-Received: by 2002:a05:600c:5247:b0:40b:5e59:99a8 with SMTP id fc7-20020a05600c524700b0040b5e5999a8mr1862808wmb.200.1701709701454;
        Mon, 04 Dec 2023 09:08:21 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0040c0902dc22sm6127004wmo.31.2023.12.04.09.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:08:20 -0800 (PST)
Message-ID: <45d63402-bd0f-4593-8e57-042c0753f3e3@arista.com>
Date:   Mon, 4 Dec 2023 17:08:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com> <20231202171612.GC50400@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231202171612.GC50400@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 12/2/23 17:16, Simon Horman wrote:
> On Wed, Nov 29, 2023 at 04:57:20PM +0000, Dmitry Safonov wrote:
>> RFC 5925 (6.2):
>>> TCP-AO emulates a 64-bit sequence number space by inferring when to
>>> increment the high-order 32-bit portion (the SNE) based on
>>> transitions in the low-order portion (the TCP sequence number).
>>
>> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
>> Unfortunately, reading two 4-bytes pointers can't be performed
>> atomically (without synchronization).
>>
>> In order to avoid locks on TCP fastpath, let's just double-account for
>> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
>>
>> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> ...
> 
>> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> index 647781080613..b8ef25d4b632 100644
>> --- a/include/net/tcp_ao.h
>> +++ b/include/net/tcp_ao.h
>> @@ -121,8 +121,8 @@ struct tcp_ao_info {
>>  	 * - for time-wait sockets the basis is tw_rcv_nxt/tw_snd_nxt.
>>  	 *   tw_snd_nxt is not expected to change, while tw_rcv_nxt may.
>>  	 */
>> -	u32			snd_sne;
>> -	u32			rcv_sne;
>> +	u64			snd_sne;
>> +	u64			rcv_sne;
>>  	refcount_t		refcnt;		/* Protects twsk destruction */
>>  	struct rcu_head		rcu;
>>  };
> 
> Hi Dmitry,
> 
> In tcp_ao.c:tcp_ao_connect_init() there is a local
> variable:
> 
>         struct tcp_ao_info *ao_info;
> 
> And the following assignment occurs:
> 
>                 ao_info->snd_sne = htonl(tp->write_seq);
> 
> Is this still correct in light of the change of the type of snd_sne?

Thanks for the report.
Yes, it's correct as lower 4-bytes are initialized as initial SEQ.
I'll add a cast for it if I'll go with v5 for this patch.

> 
> Flagged by Sparse.
> 

Thanks,
             Dmitry

