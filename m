Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB317A8D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjITUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjITUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:00:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A9102;
        Wed, 20 Sep 2023 13:00:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d2441b95so88102b3a.1;
        Wed, 20 Sep 2023 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695240001; x=1695844801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMAeJbPcmItdDgf4xgk+JNHaknHRQgjDFugqEkpXkAc=;
        b=ariurErKtC/AlRnt23VaPz4oEGVnqnHGE3dcZQ8Su7+sJcdLn80w2ShkeaCo21ojWF
         NqZjf6EpilO7Q8hGsThzzvr1mGMG1wlCILOW1APWjR6yo6hB3BuA7kB09u1SBBh3Y8Pl
         DGs/ZxLyF28aH8IEDFviCc4K1sWFFIkCt/Gy2f8JHxvaHxgTN7IKjsZ63wE3N7CCfvpC
         Q6IaK15UFsFmttEdR5qyWkHeWk3XGFBz7qsK0o01BcwevegnkwW8RfNVzvNUu7F3n2IG
         KYybej7PDjcgRtk7fUeQOZfFdUPLDVO5QR7yCeOMMUfdcItA3dpulXKaOQ/OIXHBd3yd
         D88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240001; x=1695844801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMAeJbPcmItdDgf4xgk+JNHaknHRQgjDFugqEkpXkAc=;
        b=HI8YyrokrAJtOMhZY243ADp9YJ1X7+mtFnStwls53voKMksDqR/im8eTLwc4oJjYLV
         92ahCqZYQI6U69gQY8syybgVfWiaiQeaPSKZ+CjbOtRYNOe3itsFgVsmho0m6hJ/Ymds
         zUdu3grQi2VKpKC8e+AZhgssltHsh09qXMYmxttIgxn+EsvaZMDH+RYp19idwwLuOQuS
         Ags3uUWLeZX/ZZ4chQsJqEXGczQYAMHpzW2n2kUx2nExbepo8elepZKEMbZBr5cnBBq2
         Yyjyid0ySmDb975HrQLmLgv+ffIJXqOgIymLUZiAE4OGdXs3AtbHGeYtBuDIqV+c88vI
         8ypg==
X-Gm-Message-State: AOJu0YwUbZmphUsgzEu0fody8XtOJ3JnFBz3AKtTFK9DIBCcXpxob+m7
        i/Oc4de0PJBoZNr2SXM8L34=
X-Google-Smtp-Source: AGHT+IGQvVEeSuvsRNTzKfh0H6AJmFAA5vkIfdi+bWjfJVdsi4gXOQ/xAkDweZEoNes91BOOHx3/hg==
X-Received: by 2002:a05:6a20:6a23:b0:159:c07d:66f0 with SMTP id p35-20020a056a206a2300b00159c07d66f0mr5162159pzk.6.1695240001285;
        Wed, 20 Sep 2023 13:00:01 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x18-20020aa79192000000b0063b898b3502sm10638330pfa.153.2023.09.20.12.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:00:00 -0700 (PDT)
Message-ID: <4ef9c827-f061-7b39-ea4d-6d57c16df9f9@gmail.com>
Date:   Wed, 20 Sep 2023 12:59:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230920112845.859868994@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

