Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB07A158A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjIOFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIOFkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:40:46 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12AF1BF8;
        Thu, 14 Sep 2023 22:40:40 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-57128297bd7so1084168eaf.0;
        Thu, 14 Sep 2023 22:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694756440; x=1695361240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4W9/G5aL/Wgi4GOf9IacY40VhRxR066lrHQZEMg5zA=;
        b=SdLmrb1cn3tvsELHg5Fs5whNsKnGDc6yV9YqAEqf3D+pbaxDyVL6H7eVjZYaHpMBuR
         2zjEtqEtJ6Efu0FrRqv4tgU/9RZi34G4xh6PKTqCZgLvkaH5sj+QsTVVDi38uq+ixQtU
         0v3qTZn8q1Y95KWvEhvd3EsXgM2juDy78f1a89OAijS13dAJYUAvIrxjKJeBzauHRKVV
         iAm9wP18C1wEBmHTqQR3iifEgGBO9aywg26MJZqGyXqiPJsdqZIJ6AH08+Uz6Y6rhCtH
         zleCcid+j1zpbodlNpub/8CN05cnYMWWYd1yyjtP75lF8nzTVVsqPyHosKd647XXWSEa
         1aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756440; x=1695361240;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4W9/G5aL/Wgi4GOf9IacY40VhRxR066lrHQZEMg5zA=;
        b=g1uFqvG8vvdNXk7YDmGS0lSC/wofqTSeQJg60pJNqzb0HtHbDTF4K8zuGAGJyBJKGE
         3Zny8KScjSIe7FFiAwrfnwxzYw9BXhm0QX6Qefij7jPds4roHv8x28isHOnLeG9Svdc3
         LklxkXsgJdmvEx6uL87pmRwSJxh1lQv8B6rKZtvHb5A6Pco5YUvbW0RxAdJjGfMrdLTK
         NQRViZ5fC7INHZpZI9aNi2hKuuBLhZ41tNDheiKHkckB79krtmHb6MS2HBzSk2FoSRS4
         aWWK7ftErQZCx7cMjHMM1aLriJfwesoMjhOnxA6bI68Mla7xSH7TcOt2STFgyog+Rnjg
         4j6Q==
X-Gm-Message-State: AOJu0YyfPsddL34pyxActdOjDft302XfVo9jt80zltLLNBabQ9OD/7ql
        L9lv6ffqI8/aHqXCWtmW5BI=
X-Google-Smtp-Source: AGHT+IEG8UEvEp28b8+DTHwOJTny12gqBiHiLY4gWmnUqfwyXprN3AV2QabKyhkUgir7z6HVC8JKfA==
X-Received: by 2002:a05:6870:c214:b0:1b7:4655:2ac9 with SMTP id z20-20020a056870c21400b001b746552ac9mr923260oae.6.1694756440061;
        Thu, 14 Sep 2023 22:40:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a63b34a000000b00553dcfc2179sm1762184pgt.52.2023.09.14.22.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 22:40:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b490305-0ab7-403f-7bec-a08fb8f20b56@roeck-us.net>
Date:   Thu, 14 Sep 2023 22:40:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com>
 <202309142223.D16446A30D@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (ibmpowernv) refactor deprecated strncpy
In-Reply-To: <202309142223.D16446A30D@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 22:24, Kees Cook wrote:
> On Thu, Sep 14, 2023 at 11:21:06PM +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> We should prefer more robust and less ambiguous string interfaces.
>>
>> A suitable replacement is `strscpy` [2] due to the fact that it
>> guarantees NUL-termination on the destination buffer without
>> unnecessarily NUL-padding since `buf` is already zero-initialized.
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>> ---
>>   drivers/hwmon/ibmpowernv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>> index 594254d6a72d..57d829dbcda6 100644
>> --- a/drivers/hwmon/ibmpowernv.c
>> +++ b/drivers/hwmon/ibmpowernv.c
>> @@ -234,7 +234,7 @@ static int get_sensor_index_attr(const char *name, u32 *index, char *attr)
>>   	if (copy_len >= sizeof(buf))
>>   		return -EINVAL;
>>   
>> -	strncpy(buf, hash_pos + 1, copy_len);
>> +	strscpy(buf, hash_pos + 1, copy_len);
> 
> This is another case of precise byte copying -- this just needs to be
> memcpy. Otherwise this truncates the trailing character. Imagine a name
> input of "fan#2-data". "buf" wants to get "2". copy_len is 1, and
> strscpy would eat it. :)
> 

It is really sad that the submitters of such "cleanup" patches can't be bothered
to check what they are doing. They can't even be bothered to write a coccinelle
script that would avoid pitfalls like this one, and they expect others to do their
homework for them.

And then people wonder why there is maintainer burnout. I am so tired of that.

Guenter

