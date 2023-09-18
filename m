Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9767A55C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjIRW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIRW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:27:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25647B8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:27:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77dcff76e35so64054939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695076033; x=1695680833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rqIWrOLYqD06it1VsQqnd3u9qXxj+oJZ3vgSdaTqjM=;
        b=Z+7if4xDN3LbFs1ffI94vmbQcddHx/c3lz2ERSvTqnL7N2FCJ1RRX1dYkOu9nUwzvH
         o4lsrt+91ec2Sl2TaBAh43HsjFIqQyROxT1w0EBzWdT5R00cwD+gQrxXAffmmaNUFrU5
         cPY38kV4WNyK+FAzbnFZArNeEHE/K6xpapSZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695076033; x=1695680833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rqIWrOLYqD06it1VsQqnd3u9qXxj+oJZ3vgSdaTqjM=;
        b=apwXRg4RW2pdgMevptRwDLBSbP7czQPyLoecKPaqVXc55lLkuSOTaOFz0PsPNEtPeE
         T1+wItItkTXxpM1vGoy6yAOK1fB8ieX6wlnijuPGtIeHM3jdn9PSBBWAF94DlEY8QJxW
         ThgwwJXiWDVrkSmFE40QbwG1hzMBrDyLFwBZQLJUmpMcg3jjf8ChBh4RzeG9BTV16V6f
         TdsAvPFUpTZoRX6vYFygB9M3HTsPOIrvzc+YLFnS7Sjpoz/5NR0VWNivq3poj2KtOUZH
         N09E0R9r1eej2o0tunWv4hmyDz/TDWxc1xjj0qGBx2yAcCu1AvrpBHXST7Dm15+e+ijV
         WXEA==
X-Gm-Message-State: AOJu0YyGW845hj2mi2LFPAsVCMd/8ZRrKTRJUdq5Xm2Ga8dSOjApIKld
        Ny12+jD/HN93I6bORfazX/Xang==
X-Google-Smtp-Source: AGHT+IHDpo6xjPia1Y9rnAdAv6S0PeTNKEuHYXTuoeaPDZGV2nE4B6rRETLt6m8zSLY+XF35iwe/gw==
X-Received: by 2002:a6b:3bce:0:b0:790:958e:a667 with SMTP id i197-20020a6b3bce000000b00790958ea667mr11843320ioa.2.1695076033510;
        Mon, 18 Sep 2023 15:27:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h6-20020a02c726000000b0042b3a328ee0sm3089190jao.166.2023.09.18.15.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:27:13 -0700 (PDT)
Message-ID: <0b0a02b9-3693-bec6-d200-ec1ccb7b9ccb@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 16:27:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
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
References: <20230917191101.035638219@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 13:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
