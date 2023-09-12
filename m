Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D091679D7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbjILRfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjILRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:35:15 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D710E9;
        Tue, 12 Sep 2023 10:35:11 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6516a8e2167so36249796d6.2;
        Tue, 12 Sep 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694540110; x=1695144910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yKgCvol1JzLTTChhP3VLdzRO6GqcPOymhq/VwIVtzK4=;
        b=QrPwq9dlK5INKStO6T+vTihnUo3d2Fu751rnMfjrAIug6K+JX1ONa3tYJn2I4tLp3o
         myK6lZApEYtD0xW+GIFUISn2/Ay3RXCjW+vlxxYNfI3ei3NNznnPN0nt2m6gNtStnkim
         PZRrszIhwrliSvHy19+e6ThIsnfpuGmc5BA/A+tmOZ+aAsoiP2SHgdO+rXdr+8Kte+Cd
         5QaQxSzdoJw6o2UG4jtrL0WXM/BPsCwwZIkZjSE5H5cfZoyjldo7EDV9+PMJr4Z1uBbr
         AXXI4Iw3eHOVrDgAwZL9RQsL+XHhJ6KQFOTCSI9iGYOawv0x/Ejl/RLjaBGxIwl8mWqi
         JwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694540110; x=1695144910;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKgCvol1JzLTTChhP3VLdzRO6GqcPOymhq/VwIVtzK4=;
        b=KW8a3syU2XnOc/d7p8EWe1MPdIghU0arWZnoZrLULTMD7qkdrBJTIAllvO4LBjWS7T
         0eSngG5/9xWyWvbBQT3/4tA4jVPDcviZGjp2jHiTBpJUEYfFqqtgB639gDZJpFNFCaWg
         wfpxuGQp9rsCuTA78YHU2fdJN01X2ev64oN/bGXtQvAuDZQjiSRSr0NN8UN2Y15K8S14
         3+5swhIxX754NRSfokgiSkwMHc6FkdctgJqJGIwhEiI7NAQN66/az8iCl00N3SrhhDJx
         Zh6vCB7afK2amkiWSXio4kKEV4DgLyLzJDhdAA7sRsgqBxDLTrGNF3r5dBiXquR7RvYb
         Qk+w==
X-Gm-Message-State: AOJu0YyQi7wjj/RAGDwssImpuN27e6oehVHBDPQToy8nqCzLO8Jq25i+
        enZ/goBbaWURMiDN0Sa/yPg=
X-Google-Smtp-Source: AGHT+IHV9F+Tf9UD8lr0rPhQb70NfocrHfzH/nQsnnu2dp0ULBv8jGmQbcgWbmKf3aK67d4nUtIuNw==
X-Received: by 2002:a0c:f892:0:b0:64f:5ad7:f57b with SMTP id u18-20020a0cf892000000b0064f5ad7f57bmr118055qvn.6.1694540110592;
        Tue, 12 Sep 2023 10:35:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e11-20020a0cb44b000000b0065359e0a3efsm3849935qvf.36.2023.09.12.10.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 10:35:09 -0700 (PDT)
Message-ID: <19f0d292-5377-3606-e83e-3a5c0fad5cc7@gmail.com>
Date:   Tue, 12 Sep 2023 10:35:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230911134633.619970489@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 6:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.53-rc1.gz
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

