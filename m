Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B28788E49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjHYSNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjHYSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:13:23 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A82717
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:12:44 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34cad4e6a34so1477565ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692987156; x=1693591956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7fASciw8k4HY5gXvLmNNZpvPMF/wBHDgCKHYnbqgSM=;
        b=dK7KblEm0EswR6B8cyEjjhuWM7XS5qtPbE8Bgf7VcqBX3yZ220qH2zXenViyhB/z2V
         cDxsqXZbJuNty3TjV3VlHU1dPU2xshi6sXMQ3YdiLEUZDuuHLPI27Xt13w8tyEBcylm/
         sCCiEk4ftwmOsGJVDSy2AxrS67UXgDB0TIzaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987156; x=1693591956;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7fASciw8k4HY5gXvLmNNZpvPMF/wBHDgCKHYnbqgSM=;
        b=NQHq6nElMCNKT0jLORwB+tRv7Y/3j4af4ba527hn1zogRJbJFbZCEYaO+YYI83EgJB
         ews+bmZyj/CYuoQFzZ2D2DeBuI1Ts/nqzbe0Lzi9ba917mAc1bkyvoKFUDcqepzSgpYj
         6jFUTw4LkPpEyXEC7h6ZlRJ9aFZLsyQ33klPa7J4oAWsWUyvH4R77EYeAq80OMExNipU
         LWl5waWl5tewEju/6YVJpBgGUg5fSWijDG8hwZ5v0hvBC+kkt7sgTEDZaaKmqQtunkVp
         TdqR2rSW2C2493DS0OBGHYgIPF4A3hoQhrAOjJwk7jtbDLi6wdzlZKc31JbnsxjdWW3t
         z5WA==
X-Gm-Message-State: AOJu0Yxzm377AX0ghic+zl6IY89z7Iq22tqSzNT7BdLfPmIy7NwcH5DQ
        LcWY3m6Le9eE9cadzc8Jn/FUiA==
X-Google-Smtp-Source: AGHT+IGClfzFcJ7TBPEQJdIsOSwJoe5p987iA5e84iRE5OkoNUjcWnuB8Xp2vTjF0Tgmd9qMMc9Gng==
X-Received: by 2002:a92:c00f:0:b0:349:67b0:6045 with SMTP id q15-20020a92c00f000000b0034967b06045mr19074524ild.3.1692987155806;
        Fri, 25 Aug 2023 11:12:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w9-20020a92d2c9000000b0034886587bdcsm683452ilg.18.2023.08.25.11.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 11:12:35 -0700 (PDT)
Message-ID: <631bbec0-ce5e-9bff-d645-fa24b04e9ff3@linuxfoundation.org>
Date:   Fri, 25 Aug 2023 12:12:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
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
References: <20230824141447.155846739@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 08:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
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

