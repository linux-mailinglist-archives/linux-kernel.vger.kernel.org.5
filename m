Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B771762206
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGYTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:10:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C263310C9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:10:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so58471835e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690312224; x=1690917024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fX6xLIXZZAr/AQm9E+cM414TFNlRnIjeGEpoYX0+8ho=;
        b=UVAPMfmOJz6LMxHlgBfz8yTPlXk+vlnr+l6ZZXPjl82FxQbfYNRZznBcp0AFA4VoXv
         PbRrjgR6uWU5hH4h3VUGIbbnpxjruUiNaS913b5W1uXGIqj7YCUUscqT7W7ccQ7ZGZ3q
         lynWWQd3ImfjpxnN6+l+LAy38z2wpS11lGnNvZ1uLoo5LFG0drtmNYhxivN5141qxpos
         5++8sMEvMLZOxkUSvUV6PmJJHoDdiQXCBrQKoemKm9OLT9d0UM0Rt0yR15Y4zJAxWJZc
         DN4hcNJFTN5ib+HsAwLSWl1/lcbN0xizwPnRVfdBJRsqpTUPOqmNpj5x083Z3CrrWgEA
         8xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690312224; x=1690917024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fX6xLIXZZAr/AQm9E+cM414TFNlRnIjeGEpoYX0+8ho=;
        b=DyGKQuUo4MEEJbARPfa6UvUDf2yhoH89FLfmg7BcSzbdXcI/OJuV8Bzsx5pKioCT/8
         2YkyZy2P7RqGiumfBjZJH8WpeWz5Ueo077Ehhl8rnfwabrxGdGbrWmmrs74kwkBbb5sL
         ItI76QPtTd/3OB8avacp4MA4dGiDek1LeoNIEpv2hoznTGUn7cxYomIgYpeOqoOjVOkq
         u6EN3aY90v3kASce7x18T9cRkcmmIpOAmNPH8i4CvGH6FOtUmd+M06Ix73v8GNxyY7fU
         zbHYMfWuehgZDR3g7VlQBKpGfHy5wPkhERgBrgFYsEdDsOn9VSPYX9Rynk+N5uUUub9Q
         49Vg==
X-Gm-Message-State: ABy/qLYljRYt4aMhdGqs8dZCuXIUemvOE2E7HBglS/lA0sffistBbUhQ
        wb7cosQ6wrMDRMugUNGxRSv0Jt4jRjW1/jDXRVc=
X-Google-Smtp-Source: APBJJlFk7VlYyWtrQWDrsUhb/Zd3uDmUb6Ou49pg3ERUj4q3zy18zgW/gLqIjGhAuzqOgJcFRkedKA==
X-Received: by 2002:a7b:c30e:0:b0:3f9:871:c2da with SMTP id k14-20020a7bc30e000000b003f90871c2damr9917149wmj.40.1690312224231;
        Tue, 25 Jul 2023 12:10:24 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003fc17e8a1efsm16393926wmg.45.2023.07.25.12.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 12:10:23 -0700 (PDT)
Message-ID: <b01a63a7-eaaa-85db-b04d-8270e82e1080@arista.com>
Date:   Tue, 25 Jul 2023 20:10:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8.1 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
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
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-7-dima@arista.com> <ZMAAPBKnnrdk/c9K@corigine.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZMAAPBKnnrdk/c9K@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 7/25/23 18:02, Simon Horman wrote:
> On Fri, Jul 21, 2023 at 05:18:57PM +0100, Dmitry Safonov wrote:
> 
> ...
> 
> Hi Dmitry,
> 
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> 
> ...
> 
>> @@ -619,7 +621,33 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>>  		opts->hash_location = (__u8 *)ptr;
>>  		ptr += 4;
>>  	}
>> +#ifdef CONFIG_TCP_AO
>> +	if (unlikely(OPTION_AO & options) && tp) {
> 
> Smatch warns that here we check if tp is NULL,
> but later on in the same function (existing) code
> uses tp unconditionally.
> 
> That code looks like this:
> 
>         if (unlikely(opts->num_sack_blocks)) {
>                 struct tcp_sack_block *sp = tp->rx_opt.dsack ?
>                         tp->duplicate_sack : tp->selective_acks;
> 
> I would recommend running Smatch.
> It points out a lot of interesting things.
> 
> 
>> +		struct tcp_ao_key *rnext_key;
>> +		struct tcp_ao_info *ao_info;
>> +		u8 maclen;
>>  
>> +		if (WARN_ON_ONCE(!ao_key))
>> +			goto out_ao;
>> +		ao_info = rcu_dereference_check(tp->ao_info,
>> +				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
> 
> Checkpatch complains about indentation here.
> 
> Rather than point out each case in the series,
> could I ask you to run ./scripts/checkpatch.pl --strict over the patchset?

Yeah, but then it won't fit 80 columns here. As both aren't hard
requirements I tend to comply with 80 columns more than to indentation.
In this particular case I'll check if it could be a helper function.
If it won't make sense to separate it as a helper, I'll just move it to
the same line than, breaking 80 columns limit.

>> @@ -1363,6 +1424,34 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>  					       md5, sk, skb);
>>  	}
>>  #endif
>> +#ifdef CONFIG_TCP_AO
>> +	if (ao) {
>> +		u8 *traffic_key;
>> +		void *tkey_buf = NULL;
>> +		u32 disn;
>> +
>> +		sk_gso_disable(sk);
>> +		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
>> +			if (tcb->tcp_flags & TCPHDR_ACK)
>> +				disn = ao->risn;
> 
> Sparse complains that there is an endian missmatch between disn and ao->risn ?
> 
> Rather than point out every problem flagged by Sparse,
> could I ask you to run it over the series?


Yeah, I noticed it on netdev patchwork, running it over the patches now.

Thanks,
             Dmitry

