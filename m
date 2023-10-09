Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F86E7BEB94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378610AbjJIUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:25:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F489E;
        Mon,  9 Oct 2023 13:25:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-564b6276941so3615824a12.3;
        Mon, 09 Oct 2023 13:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883101; x=1697487901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHLtgNs/RgwJBT4RjvnNxunGnFoxHtAWIXgMjp/5w7c=;
        b=hXPO3YsSNGbeSpjtt0rSqmdVaE7S+dwzSGPDiB1EsnDz6cCA4gw4teLMEyITQNdZYs
         j5Crvk4VBuGIBdYMzUajR2mGQeQwbej0oJ0sQwm3qy1Mn5CGgWsUfGPPURyvBuHHPpQx
         wxXcM1KtVxhVxsjk2XBr82R9l5YA0+/iablZeAHzQ4nygFN2kuocmTJI24hGVioay7pn
         RFvYbhQ5MppYXwXv5jKgG+Wo5MHaldj12N/YX72FMX4lMc1Z/vjYTXYWGS11u20lcpEB
         SwqNLmlzn2SMXz/74EKjZs4goGuZVdEfQrxxprc+JeB6JxVEo1v+2D+Eu0GGyb31/DVW
         KPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883101; x=1697487901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHLtgNs/RgwJBT4RjvnNxunGnFoxHtAWIXgMjp/5w7c=;
        b=Jtt/d/0M9Av8u36AbzHup0ecTh2woEom2ehlYbBicvAhYRCgYyWHCwaiDonoZkmHtY
         LRXMCaABDNaSYYucwsxWXsAYtH/r4pxnRNFOj24CGJAY5gkAPn4cux7LXcr+I7szreBu
         nD5ldmVA0mcJ0U03AMyT2WFaIk2EIBRRrLhjD9yfdruWm05qrmGJFPhjHw1r1JRVIMf1
         cSuyq3596BS/o8z0fuOvoefHj3axjq9sFPZl+1j6rrKUEhyc91QJ38RzARbNBQ1yFkcH
         FnZOCGfEtdCbs+o1eAkhs7vzu7cxGy8cLJBjk4uBOvDNz/NtsXoHey78qbysqMCnVuCV
         WT4Q==
X-Gm-Message-State: AOJu0YzYrQVM4WnhAL1qSnN43K43FbrRYdzJKMpbedzo/BjTlIZS+o82
        /mzlx2NgSMqay4N2vezxQxg=
X-Google-Smtp-Source: AGHT+IGz/SLuOVtpJrZrOd5rtyqvsTpUymuLyu7aGUZba6bIlpEhLM4AHh5pFHuAWQvOmmyU6B3Ogw==
X-Received: by 2002:a05:6a20:2583:b0:161:76a4:4f74 with SMTP id k3-20020a056a20258300b0016176a44f74mr18943479pzd.1.1696883100781;
        Mon, 09 Oct 2023 13:25:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z18-20020a170902ee1200b001c55e13bf2asm10060425plb.283.2023.10.09.13.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:24:59 -0700 (PDT)
Message-ID: <c63be538-b479-4eb5-a1c1-5f3a44d416ff@gmail.com>
Date:   Mon, 9 Oct 2023 13:24:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231009130126.697995596@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.198-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

