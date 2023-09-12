Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA52279DA05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjILU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjILU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:26:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A4189
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:26:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so1310805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694550393; x=1695155193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXBBG+6wkcnVftLhA+kOSuKbXw7DujnI2FtLB+iJEJg=;
        b=Wn9rNpEJCm2pqN52HwwDm1dnpRF4ovE+OjHAm2ffksgbILSxd+c58Bi5+t6+BLHlG1
         GK+tiP4hpSmA0K5JPJkxUset0+leKT6c078XO/HzI3bOOIRzJwG0ngfCWgHjrnp3Z3li
         CXurhwHXSWFRLmdcwDsRcwMkoUOjFQpuaW+vJUXSdhUT4N7GNKNAoFtBfUsbuBdGR0p/
         7cm4OOvlPVGQG8M7VV+VzOlVD1/Rdu1JlBHyoNILQs6sWlhZPm91Aip46nC+tKtlTaWC
         RFKH9hbldd8m1v1HDsSUCnQCVqvAe7274bMX2c9EmKrUhLS8JUQ5oAYetdD3mqCgcGHL
         8Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694550393; x=1695155193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXBBG+6wkcnVftLhA+kOSuKbXw7DujnI2FtLB+iJEJg=;
        b=K5fwyRHqxXzADAgSNcEO7gSkJbaKQE+yLVBxT3J0zLCe+st5FNnHk51+EcijyG1hpd
         NgC+ra2w9u1zISaoaTTLigBLlV48bXThRoxEAx2MwVEIwOnnbyrQW6TSN0XiAI2w5O4t
         FNXJTpKKXoS8+i5Mj6Jle8AnWnGAKDyuPph1rLQVgWmv855rqoyQPtrmO/dBQ+nxvekg
         uGmu4xRc8wqeAMogJ8D9dmPQQe+g+kyah4ygtir9DArvIqCFYDTeSwnqiOZw5EiB4rb3
         YuKflxwZo2FpQsmO8NU0SsVfJONMoHTxXkNiaaeany9W/xIra8KlMowOr3LIjdlCQCb9
         ikiQ==
X-Gm-Message-State: AOJu0Yx5SmU+I5rtMOJzCJZMFrhodyYnAhBDfZzTCPMM4hT03GfWrxa0
        TOvVDR6C51UV9mE3Ede9ExzgSQ==
X-Google-Smtp-Source: AGHT+IGxTZQs0tfX978KftZKHO+eLQ06ND+Anz+7/0DX7CVA6pAq159e05zXpMe5lxg9BmdoeBwKDw==
X-Received: by 2002:a5d:5087:0:b0:317:ce01:fe99 with SMTP id a7-20020a5d5087000000b00317ce01fe99mr643284wrt.9.1694550393295;
        Tue, 12 Sep 2023 13:26:33 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f8-20020adff588000000b0030ae53550f5sm13773005wro.51.2023.09.12.13.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 13:26:32 -0700 (PDT)
Message-ID: <ce39120d-e76a-7353-2e9c-1995de0827b0@arista.com>
Date:   Tue, 12 Sep 2023 21:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v11 net-next 11/23] net/tcp: Sign SYN-ACK segments with
 TCP-AO
Content-Language: en-US
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
 <20230911210346.301750-12-dima@arista.com>
 <CANn89i+gs2oNDWL-w+ZUfNAYZ3GXf6RqN3wyr+4YqiQm7jq+1w@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+gs2oNDWL-w+ZUfNAYZ3GXf6RqN3wyr+4YqiQm7jq+1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 17:47, Eric Dumazet wrote:
> On Mon, Sep 11, 2023 at 11:04 PM Dmitry Safonov <dima@arista.com> wrote:
[..]
>> @@ -3777,16 +3787,43 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>>                         tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
>>         }
>>
>> -#ifdef CONFIG_TCP_MD5SIG
>> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
>>         rcu_read_lock();
>> -       md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
>>  #endif
>> +       if (tcp_rsk_used_ao(req)) {
>> +#ifdef CONFIG_TCP_AO
>> +               u8 maclen = tcp_rsk(req)->maclen;
>> +               u8 keyid = tcp_rsk(req)->ao_keyid;
>> +
>> +               ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
>> +                                                           keyid, -1);
>> +               /* If there is no matching key - avoid sending anything,
>> +                * especially usigned segments. It could try harder and lookup
>> +                * for another peer-matching key, but the peer has requested
>> +                * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
>> +                */
>> +               if (unlikely(!ao_key || tcp_ao_maclen(ao_key) != maclen)) {
>> +                       rcu_read_unlock();
>> +                       skb_dst_drop(skb);
> 
> This does look necessary ? kfree_skb(skb) should also skb_dst_drop(skb);

Yeah, it seems not necessary, will drop this.

> 
> 
>> +                       kfree_skb(skb);
>> +                       net_warn_ratelimited("TCP-AO: the keyid %u with maclen %u|%u from SYN packet is not present - not sending SYNACK\n",
>> +                                            keyid, maclen,
>> +                                            ao_key ? tcp_ao_maclen(ao_key) : 0);
> 
> dereferencing ao_key after rcu_read_unlock() is a bug.

Thanks for catching, will fix!

-- 
Dmitry

