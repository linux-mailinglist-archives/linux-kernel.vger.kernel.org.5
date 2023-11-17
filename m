Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C850A7EF6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKQRGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjKQRGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:06:39 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57121D57;
        Fri, 17 Nov 2023 09:06:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so1691532a12.1;
        Fri, 17 Nov 2023 09:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700240796; x=1700845596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOZt18bg9KriBHr8Kwgqk5RCy5/kT06h5qAauPIkHFc=;
        b=TOl4ykpbg6Zrn/Jtkgw0dhKDs0Cv8YGqNSljjsrmchbrNb0b8mO6KMUa72f0bpceqT
         9gENIUdOKZI+vHPHKHcWVKdWfH3UxF1miPDqjvNnx2G/aaoByH/zMVJBLMB9ITcts5F8
         duSX/MZeQjTnvjqQ06Yl/g/2qefrxLwDgORwYqyphdnaxhCK1rMBd3x2Wb22exzK8hRp
         NJikDikM8f3ihB2F3w0LU47TUxA8BQ6KVVKXb0eRlH6Uh29CKbErTlbaj5afMK/vwEtq
         OfqgHqkgdgT5wikw2utlrFdst9T8u/HC0GUWi4FEz6xGYN4z6ZXwcUtl9ApIiTyV2iD0
         Smxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700240796; x=1700845596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOZt18bg9KriBHr8Kwgqk5RCy5/kT06h5qAauPIkHFc=;
        b=bq4PGPgm0uK0ojw8ksU4u/snO1uxO8LTfy1AcrIXo+vUT6DabiTiHk3+uXo4oVPvYE
         JuH3YedjvXXMlmwaW35Mh8sVr7/ZDAj0MPWvN44Q8ga1IIwX1ylBF/AbFZxdCy5HyaZX
         rF7K+9Os3xNJdmVxK7v3zTJDs9ASdFsM5hk2ADUvXkw5BI8E0dQF2hwCDfSdxJNaEC8j
         AqlpjcWCSedrqqfvKrEQ/6MivwYpHaVfYCpi251kEira1QDfXsDMx0ZqWSK1V78ybAHw
         E0rvhxU5sP34q2RPPBJiRctwcnD5ajUALylMZauAreECmy/N+l0MA3Jjy7GPxu9+YF1t
         wXmg==
X-Gm-Message-State: AOJu0YyqgLdLV+u/P6kL2er40hrngiH9K53JxlnWoPgXZlY+xx+QnOYm
        Tq5LeViguhgvyQsEvmHEiM4=
X-Google-Smtp-Source: AGHT+IG2NPDDzAoCkY6gi1aQ9VRk852pWBM0l9/45ZUgEmn0uG/+frUQQrg7EwY+8YcVLvsJTR0LHA==
X-Received: by 2002:a17:90b:1c05:b0:280:85a:b425 with SMTP id oc5-20020a17090b1c0500b00280085ab425mr48321pjb.49.1700240795600;
        Fri, 17 Nov 2023 09:06:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 4-20020a17090a1a0400b0027ffff956bcsm1721375pjk.47.2023.11.17.09.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 09:06:34 -0800 (PST)
Message-ID: <081febd5-9b95-4a30-bd37-d4dc1947c1eb@gmail.com>
Date:   Fri, 17 Nov 2023 09:06:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115204644.490636297@linuxfoundation.org>
 <b5367845-8d70-4fcf-861a-ff9b8849c9c9@roeck-us.net>
 <CA+G9fYtOMKserwz7w_gpe4bZnEwrd_-zSyndSepFP_jO9X-o1w@mail.gmail.com>
 <1059aa1f-ad92-4022-a2f5-c313561ae742@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1059aa1f-ad92-4022-a2f5-c313561ae742@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 06:58, Guenter Roeck wrote:
> On 11/16/23 23:41, Naresh Kamboju wrote:
>> On Fri, 17 Nov 2023 at 06:43, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 11/15/23 12:44, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 5.10.201 release.
>>>> There are 191 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> Build results:
>>>          total: 159 pass: 155 fail: 4
>>> Failed builds:
>>>          arm:allmodconfig
>>>          arm64:allmodconfig
>>>          i386:tools/perf
>>>          x86_64:tools/perf
>>> Qemu test results:
>>>          total: 495 pass: 495 fail: 0
>>>
>>> with:
>>>
>>> Building arm64:allmodconfig ... failed
>>> --------------
>>> Error log:
>>> drivers/interconnect/qcom/osm-l3.c:6:10: fatal error: linux/args.h: 
>>> No such file or directory
>>>
>>> There is no linux/args.h in v5.10.y.
>>>
>>> Caused by "interconnect: qcom: osm-l3: Replace custom implementation 
>>> of COUNT_ARGS()".
>>>
>>> Also:
>>>
>>> Building i386:tools/perf ... failed
>>>
>>> util/evlist.c: In function ‘evlist__add_aux_dummy’:
>>> util/evlist.c:269:24: error: implicit declaration of function 
>>> ‘evlist__dummy_event’; did you mean ‘evsel__is_dummy_event’? 
>>> [-Werror=implicit-function-declaration]
>>>      269 |  struct evsel *evsel = evlist__dummy_event(evlist);
>>>          |                        ^~~~~~~~~~~~~~~~~~~
>>>          |                        evsel__is_dummy_event
>>> util/evlist.c:269:24: error: initialization of ‘struct evsel *’ from 
>>> ‘int’ makes pointer from integer without a cast
>>>
>>> There is indeed no 'evlist__dummy_event' function in v5.10.y.
>>>
>>> This is with v5.10.200-192-g550b7e1fee20. I am a bit puzzled why others
>>> don't seem to see those problems.
>>
>> Thanks for reporting allmodconfig build failures.
>>
>> My apologies.
>> The LKFT found allmodconfig failure lately due to infra issues / 
>> timeouts,
>> the builds have been re-triggered manually.
>>
>>          arm:allmodconfig - FAILED
>>          arm64:allmodconfig - FAILED
>>
>> LKFT have stopped building perf on 5.x and 4.x branches, because we
>> reported several perf build issues and were not solved in the past.
>>
> 
> Kind of makes (sad) sense; after all, I had stopped building perf on
> 4.14.y as well for the same reason. I'll do the same for 4.19.y and
> for all 5.x branches.

FWIW, I will continue to build and test perf for all branches that I can 
easily run on our test rack, which are all of them except 4.14.y and 4.19.y.
-- 
Florian

