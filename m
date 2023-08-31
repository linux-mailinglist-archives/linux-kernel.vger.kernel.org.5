Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745E78F466
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbjHaVOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjHaVOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:14:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF13EEA;
        Thu, 31 Aug 2023 14:14:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565e387000fso952248a12.2;
        Thu, 31 Aug 2023 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693516474; x=1694121274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHU8xwcvtMw2qUMUWHLTxEFcvEw+f7GCxVOaIZEcxpc=;
        b=ffL9WJK+esng4Y38x8xMcTyxmruh0Q/t5Je6olIHo2/v2YYMGEJmEEmWTc9KRKfto6
         s7JyZXkdBu/Q+s7a8c8y4xqGNs1nmIavjXtlojZqrjOggkYcVbm+8lOyzoM0Tzr1xlt6
         Qwv/8f1IxgXL+6vCX3L4q6VJiyV4PWXIzcdWZFKZYN4YtrWbj4icB5qhaHSCkVcw/km3
         7Cb6CXFKyk6cJsLqXf6ymWIRVmyleJlGEBRSfFOogq1NLt3401MfRyE4bQ8jER4iQcC3
         IGfo60USEC7v1CyMcIudZ43LM4s6E5zymLbH09/E4foHuuuIsIebIfEyxAbaR+tPM0Fv
         Hz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516474; x=1694121274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHU8xwcvtMw2qUMUWHLTxEFcvEw+f7GCxVOaIZEcxpc=;
        b=K9De5iEZrkoV3+Gp/GVfaQF8B95ugqyRRNWC4OTN7fr/PXnteVqZ/To2hfP5YBkarZ
         8E0IYWh+hl8qLjROhafAFqwCOC9UHl+tRcekqvoVfch0g8Ju/WDh58zY1reQet3kC2i6
         6ekO1ZzPy+xysnc0kh+q+ppI6Y1bOw488VmPuUwZSMAjuf3bptt0C6hdPuBtOk3t/CJh
         xkFmhagy0RlI3CjrK8WzO8sL+YjEKzF1jR/5IoNwSqLqXCM8QcStU860RKx0JBxK+j8X
         cZOIGtex7AEhASUOwXfzgoIQDQV3+9hzduKb91//IP2I+ct3qE38emO3j7bYkuJMXZpu
         eNiQ==
X-Gm-Message-State: AOJu0YxkF6rdAFQwaYuzt+GHWGL5vWkFRa2+s+0zbBIPb81ackObpLIQ
        MRtT17fFqtDV/H7YsUZjV3oxWoz/4BU=
X-Google-Smtp-Source: AGHT+IFJzw1SZ9NLsahcn5LV5oH2BZXdKOn/jr7kyrsmboOOVdZkH5Hpln6QNIw8xI7bIc4YF/NiyQ==
X-Received: by 2002:a17:90b:212:b0:271:ae19:c608 with SMTP id fy18-20020a17090b021200b00271ae19c608mr520253pjb.41.1693516473861;
        Thu, 31 Aug 2023 14:14:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gm15-20020a17090b100f00b002681bda127esm1734726pjb.35.2023.08.31.14.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 14:14:33 -0700 (PDT)
Message-ID: <bdeadf18-13f3-2946-731c-cfdfcb871173@gmail.com>
Date:   Thu, 31 Aug 2023 14:14:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230831110831.079963475@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 04:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.51-rc1.gz
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

