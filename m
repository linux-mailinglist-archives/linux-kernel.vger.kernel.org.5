Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C5677D039
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjHOQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbjHOQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:38:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FA10E3;
        Tue, 15 Aug 2023 09:37:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc83a96067so34410375ad.0;
        Tue, 15 Aug 2023 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692117476; x=1692722276;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vATAq2DFTP/4+GP8gbYG0srJWsKWgMXyeZyFkj7eOU=;
        b=ML3ux1Mz/CefW3Jvi9G3Ffs1OZ6/FmsqGjOwjwxi6bFy0X6Ivzf37pRs2z2ePyX714
         Pw8w4kJ+2TUBgcBs9xWnOPj/JR2NA80nG+sC4ecTJ0VmaNAskN/eiVXIXbqOp0U91a13
         7H1QmyqfWGjOu0s5ioPj3ak0Xw8Zgd2EgRf34/WIlhbbfBFXv722jTIiDEZRlZ9WWSuF
         C8cO3bO7orOnozGLpolivHQKJ+KOhlvSNu2InDpTe/hbRfcAxA+ka6gShHOWfRJz7Efy
         7RkVM2MBkwGv7aowJJQAlbQdhgdtrNrlg/KHCqXrwUD2rq3n3kmDSVum+waxSw8c61r2
         T8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692117476; x=1692722276;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vATAq2DFTP/4+GP8gbYG0srJWsKWgMXyeZyFkj7eOU=;
        b=W/QodkuTg+kNtd0wmnxaBOB2QSTTX//p2YBfEwSXMfLLWvQip0fkiVbzxFrPcDR/iJ
         2f5gNeVSis91MtyZUO5RcmvEvMJcsalnfdvK3qa+nMn71k1ZRTPeaXFWPbmGIM8xmqmo
         2uDqYCBieEFxBGImiWCj91rKDm5BIOZDn3Eh0xMc6USx3/VG72RAZbUm/wBbgQUpyGfF
         D+2vCCOyXayU1ahhDgOuUtCszJD9hkn4VkgmF86y373beKGHYvaydeyN8Cvh1Jnh694F
         M7OvmaDuXn7BWvJuXgG04qNA1Y7pA+UVXmXG23pHtlA/qwoExj+z36klV0XAf2Hgtfpb
         8DwQ==
X-Gm-Message-State: AOJu0YyAbT0c6A6/uXpJvNu7aCpyiyBDiE/A8gs1mdIDz8CublTmsZXV
        wUydwPwzjAT5tIuu7YFFq8Q=
X-Google-Smtp-Source: AGHT+IGv+JO5l2kJHdMXb4Jule4OuJqBE1aX+0zoyifq+BIKVlP/q3pu6vjLQ7KF7WezzlTEDfAf/Q==
X-Received: by 2002:a17:902:da8d:b0:1b6:af1a:7dd3 with SMTP id j13-20020a170902da8d00b001b6af1a7dd3mr14695025plx.23.1692117475992;
        Tue, 15 Aug 2023 09:37:55 -0700 (PDT)
Received: from [192.168.114.133] ([107.119.56.177])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001b9fef7f454sm11275719plb.73.2023.08.15.09.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 09:37:55 -0700 (PDT)
Message-ID: <48703396-b7c7-8d8c-553e-22c42dfc07f5@gmail.com>
Date:   Tue, 15 Aug 2023 09:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230813211710.787645394@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 14:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

