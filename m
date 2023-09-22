Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34987AB424
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjIVOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjIVOw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:52:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C82194;
        Fri, 22 Sep 2023 07:52:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c43b4b02c1so17718365ad.3;
        Fri, 22 Sep 2023 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695394372; x=1695999172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uFOz5B5cvfyphqLib4XjPgRuoCQemaGEyuj1nS/YTcY=;
        b=XyusmUfHx/7qJFb+Gs/345cx28Cx9fJQ8OEXwZssHKO+m4SkGf9XT3hlDOGtRNL+bh
         4aoFCGiNs18hm+xyxu8u0dl+F98h6y/CoyClV9Rng6AXKxPqky2gJRSz2ux1xYroHumc
         3yIVdF8E9pU/2Gre41mFqP+4t8vC2bPzrERQkoNw/v3HVPlYzYNk5S9tCro6gp27o8Zc
         504PH4jjvT2haixWi+G27rc9qgP6IM4+6UbexoNfVKjOIP6gjxUHU637dLTfDTNhoCCS
         9xbvnwPiUg7r5u5fTT6CkhLuguRrEOpCNqcQOVWDjv6M2h3GObyiClJ6NRMJULC+Y4vF
         7MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394372; x=1695999172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFOz5B5cvfyphqLib4XjPgRuoCQemaGEyuj1nS/YTcY=;
        b=cmQL2hNEXMKZx2GUX2CCEN7jEvlwfveDnK10I9bAe4gvtM04zGJI3TsZPAuQd3rMgN
         TZDJQimL3uzbUv+KHdIMxdxP08StoIKjP0FzpF3wnGaw6ZpzfpKJHYXwQ/7tcHnyyi6C
         ei4oCFE6qvR+YjtgEqYrqIzcJuBrQhouLBeLC498LIiDdrRXzK6MfKB1zKBrDh0sqyk9
         uIgwpD7uio9R9bllHm//bONBFkTocSiK2hhsHU8pK8ua9NiADHPFaKFlCNMmCe/Vq9Y3
         7hnOWqK0CIkApZ0VAH9r/50TyHoKw0b6cS0VXubo7DJuydie9vAOlK39rxMth7tJpaDV
         QOCQ==
X-Gm-Message-State: AOJu0Ywh8pBlB37jMIrIY4f1QUe7j6dEn+qiA0G/fJc5qqXHMRA55Epm
        iW7/JB03Pvz52dt0/Qh1JH0=
X-Google-Smtp-Source: AGHT+IEZN572fa6bFTfpRChjwE2UuVpBnja/f797TYM8J0DmFRetiu2CQF9UKBb4yh5diMB89nb/qg==
X-Received: by 2002:a17:902:e808:b0:1c4:3ea7:4328 with SMTP id u8-20020a170902e80800b001c43ea74328mr10800989plg.45.1695394372514;
        Fri, 22 Sep 2023 07:52:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001c0af36dd64sm3548071plf.162.2023.09.22.07.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 07:52:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <53c9f81e-55b9-b8bb-7821-cb124780d4c0@roeck-us.net>
Date:   Fri, 22 Sep 2023 07:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        robdclark@chromium.org
References: <20230920112835.549467415@linuxfoundation.org>
 <79a96d41-1b79-51b4-fda0-743b853213b9@nvidia.com>
 <7e0355bd-64cd-f6c2-b720-e4643579078c@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <7e0355bd-64cd-f6c2-b720-e4643579078c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 05:31, Jon Hunter wrote:
> 
> On 22/09/2023 10:45, Jon Hunter wrote:
>> Hi Greg,
>>
>> On 20/09/2023 12:28, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.55 release.
>>> There are 139 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
>>> or in the git tree and branch at:
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> I am seeing some suspend failures with this update ...
>>
>> Test results for stable-v6.1:
>>      11 builds:    11 pass, 0 fail
>>      28 boots:    28 pass, 0 fail
>>      130 tests:    124 pass, 6 fail
>>
>> Linux version:    6.1.55-rc1-gd5ace918366e
>> Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
>>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>>                  tegra20-ventana, tegra210-p2371-2180,
>>                  tegra210-p3450-0000, tegra30-cardhu-a04
>>
>> Test failures:    tegra124-jetson-tk1: pm-system-suspend.sh
>>                  tegra186-p2771-0000: pm-system-suspend.sh
>>                  tegra20-ventana: pm-system-suspend.sh
>>                  tegra30-cardhu-a04: pm-system-suspend.sh
>>
>> Bisect is underway.
> 
> 
> Bisect for this issue is also pointing to ...
> 
> Rob Clark <robdclark@chromium.org>
>       interconnect: Fix locking for runpm vs reclaim
> 
> Looks like all the Tegra issues are related to this.
> 

This isn't surprising because upstream commit 136191703038 ("interconnect: Teach
lockdep about icc_bw_lock order") silently fixes it without Fixes: tag. If you
look into that patch you'll see that the the missing call to mutex_unlock() is
added to icc_sync_state().

Guenter

