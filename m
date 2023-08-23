Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C5786142
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjHWUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjHWUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:14:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96A10D2;
        Wed, 23 Aug 2023 13:14:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso218807b3a.1;
        Wed, 23 Aug 2023 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692821682; x=1693426482;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ENARu/aPypvUKijJ61BaG061fO+rJyQYL9bbexKiSJQ=;
        b=DOwyH1+0wwzV7UVglk3+hbfFVcvdl7t/vbjnXO6S7kGoAuA7C7QfSFHqWWaJtI9fcQ
         8Npa8la2Wc5nooTvzLzSrM2Gt2s6wivswGWt5O0bi/XRrkSjN+KwmVBUynvEqp33eish
         UKi3abUGp+7Oiu6lZ1j4P8QWF2EncAoB/HM9sWncYCkB/YzW/VWU38ksd9OlxQqqaFQ3
         /JDenatfe2z1NCGJrmeiybri2Fb3Xgqx/FsYfOWnO/uLjFf2On8vhwg2jjstEuSbWzGX
         mGBvNYCvmGSthkkwb4EO2xYjrU+A0H9ziMi6vjf/HY2Qd8fYWPliOjJV2WjZHug8WiJY
         da3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692821682; x=1693426482;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENARu/aPypvUKijJ61BaG061fO+rJyQYL9bbexKiSJQ=;
        b=YHex7i+GzPnQtd64LeFH8/rsMTfMA5sHQQkMwC39LoHL6X42M9a54hfp7RxNSsKRAQ
         a1cduv+AKsyq6vK38N3ogOkvBRtnMpOcdpqVjnR/ZjZPuswTgPa94K+4dMJxl3LY5Wka
         ZKLDswc/LfoUQWzD3erCPqkElC2k1Rp7a+wsWly8/VgK0bQsZNqe7Yn0ZzhjoxZ5qBPL
         XJXdJqnyH7Vd+gXdCntSxdx6x3Cn5qiE93jV/QNYtBxUaUzZv44G48nanWBuagY/E9lu
         rUF6/vUgJUQ4kpaGytGubQ2KfeDCipb/Ak0YRvV3OtFGET8gkgKiytz+ReFCmRR5t9JG
         +Y/g==
X-Gm-Message-State: AOJu0Yz4nQPYB/u/BadBFxAKD1Yzi6GxxFKDafvt9xhyZl9bnZBFoDwA
        4fcFweSmBUfyTZmMEE+KXhT5MNMDB2U=
X-Google-Smtp-Source: AGHT+IHuoCBRBpvaTtL0zg2ATZOSsX9vVOCtLY8ej1KK9HqDGq1zRIVqpbNPesPonujmRCazLjSryA==
X-Received: by 2002:a05:6a20:4310:b0:149:2149:9491 with SMTP id h16-20020a056a20431000b0014921499491mr10020989pzk.43.1692821681631;
        Wed, 23 Aug 2023 13:14:41 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b0068a077847c7sm8219980pfa.135.2023.08.23.13.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 13:14:40 -0700 (PDT)
Message-ID: <5a4fedbd-ee1e-9413-2022-a155a098fe4d@gmail.com>
Date:   Wed, 23 Aug 2023 13:14:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230821194128.754601642@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 12:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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

