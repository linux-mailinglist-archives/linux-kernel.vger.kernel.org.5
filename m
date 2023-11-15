Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD457ED822
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbjKOX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjKOX0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:26:09 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90F18B;
        Wed, 15 Nov 2023 15:26:06 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce2c5b2154so108271a34.3;
        Wed, 15 Nov 2023 15:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700090765; x=1700695565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axWDgASU5kx8BQUPImQQJLs6vIRAi23g3L1V87kq5xY=;
        b=LA9eqL1zdbDtuljahRvcLh6LV3iH4+rT6+rRp05Dfx+gDJSYhsAJ0BFshIFcrWBpSg
         dBI2LfdxkZnBsapMPbXRD6IhSNVSCboGIzaHBWq3bD0+aQRAg6c2EdqLbvcz+dci/0y8
         a20pNwiZkIHd9IeP1vzKrW+07C5TqsfWgVRsfjm5+XpwEc/eJeaiSbj5WJv1HdV3LvfS
         0BAK+Lyix3+l996ESevKbOKxbdCmyu2nMme1sT+09P9UxEQcTo0sbS/oUtcEloFztNM7
         hDciLjCiZsgyprmh6NH3t0R+qjGOiTsTxjj7ttCmntDc01cg3ps+vG9/gA8lwy9dGCXy
         6VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700090765; x=1700695565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axWDgASU5kx8BQUPImQQJLs6vIRAi23g3L1V87kq5xY=;
        b=ZyScYlJddyNmx7Aa0xdJ9VkrSNXuTXwENT7dUxai/oWVaxhvcQeur9KGSY7alnwHmb
         qoUeM4u4P27PrRAs38DiXjPCg6hEc8w3lLNlGbLVu6hPEBGu8e+HcwXtRM4XaxzpmyOY
         ChS22+U9gtqBOgKNp366DOEoSH3eaIvTP6KOaBh2v+IbEljg1FHP0fx3L7spnPZEXGFH
         ufgVmqiWuEbxLjRifvqFI2YDTj3QYDAxu55/8vR5faApbUarBCw9lOkXYZmffYxc6waN
         JKC1Ymab9oN6cqDQ1DdO/oHkKCFfsQLSFX3wMyLxNoq6wHmMDipr7IXQkJL7pVluS1pB
         KVVQ==
X-Gm-Message-State: AOJu0YxADD4PcyDMW/WAG70nBdP1pbaRnYT5pcjqip5jdFdFGVDMNKv5
        20BwS8NrcmC5y0ppl4V8Y0XbjIrHo8E=
X-Google-Smtp-Source: AGHT+IHCpHTQOm2E+/WA5JSn/AVuL9HHYRjwTZkx0CxsodNCQQRz3ZAcGcEGXuLeXtUXaaSuNKt/jQ==
X-Received: by 2002:a05:6871:53c6:b0:1ef:c082:ec98 with SMTP id hz6-20020a05687153c600b001efc082ec98mr18826139oac.59.1700090765265;
        Wed, 15 Nov 2023 15:26:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i126-20020a639d84000000b005897bfc2ed3sm1663081pgd.93.2023.11.15.15.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 15:26:04 -0800 (PST)
Message-ID: <5c9d34e3-ad31-410a-a46d-ac585a4d4e58@gmail.com>
Date:   Wed, 15 Nov 2023 15:26:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/379] 6.1.63-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115192645.143643130@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 11:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.63 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.63-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

