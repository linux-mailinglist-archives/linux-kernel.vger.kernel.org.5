Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2E7B995D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbjJEA7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjJEA7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:59:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250BAD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:59:20 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so7687939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696467560; x=1697072360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fixv2Hf1UsG/w6NMbxeKghikSwWK34zVD+OdqdFjjpo=;
        b=ShaEsw+iWczqJTvq/P8R16EaWYCYZJ+wljTycQ4U0iXQeLCPFv5rIVl8Bv9+WrLA1/
         mhFSVf2Zugd0xkHmAwEfsiaaL1R8QqTvYyerpzBvwO8kX4v89NXEZBcrgzU8Y4cyIYr0
         Q3KoZ7hV7qIR0y53XbblLGOsiEA++QW/GAyPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696467560; x=1697072360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fixv2Hf1UsG/w6NMbxeKghikSwWK34zVD+OdqdFjjpo=;
        b=PJalbjUgDx8aweyhm4j71E2Fle6T2VQyTcRelSR5tyAdyDER+fFYPXESsXlUSAMv81
         73ILbVF7/o5JlgB/gxRWG7HHAC/YjszniC6mCeQDo50Lc66vv+y4UHih4Ixp/wpDUJCS
         MfROIaR2Upn/tCnQRA65g3l8Glze8N+eQE409lMW6o++IlZkFa5vQTFykylwfAdrCpYr
         k/Wit2P8TTx432q3E9U2fpdtiVjHpcP3+pK8kBxocGNCF3E0Fyoqlx8px6lyKIa2tU5L
         9Hx/JB49m6hVzCkSTg+v5rRLx161xZDBcVcUDNFTuXgwja8pzIMjC/evzyHjKu/hf6w3
         8igQ==
X-Gm-Message-State: AOJu0YymSCrzvTbA0XwuLsaOAarSdNY/qA3mUQRO65ljMpgQKdQHFB5f
        61NlW8sr77FTP1SjjpmQtISq0g==
X-Google-Smtp-Source: AGHT+IHF38mxXPuGgNrncsbu0//1ttTQuV8kZCZOiNVzflvIZHlwoBno7oJnsMGeh3v09VdW7c4NCQ==
X-Received: by 2002:a92:d1d0:0:b0:351:54db:c1bc with SMTP id u16-20020a92d1d0000000b0035154dbc1bcmr3791663ilg.0.1696467560212;
        Wed, 04 Oct 2023 17:59:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l17-20020a922811000000b003513b7613f3sm104924ilf.3.2023.10.04.17.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 17:59:18 -0700 (PDT)
Message-ID: <6137d647-f1f8-45e6-b2a6-2258cc90e75a@linuxfoundation.org>
Date:   Wed, 4 Oct 2023 18:59:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
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
References: <20231004175217.404851126@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 11:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
