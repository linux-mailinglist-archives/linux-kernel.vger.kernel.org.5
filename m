Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C880ADA0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjLHUQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:16:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE8123;
        Fri,  8 Dec 2023 12:16:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c3b3caa55so431815e9.1;
        Fri, 08 Dec 2023 12:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702066613; x=1702671413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIAzMCiwJSZ7GUp121efXJqWFAFOgKJGEvOKpU6gcvs=;
        b=ciaEEPpz5lAJoGJzD2cvMqHq1rfkSp8yisi+8QJ0AoflLBBIQvgXpbq30467OoeEVM
         c6xvnsBpikH2QsN3pZft/szdcx+t2nbpqRklkTFmUV5o6u1ZJXozNiR+KME1/gVcouE/
         0AuxXUww17UUhn4zt0fn1whDfIvnUNQBRbfLvvMJ13DqFIwJ4EkTOKdLjSDPegb5UGLr
         ko1tq45cIIecTWe8yiqxyMGxxNd4lW7ykYmUB2/0CBbLSupAuif7Ef0UmlvGEjvMzBxF
         XzYNSi/O7U7xrvV9x+MzsFP3wdwlAWxVHrPIrI3TTqGTdkH6agwc3zC4VSHLs/DX6rWN
         tR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702066613; x=1702671413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIAzMCiwJSZ7GUp121efXJqWFAFOgKJGEvOKpU6gcvs=;
        b=wMPTyeheRHqQxjb5Q0ObGdSQlJCxzh6AExB0KHPUnxuASRefRQPHZAbRQl/EOIShhC
         ZdULtH8x0a3xU0GlMU6dT6czjKHLvzDKpCdavuahhMyrQJ/sQL5nB9BsJWdG1bCcX8OS
         p9sA/SmDHLVB+t0I+SELT9yKq8FY3y7ymHkKxS1aJKmaWpgdRQMF9tUI8ZUgQSBYJEiL
         wEzeq5HV6sEGYSBSRohjgYpmEPcE7Cruu4nmbuCJwgbpqaVFdhtZSMt0TPlzamY8oiHp
         60LYaKhQKUcwfFcyLbRRzoZ9OM0jvrKfImmhqECnRM74kCQE58+utjObjNayMW5vcgcA
         r3/Q==
X-Gm-Message-State: AOJu0YygfZ9/ig5yV/nLffHfYGS9htCuCmi4uCDuDC+d995gl9BToAKa
        gxsLQbwydaAMvR+JUvcCVSo=
X-Google-Smtp-Source: AGHT+IH9E/4bnvH9YSWOadmFJf+ut/SYIovjRfbTDYSnJvWRybbbFwlBNw1G8CFwyXdv0OXGnX+rsw==
X-Received: by 2002:a05:600c:54c2:b0:40b:5e1c:5c25 with SMTP id iw2-20020a05600c54c200b0040b5e1c5c25mr272170wmb.58.1702066612869;
        Fri, 08 Dec 2023 12:16:52 -0800 (PST)
Received: from [192.168.8.100] ([85.255.232.89])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b0040b37f107c4sm2713374wmo.16.2023.12.08.12.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 12:16:52 -0800 (PST)
Message-ID: <48bcbb79-6464-4a46-8070-b59a64018b91@gmail.com>
Date:   Fri, 8 Dec 2023 20:09:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com>
 <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
 <ZUlp8XutSAScKs_0@google.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZUlp8XutSAScKs_0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 22:34, Stanislav Fomichev wrote:
> On 11/06, Willem de Bruijn wrote:
>>>> IMHO, we need a better UAPI to receive the tokens and give them back to
>>>> the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
>>>> but look dated and hacky :-(
>>>>
>>>> We should either do some kind of user/kernel shared memory queue to
>>>> receive/return the tokens (similar to what Jonathan was doing in his
>>>> proposal?)

Oops, missed the discussion.
IMHO shared rings are more elegant here. With that the app -> kernel
buffer return path doesn't need to setsockopt(), which will have to
figure out how to return buffers to pp efficiently, and then potentially
some sync on the pp allocation side. It just grabs entries from the ring
in the napi context on allocation when necessary.
But then you basically get the io_uring zc rx... just saying

>>> I'll take a look at Jonathan's proposal, sorry, I'm not immediately
>>> familiar but I wanted to respond :-) But is the suggestion here to
>>> build a new kernel-user communication channel primitive for the
>>> purpose of passing the information in the devmem cmsg? IMHO that seems
>>> like an overkill. Why add 100-200 lines of code to the kernel to add
>>> something that can already be done with existing primitives? I don't
>>> see anything concretely wrong with cmsg & setsockopt approach, and if
>>> we switch to something I'd prefer to switch to an existing primitive
>>> for simplicity?
>>>
>>> The only other existing primitive to pass data outside of the linear
>>> buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
>>> preferred? Any other suggestions or existing primitives I'm not aware
>>> of?
>>>
>>>> or bite the bullet and switch to io_uring.
>>>>
>>>
>>> IMO io_uring & socket support are orthogonal, and one doesn't preclude
>>> the other.

They don't preclude each other, but I wouldn't say they're orthogonal.
Similar approaches, some different details. FWIW, we'll be posting a
next iteration on top of the pp providers patches soon.

>>> As you know we like to use sockets and I believe there are
>>> issues with io_uring adoption at Google that I'm not familiar with
>>> (and could be wrong). I'm interested in exploring io_uring support as
>>> a follow up but I think David Wei will be interested in io_uring
>>> support as well anyway.

Well, not exactly support of devmem, but true, we definitely want
to have io_uring zerocopy, considering all the api differences.
(at the same time not duplicating net bits).

>> I also disagree that we need to replace a standard socket interface
>> with something "faster", in quotes.
>>
>> This interface is not the bottleneck to the target workload.
>>
>> Replacing the synchronous sockets interface with something more
>> performant for workloads where it is, is an orthogonal challenge.
>> However we do that, I think that traditional sockets should continue
>> to be supported.
>>
>> The feature may already even work with io_uring, as both recvmsg with
>> cmsg and setsockopt have io_uring support now.

It should, in theory, but the api wouldn't suit io_uring, internals
wouldn't be properly optimised, and we can't use it with some
important features like multishot recv because of cmsg.

> I'm not really concerned with faster. I would prefer something cleaner :-)
> 
> Or maybe we should just have it documented. With some kind of path
> towards beautiful world where we can create dynamic queues..



-- 
Pavel Begunkov
