Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76817A8E90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjITVjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjITVi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:38:59 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05978A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:38:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79e27406225so5556239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245931; x=1695850731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QY8PVgVpIHAID+AJM7qZltvMhQbKxhG6t29eKHUi9O0=;
        b=Wb4lmqOsd6Y1VdqTr8MN1/PodcE6dfpZJschv+UhNCci2Npo1ncRHR+urZbUJ8OTVl
         QVynQnvWeJsBe8AkvZa8z75GFVns6Hn0B8BkVG6YjejO5azTCwS9QhtMQ135cOH9tWuc
         Qw+OykMgEbeeAZSbIHYINy6CZ4hPc4Xc3urg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245931; x=1695850731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QY8PVgVpIHAID+AJM7qZltvMhQbKxhG6t29eKHUi9O0=;
        b=Ff8Rx3bxGBynKyecAv9FCqDjOEWlR6IQnffkZtED59VdG3v3vKasm6ektlZ3rlSVRp
         5Zhhg/H5DowWNoOzNPGh1BIh6HIlMGfiddphiWds2/aueZCfydkpCbd06EJhx/sZLTGw
         amW2Ts8nFV9yd7j8ih/YB3NogXAfFKSnC0y3K5J3639TbNJDAPqbHlVzJRUhleVlZ0yh
         tXsYsWScCGCAH2QDlgxt0/83Vkjfbl3PwL3Ao6Ijjm6ANhLq+txK54NyK7AlyB4+V9lg
         6s2+JEmoHF0WVy/jgZoA07jiJ3kL/ThCKcc8Oe2xTxd06KLQZfl4MRw8vqe9r5/lFki9
         8cRA==
X-Gm-Message-State: AOJu0YznyvDDpY1Y/M/E7jTKW/bEzt9vQQbKhHpyPSoLvLIT1OHx/BHA
        NtpWZWjguyNRSxc2t8Rr7u4WaQ==
X-Google-Smtp-Source: AGHT+IGeHWyarZCNN2M1V8niROtMVtxRAlyZHQiX5ZEUHbSs7i9apmB2jBsqQqYB8J9AtOBuxissgA==
X-Received: by 2002:a05:6602:13c2:b0:79d:1c65:9bde with SMTP id o2-20020a05660213c200b0079d1c659bdemr5599120iov.1.1695245931384;
        Wed, 20 Sep 2023 14:38:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n2-20020a02a902000000b004290fd3a68dsm4262773jam.1.2023.09.20.14.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:38:50 -0700 (PDT)
Message-ID: <db56cb31-9615-c4a7-3740-17fa61e7bffd@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:38:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4.19 000/273] 4.19.295-rc1 review
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
References: <20230920112846.440597133@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
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

On 9/20/23 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.295 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.295-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

