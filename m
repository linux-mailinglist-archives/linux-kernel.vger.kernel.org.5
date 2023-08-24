Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD02787880
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbjHXT1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbjHXT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:27:38 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D347172D;
        Thu, 24 Aug 2023 12:27:36 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-64bb576b8abso1068776d6.2;
        Thu, 24 Aug 2023 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692905255; x=1693510055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2YOn3bP9wwC0wDxAit0hTPbuVLPN9/Loqqsh/N4BSw=;
        b=R/TbRsvuPAI2gC0fsHPTf2Vjz+HKcyF7tuNc5VynpFgnMj9B5sCEYXhYxI2doIYH7c
         I5ZsuZPBMmObsd90zKd6rUlBns2f/7+JXRfR1/7L6hflggRb7xa8B673R4VDRDc2lHZ0
         o7XOmYwayAkL7o9tAbYxLdg2xzmcbqEqv1G2tDEAJpiCHIVxrQiURn7G/c2qW+vlae4s
         phvO+EcY0uJZm/X++DvFSBH/EB/jKQkQVcSYsLWTOFULeuaUv2N9nL9u3Frun9WLxmwO
         33WsSFaSg/nY4e0AhrglYhDRdw8Eh/zbhLdJnhvbpmIDdx3NM6hWmD1MJx5xyQK94MrC
         UPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692905255; x=1693510055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2YOn3bP9wwC0wDxAit0hTPbuVLPN9/Loqqsh/N4BSw=;
        b=JRVmp5kPJSLC4FRwp1XkftPZAE8QZPsobMXnU2qCMsECgWU1PMNT/Gxa9mFooESVt/
         WaHevxuDnckFRZWayf4nqfFTM1aHv+F/N+sogVdppA9K4cy55oMEGwoEqxdMkSHrGayP
         qDWLV9nOJXsDN92RfgSWi2W+Yn4j7HGWlaoxsiNIADdKpvBi5VX6by6plYJTadESmi9z
         NeFhQ/rj6PAKRv8Z63KwsNrMxn8Bi0BIgwW3hls7YsAp64bH0uJSIllamIxVicbwtsjh
         YyKwRjo5XHk5gVpcqL/C2AGvPOOAAEQtVG6CXdHFiJxFocWXDT+kD3gmWfBuBuVR7uSJ
         bGKQ==
X-Gm-Message-State: AOJu0YzeY++/DcbVOE70i7hU/rH9rBsZAhtI11QrZSMxECOVtGjLqDVP
        gDvESEGLKBor9wKs4ZwscVaHGwweA1E=
X-Google-Smtp-Source: AGHT+IE5w5WwObOT/qIdaqj/Bn3OwAgEl9gNcUs7jwqV/RXTCLkmWBHKHWZzScA78m1EG2QE8xFw+A==
X-Received: by 2002:a0c:c543:0:b0:649:7da6:3c66 with SMTP id y3-20020a0cc543000000b006497da63c66mr15118708qvi.44.1692905255223;
        Thu, 24 Aug 2023 12:27:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p12-20020a0ccb8c000000b0064f4e0b2089sm18228qvk.33.2023.08.24.12.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 12:27:34 -0700 (PDT)
Message-ID: <61314350-629a-f870-e203-270d66b13a54@gmail.com>
Date:   Thu, 24 Aug 2023 12:27:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230824145023.559380953@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 07:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.128-rc1.gz
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

