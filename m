Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EE7D5705
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjJXP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343973AbjJXP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:56:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A58410CF;
        Tue, 24 Oct 2023 08:56:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cb615c6fbso28740191cf.1;
        Tue, 24 Oct 2023 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698163008; x=1698767808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3iJ9n4kZf5Fmlt/Zj0lshvC/7uIWRd7BIbE6REwALk=;
        b=eaLqvcCFb/CUAhlyyFjgkQAFk3Z8QtAOsplyU/A57PDQEmqhIM0GgTbkgpzAepcwH6
         OlPH0gyA+lG7PWYFcOBDzHtq4YAro2KZIEPThXufgsiOIJMo/jNez8TiZIaTjBu9TFOF
         vYfOyBTUhNwiNjy102bQEBTM/jC0YtJ6WkBz2yBrq6NY6mEqX+0Z1ChoHMvSZuP/fn/t
         JqN/qmcrkRKJfco6RANzc7CJOTk46VjStjXI0Ld2a4YnKRSCWdZpH+MvgqLd5SrXFEja
         U2lprNCWpq4d2k1pFPlM9bZd5c5imxnkxxar/hdvG5M22CbQG5ShkiPI++/MvK+KASyT
         oY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163008; x=1698767808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3iJ9n4kZf5Fmlt/Zj0lshvC/7uIWRd7BIbE6REwALk=;
        b=u26p85kCHZh+71dfxn1/OVcEgDVkKuNWw5vAbK60ClQKF0XwIUnpbk3u91Y/4FjtOI
         292qs7+p+pyO/Vi0VL632fSZo5s6faVzselOkWjDY+ZpzE+P2WVF0g/4luHVYG2scN4h
         Q0Q6w5MkRtpEBRJ4CxShoRxZ8cKDPEpfNk+gaW2Y9WGj1krxvn8UoNLEoMX+fOxtE+mc
         SoZ+GLyxrVYFQ6uAlxPe41FdBoWii3NYGkLn6bbfTaczS8Ii1mayK7ndWUO3/ipbOV7k
         uK5u1lnKvZ5wyHte3fRCHt/q3j0GLMxdN5NarNAhatiF5t0nfDCkTf6K7OykUArs9ZKz
         jvjQ==
X-Gm-Message-State: AOJu0YyzcgU9V8DV7/MV5DdBHqb8u6kKNk+Ecz5CQh0R75IJYeW2ZJua
        qI1FOOP1M1z4WnrvpMFULOA=
X-Google-Smtp-Source: AGHT+IE1iGEuWcd/WUNh3/SL+ti517dmHtLT8RqAVaypZK3yGF8nikkVyL6c5agsMBer204IRfPWFA==
X-Received: by 2002:ac8:5e08:0:b0:418:1084:1f4 with SMTP id h8-20020ac85e08000000b00418108401f4mr14267795qtx.48.1698163008461;
        Tue, 24 Oct 2023 08:56:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q8-20020ac84508000000b004198d026be6sm3582416qtn.35.2023.10.24.08.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:56:47 -0700 (PDT)
Message-ID: <5b5a223b-b5bf-49f1-8259-3dbedf1dafb7@gmail.com>
Date:   Tue, 24 Oct 2023 08:56:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231024083326.219645073@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
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

On 10/24/23 01:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

