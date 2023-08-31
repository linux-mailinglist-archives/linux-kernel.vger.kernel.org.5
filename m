Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6226878EFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjHaOyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHaOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:54:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6501B1;
        Thu, 31 Aug 2023 07:54:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbf10333bso7180355ad.1;
        Thu, 31 Aug 2023 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693493649; x=1694098449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEC87zX549E+U9vV1oszlAIcg0x95pSsoYr9+gGAPGg=;
        b=DLesYJFQ2BdGuLLLc9ejRsO2gbpVoFY51bT5OLiF0KQHs9irBRL0m91JokUiFLfiVv
         Z71cnX6z2q0VNibLBGVPcibVZrZex+X0JneeTQy5QSZfXSa+9GjGtx75ggwuGh2Wpkpt
         B0qWIAnHoFsE46q38HfIlqZP7c6OAF/WaroUs9mYrfwBqCq06brdBYovmC3S/Pzxy8Ru
         yZmxb3EZYy/KfahuiqiMG0bn4LrFXQQT9cLbP/foebzBCN3AE8FFCKFttxHUtzboRLRp
         SRBROBqcPVT78IQorM+i0L5LYyXjV/PGsS5qLC9fuDTEXGdOqJBGl0wjbIVPwg9ZEmR+
         rBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493649; x=1694098449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEC87zX549E+U9vV1oszlAIcg0x95pSsoYr9+gGAPGg=;
        b=cktPdbdZN1FgqvIcJ/WhJqHmXPpXkSWhJEAQLU3zYk5FPNq3oN9yS1RG7g21foRQ3Q
         HzoL5Zsqwrw2stBKPRZ9UcdrqcJwyKM/pWMxwTQJFqDRYhshKUIWvjID1P308MT0CpVZ
         wMdN40i3b9ALxl0GpSYhVR3XN/8qV9L9SV3srBGLAAtoLsWPbf5aQ/kGhc4Z3dj4O3mP
         JuSNEM1kyLtYNbDk9ygE5LPV4Rrc6+7YrSgMyl5Zz5xIa9ae/9iw4NW5sLzqOVDVzOVq
         WO2c3VpG4puF2Y+GNjkj4Obd2xRqfibPr0Z82k/gEO2NwkK1KFkTj45IIvqlCJoatR62
         jFhA==
X-Gm-Message-State: AOJu0Yw8c37kZDTWU8eaeefThXEt0D8A+Lla9cxcjIuCFAbbZBW72TF8
        2Yu38x4b27kEYTda1WQbgGQ=
X-Google-Smtp-Source: AGHT+IFif2uVPz+tA6oL7Hzvt2UjKSQ9canwj2E14FUfSGqTe6utdnK5JoLTrBnjrZkAGA3TVO+A1g==
X-Received: by 2002:a17:903:11c5:b0:1bb:c06e:647a with SMTP id q5-20020a17090311c500b001bbc06e647amr5915734plh.53.1693493649066;
        Thu, 31 Aug 2023 07:54:09 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:f5ca:eebd:7e8f:7734? ([2600:8802:b00:4a48:f5ca:eebd:7e8f:7734])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001bb1f0605b2sm1357534plg.214.2023.08.31.07.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 07:54:08 -0700 (PDT)
Message-ID: <4a69c0c0-5e8a-9a3a-6527-3eb7e51a955e@gmail.com>
Date:   Thu, 31 Aug 2023 07:54:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>, patches@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Pavel Machek <pavel@denx.de>, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230828101149.146126827@linuxfoundation.org>
 <5b30ff73-46cb-1d1e-3823-f175dbfbd91b@roeck-us.net>
 <2023083014-barley-upscale-518e@gregkh>
 <64374066-4086-3e92-8650-ab1563350f0c@roeck-us.net>
 <95baa835-9940-a257-cf96-93c543aa389f@gmail.com>
 <CAOLZvyEuj=93tpObwDgyAK01Jyz8NfXQzJfAX5=vVwG1wxo-cA@mail.gmail.com>
 <2023083138-frustrate-race-9264@gregkh>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <2023083138-frustrate-race-9264@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2023 3:31 AM, Greg Kroah-Hartman wrote:
> On Wed, Aug 30, 2023 at 07:38:09PM +0200, Manuel Lauss wrote:
>> Hello all,
>>
>> Florian Fainelli <f.fainelli@gmail.com> schrieb am Mi., 30. Aug. 2023, 19:07:
>>>
>>> + Manuel,
>>>
>>> On 8/30/23 09:01, Guenter Roeck wrote:
>>>> On 8/30/23 03:52, Greg Kroah-Hartman wrote:
>>>>> On Mon, Aug 28, 2023 at 09:42:11AM -0700, Guenter Roeck wrote:
>>>>>> On 8/28/23 03:13, Greg Kroah-Hartman wrote:
>>>>>>> This is the start of the stable review cycle for the 5.10.193 release.
>>>>>>> There are 84 patches in this series, all will be posted as a response
>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>> let me know.
>>>>>>>
>>>>>>> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
>>>>>>> Anything received after that time might be too late.
>>>>>>>
>>>>>>
>>>>>> FWIW, commit 619672bf2d04 ("MIPS: Alchemy: fix dbdma2") should be
>>>>>> reverted
>>>>>> v5.10.y since it doesn't fix anything but breaks the build for
>>>>>> affected boards
>>>>>> completely.
>>>>>>
>>>>>> arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
>>>>>> arch/mips/alchemy/common/dbdma.c:632:14: error:
>>>>>> 'dma_default_coherent' undeclared
>>>>>>
>>>>>> There is no 'dma_default_coherent' in v5.10.y.
>>>>>
>>>>> But that was added in 5.10.185, from back in June.  What changed to
>>>>> suddenly cause this to fail now?
>>>>>
>>>>
>>>> Nothing. I started to build this configuration and tracked down the
>>>> problem after the build failure was reported by others. Sorry, I didn't
>>>> initially realize that this is an old problem.
>>>
>>> We could back port 6d4e9a8efe3d59f31367d79e970c2f328da139a4 ("driver
>>> core: lift dma_default_coherent into common code") but that won't work
>>> too well on 4.14 or 4.19. I believe it would be simpler to adjust the
>>> branches with this patch, Manuel does that work?
>>
>> Please drop this patch from all stable releases. I didn't CC stable
>> when I submitted it,
>> and have no idea why it ended up there anyway.
>> It was intended to fix a problem initially found in 5.18 (I think).
> 
> I'm going to revert it now, thanks!

I prepared reverts yesterday that I can send out if you want?
-- 
Florian
