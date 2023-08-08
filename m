Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD623773D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjHHQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjHHQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:14:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E83C3A;
        Tue,  8 Aug 2023 08:41:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B749B5C0090;
        Tue,  8 Aug 2023 00:50:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 00:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691470254; x=1691556654; bh=Wm7vgVpyNkBovEIVcDALXg67wDGyu9eYENE
        6yQjh/qo=; b=lFQJQ6nVziMDKcES6RNB32k3lPEozvdgM/igCLTgkXuwis+6A0j
        exxvtzVnnBL+dwILAC3txSK8K/fL5hBvHiyC9+Tr/xwaH/PYHx8cgXJ8AnRvVBp0
        TSBS6QpkI9LCAG3gXBcsy21msfdLvP4/mvrlJ8BTIVIAgQsJwEW1WpHE0tIOEd6L
        ugoqUUP99A+NomxQw6jPYKEZon1/yAiKbbT8igdEKdP1eyPbQZYd3RJQ+q61juoa
        avXqO/zmcZIAzZOniWL33aoY+mBjy7B0mWv8YLW1N1qihqLr4PmHRIZsA9ySjwxZ
        esiz/Axtdhoq7DTIztcHikKwZ87SvWaS8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691470254; x=1691556654; bh=Wm7vgVpyNkBovEIVcDALXg67wDGyu9eYENE
        6yQjh/qo=; b=f7g+IaoQM35PVL4ZEAIZqC7dTkKJe4xNoVSrGFjX/mN+JWQDU/n
        OlA2aV9ipoq9wOA+a7W2siWpATxORIHGqvsVoBrWKnV/ZgMFjKfii59WeANNOgtX
        HVyHTgZt/qKHHJW7xFGWtPc1KBXVRWANyySyeYP8e1QltIXVgoXitevHDeZgwhxd
        S6Thnjb2NfagG2giJR15QANlvu8wEKYo7hqVMetv9hIjCmvStZhpZuzuTcmGEcAa
        nVqGCSU324EPhk1LRoGQUXqOiCpc8hT/I3Ni+PcZcneORDHZJCP9u8e8KHlA3ta2
        bIU3Q1d+BOyjysaTWm4Q47NJRNZ7e69JpJA==
X-ME-Sender: <xms:rsnRZPqzCPiltoXrMJVOEvTvBKVw0UJwTTW8LR0HwQIGVKfcs6hWiQ>
    <xme:rsnRZJpZ1WurPRRg5wbbQaT1ikGKR05gZ3okxMXavsDN6URBUAHX2wsysGIEgwnnF
    DfhGRQH2bgfzAzoB6s>
X-ME-Received: <xmr:rsnRZMPar7XO1sd0erjYWhwv94iatwhv_KADYrWRf_4YmN9fgkYHAxoNUnoyL_YSPYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepofgrnhhj
    uhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgvqeenucggtffrrghtthgvrhhnpe
    duveevjefhjedvgeevvdeutdeukeeljeelhfeftdehkefhfeeivdfgudekueeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesmhgrnh
    hjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:rsnRZC7DEmVths1EIvkBWslzaioYWGokQcRJ_Q7uWKKBnWCBfqibdA>
    <xmx:rsnRZO4yBPMXyFzMsUIJNs9oQkvbZ3pL2dVOMS-rBgJx3u-v6C3vFw>
    <xmx:rsnRZKgf2ha_cT9-NXG4H6EA9l0IUErBJRjj73ltnqsKJEMUHNqJAw>
    <xmx:rsnRZLxctaBqUo9HUQTfcWSzmim_koKGN-5S-bnsbps7n8mGxr6wOA>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 00:50:50 -0400 (EDT)
Message-ID: <517d5988-2e71-4ba5-9588-15218eebc8ef@manjusaka.me>
Date:   Tue, 8 Aug 2023 12:50:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracepoint: add new `tcp:tcp_ca_event_set` trace event
Content-Language: en-US
To:     Neal Cardwell <ncardwell@google.com>
Cc:     edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20230807183308.9015-1-me@manjusaka.me>
 <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
From:   Manjusaka <me@manjusaka.me>
In-Reply-To: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
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



On 2023/8/8 04:00, Neal Cardwell wrote:
> On Mon, Aug 7, 2023 at 2:33 PM Manjusaka <me@manjusaka.me> wrote:
>>
>> In normal use case, the tcp_ca_event would be changed in high frequency.
>>
>> It's a good indicator to represent the network quanlity.
>>
>> So I propose to add a `tcp:tcp_ca_event_set` trace event
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
>> index bf06db8d2046..38415c5f1d52 100644
>> --- a/include/trace/events/tcp.h
>> +++ b/include/trace/events/tcp.h
>> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>>                   __entry->cong_state)
>>  );
>>
>> +TRACE_EVENT(tcp_ca_event_set,
> 
> Regarding the proposed name, "tcp_ca_event_set"... including "set" in
> the name is confusing, since the tcp_ca_event() function is not really
> setting anything. :-)
> 
> The trace_tcp_cong_state_set() call you are using as a model has "set"
> in the name because the function it is tracing, tcp_set_ca_state(),
> has "set" in the name. :-)
> 
> Would it work to use something like:
>   TRACE_EVENT(tcp_ca_event,
> 
> thanks,
> neal

Emmmm, sorry about the confusing var name and thanks for the review. I will update my patch ASAP.

best regards
Manjusaka
