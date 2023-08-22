Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707C378437D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjHVOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjHVOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:09:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDDE4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:11 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-760dff4b701so38909039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692713282; x=1693318082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Sv9Fe+EBLlzCKA7Fw8Ctu6Jx8HbbPfz2ki4k9zi0Qs=;
        b=L8T134VPAe3dTLu2VnFTRHlVyS3WmjzSYqzPQN/4uxgai+nz6DYXWWlLULm5r2FfUs
         YtYF4w/Goun7y5u0cvNHNNDoxBvCs61W87Mj6wCAeMlKeT8I/2wOSjlhPHDiSd/vYfiZ
         t4JzAu8yP+gGP269gYUQWYNXdxd0aGCE39H6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713282; x=1693318082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sv9Fe+EBLlzCKA7Fw8Ctu6Jx8HbbPfz2ki4k9zi0Qs=;
        b=FxGYF8/4hxj09qWT+nKGp+qURMcSybBedsVaMUZzr+lZnL4e8HgG3rM7KSM0rKUKYi
         eM8R6P9BF3f+TsiAQFkOQvZLgvyRmZTcckVwnbafKL8yislRNX7RLM74rk5STRKs1hJJ
         imkfRVwCRXeqfSf+tJpXCielzRi9T7WNgRcR4bfIbj/M6P1BMNlNEnABRZ9ek0KyvQqk
         yCy8nx+kZgSLXZMX6R3/yDupn6s6EC72igGBqSDLdzt0vGrAa5hSx1fFgsJ9PrdH7eev
         JoIlvJi4SSTPKdo/4yZgY5MbHOdfJ120o1JxdenpXzQfsIZ8RXy09qmzHw5oBivhNmSa
         CToA==
X-Gm-Message-State: AOJu0YyUCAoKRGzgqipVqQWDwqJkxUFYCHbhjW7N5xgmpiLOV00x4aAs
        3HSyVzFhh/H09PAVWAYNENwA7tY9tiU2LGcKszk=
X-Google-Smtp-Source: AGHT+IE/sY5y70dT2P1jGFBFoB4PjfCtYg1oDiKqs+unQsjzJZhRsERUTViMa7ZaE1WhcfrSs0gQjQ==
X-Received: by 2002:a6b:4e17:0:b0:790:958e:a667 with SMTP id c23-20020a6b4e17000000b00790958ea667mr11207987iob.2.1692713282247;
        Tue, 22 Aug 2023 07:08:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dl28-20020a056638279c00b0042b320c13aasm3128441jab.89.2023.08.22.07.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 07:08:02 -0700 (PDT)
Message-ID: <fb189b65-ccc9-a322-ffd6-ab00a2b82887@linuxfoundation.org>
Date:   Tue, 22 Aug 2023 08:08:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
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
References: <20230821194122.695845670@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 13:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
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
