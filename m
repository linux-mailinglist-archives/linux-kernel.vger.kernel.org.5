Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750678CB88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbjH2RrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjH2Rqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:46:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72FF103;
        Tue, 29 Aug 2023 10:46:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcb5df95c5so3501887a34.1;
        Tue, 29 Aug 2023 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693331203; x=1693936003;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ocew/w2atcEmCSwlMkjdQJJuFYY4ZZA2+kzr8umyZr8=;
        b=Uf+BZ9/FvKEWV5aK4pn0W+Gi4mKLfYKJ2pNzRZ0IsC3B4bTeq/IL9Miie6eRR1KzxG
         DhRqrs2o6KDhSSRjCCGyMH5reXLfAG9kIFVHJbPa0Mf58xcsDzOrkH67m12dxIxLfh3W
         SNBfFw+i/DyLKiBhIpgihfV9nH7oL3RuoGtP6i44ZGd6eDnZnI61RLrv3EHkLv40hR2l
         EtxNNKChCKN8aHe0JXost5NSfSVpt7QRWIK1U+a4bHEKcdk+x/nYYB6XPx5bULdCMVCW
         AOdO9ywoB+53b5XQZZsojXp0taEX+9JIoU9V8Z6WFHv3Yh7/zhdYV3l7MJWDqVAb0sbo
         RMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331203; x=1693936003;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocew/w2atcEmCSwlMkjdQJJuFYY4ZZA2+kzr8umyZr8=;
        b=KFxUwduvR84fe6A+GF8tNpwuhYHaY+3BeXsouiwXt3jwvC872HWJ31Db6tCQjUDgTn
         Gyt9pmfn5Yzj4lAB17fwZOp/b2+dnXFUjUZ2VvG+Ut+MMvCKkQgUsZ5CXElj2Mp17UXv
         YKMNBX4qOnM7bn2Foh+rWVVk2E6XUBozZjh3sd8BZPN1DHB6pwuErgja09m5vAFP75Mc
         6XoV6XyfoJTXqw0Gkv8Jd16ueLtB9CmQVS8KejyAegui6+HNuSlhtRiCNtaET5fASmD2
         wgM98M4s0iZpT7s8PA7Y+kAGqfBlY47yHqlbhrgXUTkX3ys5PXcLOKEwqROb7Vwg/uGf
         puaw==
X-Gm-Message-State: AOJu0YwN4YshPe+tHDCZrMDsXXgKH6qZn9Ppt1S1gzlm+fPRmxHk0aNU
        +rWgZ5pk2xNoE1FGu9VqU2E=
X-Google-Smtp-Source: AGHT+IF1aiYM5WpO4pbflA43yDUEkRs6AxfZ3StLZiWwJeWALuJ43TCZAU9p2HKF19s1ubZ/shybBw==
X-Received: by 2002:a05:6830:6a0f:b0:6bf:29d4:1886 with SMTP id cz15-20020a0568306a0f00b006bf29d41886mr1460142otb.34.1693331202963;
        Tue, 29 Aug 2023 10:46:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l4-20020a639844000000b005651c9351e1sm9274618pgo.64.2023.08.29.10.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:46:42 -0700 (PDT)
Message-ID: <ed443975-1fff-3ec5-d60c-a6f5bdc09772@gmail.com>
Date:   Tue, 29 Aug 2023 10:46:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230828101157.322319621@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 03:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.255-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

