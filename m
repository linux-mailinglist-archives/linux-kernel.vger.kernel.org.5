Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC376B9E7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjHAQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjHAQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:49:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E3212B;
        Tue,  1 Aug 2023 09:48:58 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca3588edbso1507784a34.0;
        Tue, 01 Aug 2023 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690908538; x=1691513338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0yN6oK3W9vL3zkCb9k5pyMai7qNiWEPcK6Gyy1cYqA=;
        b=Ix/DTEX1m/gtD8uXOHuBBxW6hMOKamO9UAXE9c1LO0s4csrTFC/bweCy9bbE899qXX
         WpKI8EdLvpeeXT6xsunwg08RqeT+jxuqwbLip5JROV3XcnCFg3YSsp92f2WI9/2pb5sh
         SOSienQtHkV80z4qdnYqExUVRIteMzqbQxRR/ekxYZCeKRGzZnm3dxX864M1RFq0Ti0c
         0ht6ty6vc6eN2Ey6r8kLTXbibw2CUrGRxMYOnpaAnO1j1RCfbAIwjoB9eDzKDoESQU6D
         h7aVSOtomaPFrZ72fpd7IECb1xRxheRL5KZfcTEUR/gQTdTxR/rMholQ0ddOKfT6KJpk
         CfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690908538; x=1691513338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0yN6oK3W9vL3zkCb9k5pyMai7qNiWEPcK6Gyy1cYqA=;
        b=CUpbcWheWZrGYjkVxYJ3qriWSf2rBzbzQXsVCAH0OxFVMX7e8cXkh9Ba1UnrgIx+d/
         ztg1Hn5s1nFYb8RhM9T6QXDQNfjMFqg1I+TxjRM85C+91NFodX+1IkN2/B8W5q/7ewUl
         5yIGMO05i6HQXTu5B8u7rvciBbhZN1r26Hw/mrnh4B0MBbilub093HCDOyDLIPsx+LUo
         SYDXYI5pwFODdtgqGwcNvjjP3nYk3/YEQaUStXy4ZM2JWtNCXcJjTaKzXMWYWCGWH/b4
         /SqVVKdqvGFE7MrFzqXNeDtdoJnU9Sdre1odHNZkKiRaJWlqZkzE9jdRFrTUlE80Wj4N
         kd8g==
X-Gm-Message-State: ABy/qLarOr6+V9V2PVQMoHaXqPu4hbWR+34JEABMNia9zjB2NoFSptIt
        DKPvVu/QCtV5cFSN58R1i5ADle6nv9IDZA==
X-Google-Smtp-Source: APBJJlHOeh/7Q1YTGuo1v/PI5q/b2xtH3Wfwj95sIp3lC1DXJJ3qkXpBpoMlIx73ZvkebdPzr1qgAA==
X-Received: by 2002:a05:6358:5e0e:b0:139:8a11:8a00 with SMTP id q14-20020a0563585e0e00b001398a118a00mr1454370rwn.32.1690908537839;
        Tue, 01 Aug 2023 09:48:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a17-20020a0c8bd1000000b0063c6c7f4b92sm4768947qvc.1.2023.08.01.09.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:48:57 -0700 (PDT)
Message-ID: <11f91413-3300-bea3-7f61-3ad855ef8c59@gmail.com>
Date:   Tue, 1 Aug 2023 09:48:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230801091922.799813980@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

