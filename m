Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483487C7615
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441975AbjJLSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441821AbjJLSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:43:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1731DB7;
        Thu, 12 Oct 2023 11:43:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-773ac11de71so83385385a.2;
        Thu, 12 Oct 2023 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697136195; x=1697740995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5vgE2fYXgKlfq4nH2TUkTSW1zkdBwLIEnXGe5BmWog=;
        b=kkvrf9WxpDnYZVM9X1Ai3kCVyW2LzDsJU/Pw2yYXgIFa5NIJdInlUKmKYCQU5R9KO+
         XJfeCGPYsbEiPn9+nH6HSas751dbK/5Ku+B17zgjTfvHjmN7jhCOFTHndVJw4EDarbh5
         fg7mC+BGYvK2DctwJdgWL7KPkhZWaoC9BkfATDk4G9AFDU+8gKhfvQQtDHlWN2c20kKW
         RIUbaBR4rhFEf6LVOb4huLpQrOOlys/MS4GcX6et5DxQCKOwc+cTR6wL0J3rYCc5sbMp
         ae9cB91DJMsNXSJ/7xKFbthtQiCazsgzHERGJCQbzti/v/dkAzufZcp8lYkyErZT1aAi
         FIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697136195; x=1697740995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5vgE2fYXgKlfq4nH2TUkTSW1zkdBwLIEnXGe5BmWog=;
        b=P5FatIre245pFiehYJaK+qXyubCVOKboSWyvy8I9ouu4udKbA16lunrZ8BwUf1/yUQ
         WHiEp3cn7/GWqoPGGhjYRvk++lYxOC7M2TU34RXdIdmvS8Kalcl7QNbZWXiLjSvVkm0W
         O/tBkvOdYMUNdlcfNEZkKQfa+NNZiDklo4dqKWJrXcxPFlnRtxETXCRmsdgQCV+fbXoK
         xidhjFYRLsIox4DR09VztJ9lO2WuOq811HqKbZcSV0rafETs7jma65yskgJSQhjox+Er
         AOJqP6NxTOaHmBMgmUVKKpUrLvrQD8wbBLGFEyDIGZySApy60RKpGN2BX6K3ZMqhOqWY
         A12g==
X-Gm-Message-State: AOJu0YwQj7PZABKl6x9G0Cnpv3PpO722rQdM+ZO8n8uB9YpaoYIukLFq
        r615b87TnDfLqXIYJZz2qAo=
X-Google-Smtp-Source: AGHT+IGNXM1JbRwqsGrTfGInKbc4JVqtJUbsW3aoOcuBfbXiDeKITiAf0Ac6PH0/oHGa+6LYWwyvLQ==
X-Received: by 2002:a05:620a:4106:b0:76f:1614:576b with SMTP id j6-20020a05620a410600b0076f1614576bmr29725754qko.1.1697136195052;
        Thu, 12 Oct 2023 11:43:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pa25-20020a05620a831900b00772662b7804sm6205838qkn.100.2023.10.12.11.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 11:43:14 -0700 (PDT)
Message-ID: <1638385d-a5b3-40ab-ae0c-25b53d761336@gmail.com>
Date:   Thu, 12 Oct 2023 11:43:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231012180030.112560642@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.58-rc1.gz
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

