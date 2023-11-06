Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9AE7E2B78
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjKFRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:52:43 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A199;
        Mon,  6 Nov 2023 09:52:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc0d0a0355so35042505ad.3;
        Mon, 06 Nov 2023 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699293160; x=1699897960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvMLV/XYihjMVpZoZAMN1HtjGi3fRmETd2VsU6bI7YU=;
        b=jc3J0W5ldWutRNQ4vFkBhlFO1IiW4feQsnwgv5kuUGkXYdqTpeFF9o1UnXHAVVgx9o
         AJf2+PrcM/BdOkB+CK3gSStVJJP2/wwkjvkA4yXdiFnWWx03sN18+m2rp8aE6SveK5NU
         Rhe9S6OyFnZT+BjsttHpGvjCrdS28Rhm2+hwNkKClmWvHqRkqLLjWzWL0kXPYD7qP59r
         FhaKkbMmed7Ob0osaKKL30wRzDZPxQpq226Wk3CYa8NQy5x01tdTujeSY7tDqldmZaGR
         OMplIsi4XrFLvXfYKOj0F3OWFJEpwrjh88EGePfdGfE44yO/EOLwCcJ7+1gZRySo/SP8
         ROGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293160; x=1699897960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvMLV/XYihjMVpZoZAMN1HtjGi3fRmETd2VsU6bI7YU=;
        b=aPyr++ty6GXrGQle2wDTJkTO3lvsBONv5sFB3Y7dPWVO9cQ43cyOKYQwwTZy30rqbm
         8669IsPMLf0m04HmUaHi/su1onsIkCGbugxZJwp1uvBP3f74CNFbs+exY/mLChIsj6ZM
         N6XuqwcdKh8Qi62TqukcFpwip2HFrS519SdAVF19+786UvnV0RIyzBz6D1rvHY+LPnb9
         UtwlfeLwJeBOKCGwQWPwMVR/VtIOEt6gO5hp1BUwF/Jih9Iyz3a1XOQFJLYD3M3oqZlK
         Nk4bJuYaSK/ZJfPAD7zuc7vIOKM1ZCGB5Fy54BNUhXmhddzbX44DRnIR9N0Ovo2PjZWg
         oxFQ==
X-Gm-Message-State: AOJu0YzNkfL1bfBAh85+BQZiU+XeoTMqxQKySSXUPMQkxNLeAGT4tEg8
        nCZcpzj6rU75bXpNz48pK68=
X-Google-Smtp-Source: AGHT+IHkBjm95S2cCyGqYNTJXIfdVIzMId/N24sP+ZbAuxhORjpVmXmMljjPwYKN6tI93qg3Uu5XSw==
X-Received: by 2002:a17:902:e80e:b0:1cc:482c:bc54 with SMTP id u14-20020a170902e80e00b001cc482cbc54mr23308613plg.48.1699293160443;
        Mon, 06 Nov 2023 09:52:40 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id iz18-20020a170902ef9200b001c9c6a78a56sm6188602plb.97.2023.11.06.09.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:52:39 -0800 (PST)
Message-ID: <a6e89e5c-9f9b-435f-ade3-f88fa4103abd@gmail.com>
Date:   Mon, 6 Nov 2023 09:52:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231106130301.807965064@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
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

On 11/6/23 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.62-rc1.gz
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

