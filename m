Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817F7788E75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHYSR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjHYSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:17:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFC2736
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:16:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7748ca56133so11217239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692987408; x=1693592208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qbzVBrFYBOFGEjozwceiSctIozK/IVpN0SA2ucrboA=;
        b=Jp6WEs+BbxvQqlA43SiQJcMySHUvlPQFU3vidRUi99lkPe3GYjgHmfP14cVmAgkgbY
         nAHhitzvlgq+SS42MpKRUMTd6UFWu4+IylixpoVldD/oNBIW6h6Hd7GxP+Qm/XyvzPKu
         4PYyUrj1hiDV8fJhzVjlCvqbgtTfxPkb98Ym4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987408; x=1693592208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qbzVBrFYBOFGEjozwceiSctIozK/IVpN0SA2ucrboA=;
        b=b2TK5aehZgxDDiMxLfGaCaD4YMxQXM//XS0rET8oAx0mbK1N2LUumxx5hCNF4aT6K2
         OpRK31V5FBVCm6lYzdVo8Ni6IciGxJbVg6Aw3dlOGeoCGpqGbZhz0biZ1ggwTWWSxLnq
         wJBe23gvkacOpc/NUYvTvMKk3hX6GvG8sx+Ad2gJqcwBL8HCsB2e+bk8l8BdA5R3162r
         SdmFPT6gha3sIW8PeWd/Dvi3ENSFdSuZ4rd4KQljiqmDvALZdvc/0OKec3A1whlLyZ2x
         xmsB9dgh6PjiXPdC/+IH7LTAziwtHIgNToWMe9BtA/Kkr/32wK03YH4kVkQvKSljgAH8
         zK8g==
X-Gm-Message-State: AOJu0Ywby1gyTY8v+5RuywAtziandPUEl4Zez6+UJsgqX0w6HNrrJIgV
        +88ZgAFwpZZXMQF5A6uNPyY4yv+S9SJCglNTbsM=
X-Google-Smtp-Source: AGHT+IHbFvJzt+4lbtNc6RU3u5aWeTgxlUUl/Xv6HHaLe3oqqYziTWsmUKeF0uN+nlLkpYSshx2Puw==
X-Received: by 2002:a05:6602:1790:b0:792:6be4:3dcb with SMTP id y16-20020a056602179000b007926be43dcbmr6093866iox.2.1692987408618;
        Fri, 25 Aug 2023 11:16:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r4-20020a02c844000000b0042b3dcb1106sm692794jao.47.2023.08.25.11.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 11:16:48 -0700 (PDT)
Message-ID: <b53e3af1-52a9-1fdd-4c1d-7fea6b59ac9f@linuxfoundation.org>
Date:   Fri, 25 Aug 2023 12:16:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
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
References: <20230824170617.074557800@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 11:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.192-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

