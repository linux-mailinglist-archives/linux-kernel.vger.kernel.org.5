Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AEB7FDF27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjK2SOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2SON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:14:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4BB9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:14:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3331752d2b9so67455f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701281658; x=1701886458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wY9WeKtXlEdT6ZB9TX0PBdHOlwsuJkt60GHvQlNmDZk=;
        b=eNe2jYbiHpkwa/ZNkwOKT14qO98/sNJ5OK0f5gcf2tcDDzf6G05TeflGiDnlPn0b/F
         0jxSCryWYJh/61ZODteUoF8r6sudle8sNM1yGrTdsJjOjjXDkql/4VHQIXo3boRe6szq
         LSMOp+vWjXRrseRTWyFWY8Jaes+wBc2bm/EJc4fK10Kb1VYQQe8Y2yP6BLIcvkouJfcj
         VC+dT8srvnfX+I6dAg3oLRuvC2vjnEOBnCt5OTGXG74Qy2aj93cKs31RpOYW0ap1OlHL
         KN7Pmo9ak++sDXbQQwhOI13g+tXtu6+FZZMky8pD3e6W1rJGuI1c6bap6T2v5ce6L/M/
         vS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281658; x=1701886458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY9WeKtXlEdT6ZB9TX0PBdHOlwsuJkt60GHvQlNmDZk=;
        b=ATEBJlOt41kfBAMHsX5aqE4BzEQD1p+nXYSBvU8uUqYypvvsZAoIfeel8/ggZtqMvD
         pCL9KIgiL0f3gubvWeWxjf05O0Ql6qp5ayCdR8axR5gCg/yGBARal2Y9KXKy5L44IhuJ
         qE9/r3yZ+HJmip0UNrhB0h+AwnglP42QjsuXNZEffX9AiX39cO5Cw6CQwamf75UFScuU
         x0Bv2xn9lQlj71KuHnrNT8jgdlAQBvwY2OTHCyMuamjQaR5qMUNi4rL0YUS1Gh2RoCgS
         1v5XAvoACft7jXra4OGHTVqcvuDA7VuQNeoaJ24l6C7KPZ7ge28ASAb5vJblUPypr0J1
         R1+Q==
X-Gm-Message-State: AOJu0YzGIr+mwBDwayq15tlXyfiMe06tnoa0hpS0ctfaJpAFAcn13cdK
        LV/Fn359XZR7ISvxjW5Oax08DQ==
X-Google-Smtp-Source: AGHT+IHofg/hK+69psa2zHUNArxjJYgRtbYj/y3G4jlgWw7XUJhrw71mnLqzsxXOXWGxw3ObhmdCgQ==
X-Received: by 2002:a05:6000:88:b0:331:6b82:a3ad with SMTP id m8-20020a056000008800b003316b82a3admr13548656wrx.60.1701281658390;
        Wed, 29 Nov 2023 10:14:18 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d4602000000b0032da4c98ab2sm18812649wrq.35.2023.11.29.10.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:14:17 -0800 (PST)
Message-ID: <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com>
Date:   Wed, 29 Nov 2023 18:14:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com>
 <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 18:09, Eric Dumazet wrote:
> On Wed, Nov 29, 2023 at 5:57 PM Dmitry Safonov <dima@arista.com> wrote:
>>
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
> 
> This will not work on 32bit kernels ?

Yeah, unsure if there's someone who wants to run BGP on 32bit box, so at
this moment it's already limited:

config TCP_AO
	bool "TCP: Authentication Option (RFC5925)"
	select CRYPTO
	select TCP_SIGPOOL
	depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)

Probably, if there will be a person who is interested in this, it can
get a spinlock for !CONFIG_64BIT.

> Unless ao->snd_sne and ao->rcv_sneare only read/written under the
> socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
> necessary)

Thanks,
            Dmitry

