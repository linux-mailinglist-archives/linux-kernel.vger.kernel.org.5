Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33527E4AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjKGViP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjKGVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:37:58 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3996C199E;
        Tue,  7 Nov 2023 13:37:52 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7ba6a0bada9so2114289241.2;
        Tue, 07 Nov 2023 13:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393071; x=1699997871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OscIyj4i8GIO/pAULmGru3eamggIkLaqaKY2i8guPY=;
        b=UaURblc6RnKS5x9yn0XiM6GoVZzavMd5OhQ6FfR5YL/vkLqBA8E38mYm549VVGJzy1
         EUZrYRB/8TGYIZ+a0/GSWsVupwyaEnXGBnTfo2WrZyNGFAT1ZXE8Ga6zn+d4P86+Ebxr
         LEi8S3wQpYx253pjGdrC4XoXhKbHdfOOoi4IeR0jrDi3sRfOTezruvdkR6uh3YCVREDc
         NZXMmAwq1iU64CbueJw2b3wtTeeZDteTDu36KX3QllRRIYcuI6eUABNSs13DudFwWqXU
         oRlM8TOED4ti2mrTDFkJ2alYwT/zKPY6s5jp3s3YyYQ6PcP3/Lz5u6/9svT4QiWKAzhW
         Iv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393071; x=1699997871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OscIyj4i8GIO/pAULmGru3eamggIkLaqaKY2i8guPY=;
        b=Bi5PWWSn+y86QTrqCLWSGP1JuhmkHRXkFOHlhw2qIF9yyoa+vQhBUaByl8T3KF+fGp
         TtGDUzd2stDsOC3Mlzzef1PYdmtKIRAZW8XFPVLyMjRk0dCWDFALgYyoJH6pys0IJc75
         5DvuacOLLpWRS2ySpM8ILxq1EaVuF5lqWufBy/xtLmttCRvG/9BVtIb612QbWWUNK5uu
         kTM+cfFg+fWFu9AFbSWxOqFxOtByAye0Y3gU5xvaKgpfuSPOBkbc5TGJDV+C1Y4aMQou
         ZykBZOyY5OlmVRtpF2MHjUCoBnHGZmXxlOrnGHCUUox6hZB/6Us8kwxfSHYA2e70OciI
         1x5w==
X-Gm-Message-State: AOJu0YwdsLfU8DbThYd8+O1cuEbMdkjNbl65TCzLCPIiEBIw7D0JjLVg
        AG6kYRAZ3/s5kGvq+Q22ZYhmDL7ns6c=
X-Google-Smtp-Source: AGHT+IHfZKOcyiczSG9qjN0nBFczJGgManA+OefTDO1U0lQ0hQGCnFWFwCaqa7arjNdcdrWC42MwAQ==
X-Received: by 2002:a67:e041:0:b0:45f:1349:fec4 with SMTP id n1-20020a67e041000000b0045f1349fec4mr7488767vsl.20.1699393071294;
        Tue, 07 Nov 2023 13:37:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c21-20020a05622a025500b00419b5274381sm88621qtx.94.2023.11.07.13.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:37:50 -0800 (PST)
Message-ID: <7406cc46-15e6-439f-a8a1-3e44cc2ef4f4@gmail.com>
Date:   Tue, 7 Nov 2023 13:37:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/125] 5.15.138-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231107202324.434534294@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231107202324.434534294@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 12:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Nov 2023 20:22:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

