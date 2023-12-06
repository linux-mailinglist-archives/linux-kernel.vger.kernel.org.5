Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D258064AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376486AbjLFBjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376452AbjLFBjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:39:11 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB81B2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:39:17 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso2365075ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826756; x=1702431556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnDyv8mpa3XCy2SgMLwpGLCMFpHcfg7BstAYVZ2g+vk=;
        b=CBLXLQ60e3NGgK/kA9ff+RiSlSw10EqwJcj4lkuUDElcgVS+TCg5X1jAcYk3PJz8v1
         TyNaWSSRrePlx/EX0WQxJ088pETeV7g0rEnf/exPPHFML3MVPZAEEbrZgEsIpw3DPqV8
         XF2iuQ/mLulreYTKEBxxxfS1jDGvFQySGtzEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826756; x=1702431556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnDyv8mpa3XCy2SgMLwpGLCMFpHcfg7BstAYVZ2g+vk=;
        b=b5SVq4wmBmga7/HyCv2+96+H9GQ+R8DOwKWvC7BZf0rU7n1k/yYCCBB5algI3VRAbL
         ENRTrxoZsgSjQ8jPD5wZ5OqyuDN2fgqhrEZQHur3sMq7FYIIO7xVWeEmz51bZUkED9Ja
         cdliRAa1riczlRezVZ0nJ4aTIC8BDTwApoEdBXXlEe/eVxuLsxAg1k0+Yecr1/86+wsd
         6kQiIBXex1umKYJradBxCV7FMa46gOaTof+gGAjnAQCZzBdgoWNhWrTTnx/o78/JSVio
         jOrsaM+XCLl2xSGMSb7DQk0yxxY6n7f0+SvU8EzgShjNRKZXFu96owr4sS2v7CmUUU+R
         2WHg==
X-Gm-Message-State: AOJu0Yw8VlDK76lFn9SmmMrq7+MVR1gAcMnBTl/ivYfBPYIRDSPXe0py
        Rcl8uGROWoaUhtjY9BnRZv6rSQ==
X-Google-Smtp-Source: AGHT+IGzIESU7A3Ck3UjU6zQbOlLRTIOa75cH8+024JUo3E3grE2pQ2di68BCQa7ACjTU6J0dCrp5A==
X-Received: by 2002:a6b:5004:0:b0:7b3:5be5:fa55 with SMTP id e4-20020a6b5004000000b007b35be5fa55mr505681iob.2.1701826756393;
        Tue, 05 Dec 2023 17:39:16 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d25-20020a056602329900b007b457549001sm931003ioz.36.2023.12.05.17.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:39:15 -0800 (PST)
Message-ID: <55bf7a58-3b9f-4c95-841d-d483c3b0bb12@linuxfoundation.org>
Date:   Tue, 5 Dec 2023 18:39:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
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
References: <20231205031517.859409664@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 20:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.301-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
