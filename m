Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3192C80F240
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjLLQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346726AbjLLQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:17:53 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79CD7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:17:33 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35d559a71d8so3098285ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397852; x=1703002652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZZsDTMwulx2C3PHKVWLrfVDevlLtMgvyrHa2kD2onU=;
        b=My5iUGhMjRl7x8qpUmPLn1QgT7QenFhVs7dVxTpeffupXcFR0RxmYnCOoCx00M3tOj
         4wWhmqV/8TWdRAhBZyOVEhp02zjFTPU3S0np/GamYs+C2e2rfv9xlr2oNv7PyG53Itq4
         AsxFd9E4pXYAAqQDdJrE2y3NkgWNqoJvZ/tlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397852; x=1703002652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZZsDTMwulx2C3PHKVWLrfVDevlLtMgvyrHa2kD2onU=;
        b=oZANHHcN6EWbQoxAHpMHE6gpuB4AipbXkYE/uZ4M5WH/kOrWJ679PH9NEDXH01nWqd
         crAMDD4Z+eUAAjJJ4p9kjjTGMdf/UTu1M7W9oaKn0ZZsxCDTFTMELTHEkOCz61+730TF
         iGWA9QAKaF6az9Z35zszSj3ng7avChICUhOotd3a/aSWdR6R1J8Fm3f7Pz0KnTlxVyk9
         LjHO0OaxUU1vxeTSjligAOk1mSAQPyR16eohXrrOYw+XQYyeSBRInT5fZFbWsbdab//G
         mBAByHtLayh1cKEUvkR+woEECJ2kDslNe1s1juBVT8HPAa5KcMdmS0SyBZnkpOc/xrPO
         49MA==
X-Gm-Message-State: AOJu0Yw4/lGjSr+FJlgJVUTL693QTn1vZebCj2LiPy25y5c8sjqNnslN
        zGT8SbFs+W6e2Z/7Z9jEs0U6tx60DoRu84CzEL8=
X-Google-Smtp-Source: AGHT+IEw06m80JBwgXxznxRucxWd2rsVfnN7r+g4/CDkw9yYXOxydY/mOkQq1kN0lweotU7cVET3yA==
X-Received: by 2002:a05:6e02:17c8:b0:35d:5550:76b7 with SMTP id z8-20020a056e0217c800b0035d555076b7mr12405452ilu.0.1702397852518;
        Tue, 12 Dec 2023 08:17:32 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id by4-20020a056e02260400b0035cb9b85123sm3014243ilb.46.2023.12.12.08.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:17:32 -0800 (PST)
Message-ID: <a716de20-d5fa-40c0-bb11-e34c1034d2eb@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 09:17:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231205183249.651714114@linuxfoundation.org>
 <fa221062-03b4-46d7-8708-9d3ce49961dd@linuxfoundation.org>
 <2023120932-revolver-apple-d4c9@gregkh>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2023120932-revolver-apple-d4c9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/23 04:44, Greg Kroah-Hartman wrote:
> On Wed, Dec 06, 2023 at 09:31:48AM -0700, Shuah Khan wrote:
>> On 12/5/23 12:22, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.203 release.
>>> There are 131 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> Compiled. Fails to boot up. Boot hangs during systemd init sequence.
>> I am debugging this and will update you.
> 
> Anything come of this?
> 

Still working on it. I upgraded distro on my system which is complicating
things. Not sure if this is related distro upgrade or not. I suspect it
is distro related since 5.10.202 which booted just fine prior to distro
upgrade is behaving the same way.

For now ignore this and I will update you.

thanks,
-- Shuah

