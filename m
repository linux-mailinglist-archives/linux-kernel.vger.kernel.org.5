Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636F76BE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjHAUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:15:37 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54A2683;
        Tue,  1 Aug 2023 13:15:35 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8b4749013so48229415ad.2;
        Tue, 01 Aug 2023 13:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690920935; x=1691525735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB85EUEyYNgKQVCE1WlItPU56xIvZB5N93QNEp6sDIo=;
        b=geDpVVZFDdfqZbkAtbfy2X67vKV3caS6dvGDKIti3r3qOYtI+8nC+ldfK2k12CNWcH
         9xorTSy1bzCwfhyTDwbuuAwEneqXlxncMcHSEs1BI1qOu9huJH84O4V9LYrQUS0GMwJZ
         Zdt4b3lyAL9MnUPOwVJ+4r4txRAu+djO5AuWyexBrZej514PYU0b/pQ9d6UcWR3Aatu1
         mIyakXsJ5Meey5euBZ4NfdYhLRxtzvSzrPXQgxVrq/lqksjlR6pTrdXihasN3aoyaaI/
         cX9LE6K7Y6TX3HNMk1YBPmJSIe1i1JIOidOpZxWSoBTjiOiBpDykTk1blasFy+RvXHvH
         60/Q==
X-Gm-Message-State: ABy/qLaajollY2YH/5nufITH8Gg6Yrc+2sCqcMEpYUyxUDqaxReAIj5A
        780Ub4QfYCFL2e2SBUeFN5E=
X-Google-Smtp-Source: APBJJlGiDSeX7q/7wphP0CDKyITTGsFfFei8daLm8zJFXJMqWHNLbENCK9/WG9cSi6fxOLNzhIjciw==
X-Received: by 2002:a17:902:7009:b0:1bc:2bd:852a with SMTP id y9-20020a170902700900b001bc02bd852amr9131808plk.42.1690920934786;
        Tue, 01 Aug 2023 13:15:34 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001b558c37f91sm10825541plg.288.2023.08.01.13.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 13:15:34 -0700 (PDT)
Message-ID: <5f6c1dd7-982b-2214-f229-80a8ae40780d@acm.org>
Date:   Tue, 1 Aug 2023 13:15:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: next: arm64: gcc-8-defconfig: ufshcd.c:10629:2:
 /builds/linux/include/linux/compiler_types.h:397:38: error: call to
 '__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
 failed:
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
 <a660adba-b73b-1c02-f642-c287bb4c72fc@acm.org>
 <CA+G9fYsYifn9ywPc8KqYHwDDSTRQGOgf_T58Gpt9CYDBs8u+SQ@mail.gmail.com>
 <227327a3-399a-4a9f-a775-e9627656b5a1@app.fastmail.com>
 <67f2a68f-8462-e1de-c016-b84d7c6e3222@acm.org>
 <1f7e045a-5dc1-4667-b09d-bc74953e48b0@app.fastmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1f7e045a-5dc1-4667-b09d-bc74953e48b0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 12:54, Arnd Bergmann wrote:
> On Tue, Aug 1, 2023, at 19:51, Bart Van Assche wrote:
>> On 8/1/23 07:56, Arnd Bergmann wrote:
>>> On Tue, Aug 1, 2023, at 16:23, Naresh Kamboju wrote:
>>
>> If I change the return type of ufshcd_check_header_layout() from void
>> into unsigned int and insert the following at the start of that function:
>>
>> return ((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2] != 0x80;
>>
>> then the compiler shows the following in the output window:
>>
>> xorl    %eax, %eax
>>
>> In other words, the expression next to the return statement evaluates to zero
>> but the same expression does not evaluate to zero in the BUILD_BUG_ON()
>> statement. Does this perhaps indicate a compiler bug? And if so, what is the
>> appropriate way to fix the build error? Insert an #ifdef/#endif pair inside
>> ufshcd_check_header_layout() such that the compile-time checks do not happen
>> for gcc version 9 or older?
> 
> I played around it some more, and this apparently comes
> down to constant-folding in sub-byte bitfields, so in the
> older compilers neither the ==0x80 nor the !=0x80 case
> can be ruled out because of a missing optimization.
> Instead the generated code would try to initialize the
> variable at runtime and then do a conditional branch to
> the assert, but that of course fails the build.
> 
> I'd suggest something like
> 
>      if (defined(GCC_VERSION) && GCC_VERSION < 100000)
>              return;
> 
> before the assertion, in that case it doesn't evaluate it.

An untested patch has been posted on the linux-scsi mailing list. It would
be really appreciated if someone could help with testing that patch since
none of the Linux distro's that I use regularly provides binaries for gcc-9
nor for gcc-8.

Thanks,

Bart.

