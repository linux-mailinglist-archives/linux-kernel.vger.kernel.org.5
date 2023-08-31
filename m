Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE57978F2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbjHaS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHaS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:56:56 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21519E64;
        Thu, 31 Aug 2023 11:56:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bed286169so948467b3a.1;
        Thu, 31 Aug 2023 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693508212; x=1694113012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtK2p2poP/3rtfd8yJfH0otw1ECIcsU4I9M4hwYRP3g=;
        b=oRCgopWrsr8NgL7re2YdYaBDcRoUbUqfbnp1UaZLq304+CN+sgCY411F3FlpvzBmWf
         PoPbAMLoCca5Pxopn6FyV2BveJ2iS9pNOb/Z573nzSVo6mWa+1o6jrongKRLFpbBoDpZ
         jFJowsRRCG6x82SFO18gMQiYK4UW8S5xqfkgts10dCXajEVfMzmbBM7srx9fkie3jA8G
         Ep0IKDXK3QiKI2Z1ygfu+BOsa0MCNVAeJQhiFbPh3T/RIIRo3Fz6K4RJyU96q0n+8bFJ
         Xlf3pPphvLGtUosw5TW8tQEPEo1rvVeSYtrDCAi9kW6JYutIiGhV7hswItDi/BPbOGCJ
         M8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508212; x=1694113012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtK2p2poP/3rtfd8yJfH0otw1ECIcsU4I9M4hwYRP3g=;
        b=dS1TeKUypeGTDEHzOXVtPrv7UlQXF7fMmlyMQXwHZrFUvmOvJalhnWvMWdQtxa110D
         MtB1RGh/TKJVjY+C7+lrTmddMhh/Y1xfFhwfptayZol5Dv872d5vBOoz/tx/YK1+41YI
         C6U0ZjO07oYOQnd1H+Fkt9goB1xk6KeDX4YYBnkVnw/pNpXcSSjKocvgtQ8BnJ9q9OgS
         m+fc/AAUlZK4yPU5kJDMdB6XKfxyjTrpV1rrgj2lcn09Mpc3GoVviWMXZrysVR4VL/Bs
         Aqg7716BI1Pmaa0vN69OvoN0Vp8Fq4bHXYlxwOXJOP7OvO6V1U74v5Och+FNbrlRPtm4
         GUow==
X-Gm-Message-State: AOJu0YxtcgSbnNC5nDAvDQAA0r32vugd1rhbXN8sQfJ9hXKVHmu/bX9F
        LUrUInQPK3H9Wg732ZqBgYk=
X-Google-Smtp-Source: AGHT+IGFcgQpNTKl2oph6jmBDsPwKQ21j69FZ9RnP6pkDf4aXnGhmqrpK+TH7ImnKJO0a8EEu3R0zQ==
X-Received: by 2002:a05:6a00:1acf:b0:68a:5877:bfb1 with SMTP id f15-20020a056a001acf00b0068a5877bfb1mr600756pfv.20.1693508212326;
        Thu, 31 Aug 2023 11:56:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s5-20020a62e705000000b0068bc014f352sm1627201pfh.7.2023.08.31.11.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 11:56:51 -0700 (PDT)
Message-ID: <87933236-1f5c-c03f-650a-9511e1df879a@gmail.com>
Date:   Thu, 31 Aug 2023 11:56:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 0/3] 5.4.256-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230831110828.874071888@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
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

On 8/31/23 04:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.256 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.256-rc1.gz
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

