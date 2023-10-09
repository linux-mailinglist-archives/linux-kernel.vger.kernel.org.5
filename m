Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4897BEE78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378929AbjJIWs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378870AbjJIWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:48:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF29C;
        Mon,  9 Oct 2023 15:48:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-577e62e2adfso2717461a12.2;
        Mon, 09 Oct 2023 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696891732; x=1697496532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7VKEDJKM9mK6XMWRrXy/cci19BVhFbaDyUV9SYedmY=;
        b=aN8KQRgIFusnyQInd2SI6eg3Z+xMyxyg4Z0p77objNntSy3WveMpRdi+WDDvZ4uAx6
         uA/I3teNsZCP2agEBy3/BwZ8ALxGxkEpiZ/M5DGmD2Y68wjGbn3j7Qn+OTLTqKRX9cvd
         NGHDRMhMdrWSiUNKZ8mXNgl1snOwXljiwdBkoWTAWnNL7UZzc1NIoYCeTIfcbQlUvRu3
         BA3j7CG7O1JIt8c5KrN3a3duSEESkf5naaSwCs2EcuTP2koz5Vfv3P6s8tqeU4TtEqrP
         uvmiJywpSQR1juHmPTHH/wqq6cdIdR56C2IV9rt/WMENgCCopnjLZiOMhg5bFPv5le/s
         3Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891732; x=1697496532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7VKEDJKM9mK6XMWRrXy/cci19BVhFbaDyUV9SYedmY=;
        b=qCvd/tiW7b6t/y6/63kiXSif8ZAWoA8LkHCTthS7Dfjvve2F0YjP3UD/dMSxTcjUFz
         r0GAWDTtJ2UG4ukEuS3GFl95WdR+Pa1YKtpP5mMUJAx15OBDvwNG8SDrjQbfP++/zdWy
         v1zJeOQxX1kSnt+F4r4vkcv+hMVK9QZIKY8uDy7VXqRTNG5Y0fvoPh7yrom+nazOhAeL
         Tsf06gnCyPrxmafkH1xgTI/W8NPyHLooDMIz2C1zH33uvXxS8xPxb3ZkXIDbm/I81SnE
         EqgBq5mTiJpKx4nJiC6wzlF7tBj+mBRKsEux1rIFGwPIXxQLgwCT8UqNF8qJAzhQBI1J
         veCg==
X-Gm-Message-State: AOJu0YxJU9orp1GXQ7PnnDG6fRWWMkhKyrAeaqaqdnZeB4iA+xHrMDS2
        zJSXXYwAV8Add7An4S2PB9z6ILo94cI=
X-Google-Smtp-Source: AGHT+IGKZ0PJdN2LNmFwDtzYbFcGrW8ZWUBGyRN5eRv/pSoWmyF5A7jrsXidpX18xJF3bjn1sF21qA==
X-Received: by 2002:a17:90b:3911:b0:268:5431:f2a7 with SMTP id ob17-20020a17090b391100b002685431f2a7mr14535964pjb.28.1696891732188;
        Mon, 09 Oct 2023 15:48:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dw4-20020a17090b094400b0027768cd88d7sm6985811pjb.1.2023.10.09.15.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:48:51 -0700 (PDT)
Message-ID: <75252507-62ba-4209-baa4-447517cb37d7@gmail.com>
Date:   Mon, 9 Oct 2023 15:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231009130111.200710898@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 06:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
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

