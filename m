Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A531678FFE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350206AbjIAPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbjIAPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:22:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF08110EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:22:11 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34914064ea9so2235655ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693581731; x=1694186531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZ/UUo7dmwgPx7RIpKjWTig9qF/FMJDUQUgngiYJLfA=;
        b=K8F3UQV1ymOfLdLSfAlZ3BcWmxspGrDSIEWGsDcAnxn209F4Mib6yLpuHQnnTwufTH
         X/C7PWd3DFVs3JmpdTrRaAYJSUAgkBqMO8K98Bv7Ag3MrUK+UVbnCZwHeEGEhZmMEGdD
         xTTru4PvyPAYDri8JvdVrsv8m2TG+OfO9vGVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693581731; x=1694186531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ/UUo7dmwgPx7RIpKjWTig9qF/FMJDUQUgngiYJLfA=;
        b=fchffSjzjtko2sfeDC8gaOtuBCQrT8cTN/vECFNL+HDeKxvZWugHTFIqFdmkdUiTiI
         FOr2cpNDQy7fojg8/6M3R+P2xw8DJ60SCTrYwRFm0NP9Jp75pXNEwCxp6DrxsIpQFGEF
         kr0f0oX3V+wioktm+cQ9F+xe8zbCAOs8mz89ALa4zdCHKUTW+2hliJYXImdV/ZEUTE+Q
         rgtZGQAnQ/k32QtiRVTcwqEod77iEP/p3qr/RVzVn2bMnLHkJqfyqGKlOFRiJve1mf3p
         Co388HCD2ej1cWS8++ZExzjs8ut8a0jAGhjZhuGUJYai3NDo89LK+QloyZTrwcBAsDHV
         w2CQ==
X-Gm-Message-State: AOJu0YyBUTYQRpaWPi6N8Xgy5kQO/nEsGImEqzXAzoHPhyQu0P5f5/7c
        3gioQ+Xuzd/kmwyckGrgH4TnuA==
X-Google-Smtp-Source: AGHT+IHFcGUzVCAq3Lqr5rDQN9JRA05kvOnNtuaxsaT9/v6PSg4LrB+8Wcv5937QwjnuRm5WtJLImw==
X-Received: by 2002:a92:ce48:0:b0:34d:18b:aede with SMTP id a8-20020a92ce48000000b0034d018baedemr2707579ilr.2.1693581731064;
        Fri, 01 Sep 2023 08:22:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q10-20020a056e02078a00b0034901a2f693sm1142863ils.27.2023.09.01.08.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:22:10 -0700 (PDT)
Message-ID: <e0636350-cf04-d643-c202-a630802cf541@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 09:22:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
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
References: <20230831111127.667900990@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 05:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
