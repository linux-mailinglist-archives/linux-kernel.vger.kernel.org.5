Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40467FDBB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjK2PmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343857AbjK2PmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:42:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF9F10D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:42:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b552deba0so4850675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701272529; x=1701877329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAAXjfMF22wmNcQ+s0IdrozkzcalgKiO4M1qR7njTVA=;
        b=Qu+XOJqtH2wUCFR346HMDrgW5TYqA6wK9HntzV2tp0ytB3Ix5wbF6is+znjSyAPS8o
         yef3Mqon+uSMjf4KzOh9gQdp0HeHHkwHgQ8AaqUBl74OkLMEC4PxqIEU9mhGYwPDlGHP
         BoLh5DxI3KZW8mxOPQ8AJFjB4+iMdYjDrVzftOogXWm2Ua+zOFsHjLVU95JrD9vkXxPK
         cC2VE3zNkAh1KpeOgWoTyybz+lX0leOHeGRrDOUmgfBdq06cp6PmwZjNF3g0J9wUX8wl
         UNcuRScP4U4qD4OJWO2bM3WlLEU44FBa18IfjrI/MyfJiDfj8uQ6+lwWs1MzQ2AnavLJ
         T1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272529; x=1701877329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAAXjfMF22wmNcQ+s0IdrozkzcalgKiO4M1qR7njTVA=;
        b=W4yrNTli62mAGo/QdASMV0NBmpaFOct0y03sB3rUovegWRXQPno/AQlYXmHAgcWngM
         Dek3MUicZoic7Z2wJpEvjcuaUjfgoXCKiDbeXGxeU1Jt7jUw/ywNeae51R/iRqSUE2wm
         6goN/vOt3t2J+rsholMeol5AxEWKqLIYGFboq30SXWeLVrm5QcbM/PeUnjBgM81TPNLn
         iEPvC7a4e4aEB8hevBicMmgP08xFX7ZlVaJo78BpKnCqcGfBIo0w2P4yZSuKKCNjJs6y
         ZC21ZkqRvSQzssA4AmgSILGIGyvOlELnJ1yw91Q0kpEjtyySCynETrXgHaDniWZ6NcZk
         RR9g==
X-Gm-Message-State: AOJu0Yztjkyw+sLr2BCTSl4M+IALAjfUffZFHK86SRohVOu7Q6KlAias
        4NdxN8ftSZBNF58WXo4d86IrVQ==
X-Google-Smtp-Source: AGHT+IH4TzrRfDgsZod0caVz5r8wR1GQWm/j6x+x3almVBQZsjsddYvc+zPovzCXLzvr/SkYpPf2cg==
X-Received: by 2002:a05:600c:4e8b:b0:40b:4c1a:f5b2 with SMTP id f11-20020a05600c4e8b00b0040b4c1af5b2mr4370574wmq.35.1701272528922;
        Wed, 29 Nov 2023 07:42:08 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000194a00b003330b139fa5sm5316980wry.30.2023.11.29.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:42:08 -0800 (PST)
Message-ID: <30fe685f-d09b-48b7-840d-9d19d6c183db@arista.com>
Date:   Wed, 29 Nov 2023 15:42:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] net/tcp: Don't add key with non-matching VRF on
 connected sockets
Content-Language: en-US
To:     David Ahern <dsahern@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20231128205749.312759-1-dima@arista.com>
 <20231128205749.312759-6-dima@arista.com>
 <eb9a46a5-d074-445a-9e18-514ef78395d7@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <eb9a46a5-d074-445a-9e18-514ef78395d7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 11/29/23 01:34, David Ahern wrote:
> On 11/28/23 1:57 PM, Dmitry Safonov wrote:
>> If the connection was established, don't allow adding TCP-AO keys that
>> don't match the peer. Currently, there are checks for ip-address
>> matching, but L3 index check is missing. Add it to restrict userspace
> 
> you say L3 index check is missing - add it. yet ...
> 
>> shooting itself somewhere.
>>
>> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  net/ipv4/tcp_ao.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
>> index bf41be6d4721..2d000e275ce7 100644
>> --- a/net/ipv4/tcp_ao.c
>> +++ b/net/ipv4/tcp_ao.c
>> @@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
>>  		if (!dev || !l3index)
>>  			return -EINVAL;
>>  
>> +		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
>> +			return -EINVAL;
> 
> ... this is checking socket state.

Right you are, it should have been under check for
: if (bound_dev_if != cmd.ifindex)

Currently it's warning for all sockets (which can be re-bound), but for
sockets in the connected state it doesn't make sense as the key lookup
is not expecting non peer-matching key post connect()/accept().

In this patch version the check will restrict adding a key on a
connected socket with VRF regardless if it's matching the bound VRF.
Will fix!

Thanks for spotting this,
             Dmitry

