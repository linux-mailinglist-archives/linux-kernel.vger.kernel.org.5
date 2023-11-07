Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C97E4B77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjKGWFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjKGWE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:04:57 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01353879;
        Tue,  7 Nov 2023 14:01:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41e3e77e675so41173391cf.1;
        Tue, 07 Nov 2023 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699394484; x=1699999284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CJun7UB52S4zZmzZk7Tc5+t2/EYY1acmDjuc/JVwgQ=;
        b=UMENwc5hcJtwPUmADRD81+YK5+JPqKU5/uV81TXA/tTYQdKnFDGRLhx5G7bKX7H5hL
         N+tY3ORbrSrZ8+F3CbYpuflKq40WaYg2to6P0R0l3cKV2w015DB660fGSB3LPGzmG2Fi
         FIRmoJXbD1y1Yumefu92lTvO4WyyWlM348csa+gaPpOTdlg92nYc3VHT2hwlcOF5roRx
         +mQ2HcdTTZib1ArcI8YVjf8UZpy3ItT+lBYLM/ZydPNPHHyuwk5V1z5uEiD/dowoFGcf
         Lgok+y1kI/0klyDX//FlthpUCQmF9vFd5KxSHVba2KRhJ8I/YEGry2QNMRaT/oaYP0ez
         ZipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699394484; x=1699999284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CJun7UB52S4zZmzZk7Tc5+t2/EYY1acmDjuc/JVwgQ=;
        b=vc/lYOekr9HFH6seya1RIA+ygDWXUPIFwfGuiU8xKCZWJM0vFbhEDWj8rSm0tlYVhZ
         ucVdZZ5L7GmwnSSFRwd9XwM8vxrnfyw8oKDm+7MyaU2n9EyMt3XzWCF99iZodynNyJ1J
         cqwl7d6xo2TRL2PFeSorEpiZxxdEBudO0IDlfdv8PnjnB9P+GSjfYkPw5s7xRMmSVxGF
         YLuln92U6x1z4aQmtGwjWGllieuGEbp/j/7vJuuhbY+afBBrHGSVWMRHLbYtBxtsJ7cF
         VZH1eSgESm+ftHBs8+wpRgmoFxzm4hsp1c1PX1nOQt//KO5BNnxW3geOFgcXuYf0t6Pr
         YDjg==
X-Gm-Message-State: AOJu0Yy8fx2e8ufmCxghvVAG20XzZ1aOFXgNV/Nuc8BVBJgMrrpIg6HJ
        Z/350nt5d3RcFj/PIolrBClTur1430Q=
X-Google-Smtp-Source: AGHT+IFTHyw9DU2WGhjY6FcF6KtbfcVzCzuY8S2stcJyiOKpBL+mrrHEXciP/HQOemZYy2hIv7k0IA==
X-Received: by 2002:a05:6214:e64:b0:672:118e:e368 with SMTP id jz4-20020a0562140e6400b00672118ee368mr49430qvb.24.1699394484288;
        Tue, 07 Nov 2023 14:01:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nd10-20020a056214420a00b0066d0ab215b5sm340940qvb.13.2023.11.07.14.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 14:01:23 -0800 (PST)
Message-ID: <847671d3-efef-465b-af9c-f9789f9cc1ef@gmail.com>
Date:   Tue, 7 Nov 2023 14:01:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/91] 5.10.200-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231107202447.670990820@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231107202447.670990820@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 12:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Nov 2023 20:24:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc2.gz
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

