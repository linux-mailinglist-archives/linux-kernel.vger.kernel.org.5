Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70157F3AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjKVBAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKVBAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:00:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573E199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:00:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40859dee28cso33205225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700614810; x=1701219610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7z/Ncze8VsxsQV1/X1aHBHLUuutXLztntTa5pi1dYLs=;
        b=RC2EL6F5X7lwgIY/nWSO438Mq/MuoWSvG6hDsB4jeubmsjh4fM/yY06uxFOdlikVvE
         KpRNYqiKHceHvxhtaLC1xJRqb7TBmLY4abEeya0s3Ai9p8bBrONPAVeNS8YfxTbiU2Jc
         Y1vvAAusBYtBs5ouYrqezB6mpgQjSYnoYlsfm956OIp37qOAecbUrt0SdwPQSBBBQttG
         dFCf8AKNWkueGRvS0Ip1+AnSNsf+hk9D4utd0fbSFEoD+KoHdSLBJZLdAX36yHfd8cCh
         iKC19BYsULHSd3j3JkXayYdsho046FC0drigacJn/VYEaDqyjQlrHukDHhwIq86RgK/Z
         4guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700614810; x=1701219610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z/Ncze8VsxsQV1/X1aHBHLUuutXLztntTa5pi1dYLs=;
        b=k3cc0w4yg9U9Eu26UJxo+REwkNm2YusB9wTkeOWi12M8iZREk7F+W/1XK7dngm78sB
         7I8L2Qje9rwN8wtKxPL9jVGCcU/BCtTwlY/h/Dfem6or59OXT9JWcVwj60aipLNlgtIw
         w/X9ETmWJMy7DFLWV2OSiCIutCIDrk52vdmGVy6zORa3ecwq0EgbMR/Q5FyuQuTjPSQY
         lQFMLOMI+13eVi4ofHXtFhx6Vlo89oWI5OGjNSEvNSQLtkE53G8vdLsQi7e4AUVQGO6V
         PhShNUhFlcj6uRzRB3ylgBN5Y2kIcs1uL5ZQ963QE1ZYU8Z8Ftgi9ncoKYTsgkBGF15V
         JY4g==
X-Gm-Message-State: AOJu0YygP6k4LlIYS8A7Ss8yuL8zu9YiIr6qzOS1jQ03PaAIP+9SDXtu
        LXYlw+TJWbHzfsIqq3qUM3wl3g==
X-Google-Smtp-Source: AGHT+IGWfqttaUh7V6lCiHLkEQqnJfYw1U5++qE0LNe7r9fT0KxEwUqIRkLzKCuyF/8jxNnoVwJbzw==
X-Received: by 2002:a5d:56c4:0:b0:32d:9a8f:6245 with SMTP id m4-20020a5d56c4000000b0032d9a8f6245mr341419wrw.68.1700614810074;
        Tue, 21 Nov 2023 17:00:10 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b004067e905f44sm377388wms.9.2023.11.21.17.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 17:00:09 -0800 (PST)
Message-ID: <85e84d97-af6d-47e7-b188-0ee000c4ee8c@arista.com>
Date:   Wed, 22 Nov 2023 01:00:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] net/tcp: Reset TCP-AO cached keys on listen() syscall
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
 <20231121020111.1143180-5-dima@arista.com>
 <CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com>
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

On 11/21/23 08:18, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 3:01 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> TCP_LISTEN sockets are not connected to any peer, so having
>> current_key/rnext_key doesn't make sense.
>>
>> The userspace may falter over this issue by setting current or rnext
>> TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
>> allow removing a key that is in use (in accordance to RFC 5925), so
>> it might be inconvenient to have keys that can be destroyed only with
>> listener socket.
> 
> I think this is the wrong way to solve this issue. listen() should not
> mess with anything else than socket state.
> 
>>
>> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
[..]
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index fb81de10d332..a08d1266344f 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -200,6 +200,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
>>          * we can only allow the backlog to be adjusted.
>>          */
>>         if (old_state != TCP_LISTEN) {
>> +               tcp_ao_listen(sk);
> 
> Ouch...
> 
> Please add your hook in tcp_disconnect() instead of this layering violation.
> 
> I think you missed the fact that applications can call listen(fd,
> backlog) multiple times,
> if they need to dynamically adjust backlog.

Hmm, unsure, I've probably failed at describing the issue or failing to
understand your reply :-)

Let me try again:
1. sk = socket(AF_*, SOCK_STREAM, IPPROTO_TCP)
2. setsockopt(sk, TCP_AO_ADD_KEY, ...) - adding a key to use later
3. setsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, set_current=1) - could be
   done straight on adding a key at (2), but for an example, explicitely
4.a. connect(sk, peer) - all as expected, the current key will be the
     one that is used for SYN (and ending ACK if the peer doesn't
     request to switch)
4.b  listen(sk, ...) - userspace shoots itself in foot: the current_key
     has no usage on TCP_LISTEN, so it just "hangs" as a pointer until
     the socket gets destroyed.

An alternative fix would be to make setsockopt(TCP_AO_DEL_KEY) remove a
key even if it's current_key on TCP_LISTEN, re-setting that to NULL.

Now as I described, somewhat feeling like the alternative fix sounds
better. Will proceed with that for v2.

Thanks,
             Dmitry

