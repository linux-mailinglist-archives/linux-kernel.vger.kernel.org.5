Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97A7A9EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjIUUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjIUUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:15:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869C43CB2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:16:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so781934a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695316575; x=1695921375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLeTejN+krtXCBUoQ8c2GsyBFaUAnJ4kR1g83a7uWA8=;
        b=OlwmdQT9VB1TgWmXiurmEbUYraDsgXQEph0gp8X6yvn0u7CxOCkK+sqfgIUxc+RLKN
         Xd/mHxS2Kyc+oRPHaWhF+gt6mqk9u2WmDTpvU5hhuCPFkODLVzt69B3a98lASThj0WIK
         2RMobMclcUbSowWEQJbYp2vvCtP8t6eUALK/NrRhgqSm8TjLyXzrxFRVarz8xW9zBZSd
         HxN5Fvi1fDvyebiOf/oI3BxmTZdR+IeIPlmW4ruWH+69mLNqlLOExnZWIlf3YcDXP3mI
         00xmqJQUY88tvMR0Xx1uLh8gR+GLv4qbFzraPZmzWok7bL+iwHVdqVbIkTrutK0aQWEw
         AGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316575; x=1695921375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLeTejN+krtXCBUoQ8c2GsyBFaUAnJ4kR1g83a7uWA8=;
        b=QzVneO/MDr4SSVO6zS92rhPvGTnzPNEUUhO4Vmcscl5G0Kfc5gITRhBMzRxclvd1h8
         BZWc6Gf/tfrOz3Mc0+c/dyI58zh7qANXutDG5nvJUPB8Pn/s0zm19/nZImUlbcQWWcDR
         loDgmTZ+o5m8x50/U7V5qJQesNgQvrVCk/MfCnlxXcqu5MyKwR6OMhhXOtXVGnO8MiLA
         oupcGtN0eCRgXFZKUm1T5IFsbR8aBkWxTaEHWyREadzYbsCr4jeYYXYnVEXPTP7vEigL
         87BTxPkfTDrhAF2fF84o0kMe6Xc1YY+CqTbQM/jSDwoDTc5qdD+cVeWCWPkyA1r7LFvq
         r59A==
X-Gm-Message-State: AOJu0YzCGL7UZ4MdPYwSHhdif3xrmUV3t6zcfXrCMO+n5nj647TRaYtk
        sSnjiLrqReU/8LycziNQv3btsD+lLjutxVS8cuA=
X-Google-Smtp-Source: AGHT+IHqkoyAs8j3cuxFWRtoTCw47NxHsOSGjMKRiLPU0zR/pPum9yeXdhIngEZ+J2VrxNeRK//JMw==
X-Received: by 2002:a05:600c:478a:b0:405:3955:5872 with SMTP id k10-20020a05600c478a00b0040539555872mr945316wmo.18.1695312190050;
        Thu, 21 Sep 2023 09:03:10 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y2-20020a7bcd82000000b00403bbe69629sm2279793wmj.31.2023.09.21.09.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:03:09 -0700 (PDT)
Message-ID: <24f4b6aa-3be3-8fd1-7f98-503c1d7fea56@arista.com>
Date:   Thu, 21 Sep 2023 17:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
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
References: <20230918190027.613430-1-dima@arista.com>
 <20230918190027.613430-7-dima@arista.com>
 <c2c0b0684b9c2a930ae6001bcc0044dd7a0862d5.camel@redhat.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <c2c0b0684b9c2a930ae6001bcc0044dd7a0862d5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 12:23, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 20:00 +0100, Dmitry Safonov wrote:
>> @@ -1361,16 +1385,48 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>  		th->window	= htons(min(tp->rcv_wnd, 65535U));
>>  	}
>>  
>> -	tcp_options_write(th, tp, &opts);
>> +	tcp_options_write(th, tp, &opts, &key);
>>  
>> +	if (tcp_key_is_md5(&key)) {
>>  #ifdef CONFIG_TCP_MD5SIG
>> -	/* Calculate the MD5 hash, as we have all we need now */
>> -	if (md5) {
>> +		/* Calculate the MD5 hash, as we have all we need now */
>>  		sk_gso_disable(sk);
>>  		tp->af_specific->calc_md5_hash(opts.hash_location,
>> -					       md5, sk, skb);
>> -	}
>> +					       key.md5_key, sk, skb);
>>  #endif
>> +	} else if (tcp_key_is_ao(&key)) {
>> +#ifdef CONFIG_TCP_AO
>> +		struct tcp_ao_info *ao;
>> +		void *tkey_buf = NULL;
>> +		u8 *traffic_key;
>> +		__be32 disn;
>> +
>> +		ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
>> +					       lockdep_sock_is_held(sk));
>> +		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
>> +			if (tcb->tcp_flags & TCPHDR_ACK)
>> +				disn = ao->risn;
>> +			else
>> +				disn = 0;
>> +
>> +			tkey_buf = kmalloc(tcp_ao_digest_size(key.ao_key),
>> +					   GFP_ATOMIC);
>> +			if (!tkey_buf) {
>> +				kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
>> +				return -ENOMEM;
>> +			}
>> +			traffic_key = tkey_buf;
>> +			tp->af_specific->ao_calc_key_sk(key.ao_key, traffic_key,
>> +							sk, ao->lisn, disn, true);
>> +		} else {
>> +			traffic_key = snd_other_key(key.ao_key);
>> +		}
>> +		tp->af_specific->calc_ao_hash(opts.hash_location, key.ao_key,
>> +					      sk, skb, traffic_key,
>> +					      opts.hash_location - (u8 *)th, 0);
>> +		kfree(tkey_buf);
>> +#endif
> 
> I'm sorry for the incremental feedback.
> 
> The above could possibly deserve being moved to a specific helper, for
> both readability and code locality when TCP_AO is enabled at compile
> time but not used.

Sure, will do for the v13.

Thanks,
           Dmitry

