Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0B78B994
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjH1Ucu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjH1Ucn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:32:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C2CEC;
        Mon, 28 Aug 2023 13:32:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so1719794b3a.1;
        Mon, 28 Aug 2023 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693254761; x=1693859561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2DctLJ0sN1rLWYEamaeYJQ0hHmAoC8BkhI/utXkH6Aw=;
        b=VvKs3rkGARBLGEpM3G8ywEMrZHgDQuchaZOaU3WtfgG/YtD1U8NvSurQYR7DAJ1sjB
         dhjJDgAQ74ISsXXekf13niRLAXTbtq6Xi4jZkBSanw2MllQAY1K3v5xzFievOt9wmACX
         H0uZvTBLmHXMDwszPcNPZzflva3udr4LEiFvjH3mNJVhfvYftjnH5LAR2JH493N5PKyH
         Nx0A2nAENsfpjVudY1uHoRhbky8qzBu4os1M654Plm1Jrf1YLTXPjjFLzxf41mYJp7Mn
         RUXgJghzcik104Ev9RINlkZRLZpSAEFhI9jCZ6X2ibAqprJ4/adxzzIJhoCna4t0BMlf
         DlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254761; x=1693859561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DctLJ0sN1rLWYEamaeYJQ0hHmAoC8BkhI/utXkH6Aw=;
        b=NfsV9kog3pbQD521TXRnIO+0s/lKPlw/p+RfW8jZCQIltzqGzqI3gOndVYw9bkZYNk
         i4NJruX0sxcwaCMtwzJlKMx0TiBTDrdqNdiqU85kYT5M8WeYWxSvmNTKJx+CS7aaynZu
         zAwVoSd8coM0SaoiP5hvh7wt6BHyPzvgEi8mEuSunHk5eSYo7R3mbaJjacVuFg6EM6YM
         OjJ8S3pK5MM7CENo87sDv3clEhWO7SgI2pdnpyIS0vD7RWiIBLE4UaMEuUwmgAO6avHk
         sQV4TrLY0DP9jk7hIbANzCae3nnIPfVW3MNyY/LbfnxvcGs8Ufcfdp3huja8VkvW/pw5
         gSIg==
X-Gm-Message-State: AOJu0YwJwM+bDcdiHHDgjDv+dBZxozVItcq5DYRuTJ65qiFoWjuJnRJ4
        g0e/gM6+v9LDxd+XE7z4rOhAqSZRa2c=
X-Google-Smtp-Source: AGHT+IExS4GSW+/X8U9BFi2G0OwOd4T6jCEWg8kgMcckw/tc7P9drIQDk7DlD2SzNFGol3eWBvEbmw==
X-Received: by 2002:a05:6a00:35c4:b0:68c:59cb:2dd9 with SMTP id dc4-20020a056a0035c400b0068c59cb2dd9mr1026403pfb.1.1693254760933;
        Mon, 28 Aug 2023 13:32:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b0062cf75a9e6bsm7092592pfa.131.2023.08.28.13.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 13:32:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef24157c-75ff-6874-d8e5-723baa2ac7ea@roeck-us.net>
Date:   Mon, 28 Aug 2023 13:32:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230828101153.030066927@linuxfoundation.org>
 <CADVatmPpi8pLT=MKNuPjkTP5pLHPnCKu2v2Ms98YhzXUhAvyyA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CADVatmPpi8pLT=MKNuPjkTP5pLHPnCKu2v2Ms98YhzXUhAvyyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 13:20, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Mon, 28 Aug 2023 at 11:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 4.19.293 release.
>> There are 129 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
>> Anything received after that time might be too late.
> 
> Just an initial report.
> 
> mips builds are failing with the error:
> arch/mips/alchemy/common/dbdma.c:33:10: fatal error:
> linux/dma-map-ops.h: No such file or directory
> 33 | #include <linux/dma-map-ops.h> /* for dma_default_coherent */
> | ^~~~~~~~~~~~~~~~~~~~~
> 
> arm build has failed with:
> arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h: No
> such file or directory
> 12 | #include "platform.h"
> | ^~~~~~~~~~~~
> 
> 
I'd guess that the mips dma patch which fail to build in v5.10.y
(and by extension in all older kernels) have been applied to
those older kernels. AFAICs the problem now affects all releases
form v4.14.y to v5.10.y.

Guenter

