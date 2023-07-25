Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5A762340
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGYUYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGYUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:23:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F11BFF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:23:52 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-34770dd0b4eso5925675ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690316632; x=1690921432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekXDyu2W+pCKzA6ZAQknA6XM9JTHKiWVdWhsFDDvJUA=;
        b=QboRsgZykf/WnZjlKNFIN/S2pglH2OzfBn/nsy42tx+qUli5k6sEBISiUnQXfCbAuw
         z69x9S67FxlW7gseYBqznVOtt/S1w2cyuzBosY50bZ3WYntpUFv4+j4JzW2dKxFyH7kS
         BQmO9NK17KswAr66QwyyOsFuP7EqdfWX1qjKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316632; x=1690921432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekXDyu2W+pCKzA6ZAQknA6XM9JTHKiWVdWhsFDDvJUA=;
        b=YQOIV0EqATTKWFTM3oehG1ge797Loe/mEGsi27NEYjDt3/chxl0zTO0fFeGj6RBvbM
         q6hVhN/C+NW+kabkgyJo6rLQcjZ53U+yvignoVqceyUBvJ/Q57wOHs0EvlwmONrCHg1g
         OfD6lgCfbwB1WlVYcUbR0HJS9k9dpZ3vnwIKbCKDwp3YTNgaWfoLQ1qSegBijpbHmPfN
         EKHiMlySKNSR4uz3pjbKHEhLK48sn0Q4NmEjsfmkuGQH3nvO4V3vw0Oyu37G/649JDPC
         87ncFHOAvC+U+9gHEfC1+3TznEKi4D/Qfa0SxxEFbnEM0bCwZYyIBbBllEMHU28PRmhU
         DhpQ==
X-Gm-Message-State: ABy/qLYH2YVCJWIR1Fapi/GfrEIyzX9SMLtfXQCqPY94xmPcpqtJZUyz
        payPH8SxZrHQ/8LRf8emvkMsVw==
X-Google-Smtp-Source: APBJJlFawHnEv9Uo5PwnXb9VgmrQbNuvCV5tcjp+P1JlUsIYrHnf20uurj9FhnExYC5nCVWA284fLg==
X-Received: by 2002:a05:6602:14d2:b0:783:6ec1:65f6 with SMTP id b18-20020a05660214d200b007836ec165f6mr16017816iow.1.1690316632219;
        Tue, 25 Jul 2023 13:23:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m22-20020a02c896000000b0042b37dda71asm3609505jao.136.2023.07.25.13.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:23:52 -0700 (PDT)
Message-ID: <2f5942e6-8f10-e785-bdce-f1ce4bb1f131@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 14:23:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 000/313] 5.4.251-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 04:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
