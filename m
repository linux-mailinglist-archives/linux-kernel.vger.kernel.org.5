Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1C7626C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGYWfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGYWfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:35:24 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF4B7D95;
        Tue, 25 Jul 2023 15:28:53 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bba04b9df3so21459925ad.0;
        Tue, 25 Jul 2023 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690323762; x=1690928562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMgEKoIgRmYHSw5zUWSAc6Af8lxf/je615muBTBUKCE=;
        b=ht3FIqp84HH+sxd+PXppnv4kRpPWSfaavWRAX3AVIeEjRs/HBIEPWFepnNKauK0xfw
         I5AYiOygguukZjZKrs6kHeUFUcqImLm80V9hSI1hQn/lAdie7pbhh99scf280RJFd5mi
         5MCDQm/xQKTFlQFXEk5riiGTPPMsmmPTdea7HJO8HcqrnaCyt2ZGHEaNdm2TW31hkSGT
         xiJ8Re/rimXDGcFw01MaECDD3k3LzHDjsTFXJxVjnXasT1J3qZh7kUlds46Z34It/It3
         mgG4d050SC+CZdOSYBH3kVz9i4fNcc0EqxqjrQ0YuZiJNOPtO0PT1BMpNq8wkbQ/NXLi
         4q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690323762; x=1690928562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMgEKoIgRmYHSw5zUWSAc6Af8lxf/je615muBTBUKCE=;
        b=TCzNjT8JZo9s+HyQFOmqxq5VAg6j2xSYrTSpdifr1bLVjxXrw9S7i6V5YnyzSMqQOV
         XWufStOwCz1p0LZOQbHgYi+P8JNB1Y+LYWNSTM+w9HB2yFvR9LgnAulOwc+96+gqWaHV
         oIgHgNZYLcOzwvMTIULyIsYbYpxS47tKOzhfekBJt0oL73SOA7SsZP3YdpOe/Gk1Ry25
         6sLD9T+a7H9SsYi6Gt/LETPz2jNHgFNfx5c5QrF4WQjX45WWggXdSGmJsD8a0Vr95nL3
         E/tHa7CgOtojZizE/zK4QXh1WB/WuD/YsjusPF3vwW13sdTDf1BP2LrLeDoj5SJ3+kV2
         iGSw==
X-Gm-Message-State: ABy/qLageZtp1sUdCuYiJwTSOM7Eb9GatPltcnOpHfPCRjqTNoMjSi/Y
        lkw6AxTSdQyThEaleCMRlj4=
X-Google-Smtp-Source: APBJJlG3HbUkXg5FKlJENU46NUjywMvrQdOG3Eof0CGN+g3dpDqpEave+YEEHOfDYU+4ZMyaCkqBzA==
X-Received: by 2002:a17:902:820a:b0:1b9:d335:2216 with SMTP id x10-20020a170902820a00b001b9d3352216mr407500pln.20.1690323762263;
        Tue, 25 Jul 2023 15:22:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 1-20020a170902c10100b001bba7aab822sm4443841pli.5.2023.07.25.15.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 15:22:41 -0700 (PDT)
Message-ID: <3040a7d2-6097-4609-c7a3-9e544773f06c@gmail.com>
Date:   Tue, 25 Jul 2023 15:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230725104507.756981058@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 03:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.42-rc1.gz
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

