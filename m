Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646DA7C5D80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbjJKTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjJKTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:16:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226892
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:16:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb673so2730375e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697051798; x=1697656598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5c7wAqJXzemiKc+eLKhbo8orKmNQ4rpugFz2Iy29s8I=;
        b=KzTHsJNgZ3lN3KQI0i1Zy0EZ76VIVxPyPt9Y3msuAHJuD/Bc+M7hYpk0TyOwX+1aKX
         UKGxlJGswZp7Kzt3y7bsU3GLQtrSt+dUobz7zGEfOVz4E08lxEbrA3xo6jjby7KicbCo
         Faej0belYWGPGqcIQvrcEjaGm1p2eKyJ4vWlAqeGe6AiA9WzqfmfDQq4mNC/SBYQm4ty
         OKmHqS2VDIS332XqLi6YKVQQPH+Wph5mp2vPFK+f/Fp4snbxr24IMlCatXwb9nVLh/pD
         mccBHaum7qp9OHnJVpxiqeem+XoJ5wgo728LHhc+Fx3gSF0vdEu33sIxIrDXGrSILcFO
         PD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051798; x=1697656598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5c7wAqJXzemiKc+eLKhbo8orKmNQ4rpugFz2Iy29s8I=;
        b=Q6HmOmp7PE+714q6KzVCRbmTfaW81RiuEc7FCgfwpx1Tr2gsdpTIthqZ3wwZSOPTYh
         JG6bgXo9C5+zxpQbnvi8SrXKj9cVrdKxAyz+75y4qHfaN2pngMn4k8+PYnI5bKc7m2aL
         UJ8OqMSFm9bnE9hjeRBTdB7rKNsZEZVh2dQfjmfVl7ZPi5LgHm+bZWrLhR23eMeR7K2i
         ptySIZlHnlcQJ7vYUBd40jkE+wA1/cqx2/UsQdHVOK7qxH6U9fStTo2tLKrk+8aMb+1J
         lpgZFxfuqSbhH347+Wfd+96rp+SBRK4oc8+8U9gmNjqgyG02mo9O4xFwLoQl+hX0SEDE
         y4uQ==
X-Gm-Message-State: AOJu0Yy67cCWUjYjrzR2Th20txoB1S9hBr9Ucd+zcRoKin/qRO+H1XlZ
        q95vi9hMW5JLTeNvb917eOg59Q==
X-Google-Smtp-Source: AGHT+IGFpegNCGbvoqybiqr50fu6J2urL7v5sqmq0HCvHcicLxuMtNreOQHCbopTZSMaN/v749I/mw==
X-Received: by 2002:a05:600c:1d9c:b0:406:8494:f684 with SMTP id p28-20020a05600c1d9c00b004068494f684mr18435537wms.23.1697051798086;
        Wed, 11 Oct 2023 12:16:38 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm19945381wmm.30.2023.10.11.12.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:16:37 -0700 (PDT)
Message-ID: <95bbc774-e527-4af4-b7b3-e49631069162@arista.com>
Date:   Wed, 11 Oct 2023 20:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 16/23] net/tcp: Ignore specific ICMPs for
 TCP-AO connections
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
 <20231009230722.76268-17-dima@arista.com>
 <CANn89i+LwYbzNd=mA8Hk0RTTy6siEUpGtJaRw7DdFQju_+4mjA@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+LwYbzNd=mA8Hk0RTTy6siEUpGtJaRw7DdFQju_+4mjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

thanks once again for taking a look :)

On 10/11/23 18:53, Eric Dumazet wrote:
> On Tue, Oct 10, 2023 at 1:07 AM Dmitry Safonov <dima@arista.com> wrote:
[..]
>> +bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
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
>> +       if (READ_ONCE(sk->sk_family) == AF_INET) {
> 
> You can not use sk->sk_family to make this decision.
> 
>  It could be AF_INET6 and yet the flow could be IPv4.  (dual stack)
> 
> Let the caller pass this information ?
> 
>  tcp_ao_ignore_icmp(sk, AF_INET, type, code);
> 
>  tcp_ao_ignore_icmp(sk, AF_INET6, type, code);

Yes, I thought about it when added READ_ONCE(), but than probably got
distracted over possible IPV6_ADDRFORM races, rather than on correctness.

Looking at other places:
tcp_ao_prepare_reset() seems to do a proper thing for dual stack, but I
see it reads sk->sk_family twice, which needs to be addressed as well.
tcp_ao_connect_init() seems to do the right thing as well, but that is
hidden in tcp_ao_key_cmp().

Will fix in the next version.

Thanks,
             Dmitry

