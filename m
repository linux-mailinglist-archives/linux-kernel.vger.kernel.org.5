Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC377400B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjHHQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjHHQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:57:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CEE4C33;
        Tue,  8 Aug 2023 08:42:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A96D5C0067;
        Tue,  8 Aug 2023 04:46:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 08 Aug 2023 04:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691484411; x=1691570811; bh=BcvV+WKIQPajFkywU4vq7mmCKoFIGw6OUUR
        HQx3H/pQ=; b=JPGP48TZDMQQ0+1F+s66iC9WJgcLfb/8JA7fH4SgnXnlD8IjRjN
        8wmXE7JWzsZCtgZ9li4TIoFxP+vVaTpltbgl10Gnyc8mszhhgjygBuyBf8Tv2Fyt
        x0WYh6GJKRagucgw2DX4Aqb9kuaWyx8UqPDQ7bMqpaNn/6Pb92cD7qUN6II3wg0k
        QeMKjIKYi60p2ZjpoLjXAzUp0evwOS1aZOitR/eKBl2LpcYgf+snnErwlkTJ/o+m
        X5ZS8V89Qbp7KJSKyfUyn1RjH3/cYdV3iy3dlPoQhd3TZCkcMhG7cr1Jc1JOlN3H
        Fk4VAzpFo6Imt16OE3A5kvyUuD6FwhxfISQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691484411; x=1691570811; bh=BcvV+WKIQPajFkywU4vq7mmCKoFIGw6OUUR
        HQx3H/pQ=; b=Va+Qo9KqKivkkA4vaEp6cRXcNZcJaB9iP6mrTlAEEgyAbkbmPcu
        x9ipOaaqG95BtETWpGbAMoqd0nmO6dzg+o4vc/xFZM6+OpGElvb/YGMwKsOLBDcV
        8j3q+/5FrQTpbEXZ0LUBaLcM3Zgz4nuulbv0CbFui4bhXgKPNFYyvA9r8xwtxBLX
        RQbhqB5ZCDOSiDAPSrf4qXvpWfcH35SEv7boGWWft9xDr5DJn/JYXUtrfNkffmUg
        z7QOjKiZuN+ar5DVo0drb7TyLMvPkpi86QMP/7Ezh+2vEl/Tl9JgQ2oP1paR45sA
        Ql0dE3W86YEAYBZOPzr4q56AIZMQCY5w09w==
X-ME-Sender: <xms:-wDSZMSv3t0uk4lc-bnFiIlnuFEKae2Gv_-3nBfThwZ3PAyz6OxRyw>
    <xme:-wDSZJwKYdI7fKTMN96otoq-OT_B_KLt5EM6pJ8379_0yH_dCpRo8GXRjPf_zOkcr
    4hLzwCQJxP-GNOOqkg>
X-ME-Received: <xmr:-wDSZJ0ECso3bvQvLlnFGwUi_887xwK7nsR237EtDPgnvGakFH72swZwgRE1Romqexw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepofgrnhhj
    uhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgvqeenucggtffrrghtthgvrhhnpe
    duveevjefhjedvgeevvdeutdeukeeljeelhfeftdehkefhfeeivdfgudekueeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesmhgrnh
    hjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:-wDSZABxCLIiajjPl08H-9NfYIlqO-dbI79W8Nd8_p2ct3wYw29r1A>
    <xmx:-wDSZFjhYctKODNMC-EgYnk1hLZq66-RedJmGn2zTdlOV_9GPfUOCA>
    <xmx:-wDSZMqeKBe56hfYoBbZkOzU2NPwI77fjD_n4dlzHIdDgLS9s8g19Q>
    <xmx:-wDSZKZ54xM9a115BCmtTztLqLA8ULD6PlhshGDPccc57ZK7xXs1lw>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 04:46:45 -0400 (EDT)
Message-ID: <af02d2a9-4655-45a1-8c3a-d9921bfdbc35@manjusaka.me>
Date:   Tue, 8 Aug 2023 16:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me>
 <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
From:   Manjusaka <me@manjusaka.me>
In-Reply-To: <CANn89iKxJThy4ZVq4do6Z1bOZsRptfN6N8ydPaHQAmYKCjtOnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/8 16:26, Eric Dumazet wrote:
> On Tue, Aug 8, 2023 at 7:59 AM Manjusaka <me@manjusaka.me> wrote:
>>
>> In normal use case, the tcp_ca_event would be changed in high frequency.
>>
>> It's a good indicator to represent the network quanlity.
> 
> quality ?
> 
> Honestly, it is more about TCP stack tracing than 'network quality'
> 
>>
>> So I propose to add a `tcp:tcp_ca_event` trace event
>> like `tcp:tcp_cong_state_set` to help the people to
>> trace the TCP connection status
>>
>> Signed-off-by: Manjusaka <me@manjusaka.me>
>> ---
>>  include/net/tcp.h          |  9 ++------
>>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp_cong.c        | 10 +++++++++
>>  3 files changed, 57 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 0ca972ebd3dd..a68c5b61889c 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
>>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>>  }
>>
>> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
>> -{
>> -       const struct inet_connection_sock *icsk = inet_csk(sk);
>> -
>> -       if (icsk->icsk_ca_ops->cwnd_event)
>> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
>> -}
>> +/* from tcp_cong.c */
>> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>>
>>  /* From tcp_cong.c */
>>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
>> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
>> index bf06db8d2046..b374eb636af9 100644
>> --- a/include/trace/events/tcp.h
>> +++ b/include/trace/events/tcp.h
>> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>>                   __entry->cong_state)
>>  );
>>
>> +TRACE_EVENT(tcp_ca_event,
>> +
>> +       TP_PROTO(struct sock *sk, const u8 ca_event),
>> +
>> +       TP_ARGS(sk, ca_event),
>> +
>> +       TP_STRUCT__entry(
>> +               __field(const void *, skaddr)
>> +               __field(__u16, sport)
>> +               __field(__u16, dport)
>> +               __array(__u8, saddr, 4)
>> +               __array(__u8, daddr, 4)
>> +               __array(__u8, saddr_v6, 16)
>> +               __array(__u8, daddr_v6, 16)
>> +               __field(__u8, ca_event)
>> +       ),
>> +
> 
> Please add the family (look at commit 3dd344ea84e1 ("net: tracepoint:
> exposing sk_family in all tcp:tracepoints"))
> 
> 
> 
>> +       TP_fast_assign(
>> +               struct inet_sock *inet = inet_sk(sk);
>> +               __be32 *p32;
>> +
>> +               __entry->skaddr = sk;
>> +
>> +               __entry->sport = ntohs(inet->inet_sport);
>> +               __entry->dport = ntohs(inet->inet_dport);
>> +
>> +               p32 = (__be32 *) __entry->saddr;
>> +               *p32 = inet->inet_saddr;
>> +
>> +               p32 = (__be32 *) __entry->daddr;
>> +               *p32 =  inet->inet_daddr;
> 
> We keep copying IPv4 addresses that might contain garbage for IPv6 sockets :/
> 
>> +
>> +               TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
>> +                          sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> 
> I will send a cleanup, because IP_STORE_ADDRS() should really take
> care of all details.
> 
> 
>> +
>> +               __entry->ca_event = ca_event;
>> +       ),
>> +
>> +       TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%u",
>> +                 __entry->sport, __entry->dport,
>> +                 __entry->saddr, __entry->daddr,
>> +                 __entry->saddr_v6, __entry->daddr_v6,
>> +                 __entry->ca_event)
> 
> Please print the symbol instead of numeric ca_event.
> 
> Look at show_tcp_state_name() for instance.

Thanks for the kindness code review, I still get some issue here(Sorry for the first time to contribute):

1. > We keep copying IPv4 addresses that might contain garbage for IPv6 sockets :/

I'm not getting your means, would you mean that we should only save the IPv4 Address here?

2. > I will send a cleanup, because IP_STORE_ADDRS() should really take care of all details.

I think you will make the address assignment code in TP_fast_assign as a new function. 

Should I submit the new change until you send the cleanup patch or I can make this in my patch(cleanup the address assignment)

