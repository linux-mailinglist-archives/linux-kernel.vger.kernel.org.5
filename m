Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D177C87F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjJMOiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjJMOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:38:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12C6BB;
        Fri, 13 Oct 2023 07:37:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c7bbfb7a73so1351500a34.3;
        Fri, 13 Oct 2023 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697207875; x=1697812675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbPsrJcoBy9BqlyOGafIHjglt8aQnlICvj5agohrEkI=;
        b=AY039YuwAvOIL3w5JOMPROqP4jeoy3HmesJasfe3f/6Yics7E5YNIJdBqORyjmDNL7
         87FcVeEEK1vv74C3nMY5YWqCum839Xwv8ofzNWf6owV+P1V4C6jYvYNze5k0Jo9B4lMf
         PKUdwu/vY84x7of6B31ZgO6YEcGPoYqSPF56vBZbFViVatQ9o9hO3htr8nVru5prQLmy
         XR58MSXQ8/cz3ECOu4Lf3bLi9UngXlNM/DHoAlI0ywUOBGIrQxCL101aUaJrlb8yYg2B
         NsbRZ4f0hGwecj/Fl9qoXMuKq2uT8jU9Sqqs8EvKbkmHOj6A3huGP15/ZTJDKRUp/yzz
         aLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697207875; x=1697812675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbPsrJcoBy9BqlyOGafIHjglt8aQnlICvj5agohrEkI=;
        b=Mqk1jqeu7xbPsY+96glbbLRWiZRGb3Xs0UNq83wPc+CdrXACPi+xesXML2AL+3fLfB
         3woovgDvCxUDDDtG5f6sgdW2+qZCmeyn5VU4heQSOKknn96HlyUNPiI/sDMFBEv1RpHG
         C/KQQWBAIyNyUqEQEhLexDTPPaUsxXXzq6g6l2ojPGuiAtNNkHIobrJXg272qoKvCdf2
         SUi0+Y61eetQKYcHLPy6ZtqouNw/zkhTd4n07LboY5wFs998aRR5IprY3b1/tFTE+cXo
         Lqto3M9MrMo0c0TfHkDKYZrJqREU0xJqhYEVcNukk92GNpKloR6uQQicT5rOvKTtDYmh
         LMnA==
X-Gm-Message-State: AOJu0YwZ06ljRblg+kfcqDLAt0P6caPQ1DqBYZNPRFJMaFdh7IilRkSn
        rRU/7JvH0ihDzbCHM4FOLUg=
X-Google-Smtp-Source: AGHT+IFfm+l7CiPc096l3so6sYjYDqpMw8wulF9kO9eG3vYQ6hHQHV4GyWqRQmtsxauxwFJ4npblNw==
X-Received: by 2002:a05:6830:18f8:b0:6c4:e81f:59b8 with SMTP id d24-20020a05683018f800b006c4e81f59b8mr27317088otf.22.1697207874959;
        Fri, 13 Oct 2023 07:37:54 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t26-20020a05683014da00b006c4d56392f4sm684143otq.24.2023.10.13.07.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 07:37:54 -0700 (PDT)
Message-ID: <2e52c8b4-e70a-453f-853a-1962c8167dfa@gmail.com>
Date:   Fri, 13 Oct 2023 09:37:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: remove md4 driver
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        James Prestwood <prestwoj@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
 <ZSkeWHdOAOfjtpwJ@gondor.apana.org.au>
From:   Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <ZSkeWHdOAOfjtpwJ@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 10/13/23 05:39, Herbert Xu wrote:
> On Sun, Oct 08, 2023 at 05:01:39AM +0100, Dimitri John Ledkov wrote:
>> No internal users left and cryptographically insecure. Users should
>> upgrade to something else, e.g. sha256 blake3.
>>
>> Some drivers have their own full or partial md4 implementation without
>> using crypto/md4.
>>
>> Userspace code search indicates a few copies of hash_info.h
>> https://codesearch.debian.net/search?q=HASH_ALGO_MD4&literal=1 without
>> need for MD4.
>>
>> Preserve uapi hash algorithm indexes and array length, but rename the
>> MD4 enum.
>>
>> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
>> ---
>>   crypto/Kconfig                 |   6 -
>>   crypto/Makefile                |   1 -
>>   crypto/hash_info.c             |   4 +-
>>   crypto/md4.c                   | 241 ---------------------------------
>>   crypto/tcrypt.c                |  12 --
>>   crypto/testmgr.c               |   6 -
>>   crypto/testmgr.h               |  42 ------
>>   include/uapi/linux/hash_info.h |   2 +-
>>   8 files changed, 3 insertions(+), 311 deletions(-)
>>   delete mode 100644 crypto/md4.c
> 
> Patch applied.  Thanks.

Does this patch break userspace?

Here's a thread regarding MD4 the last time its removal was attempted:
https://lore.kernel.org/linux-crypto/20210818144617.110061-1-ardb@kernel.org/

Please note that iwd does use MD4 hashes here:
https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/checksum.c#n63

https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/eap-mschapv2.c#n165

Regards,
-Denis
