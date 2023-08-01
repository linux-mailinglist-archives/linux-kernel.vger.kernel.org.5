Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4777976BF2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjHAVXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjHAVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:23:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400210C3;
        Tue,  1 Aug 2023 14:23:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f090316dso4179785b3a.2;
        Tue, 01 Aug 2023 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690925006; x=1691529806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSkb1LatFo01kR5er2AkepZzOE9ufFWbUCqCUcrWwRg=;
        b=Tvxd4/k+ldaZr43vqe4RVnaY+c5ReOgBCT7JC+J1HYzGuey1mTjHt84IBWamfWmtPy
         mC0nomaz/Ipj5BlVYwegvYb9zHdpBu1JkB9o4jk4FIZGnGuC53SLJ4o3L6Ex4K6MkNTY
         a4alMgqE/SfA+BeOf3/9noRqw4FS/7EIXXtjUgxXU6xxYNE612gKAPlFmhXaSLh5/0BW
         +NYDZcyrelqcnCwy5fhbYcCTBcpzppqti9Takdu/8QkirBQlF/XWP6rSq/ZvuZ6n4TIw
         CDmHOS6KamxrqoGhH5wVmuXLMIZ/hMrgm1xTCN1o5kCpyfwitEntP3vLk6+t+Nk/VXEK
         xkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690925006; x=1691529806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSkb1LatFo01kR5er2AkepZzOE9ufFWbUCqCUcrWwRg=;
        b=huJ64F1EhwBghLKkv+Upfu0cWRGCRiWeLWq/R2fB/R05vFQaf48tVTYJUtKspoJxC0
         Lisxeka6c6lJxZAY+b3btNsd6z+50pkpcp3wqfapGiluMa9+FU5P2HSSdCQaye8pxS9d
         4dRFz9Em9s7kvM78lgciwKwmkHHy52ikDv6pfKsegLObGgZw35e3jfwU7NNZlcRWrd7p
         rRkq2Zd0TMjfUh3aFu+G3/Scp58Z8P3QF2O9/BnqadDHi5uKmYta1QDylo+5ut2ixrmi
         H+eRumOkU/Ye5Xs7tKati5qHSWxD7Dd0f7JoUilDn8ovsuXD9LbXCjXYsSJngnq9mHg1
         SjxA==
X-Gm-Message-State: ABy/qLZ8/wyIW6jR1ZvtZxUgH1mlX8w5Ue/3ivedUe1L/2hkOsRmwkiC
        itPS5bbIVE1OTmN2x0hV5VI=
X-Google-Smtp-Source: APBJJlEUQDSWiKITL7N+JSJRU4yDFDeczzCRVHuO5A0C0xOs0n74cZrlbzrWTNt+DYd7G5dZgEVBrg==
X-Received: by 2002:a05:6a21:4984:b0:12d:3069:69e1 with SMTP id ax4-20020a056a21498400b0012d306969e1mr11098258pzc.60.1690925006248;
        Tue, 01 Aug 2023 14:23:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n9-20020aa78a49000000b00668652b020bsm9741246pfa.105.2023.08.01.14.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 14:23:25 -0700 (PDT)
Message-ID: <3f3aeff2-0930-3be4-d9b4-0843d5fa3944@gmail.com>
Date:   Tue, 1 Aug 2023 14:23:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/239] 6.4.8-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230801091925.659598007@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 02:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc1.gz
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

