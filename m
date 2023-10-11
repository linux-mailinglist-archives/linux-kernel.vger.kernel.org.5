Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804997C5D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376265AbjJKTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjJKTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:23:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B190
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:23:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4064867903cso2994465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697052221; x=1697657021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVY4n+sUUal8Mo6ekLH5OHpKIcKhQ7qGm4MhPBpzpRk=;
        b=PsbFF0AkTiENlOdBSGZZXtkuS4mXS53gmYKDCEFtu5mOZq6e23DQSdesi4y9kNicXv
         WEdKx4hChnE1iaPYx8zqsR+1hSfgVLOgpXxMfFxnJG5q4vPNATNwc6C2lntoExEZfi+p
         OLDaRAtep2naqsjhLxF0FJh+QpMbC/v8ARfPsUT2KaAoZA/AhqgtjU3RupttIo+yaNvJ
         ao9oxsjWSgOg8VASH+L0b04s6N0/GO0dLWQcMF8VClebhtX2UVH+BcLvT+rGiHRVA/w1
         RcYIk/K5o4y6X4FCbxsmwuifav6HiRPc5z+QxfEAKgDlCHCfe+4ryFinz7jLdSq9NEEf
         AqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697052221; x=1697657021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVY4n+sUUal8Mo6ekLH5OHpKIcKhQ7qGm4MhPBpzpRk=;
        b=HL4SkvmFB8E5Z77DyeWnBXMZxxi18R11e/NqeVyBu6fFietwiXofijsdtvFhaDIqLt
         jk9UZwDc/YIee8YkMh4YatIIVs8e4O6kEdCqwS/QrhqiOgncKv8hQxfIO+J08sd0zJqd
         T4T6pjNZA9W23wBSv2GZViblibrRjMnAU47g4xkNPslD+2zeXtuAhu9mKGAwcXBgSUPW
         wHYHfebg4ETpCTGQFETlvvRmWVQQ8Hw7j43eTDvis+6Cx8q5+DndDb+PMp9kOlNScKZF
         o3YWqGs2DUNN5v8UpZnioYfqbrLaTqG9BDrLvKNu22JpckcBZd9EtVYAw1rn+ORk/w5f
         /Lxg==
X-Gm-Message-State: AOJu0Yzg/Ou+9lSlfzRBIVruOyXUaclo1zU9y1Xt48N+WVZJ2ucq5rAp
        aKorx1KZJveej7ghmGGNBfXu6Q==
X-Google-Smtp-Source: AGHT+IHeNgrBix7GEbfUSp9zM6c8FNctrIOr/aV8H4HukOYSoHTkvlmFE3Zjl3SeMueAfMBWPsG5pg==
X-Received: by 2002:a5d:65c4:0:b0:321:4c58:7722 with SMTP id e4-20020a5d65c4000000b003214c587722mr18708893wrw.69.1697052220829;
        Wed, 11 Oct 2023 12:23:40 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b0032d892e70b4sm1970391wra.37.2023.10.11.12.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:23:40 -0700 (PDT)
Message-ID: <b1f1e94b-593a-4eb7-907c-cf5d61d74510@arista.com>
Date:   Wed, 11 Oct 2023 20:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
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
References: <20231009230722.76268-1-dima@arista.com>
 <20231009230722.76268-9-dima@arista.com>
 <CANn89iLo8sOL=CnAvMv_PSeS_hUQ0cfF6LdFEDnuwGxhSmo+xg@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iLo8sOL=CnAvMv_PSeS_hUQ0cfF6LdFEDnuwGxhSmo+xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 19:04, Eric Dumazet wrote:
> On Tue, Oct 10, 2023 at 1:07 AM Dmitry Safonov <dima@arista.com> wrote:
[..]
>>  struct tcp_key {
>>         union {
>> -               struct tcp_ao_key *ao_key;
>> +               struct {
>> +                       struct tcp_ao_key *ao_key;
>> +                       u32 sne;
>> +                       char *traffic_key;
> 
> Move sne after traffic_key to avoid a hole on 64bit arches.

Sure, thanks!

[..]
>> @@ -435,6 +495,46 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
>>         return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
>>  }
>>
>> +int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
>> +                        const struct tcp_ao_hdr *aoh, int l3index,
>> +                        struct tcp_ao_key **key, char **traffic_key,
>> +                        bool *allocated_traffic_key, u8 *keyid, u32 *sne)
>> +{
>> +       struct tcp_ao_info *ao_info;
>> +
>> +       *allocated_traffic_key = false;
>> +       /* If there's no socket - than initial sisn/disn are unknown.
>> +        * Drop the segment. RFC5925 (7.7) advises to require graceful
>> +        * restart [RFC4724]. Alternatively, the RFC5925 advises to
>> +        * save/restore traffic keys before/after reboot.
>> +        * Linux TCP-AO support provides TCP_AO_ADD_KEY and TCP_AO_REPAIR
>> +        * options to restore a socket post-reboot.
>> +        */
>> +       if (!sk)
>> +               return -ENOTCONN;
>> +
>> +       if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
>> +               return -1;
>> +       } else {
>> +               struct tcp_ao_key *rnext_key;
>> +
>> +               if (sk->sk_state == TCP_TIME_WAIT)
> 
> Why not adding TCPF_TIME_WAIT in the prior test ?

Well, twsk is wired up here in the next patch "net/tcp: Add TCP-AO sign
to twsk", while the condition for request sockets is the patch after that.
I probably can move it to the same condition just to polish the code in
the middle of patch set, I guess it felt not critical when I split it by
patches.

> 
>> +                       return -1;

[..]

Thanks,
           Dmitry

