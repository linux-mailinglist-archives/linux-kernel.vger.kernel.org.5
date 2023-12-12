Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D880F20F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjLLQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjLLQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:12:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB559DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:05 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso34962639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397585; x=1703002385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oyzEVdmAliGsUngMkAe6aQzEr895fuMODSqQrJ+wJs=;
        b=Fw+lP5ouz3iD0Wk9+iyQrlYs/g/a+SqRzeOo7MYF7YRLnybCkrRsG+ZoCfyorteqzQ
         2MBQ85fFyNK1/+Qlfmsq0oIvhv1f8M+XYOEZvdorZek9lINuR829QfznNXy6UTchPuIp
         mty//N/b9wFmu01rSCoVoxqeJlU54J5QI6Taw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397585; x=1703002385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oyzEVdmAliGsUngMkAe6aQzEr895fuMODSqQrJ+wJs=;
        b=JPVfzMOUlPvRDggE5WdiAqPZBGvlc2E9Vw0X99gsChy6l4+STP8lv6YTqV3xGZIovn
         Uoe8jNZOIuZ81IFZpirpeu+R1dpVm1uJbBOhs/rBKmLJpD6p8UOphnRcbu7LGFvE7+fC
         YjkMCjvBj/X5GjOW6b14vT6OlEiipgV2y3teLjg3PqtXiGY2y0ULALjqyGR6wlTP7233
         av5H7T/e7d4XLEH6XOym93N2v0jZu6gCs5jJ2vic7HjWQki+JElT1/qvUQmaaxnBSaDp
         yw/StJSVz5HKG1ItBiLBjpQI0Lwv2zLl3+rOjTXRhk0yLHVOuDgQ2PyVepb8VZRYjNuv
         LBVw==
X-Gm-Message-State: AOJu0Yw/suK2dCrWKjpqp/8cKkHaMUJ+vau7/E9ryF5LqeTpOr17gGm9
        bgl8oXWFSH3HfiKtPG0F3rlMZIP9QvYH6X8FpLU=
X-Google-Smtp-Source: AGHT+IFjRYP2mc0SFnikAhhPerZKmWl5K81RkC+VqPe7I6E24/T0KK8w6EA39VLWbZw9d5EE73Wiig==
X-Received: by 2002:a05:6602:257c:b0:7b4:2bdf:5a27 with SMTP id dj28-20020a056602257c00b007b42bdf5a27mr10661594iob.0.1702397585277;
        Tue, 12 Dec 2023 08:13:05 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:13:04 -0800 (PST)
Message-ID: <1d900249-4160-46b0-aa66-00ff2a7733b2@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 09:13:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/141] 5.15.143-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
