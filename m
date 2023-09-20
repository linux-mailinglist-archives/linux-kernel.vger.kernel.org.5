Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE3D7A8E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjITVhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjITVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:37:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091209E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:37:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-797ea09af91so4525839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245852; x=1695850652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTMZOz7zfHEZnxo271y0b24B0nwEkFYYZgLSU5ara0Y=;
        b=Z+Szb6LP0i2gtMuiE1Z4/+Tros+n5A2uR4l7kapcRkD97JS+NudCenqj20qhzeM7fC
         m+CvYJoH/4b0vKfPT6fZN40T5kmqlMVdUlddRh8gxn3K5i6C9xIl1dCVd7rCTUkOEX60
         gQBp9n/kaWrpFYBsjAWo/a86rpH1wrT4dpXck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245852; x=1695850652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTMZOz7zfHEZnxo271y0b24B0nwEkFYYZgLSU5ara0Y=;
        b=si5ngq3QuSEs1ooQT1ddX96QGPNvGbWZXzH39XZl828PG2xx2ebqE4aC2AVMXVQFVO
         6tlBQMAoBtCVr80lOEbDdXWkp5jzCfS+T2T7pXOppql3uGvjQE1e/hqyRV2YemGpEhBK
         jM+dbwMM/lx2luxs5z/uHiqNdUeSl+IlTpO+WYrf4jDtjhGS2z3N0acqxA2oMnrZ06D6
         MWloybsrFQVJgpeK0ERK//BYKyrWmlKmhFrPJEP5SyH93S5qg2CJKTBJucNvujSIr697
         Wg2XJ3iRrjGkYFixecEMA/OqOLAF3bZiB74NfTAyqEFWfsKcaloolpGV4Gvli/8bDdbO
         04FA==
X-Gm-Message-State: AOJu0YyDwz35/GDQH7G+TvkGmEKjQoALrrj3alIOd6Cxo4q61z9UBGz4
        di1DhkWE9X39CZqJFRGamz/qAA==
X-Google-Smtp-Source: AGHT+IG+gK+YYQCk4IAiV2PPKsJx5uyC6ZxdPHbNqGW18/9b8GKsVSaBcs6rXtre0KtZ7uGd7+FmAg==
X-Received: by 2002:a05:6602:121a:b0:795:172f:977a with SMTP id y26-20020a056602121a00b00795172f977amr4007024iot.1.1695245852407;
        Wed, 20 Sep 2023 14:37:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f5-20020a02b785000000b0042b2f0b77aasm4203305jam.95.2023.09.20.14.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:37:32 -0700 (PDT)
Message-ID: <96958c2b-bc0d-72b5-fcee-51d86bb5f7de@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:37:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
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
References: <20230920112858.471730572@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 05:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
