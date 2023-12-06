Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0998064D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbjLFBnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376597AbjLFBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:43:00 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E61B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:42:59 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d626e4f79so3937195ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826979; x=1702431779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm1V9f+oUMjohhZksyZB+sIfcQOdDZTpiTzY7f5JIGA=;
        b=Pjq2Lmv5vuWTYrj8aXeeuf3rOSnSNhDs5weYgIzYmdDuUy00i5tshq9l/rFQaENxcG
         vnMn2JeTYS2JcFbxjZl/rC34NWVDVbfZ5xh9lbVC2PJ/Q4Rt0rS4l9P0eOaWaz7uBBWb
         rIK+19093400XNFyI+uRfB7yi5HyBogmMVIws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826979; x=1702431779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm1V9f+oUMjohhZksyZB+sIfcQOdDZTpiTzY7f5JIGA=;
        b=iVnI83q7zYMVtCTchM5xbaAEGPU01JbiWHL0Aa9ARfIXX/zKKPFGjHtAAiuqccoIvS
         qeb3EcHBk+dC7k8/eZeuzXDZRBk1pLF/Q+p57XagOADcpwRFv+Tk62DgEbBBBqbb8S82
         BbdOUItW0e0nVY86v8UL9YgHGV3c1TrbqFSo0sklpeW0qcz8WK1qKxZW/B2SD53M+TCQ
         5vQdq5vxphumeXvA1l425KD/LHsWAnwLIe/k1q43a5wmEAdS93wmHFFYP01U72XoonXs
         FymHtP0OGQxYNpqHENpOOQ5eXC9SPT9siTQC1grkwGwrYexWe0hHseYMXP1D5tvWKBxd
         OXXg==
X-Gm-Message-State: AOJu0Yxeb7SGlbbASPnoaIDu67V1RL+e+M/amO5jYR2UoD4Mg1wyEUFA
        23RohGSqf4teexvqKs4F+FhKoA==
X-Google-Smtp-Source: AGHT+IEZV9QsCtUCG41Rwf5DS0/ayUasKhUxGXYpxOJu29ansePzFwZheB2UEsbVjklK6ZmE7lxGcQ==
X-Received: by 2002:a5e:c30a:0:b0:7b3:58c4:b894 with SMTP id a10-20020a5ec30a000000b007b358c4b894mr583643iok.1.1701826978793;
        Tue, 05 Dec 2023 17:42:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id o2-20020a02cc22000000b004665ad49d39sm3423615jap.74.2023.12.05.17.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:42:58 -0800 (PST)
Message-ID: <321a5f0b-e7c3-4d23-9fe8-b4fde383a171@linuxfoundation.org>
Date:   Tue, 5 Dec 2023 18:42:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 20:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
