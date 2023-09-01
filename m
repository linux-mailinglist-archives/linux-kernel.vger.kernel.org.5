Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6D790059
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbjIAQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbjIAQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:01:09 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE6B10EB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:01:07 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34914064ea9so2300805ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693584066; x=1694188866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCsm7PXzMA4syA8CcbnCY0pyK9en/7AsjazHCOViui8=;
        b=KPri6qk70P9io5Y8CK7EJWF9xEMFjN//tviUwc6u9W9omyktH3laEWg6m9vK/2tL22
         dxNC85spxM3jVn4RHuQui/Hdo7n2ln25m/CS7XEsBFz56qlmuW024Y/w1dL438Rl4Ym9
         BheGqL+qISJpHd7nOIR04izJKiuVSC/R58ZJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693584066; x=1694188866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCsm7PXzMA4syA8CcbnCY0pyK9en/7AsjazHCOViui8=;
        b=ZmKNmz8Wal7psXWBSAnzN+1mMBVf7s8BDZX7HNC8PlfLEUnmSfkM1m0eGpPeOtt2tD
         0kustJPO8GSbklKgVRz0SWDNVSwMdV1mRV1GzZVQl40og+0s2NTmfIx1o7SkfOCtSWZB
         y4nJk1YLwoUPUQGnL+Izajv0eOT4Y5A8mZ4hZWElSr82hUGqVUBdzZvK5FcKwrbMZf7Y
         epB4r3zjmz4Bdh86uO3139JZ3/x3K/IiIptCx2QlwVS5Z4YN8i++ndsMgKsACsoz+VUl
         iboQ0dFKu1X9aNMi4NtPe5ArNs8OqyquRbe/Z6zZWnzzVLLAHI20Wu2+vw53NuGxdoch
         IZrQ==
X-Gm-Message-State: AOJu0YyCjo00V66PHTupj+qVSSFR5og4FnyHQzVZsPazXB/DM3tqDPNX
        1RmZiho+erRwRaBOCeVx1qQZ6w==
X-Google-Smtp-Source: AGHT+IECl/yIAZ8YZTPgtDkBe82ANt3cbAnEAFiOnhj4JTckTUTkOO2xqK/EcdV8L56q0eNCdCsdHw==
X-Received: by 2002:a05:6602:3886:b0:792:6be4:3dcb with SMTP id br6-20020a056602388600b007926be43dcbmr2833593iob.2.1693584066384;
        Fri, 01 Sep 2023 09:01:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ge12-20020a056638680c00b004312e5c9b0dsm1097780jab.139.2023.09.01.09.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 09:01:05 -0700 (PDT)
Message-ID: <73970980-0076-292e-67d3-4563fc0d53ab@linuxfoundation.org>
Date:   Fri, 1 Sep 2023 10:01:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 0/1] 4.19.294-rc1 review
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
References: <20230831110828.433348914@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230831110828.433348914@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 05:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.294-rc1.gz
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
