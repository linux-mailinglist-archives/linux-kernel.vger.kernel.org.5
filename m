Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C98064C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjLFBmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjLFBmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:42:00 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288C01AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:42:07 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d559a71d8so5109415ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826926; x=1702431726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fl6uSMPG668/bjfJHguE8uLZnjAsB2+IPr+krcKfck=;
        b=FX1D24ia6wXJueCrn+VomkxiJ4rhPcg+v+2dHIy4awzTorcLqer5x3ZFdNKF6hq7Tv
         i7eHsE4H93rp8cMwXyZyizOf8HZI3j1sEJPMV2qugpzBPohB++m9hhEe4wlxmEZ5m/R5
         +8H1sB2TRgP/4SLUZcofZYkbC9RfOiWdcZs6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826926; x=1702431726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fl6uSMPG668/bjfJHguE8uLZnjAsB2+IPr+krcKfck=;
        b=F2aCU9mT13Y2bQrEIKNYhCQQZfsfC5uTwmH2YBi7BxsPZEganZLAw9dyMIz2qEtOZZ
         uN/5AjgMQklEWiNnFZb1BYU1WUEGpXDtRWXEXLHnmv0j++9+qVowNIVc8HUOfxH0vzuT
         Iwsib7IXQuLd3XH3kckL4FKQWcsxk+ggLY+ZgLKtB0BXTMDcOx0/RDfs069J6ctDmQ9A
         H1Q2yN61Qkf6dQLnwXpqowmLRIg1KfKOSGVQiSBj/VxuGXim8eU1QW7hUvTSzubXi8vW
         YfAN0Us+2boW2IVLsKNsI9A8gYb7JYHvKSuIsagLfsaqRJ/uJVzYkYq1/wyXRzmjKy5B
         vR3w==
X-Gm-Message-State: AOJu0YzzEShdXgnbfzs4bnjl+2keAwIfU6cE4cYvP8Pm6xCCvbG0LGAP
        mjsdxmgLzRd9AUtslBgXHAYyYWnJQru9TQ7c0ws=
X-Google-Smtp-Source: AGHT+IF7hRY676SlJdoe9e8zBAvOI5d9KgVkzLLXriIYVg++bbCrtMIl8ujxLr4pqmY+X8IPNmWltQ==
X-Received: by 2002:a5e:c30a:0:b0:7b3:58c4:b894 with SMTP id a10-20020a5ec30a000000b007b358c4b894mr581932iok.1.1701826926536;
        Tue, 05 Dec 2023 17:42:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o2-20020a02cc22000000b004665ad49d39sm3423615jap.74.2023.12.05.17.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:42:06 -0800 (PST)
Message-ID: <45e7a76d-6003-4840-8d0a-b20adfa42a36@linuxfoundation.org>
Date:   Tue, 5 Dec 2023 18:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 20:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
