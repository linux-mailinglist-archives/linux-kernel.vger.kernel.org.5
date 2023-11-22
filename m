Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496177F3B29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjKVBUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjKVBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:20:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FAD47
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:20:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d895584f1so4384208f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700615999; x=1701220799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvyPJLsHa1UpzCT3gFYRcmMF12jLhkR+Wt3mbotrxRk=;
        b=KumbRlB90XYBW8j7cdiG7lfmPdHCFrPGxonREYx92n57uObv+dpSrFN1MWPyH6P9bT
         GV0T8MvT/dkPtWPBTJuV8phr6tHR83v7aZ6+49oGVX4ZLizdIgoEGyjXX5LQsHsJSNHR
         WJ3zxWrhw4VR+gCeFRWSDo7l1hEu607aNeAVy3zITzef5OQEflMuBo1Mra4GJoIZpI2R
         zJvvogcwIVeLgtvyqO5uZ7zGsK8IegQPL46qXpwCvqJ++ECxgckBzx8Wru6ejWNDaUdj
         uMSxwZXTD6NG9nNsol/fb8myYhOzEj+OqW+HV704QcL/HBsP5oYpelvtZ70SGhE9f6Gm
         LLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615999; x=1701220799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvyPJLsHa1UpzCT3gFYRcmMF12jLhkR+Wt3mbotrxRk=;
        b=um+DRr+FOxaCqWHOhbimDpjbaWGfi0wLmlTke610880u0HDLPQf3fEtI13pZax2Nxp
         DshLaQ3d4H8DNDdrK2zu8IJ386VJuTn47+PPGJnHnTEahF+3Wtih+FcnVeZ/p2vcDjkl
         wOBvELNsDCgILV82G+zXsa5NT6u246MW0kj0xY3XKm62U6g4Dj6pa1xziM0AH6VBdsOA
         rY8mSS97Fh3Z4z5w6ojAoRTY7bnAAwekNQU4CmtLM/IHyuTz3i2pwGhnqeDin2YDiKeK
         Og5ZG26BBs4lWgaH8c/EeSApbdMtNaQvHKKeRXSvWpPhrT0ulWG+gkBeHU7QJxszqGkR
         gXsg==
X-Gm-Message-State: AOJu0Yy4Dx3t3ipcUBVwzDtht6n/jiXmBTGWVJw1sG4y5vfI3PDiPOZF
        D7UoShmxtzDGUlLFUfhQopDoJw==
X-Google-Smtp-Source: AGHT+IHJ3uIIPfIuSkwAwBuVvZkulHL9TorT06BnqC1fY1KxSN0gT//3TraVnbvp+C8HbHOFbqTPtg==
X-Received: by 2002:a5d:4b8b:0:b0:331:69a2:cad2 with SMTP id b11-20020a5d4b8b000000b0033169a2cad2mr441587wrt.62.1700615999272;
        Tue, 21 Nov 2023 17:19:59 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d8-20020adffbc8000000b003316aeb280esm14956932wrs.104.2023.11.21.17.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 17:19:58 -0800 (PST)
Message-ID: <a838b389-4c0b-484d-98bd-33f8ef4c88f2@arista.com>
Date:   Wed, 22 Nov 2023 01:19:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
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
References: <20231121020111.1143180-1-dima@arista.com>
 <20231121020111.1143180-8-dima@arista.com>
 <CANn89iK-=G7p5CMuJDjioa7+ynZRrOOpd7bK3kPzxCXzygfFCQ@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iK-=G7p5CMuJDjioa7+ynZRrOOpd7bK3kPzxCXzygfFCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 08:13, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 3:01 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> This extra check doesn't work for a handshake when SYN segment has
>> (current_key.maclen != rnext_key.maclen). It could be amended to
>> preserve rnext_key.maclen instead of current_key.maclen, but that
>> requires a lookup on listen socket.
>>
>> Originally, this extra maclen check was introduced just because it was
>> cheap. Drop it and convert tcp_request_sock::maclen into boolean
>> tcp_request_sock::used_tcp_ao.
>>
>> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  include/linux/tcp.h   | 10 ++++------
>>  net/ipv4/tcp_ao.c     |  4 ++--
>>  net/ipv4/tcp_input.c  |  5 +++--
>>  net/ipv4/tcp_output.c |  9 +++------
>>  4 files changed, 12 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>> index 68f3d315d2e1..3af897b00920 100644
>> --- a/include/linux/tcp.h
>> +++ b/include/linux/tcp.h
>> @@ -155,6 +155,9 @@ struct tcp_request_sock {
>>         bool                            req_usec_ts;
>>  #if IS_ENABLED(CONFIG_MPTCP)
>>         bool                            drop_req;
>> +#endif
>> +#ifdef CONFIG_TCP_AO
>> +       bool                            used_tcp_ao;
> 
> Why adding another 8bit field here and creating a hole ?

Sorry about it, it seems that I

(1) checked with CONFIG_MPTCP=n and it seemed like a hole
(2) was planning to unify it with other booleans under bitfileds
(3) found that some bitfileds require protection as set not only
    on initialization, so in the end it either should be flags+set_bit()
    or something well-thought on (that separate bitfileds won't be
    able to change at the same time)
(4) decided to focus on fixing the issue, rather than doing 2 things
    with the same patch

Will fix it up for v2, thanks!

> 
>>  #endif
>>         u32                             txhash;
>>         u32                             rcv_isn;
>> @@ -169,7 +172,6 @@ struct tcp_request_sock {
>>  #ifdef CONFIG_TCP_AO
>>         u8                              ao_keyid;
>>         u8                              ao_rcv_next;
>> -       u8                              maclen;
> 
> Just rename maclen here to  used_tcp_ao ?
> 
>>  #endif
>>  };
>>

Thanks,
             Dmitry

