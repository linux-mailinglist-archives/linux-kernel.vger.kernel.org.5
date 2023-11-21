Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411EC7F3549
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjKURuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKURuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:50:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132212C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:50:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b2979a74eso6970485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700589016; x=1701193816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7eEoEaHBgdi9fm5W+Qi0cAzvT8Gw9lGqubNWJJvxtI=;
        b=Fk1Xyu8F2FvFgnGIOHt8t8detzN/SNukWQ9ymhZbpIrDN+Cd9NjAj8UBdcSjak0uV6
         n+VkkBvvCqAyEWapLuEkFIIcc3yY+07d4OwcSzrHG2IZvVYuWXQy/jrmDW2jyxF9Viba
         ZTfH1Ie9l1R2dnGQ1YvsikmnLP+Nmw6UCH6o6X+WKYNOaQdsyT5aF1cYl34yIuzyiUlp
         79huflY5r9pSRErlLWL0hqMINlke25ECmFaQ6eoVE8ILrRzX5QCQfmGnR+cAkbOHPFbD
         l7QzXPucLhdY91TXxNPfG8t1Jvek0Ir+7ud1HZhKGIbtZnfyywkPKmYZLV1UkB4FEIiT
         sZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589016; x=1701193816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7eEoEaHBgdi9fm5W+Qi0cAzvT8Gw9lGqubNWJJvxtI=;
        b=wJrls9m03479WSvs9a2N0Mo6rzf9iL3YcrgxJ+BaKYGISz7qY6gxkoJR7llfShe3xx
         FBAfnZ82zwlP8VcpFoOpr9l0eI/OdXBLYjasey8tO01Wq0AwdCCu8dCXZyhsLEZLmDR1
         uuqtkMGdOrwUqRsmnPhB9fWm4oxCzkHnHwfo61gENuqvsZH7gjVo5O9YnCvYHUPRPAHh
         ZmL5C6wiqSX4T87wq0u/Zw/+OjFSGwbANjo3qcAwqYDxoz2sSv/PvASCq/TJt9E/sMn3
         Mzo8ahHyMIl4BvlNJajGqm+yVTwBqX+RJhQtoTFJluQIhhY0J7tMVg8I3855T+BXb8jD
         JJhg==
X-Gm-Message-State: AOJu0YyJW+aAKqxN6eBZDL2/CGF860B5Lnpm8JDsQi/cIVx6dC0L9vH8
        KWJ+KSkEEkpJFN/6iqavfm2B7Q==
X-Google-Smtp-Source: AGHT+IEpTAg+2Gdi3b5o9hbskbgTV/96r1yf487agp5DGQ9tqg02GcM0PNTAzeuJrdNRubxG04UqxQ==
X-Received: by 2002:a05:600c:ce:b0:401:38dc:8916 with SMTP id u14-20020a05600c00ce00b0040138dc8916mr68648wmm.10.1700589016483;
        Tue, 21 Nov 2023 09:50:16 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b0040a44179a88sm21635907wmf.42.2023.11.21.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:50:15 -0800 (PST)
Message-ID: <793d71be-5164-4943-b18d-7038492b45ea@arista.com>
Date:   Tue, 21 Nov 2023 17:50:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
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
 <20231121020111.1143180-4-dima@arista.com>
 <CANn89i+2xLv=bR5u0iGcmZhZ8WZjPHyzaqAe3cZAhmc95KSVag@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+2xLv=bR5u0iGcmZhZ8WZjPHyzaqAe3cZAhmc95KSVag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 08:21, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 3:01 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Listen socket is not an established TCP connection, so
>> setsockopt(TCP_AO_REPAIR) doesn't have any impact.
>>
>> Restrict this uAPI for listen sockets.
>>
>> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  net/ipv4/tcp.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 53bcc17c91e4..2836515ab3d7 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>>                 break;
>>
>>         case TCP_AO_REPAIR:
>> +               if (sk->sk_state == TCP_LISTEN) {
>> +                       err = -ENOSTR;
> 
> ENOSTR is not used a single time in linux.
> 
> I suggest you use tcp_can_repair_sock() helper (and return -EPERM as
> other TCP_REPAIR options)

Sounds good to me. Unsure why I didn't use tcp_can_repair_sock() in the
first place. Will do in v2.

> 
>> +                       break;
>> +               }
>>                 err = tcp_ao_set_repair(sk, optval, optlen);
>>                 break;
>>  #ifdef CONFIG_TCP_AO
>> @@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>>         }
>>  #endif
>>         case TCP_AO_REPAIR:
>> +               if (sk->sk_state == TCP_LISTEN)
>> +                       return -ENOSTR;
>>                 return tcp_ao_get_repair(sk, optval, optlen);
>>         case TCP_AO_GET_KEYS:
>>         case TCP_AO_INFO: {
>> --
>> 2.42.0
>>

Thanks,
             Dmitry

