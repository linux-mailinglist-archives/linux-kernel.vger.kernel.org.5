Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A97A9659
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIUREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjIURDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:03:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3032719
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053c6f0d3dso138275e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695315668; x=1695920468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCpRQy5aFVcZAnovNBYBG32aGoqs2l5V062iaInDme4=;
        b=TZ4n1xLlRbtodV0UdlF4O3x4MvbkYB1JgYPCZw3hTChuQotnAP/IZ5qChFg9ehRx4q
         ZW9i0taXH0c4V2SuAkA9gj+UM1PLA7ToM/H807AOK4cnRMl0Xfek7Sl2g4xLhyJ7OMwb
         8BuHrSVXNRhCaCd0Xygn075FltxlAxFXWZbhIoNZ++7GbT9ozLEgxRAJaao2xcOMGULL
         CC5N5DqjsPdeUVb9EZibdVxF3HsvE0t8EnELjq9zSkvepj4NJWFoMYprGUw9npfQRx8J
         M1w9YS3A7PE+c3fbhGXci1iDh7W4mH/kthFgf76OKtfraWGYK0GBSo86lSv3wEpK8qL1
         wVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315668; x=1695920468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCpRQy5aFVcZAnovNBYBG32aGoqs2l5V062iaInDme4=;
        b=dwZbW3JR1UlasTHRBgRmYGR+ROMtUIHgb5RcWm2yl013QPXS3NVm3+I7Dy75UnhgIH
         VfNQnnqfAty19u0bdAc/ni5hddau8byrlHvw6bvcAod4TqPM9+E4odSjr40TGxrqBJ1z
         pj2vgWW+to8hhZi8SR18Z2kxveJauq64VhRiRJAx67Cw3fg/aQHX8oncciFVGU/2vIu5
         QAfBoHGfVvF5E+LKwK5Wm0ViUMx5swQE56cf+BPDg/1/+9bRNGnqMseuG1d0cyAUM5uH
         CXjmAc2592wkg8X1XOs8fJgHCvKt5vOqXkH27XDbUv1eN0j2fRlmiUAyBLWruePTQLpz
         zpNw==
X-Gm-Message-State: AOJu0YyqjYGQlfk7Tn/Hg4mgt1+T5Xaahm3NjEFkoO6EtFNnTOtv5rXn
        ozF6nq71ua3/8SH44HG5hhIK7xmqHfSzp9kg3T4=
X-Google-Smtp-Source: AGHT+IEEGHtTkBEuwYW4pmvslrb0EckxI5A8QgaFbGs8wI47y6FHoHEO87io8T2rbmf1lRpQLmBnnw==
X-Received: by 2002:a5d:410a:0:b0:319:6d91:28bf with SMTP id l10-20020a5d410a000000b003196d9128bfmr5395098wrp.60.1695312081381;
        Thu, 21 Sep 2023 09:01:21 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z16-20020a056000111000b003176eab8868sm2105482wrw.82.2023.09.21.09.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:01:20 -0700 (PDT)
Message-ID: <65981909-e330-dc91-a977-032d427cdd6a@arista.com>
Date:   Thu, 21 Sep 2023 17:01:13 +0100
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
 <d0e332b4326eec032b77c7492f501f3c1fbe8242.camel@redhat.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <d0e332b4326eec032b77c7492f501f3c1fbe8242.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 12:20, Paolo Abeni wrote:
> On Mon, 2023-09-18 at 20:00 +0100, Dmitry Safonov wrote:
>> @@ -615,19 +616,43 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>>   * (but it may well be that other scenarios fail similarly).
>>   */
>>  static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>> -			      struct tcp_out_options *opts)
>> +			      struct tcp_out_options *opts,
>> +			      struct tcp_key *key)
>>  {
>>  	__be32 *ptr = (__be32 *)(th + 1);
>>  	u16 options = opts->options;	/* mungable copy */
>>  
>> -	if (unlikely(OPTION_MD5 & options)) {
>> +	if (tcp_key_is_md5(key)) {
>>  		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
>>  			       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
>>  		/* overload cookie hash location */
>>  		opts->hash_location = (__u8 *)ptr;
>>  		ptr += 4;
>> -	}
>> +	} else if (tcp_key_is_ao(key)) {
>> +#ifdef CONFIG_TCP_AO
>>
>> +		struct tcp_ao_key *rnext_key;
>> +		struct tcp_ao_info *ao_info;
>> +		u8 maclen;
>>  
>> +		ao_info = rcu_dereference_check(tp->ao_info,
>> +				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
>> +		rnext_key = READ_ONCE(ao_info->rnext_key);
>> +		if (WARN_ON_ONCE(!rnext_key))
>> +			goto out_ao;
>> +		maclen = tcp_ao_maclen(key->ao_key);
> 
> It looks like only TCP_AO really accesses 'key', and TCP_AO can easily
> fetch it from ao_info. Can the AO key change in between
> tcp_get_current_key() and here?

Yes, you read it right: current_key can be changed at any moment, when
the peer asks to start a rotation (tcp_inbound_ao_hash() on RX does
that). So, here we have to provide the fetched key as ao_key->maclen
(the length of MAC, the authentication/hash may be different between
different keys).

> Otherwise I think it would be better omitting the 'key' argument here
> and use the 'options' flag to pick TCP_AO vs MD5.
> 
> And:
> 
> 	if (unlikely(OPTION_MD5 & options)) {
> 
> could possibly be moved under a CONFIG_MD5 compiler conditional.

Thanks,
          Dmitry

