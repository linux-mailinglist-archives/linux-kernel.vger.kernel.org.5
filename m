Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8037776718
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHISRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHISRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:17:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438AF1736;
        Wed,  9 Aug 2023 11:17:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f38692b3so39461b3a.2;
        Wed, 09 Aug 2023 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691605066; x=1692209866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJQ7Cy50cBVPoWtJxevAy6xVINQRSlrLcMP3CSFJ0MM=;
        b=S6GX7kEVUd9BxjShZ+LShn/6Dd0FvN8vTCReO7kF9aFwm5CowNxpSZvLDf7+feMRln
         afOqtI4Ff6yM5lJRBZBvyLTgONSTDCp51K4KreukoUaF8LnEvTCvF6Y+f7Om0Gp1nbpH
         FjEmevlgBV7tI3MgAIph26/7jid68ByoYPvxMifFtxqnA+A0NT2hPNmCvGe6VVrvbfy9
         xrAnyO5OkCkiKnBSzqWu8Jp6GTenzczkyg6Pot/w0yIIVIxtiLpkyqV4JfzpAR6ct8Oq
         ZhtnukLEeANR6+jZdRCcZW4qokjKlKeoebMHg8ufgubWCwAVXRhxJTUKa1lx2nrnr5j9
         FsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605066; x=1692209866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJQ7Cy50cBVPoWtJxevAy6xVINQRSlrLcMP3CSFJ0MM=;
        b=HvZVHUwpldxe9o3brKQ3uvv7NfFJatU6WX6IaW55JrDRurrvvIXtrMXAVQ7LB/1d/Y
         3cbKNpMgEH/16met/yH0UtvvGnDrirTRyWcpivxuETxLkzEkudsVRrp7XxTPSASA51yv
         M/8wHWg7emXC6xgbe/w3Lazs5MDa8KAcyjcBAqN3snYrhr2kIQEXrS47PhZ0G/nOcQ7L
         9sr+mwThyiYQ2sCA2/RHUAeQcQf2xJHtERxzv3FBXkyd2afQYwxdsesa9XPPpiZ1U7gE
         FEoa3Vw5a2DcIejzc4O8idU34D/K49pNdXWICyRG1Lde8Enwc6l0F2AQW4ljn9jjXbpf
         nO6w==
X-Gm-Message-State: AOJu0Yyq6cbYkZ+ymwBBspuAQ2QBo6mVK5AiJZPi+k3ofW475Fh4h1gY
        F9RLse5SyehxIGvEytykFXs=
X-Google-Smtp-Source: AGHT+IFgz9/M8aPndMwOw9738tQtX1YN6G8+HnGVOxGUusoEeZS5bOxIInyOJszPp7kJj9kO0JJ0qA==
X-Received: by 2002:a05:6a20:1394:b0:13d:8b58:53ed with SMTP id hn20-20020a056a20139400b0013d8b5853edmr2858507pzc.18.1691605065558;
        Wed, 09 Aug 2023 11:17:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q24-20020a62e118000000b00679a4b56e41sm10234159pfh.43.2023.08.09.11.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 11:17:45 -0700 (PDT)
Message-ID: <2c9315a6-1e77-288a-226c-a3dd866e5c1b@gmail.com>
Date:   Wed, 9 Aug 2023 11:17:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 000/154] 5.4.253-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230809103636.887175326@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 03:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.253 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.253-rc1.gz
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

