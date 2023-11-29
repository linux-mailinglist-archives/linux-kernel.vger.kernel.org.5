Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FF7FDF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjK2SLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2SLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:11:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328ED1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:11:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332e7630a9dso71710f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701281483; x=1701886283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZfrFEjly6j3DJuSlT/uX8JuRBViVALFnaCou9DZNQI=;
        b=NNVp9y/OtJnH66LKuQbSD56y+H1Y+KXpdogjIOLhj0X+bHcHImWmN1h8HKzUftC8fC
         huQz0zRJjZx8o7dq/knSWBYWNqKLbdUioYA3ZY721Vw2eYJpuftaBKY0Esx/5fi2Mu5E
         GFNj8jbL0ra6CYm2iXHiSfPDVvL/M23OEUgiogiMYkE3vcV4x7sME8n8mAybZPM64RZh
         eHeo8uQOwkdYuRrt5mv5qgwfgsMWhzqtz4BbB4KyKOdlh3V2vrruWsLQWBQJpzm+G0cw
         3y0BVeK4yXpDferLUubQJd8rxO3nIDjDkbEmQUMPzW0YA1cbTwnwodSfMxvPRmJ52wUX
         BgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281483; x=1701886283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZfrFEjly6j3DJuSlT/uX8JuRBViVALFnaCou9DZNQI=;
        b=IlowAzmKvReGKfdTDuq4Z/0K63/YtfvJ93oCnA1ww8oyrsDhckM9x1wHFf0wfgNH2e
         ycNPX4ieCr8AcFdc4qEUtA1jlW8k/Ux/oxLgQH6rwYvcYm0DxV+9W7TNseTBJdQ7ZTpn
         CMc4nV/JrtzyLgmeRty2Bs6/b5kFYdxN1H6z74Y624e9QaMvdN/BncGi8qEtoo0y4l8w
         W7ZQ09D1MYuX228VqvaO3o21eKoF1WTtcUfZlc4TBCrQQIEuOkBQf+WPztw2Xsx8xACs
         QDbSlO8PBVMwdupiS9BH0ifeUY89ZqQ5ZAwsVTnI84Yyfdk7GxEZLJR9DaqIbVCXLqMt
         SRKw==
X-Gm-Message-State: AOJu0YxsnHWRRPVE6VIsPAGDGKQ5PjMmEYpbU02EY8qk1s+dJbg+FEg8
        kaETnSMdxqWLpv91aBahDhUiNg==
X-Google-Smtp-Source: AGHT+IEhwCkWdP0sUFbD69esxkZdh+OHuvwGZTPW0vekaKKs1hVJeZSWcjzB1fm00cVVpOUnG+sckA==
X-Received: by 2002:adf:f510:0:b0:333:db9:47d1 with SMTP id q16-20020adff510000000b003330db947d1mr4326269wro.66.1701281482839;
        Wed, 29 Nov 2023 10:11:22 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v19-20020adfd053000000b0032f9688ea48sm18208090wrh.10.2023.11.29.10.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:11:22 -0800 (PST)
Message-ID: <59960e49-7020-4a91-9c87-32031cfc57c0@arista.com>
Date:   Wed, 29 Nov 2023 18:11:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] net/tcp: Allow removing current/rnext TCP-AO keys
 on TCP_LISTEN sockets
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
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-5-dima@arista.com>
 <CANn89i+Ln+d6fci8T1MWwACZGS-RE+DfOvQ1kvejGowtiYhofw@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+Ln+d6fci8T1MWwACZGS-RE+DfOvQ1kvejGowtiYhofw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 17:53, Eric Dumazet wrote:
> On Wed, Nov 29, 2023 at 5:57 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> TCP_LISTEN sockets are not connected to any peer, so having
>> current_key/rnext_key doesn't make sense.
> 
> I do not understand this patch.
> 
> This seems that the clearing should happen at disconnect time, from
> tcp_disconnect() ?

Yeah, probably the patch description could have been better.

The key here is that TCP_CLOSE may have current/rnext keys: they will be
the ones that are used on connect() for 3way handshake. While for
TCP_LISTEN it doesn't make any sense to have them (as they otherwise
should be per-peer ip/netmask).

So, initially I thought of cleaning them up on listen() syscall [1].
But obviously the result was a bit gross.

So, I decided to just let userspace delete any keys on TCP_LISTEN by
cleaning current/rnext pointers before the checks that don't allow
removing current/rnext keys as they are in use by connection.

For TCP_CLOSE it's a lesser deal:
- the socket may just be closed
- alternatively, the user may add a new key and set it as current/rnext
and then remove the old key (as it won't be current/rnext anymore).

I also should note that currently it's not possible to set/change
current/rnext key on TCP_LISTEN, this situation is only a theoretical
issue that may be encountered by userspace if it sets those keys by any
random reason before listen():

static bool tcp_ao_can_set_current_rnext(struct sock *sk)
{
	/* There aren't current/rnext keys on TCP_LISTEN sockets */
	if (sk->sk_state == TCP_LISTEN)
		return false;
	return true;
}

> Why forcing user to set a socket option to clear these fields ?

It's just before the checks that disallow removing keys in use:

static int tcp_ao_delete_key(struct sock *sk, struct tcp_ao_info *ao_info,
			     bool del_async, struct tcp_ao_key *key,
			     struct tcp_ao_key *new_current,
			     struct tcp_ao_key *new_rnext)
{
...
	if (unlikely(READ_ONCE(ao_info->current_key) == key ||
		     READ_ONCE(ao_info->rnext_key) == key)) {
		err = -EBUSY;
		goto add_key;
	}


>> The userspace may falter over this issue by setting current or rnext
>> TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
>> allow removing a key that is in use (in accordance to RFC 5925), so
>> it might be inconvenient to have keys that can be destroyed only with
>> listener socket.
>>
>> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  net/ipv4/tcp_ao.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
>> index c8be1d526eac..bf41be6d4721 100644
>> --- a/net/ipv4/tcp_ao.c
>> +++ b/net/ipv4/tcp_ao.c
>> @@ -1818,8 +1818,16 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
>>                 if (!new_rnext)
>>                         return -ENOENT;
>>         }
>> -       if (cmd.del_async && sk->sk_state != TCP_LISTEN)
>> -               return -EINVAL;
>> +       if (sk->sk_state == TCP_LISTEN) {
>> +               /* Cleaning up possible "stale" current/rnext keys state,
>> +                * that may have preserved from TCP_CLOSE, before sys_listen()
>> +                */
>> +               ao_info->current_key = NULL;
>> +               ao_info->rnext_key = NULL;
>> +       } else {
>> +               if (cmd.del_async)
>> +                       return -EINVAL;
>> +       }
>>
>>         if (family == AF_INET) {
>>                 struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
>> --
>> 2.43.0
>>

[1]
https://lore.kernel.org/all/CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com/T/#mfd4461bf1dabf6e4b994d85f5191b6cefce337cd

Thanks,
             Dmitry

