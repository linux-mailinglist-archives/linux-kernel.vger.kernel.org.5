Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31B57CB1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjJPR5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjJPR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:57:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1249F;
        Mon, 16 Oct 2023 10:57:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so1939151a12.1;
        Mon, 16 Oct 2023 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697479051; x=1698083851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgrCPxN3s0kyDkIjbwluchqoifZkFgL3rzS9YM9DxHM=;
        b=dA6jKa0Mewi91zQ/gG0urOrakwoQ3Sx+w6gjXVdCOMntlqhctnIOyJP41O1xWk+HNL
         GFp0PLUzLDJnkqS5JUP3YrG2mvyP8yexQ1bJprIoT3xCxu7fo8pCt1gWIEOBbBcLeW9F
         fjpEYg/s/UkznkgInkF7UauhVRZ5CCLglyxXtXIh03wszAOvykKqJSUC9//sLTfbWp0I
         Yv2lcuzb5HTo2vwIL0tEfoH3hr3emtZreu13K/66MxF6JQtAW4BfiWnhdn22M3xZ1Vsh
         Zbq81hiXaUZiRMOpMyEus/adcYp6NxuFqtKfAryP3gr05pMg0RfJlsXUbTDxTb5vAmqL
         PdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697479051; x=1698083851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgrCPxN3s0kyDkIjbwluchqoifZkFgL3rzS9YM9DxHM=;
        b=nlOufVLTxkdyLKzRWW3zlLN+9NhgCuJr1J/YufPM0I22qtTdjIQJgw2X8kT91Mefmi
         rZlo+Zf83vkPwlid3i+Ho/Odj9xMeqiafsgt6KuFqt7aO1gcIrl2Bnoy5z2WrKCK2FQI
         K2CLO92Ye4Z1vRL/Ig6kzEM+jeGfn2onIKWZSxe5ZJzdcNz9rhk/wk/Sc+mQ24n7QDza
         gj5WdJIk+KsWoVBMWC4xSBvKa14WRs2D6Qg1juaqiwSd61+GCYm9XLjtOcU7L1CUgo0M
         wFo1+Q1p0KcUGjXedhCsiwfpzIxS/8lJbK/wcjHojiJRMb+1duuo5+gHodqyY5XCAw5N
         W4+g==
X-Gm-Message-State: AOJu0YyluTveOthitwRGnwQqFnYDPUmvJ3QK3adzvlADzio4EKODC5a+
        /UvLIHlARYRtSVN4F0ZeAA9eP9ZzGNc=
X-Google-Smtp-Source: AGHT+IEIApVRvIsoma2miRF/H9TQmZu/H+SrQyVpQ8eYe73uEL6Fmwky8fT0+x5txyMn5Jqgl7YgZg==
X-Received: by 2002:a05:6a20:6a0a:b0:15f:b5:bfee with SMTP id p10-20020a056a206a0a00b0015f00b5bfeemr37822612pzk.5.1697479050844;
        Mon, 16 Oct 2023 10:57:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ml7-20020a17090b360700b0026f90d7947csm4997555pjb.34.2023.10.16.10.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 10:57:30 -0700 (PDT)
Message-ID: <b42699a6-22ab-45d6-87c0-1574c54d29bf@gmail.com>
Date:   Mon, 16 Oct 2023 10:57:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
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

On 10/16/23 01:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
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

