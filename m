Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1959A7A51C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjIRSKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIRSKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:10:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB0106;
        Mon, 18 Sep 2023 11:10:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fb85afef4so4421930b3a.1;
        Mon, 18 Sep 2023 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060605; x=1695665405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6maznjEXgWDHtf3uPCnCDUhsx4nCL1qmfuNmzcDHoYs=;
        b=lKBC25hPAR4xxyS49nD13nFf2jCL9ahimSmLXdsNARPDbmMf671y1PfquXIEYJfY5q
         ziScMz5TUBTSzk1Azy35SezHGzGPm3kU4KpZxMk2kM9M7xT4HWkk4gXo2scxk2wXyd56
         2o2VZA9KkKIj1tYAiDFiaZLlDS4jC3pMyDI0Zo6mslbQoVswJTRQRBbDd8Ka8BriR1ja
         GHJ75CSeO6zn2Pg1MfySIRb/6sO5Zhw7Sh4A33oLMMynVBxlbbjGYWQEHgnh1M1RJ40N
         ugVc5zNW+bzTuBxMIdEC8fZjDFXnl97q/ySbkQl/Yn78V6sc5/E3OMjHqg/vD5s5p5tU
         PR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060605; x=1695665405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6maznjEXgWDHtf3uPCnCDUhsx4nCL1qmfuNmzcDHoYs=;
        b=H4KEY95BYSi49B951OuRu+3vJiMYcFY10IM1lGxbBRoNdYpQ3RFarZMrQT/Z89Z8c2
         MmY6dA/Jivmu4vm0OVk3Om3rJ6xU6LZnhV3rnuo6UX7FvvH3k3l5gv8uDN9RdksWQuzY
         eVtJWSEmYjvJMFNpxzYUdIdw/YK1XqK6o5V/WiiShV9gdvo/pUmeU3iobk/+ar5xAper
         A2wFq+sBrEolDh2rC3W6i+kVDYkdoq6oVXQSIzbmuDU9gZoqKVwFFPynJ84AtUP4/OgT
         c1Z1x4QG6Y6DXVUMVyCL+tDYxCfcUo+KJBjjnmciaoqkvF7zcALPELH8gKaPcHZtLLyS
         F5sg==
X-Gm-Message-State: AOJu0YzMnNoiCnOSzluQ55zLVa1e0tGlc+uXlKlICJA0Jh3LDYSd3GVh
        wMhAwZQg9vTVPBvoC2zZu4M=
X-Google-Smtp-Source: AGHT+IHPHNj2H2G7P5W1DsuqTkz5X25XRN2Oiv+LRznZx5p1RsnN4Ts0LllmXBFdo/bKA45M5il7uA==
X-Received: by 2002:a05:6a21:a103:b0:154:d3ac:2063 with SMTP id aq3-20020a056a21a10300b00154d3ac2063mr7008057pzc.27.1695060604872;
        Mon, 18 Sep 2023 11:10:04 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c10-20020a62e80a000000b0064fd4a6b306sm7402910pfi.76.2023.09.18.11.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:10:04 -0700 (PDT)
Message-ID: <936cf5f4-1025-02a8-6bd2-dff755fa9ed7@gmail.com>
Date:   Mon, 18 Sep 2023 11:10:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230917191113.831992765@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2023 12:07 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
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

