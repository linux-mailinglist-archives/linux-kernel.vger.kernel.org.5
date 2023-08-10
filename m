Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76138777E34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjHJQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjHJQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:27:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9EA268C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:27:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso10753245e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1691684820; x=1692289620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4paMJMxBw/0aqQWbgEVCFG5+6phOV9IBizg4J6a0774=;
        b=AG42pef3+XIgoJec9DBFpVZmKR7o9OVLwuWNEU7ZDf+eDMj50bRjg4s3O/FFXcyDfv
         +nbsOCn+5BjS9oonRgu45PqS7E9fbvfpryZOOEOOIqERHbW+OoxObVdphFdEoQZY+H4y
         6QTuLxx7c3xTiQqiQj3erjXimRo94u6CH7m1fAtZo1f0Tzw80VFtZoZN3KW5khsCvIj4
         5XCTZN2GKX066tcQZiP6AD+csAjDaIeXaLatbpU/7iKDwi+c2z0DJcSEc6VMfPJcy7K3
         dKveKIKVNMtjN9wpjZPZrrdDGpykWrieAiAa7pV/le68WaRCaUvSnSHK5NgPjjEfTXSm
         IjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684820; x=1692289620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4paMJMxBw/0aqQWbgEVCFG5+6phOV9IBizg4J6a0774=;
        b=aU/r7GErujdTGwNxWOCwb/mxpW6JeF1ZtvDoRXnVXOmqK0zLrbqXYF+/ey+SKAerYu
         MWVY/B8Ys74bN3FRs5DVUI5r+VcCdYmYJ9Il+V3iQ7Deh03RiKvZKRdZ5Q5+DTasRA2d
         JT7hL4s1dK0w+qrNY3XJh8JIxdpCOzV03NShBeXfyTKZdyYptxlFI/aCE1TvrrKtrcUo
         /GyKGFf+idizWt5NsyPYmNHaJZ13D6SCc5782Vg9Rv8JgGSg66HFqIoAEvZdOn/l9zS9
         hWFNU6JW0qTOzOQyEv38KbXD2XlFmDrSwODm7KlwVGq+rdvHrunw7IWKvxLWg6C0/g+t
         RlNQ==
X-Gm-Message-State: AOJu0YyP6M7I4UQitMhGvgTwp9oF/BVq+ulGwFzHCTX6vrEhIrJLMcRv
        3eC3UWTdrChNJv0aUcv0Hkkzcg==
X-Google-Smtp-Source: AGHT+IFdWVAMiybM70Zenc08TSZ8TjSlvLjKCc/GsTSxAXli2A7b7Uv8Iw1HkgbQa86fQ90vmsGuDA==
X-Received: by 2002:adf:e98a:0:b0:317:a423:40e1 with SMTP id h10-20020adfe98a000000b00317a42340e1mr2379492wrm.55.1691684819953;
        Thu, 10 Aug 2023 09:26:59 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d4e83000000b003176053506fsm2654221wru.99.2023.08.10.09.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:26:59 -0700 (PDT)
Message-ID: <d84888b2-8b5a-103c-3e8a-1be5e5833288@arista.com>
Date:   Thu, 10 Aug 2023 17:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 net-next 16/23] net/tcp: Ignore specific ICMPs for
 TCP-AO connections
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
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230802172654.1467777-1-dima@arista.com>
 <20230802172654.1467777-17-dima@arista.com>
 <CANn89iKjT3i-0rZLu8WE_P94aN65rj8uBAw3MyMPhsnMKWSs_A@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iKjT3i-0rZLu8WE_P94aN65rj8uBAw3MyMPhsnMKWSs_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 14:43, Eric Dumazet wrote:
> On Wed, Aug 2, 2023 at 7:27 PM Dmitry Safonov <dima@arista.com> wrote:
[..]
>>
>> +bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
> 
> const struct sock *sk ?

Well, I can't really: atomic64_inc(&ao->counters.dropped_icmp)

>> +{
>> +       bool ignore_icmp = false;
>> +       struct tcp_ao_info *ao;
>> +
>> +       /* RFC5925, 7.8:
>> +        * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
>> +        * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
>> +        * unreachable, port unreachable, and fragmentation needed -- ’hard
>> +        * errors’), and ICMPv6 Type 1 (destination unreachable), Code 1
>> +        * (administratively prohibited) and Code 4 (port unreachable) intended
>> +        * for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
>> +        * WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs.
>> +        */
> 
> I know this sounds silly, but you should read sk->sk_family once.
> 
> Or risk another KCSAN report with IPV6_ADDRFORM
> 
> if (sk->sk_family == AF_INET) {
>     ...
> } else {
>     /* AF_INET case */
> }

Oh, I didn't know about IPV6_ADDRFORM. Sure, will read it once.

>> +       if (sk->sk_family == AF_INET) {
>> +               if (type != ICMP_DEST_UNREACH)
>> +                       return false;
>> +               if (code < ICMP_PROT_UNREACH || code > ICMP_FRAG_NEEDED)
>> +                       return false;
>> +       } else if (sk->sk_family == AF_INET6) {
>> +               if (type != ICMPV6_DEST_UNREACH)
>> +                       return false;
>> +               if (code != ICMPV6_ADM_PROHIBITED && code != ICMPV6_PORT_UNREACH)
>> +                       return false;
>> +       } else {
> 
> 
> No WARN_ON_ONCE(1) here please.

Ok.

[..]
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -494,6 +494,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
>>                 return -ENOENT;
>>         }
>>         if (sk->sk_state == TCP_TIME_WAIT) {
>> +               /* To increase the counter of ignored icmps for TCP-AO */
>> +               tcp_ao_ignore_icmp(sk, type, code);
>>                 inet_twsk_put(inet_twsk(sk));
>>                 return 0;
>>         }
>> @@ -508,6 +510,9 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
>>         }
>>
>>         bh_lock_sock(sk);
> 
> Do we need to hold the spinlock before calling tcp_ao_ignore_icmp() ?

I don't think so. And I think originally I've written it out of
bh_lock_sock(), but now I can't remember which paranoid thought resulted
in moving it under the lock. Anyway, will move it out again.

>> +       if (tcp_ao_ignore_icmp(sk, type, code))
>> +               goto out;
>> +
>>         /* If too many ICMPs get dropped on busy
>>          * servers this needs to be solved differently.
>>          * We do take care of PMTU discovery (RFC1191) special case :
[..]

Thanks,
           Dmitry

