Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD19D777E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjHJQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjHJQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:40:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04C90
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:40:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-318015ade49so1089624f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1691685644; x=1692290444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epYEpBUgtETJSNy8PNB2Kfzmm6EHCakHcxvtmtgnuZg=;
        b=jbE3fw5Ku34OflOLZ4ytj1QJJBgGF6jCJyNJh1Hy4D5ucAoiJ+gC0pKSQbIRGJPisl
         50RpxsOURQvwAVoQ/ArmultmavFN+R2NNeXcDYR21xYvMo2YWQP2EfE2TfR7+D1wyQpy
         /DEA4S6rHILPLi7C8Z3H1X+5XaTHr3pBElvrzMXuePfo32nwCnypDRfbyCcy481/Lmok
         vnqrECjFtYKLkSH3mdr45TqcDdYTRHkM5doKn051HA3k4Q8QjgvsNP3iN+DJ4kRosVX0
         GuXcJ5LcKAVIWSjn9MFEXBnF9kUbazsaaifPoBZ/bYT2eNyDblc38v8mxZ0wGPhNkULn
         exUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685644; x=1692290444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epYEpBUgtETJSNy8PNB2Kfzmm6EHCakHcxvtmtgnuZg=;
        b=fwPSd28FVTFiJ60XbZQITgEtCMYzShiekoXADlnmx6hKq/RhIhAW7LF8YGlOJ7/TEF
         NjgK2xr25AQfbiFmxhQ0lzEbvjeHgIPGibLzIupwiwYmXJQKO9FiplPESYbkMAfVm05W
         b8wWEnYBIxNnpsPNyYQ3hQurjQpLSLEbk+3RwCUsXNynOf4P4R9F+Hp1cbjbq9V6Jf8i
         88tuYc43aYiRuqH0Dd2MYT8x9skr6YJmoPXSAwH/eAGrjLihiceeWPniiqvHf0Fwv0I/
         +UimQ4GkpcuVqpJIwG9RoEWzCFtW/ye4KgDAx+8vdvzHmVMyAzD0KRFbphgWxzJs25Sc
         ZQ6Q==
X-Gm-Message-State: AOJu0Yz31oGbf4SF6L6682pTglJMVixeuI9LKkcV7qOjK+dOidrfM8Eg
        tL53pmhjneKE1vCbbnTsamLxxw==
X-Google-Smtp-Source: AGHT+IFTiOImpkReDt/CngINBkpyx28lr/NDG9vWL6le9vl7MmWb6Le1GUOnhKCl1w/wdU4OG8aNAg==
X-Received: by 2002:a5d:63c6:0:b0:313:fd52:af37 with SMTP id c6-20020a5d63c6000000b00313fd52af37mr2571788wrw.4.1691685643878;
        Thu, 10 Aug 2023 09:40:43 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d500d000000b00317ddccb0d1sm2663826wrt.24.2023.08.10.09.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:40:43 -0700 (PDT)
Message-ID: <48e4d7b6-d02b-f1c5-26d0-92ff3ca4df2e@arista.com>
Date:   Thu, 10 Aug 2023 17:40:36 +0100
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
 <d84888b2-8b5a-103c-3e8a-1be5e5833288@arista.com>
 <CANn89i+eUrn6tzQBNQjywyS-rsqm_uamJRdfP0-o_Pz2Dv1t8A@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+eUrn6tzQBNQjywyS-rsqm_uamJRdfP0-o_Pz2Dv1t8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 17:36, Eric Dumazet wrote:
> On Thu, Aug 10, 2023 at 6:27 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> On 8/8/23 14:43, Eric Dumazet wrote:
>>> On Wed, Aug 2, 2023 at 7:27 PM Dmitry Safonov <dima@arista.com> wrote:
>> [..]
>>>>
>>>> +bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)
>>>
>>> const struct sock *sk ?
>>
>> Well, I can't really: atomic64_inc(&ao->counters.dropped_icmp)
> 
> I think we could, because this would still work.
> 
>  struct tcp_ao_info *ao; // This is rw object

Yeah, right, had not enough coffee today.

> ao = rcu_dereference(tcp_sk(sk)->ao_info);
> 
> This helper looks to accept unlocked sockets, so marking them const
> would avoid mistakes in the future.

I see, will make it `const', thanks!

-- 
            Dmitry

