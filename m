Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EF179D9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjILUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:19:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BBE4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:19:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-403012f276dso39280385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694549990; x=1695154790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlhqM27rqHR9etLBQ96r5C+BLx+QxLlIdMsL8tFgWx0=;
        b=KdVc2Tq9elFVxYKVMnf9Dw68ohLcm6KtfumW1dMj5VPy2xV91l4SDiQRb2dXEt5qwT
         /5NwZMVu3NqebPXT1X9LsXIje92BlNyW7uXNXNUgEXs7mnpsjytoQC+ZXnky1rddp+6w
         BKvLQwmoQvCNgLvDDG4ULSB6I2C3RN2uuaemNdQ+yqEAQ/3DtgdSkAvK3acdl1SAmlFx
         T9IRl5eG8OCZ3ENnu4qypGgwaqle1Jb7W9Dp+mQ0uILzm3w3C5x9D0/ipy7VVAL/pAwW
         94T0VapI4QD0iW3UVucDyNFncjg3y9mnsqGksUn6jIxLH/NK1Gf/Q6bJ8PVmThARrm0A
         Qvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549990; x=1695154790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlhqM27rqHR9etLBQ96r5C+BLx+QxLlIdMsL8tFgWx0=;
        b=msoqWiJvx0dUdeTjNhl5xqiyPrZ8ruHmdaD72KH13CICAAJ12Ev8W8ogCkqmrQzOHd
         i6gzyurKqZHZ7ayOTZsZ9Vkhz76rmpbN9UrxW3pJp60T7eii2ICEf2qozFL2fDqK1VZc
         m0Oxd8RvVDhq9WUn4mCcD1I1cyVML9qBHutaZgODIq5tU6v2LM555XgyyGQYKS5e01tT
         QbS9PBLIfy94j1O0Gvgw1NO4eXIT/wzFnmqNVyUFhCEoyLoU2LucyGsLzEsnqP4Wb/Tt
         /Acl6gVGrxVWHuQkdXoNqfgSG2SkF9eNKI4Y0SNp0F5/4YSQuQ0zq33vvAioDgcxpo8O
         fQ1g==
X-Gm-Message-State: AOJu0YxFTfK/hqm6oA1I81XzmsZ/H2e+m4T6bSnuu1oLEZiksQlaB55o
        STWM7YRmySdbfThXgG5WQgQtdg==
X-Google-Smtp-Source: AGHT+IFg+OxyjCt90WqNejUlpptQKmehtWomMrgOasbNbMQyKIk/1ktXbJ+bsu7UoPfHGmndqt5Elw==
X-Received: by 2002:a05:600c:108b:b0:3fe:2463:2614 with SMTP id e11-20020a05600c108b00b003fe24632614mr374381wmd.24.1694549989911;
        Tue, 12 Sep 2023 13:19:49 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j12-20020adfe50c000000b003176aa612b1sm13610710wrm.38.2023.09.12.13.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 13:19:49 -0700 (PDT)
Message-ID: <4e530711-51e4-6487-10ae-f61a6dc355e4@arista.com>
Date:   Tue, 12 Sep 2023 21:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230911210346.301750-1-dima@arista.com>
 <20230911210346.301750-7-dima@arista.com>
 <CANn89iKnv4AZQBfHMHsUQTKhkK1zC5qqeHUdEQcbDJWgK64dAg@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iKnv4AZQBfHMHsUQTKhkK1zC5qqeHUdEQcbDJWgK64dAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 17:47, Eric Dumazet wrote:
> On Mon, Sep 11, 2023 at 11:04 PM Dmitry Safonov <dima@arista.com> wrote:
[..]
>> @@ -1378,6 +1430,34 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>                                                md5, sk, skb);
>>         }
>>  #endif
>> +#ifdef CONFIG_TCP_AO
>> +       if (ao) {
>> +               u8 *traffic_key;
>> +               void *tkey_buf = NULL;
>> +               __be32 disn;
>> +
>> +               sk_gso_disable(sk);
> 
> Why is this needed here in a fast path ? This should happen once.
> 
> It seems you copied MD5 old logic, I think we should do better.

Yeah, I think it survived from TCP-AO PoC where it was mostly TCP-MD5
copy'n'paste. And survived by the reason that it it's small and seems
yet done for TCP-MD5.

Which doesn't mean it can't be better. The MD5 code seems to have been
introduced in:
https://marc.info/?l=linux-netdev&m=121445989106145&w=2

Currently, the described child sk issue can't happen as tcp_md5sig_info
is allocated in tcp_md5sig_info_add() regardless if it is setsockopt()
or child socket allocation. And tcp_md5sig_info_add() does
sk_gso_disable(sk).

I presume, sk_gso_disable() can be removed from both TCP-AO/TCP-MD5.
The only exception will be twsk, where it doesn't seem to matter.

>> +               if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
>> +                       if (tcb->tcp_flags & TCPHDR_ACK)
>> +                               disn = ao->risn;
>> +                       else
>> +                               disn = 0;
>> +
>> +                       tkey_buf = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
>> +                       if (!tkey_buf)
>> +                               return -ENOMEM;
> 
> This leaks an skb.

Ouch! Thanks for noticing, will repair.

> 
>> +                       traffic_key = tkey_buf;
>> +                       tp->af_specific->ao_calc_key_sk(ao_key, traffic_key,
>> +                                                       sk, ao->lisn, disn, true);
>> +               } else {
>> +                       traffic_key = snd_other_key(ao_key);
>> +               }
>> +               tp->af_specific->calc_ao_hash(opts.hash_location, ao_key, sk, skb,
>> +                                             traffic_key,
>> +                                             opts.hash_location - (u8 *)th, 0);
>> +               kfree(tkey_buf);
>> +       }
>> +#endif
>>
>>         /* BPF prog is the last one writing header option */
>>         bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
[..]
>> @@ -1837,8 +1921,17 @@ unsigned int tcp_current_mss(struct sock *sk)
>>                 if (mtu != inet_csk(sk)->icsk_pmtu_cookie)
>>                         mss_now = tcp_sync_mss(sk, mtu);
>>         }
>> -
>> -       header_len = tcp_established_options(sk, NULL, &opts, &md5) +
>> +#ifdef CONFIG_TCP_AO
>> +       ao_info = rcu_dereference_check(tp->ao_info, lockdep_sock_is_held(sk));
>> +       if (ao_info)
>> +               /* TODO: verify if we can access current_key or we need to pass
>> +                * it from every caller of tcp_current_mss instead. The reason
>> +                * is that the current_key pointer can change asynchronously
>> +                * from the rx path.
>> +                */
>> +               ao_key = READ_ONCE(ao_info->current_key);
>> +#endif
>> +       header_len = tcp_established_options(sk, NULL, &opts, &md5, ao_key) +
>>                      sizeof(struct tcphdr);
> 
> Adding yet another argument in TCP fast path routines is very unfortunate...
> 
> Could we merge md5/ao_key, and have a field giving the type ?

Hmm, I'll try to refactor this a little.

Thanks for taking a look,
          Dmitry

