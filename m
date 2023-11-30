Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812707FFA86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346782AbjK3S5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3S5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:57:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CCB9;
        Thu, 30 Nov 2023 10:57:17 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d01c45ffebso12527025ad.1;
        Thu, 30 Nov 2023 10:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701370636; x=1701975436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Exv52TPUf3AOaA6t7+19yZpTBHz2Mm8ZmomI4RQTAVQ=;
        b=edtolJZUXpNkR/VzR4ErdrKgHlSNR69zPWJ+LeaDYZO1DMeJ37zcPmepFMUbFdGNvQ
         U7HCd9m+bU02RlImSLMR1nIWVcXSKLEMp9Ki8J8gTI5whRn22cn/XPKBFnjiRMmU9lls
         LW4ZP7MbMbk/aZlhjZlyORH1pm0IS46U8CNCxFDx2qTBrNzI0OC3uy4XqBnC5DYKh9qk
         TCS5CIDij0Fzxfw6+hwjjP0JWBKRYpVWe5l7OXy2aOnwMcWBEX+RZHk7de7n5qL5PDqf
         442cQ08fJmK9+wFDwQp0yiQPCngLKXGN6kwbDtws7l4H9DGE9KnGEQhFlBoSH593q6P3
         4ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701370636; x=1701975436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Exv52TPUf3AOaA6t7+19yZpTBHz2Mm8ZmomI4RQTAVQ=;
        b=Yje3yz6tUIJZuOPC4AiGL4sD9bdcco/2if29/yYl7BN3xL7J+LZTy61jM3Exg77QeK
         jW7RJJh1G0Frmz5F8P3A+osstVxrePsj7XS5C3+3tMt/NQvuLeStfTk/5sEkAAfJUjAe
         Y93+b93TZmEhRlP8+Ntp+TWhAEDTUE/yS/yvGbToMCYrR/ZLgqAbxZL6rL1YLTqB0ubF
         DjjG5Xk6rxfqpFTkRptukO13EI5NfHjqlknCa8YkU9BuEHq09WvdVIOirss/UlJNltqK
         +AGJ3CWhwpXDiaj4MkW/eWxD9WQNfOL0OBXIqZ40az7DcJezoCY1iJg7saTju+K8LNjY
         wniw==
X-Gm-Message-State: AOJu0Ywh0T8gNtBO+Ar1hIS6eJL+OINn9ASu2YlzuKuLuldESzQ7eLm+
        n8BfX78FurexIqxI0nD7B10=
X-Google-Smtp-Source: AGHT+IH3DiDL+xLbUZQ8OmJ6Q3v/3rNl8ObJgH8sk5z8qRThL6ymywtmzmNIIwFczx569F+2B1xuqw==
X-Received: by 2002:a17:902:e88f:b0:1cf:cf40:3cef with SMTP id w15-20020a170902e88f00b001cfcf403cefmr14406808plg.64.1701370636097;
        Thu, 30 Nov 2023 10:57:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id je20-20020a170903265400b001c739768214sm1748127plb.92.2023.11.30.10.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 10:57:15 -0800 (PST)
Message-ID: <c9c5517e-5df5-4755-b47f-3582d0b19d8f@gmail.com>
Date:   Thu, 30 Nov 2023 10:57:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231130162133.035359406@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 08:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc1.gz
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

