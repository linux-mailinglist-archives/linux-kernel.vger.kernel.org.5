Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0477C4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjHOBEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjHOBDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:03:42 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD10E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:03:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso58229139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 18:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692061421; x=1692666221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zf24qn986+3HODYb4D7dbEQc+CnKSZ5LVW4DefTNb54=;
        b=dswvIqwEJ+uQndBIdiZJZx44dP90/nfHjw9vK5bNSC9lVx/tSjJQSrzGV5gDYSlzlK
         mgTL6y0rjWziN8oiKbhFfq8Tx/EGmeUHJ/zgkpH6LmH8sqgs2DjPQjYWkO6AbfQLywfc
         XiS0/lDyOZ4jFkwceBgPSiqXIJb37lWnfT2ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692061421; x=1692666221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf24qn986+3HODYb4D7dbEQc+CnKSZ5LVW4DefTNb54=;
        b=FPx4n6FxbEKJzRopHHkC+TiWL1eEb/sI+sbeGNgPo4H4CNJUQsqalxB9zPPiqGCoEz
         GsBJ23z7FL7riTEtjZQgIXGVtvlug6s/ThwUxi8Anvt5WaWIyKSgJKo3lHcbXEuY8HHl
         boVyTwurvWMsRlak/Re9344Nxqj9xA1fwBz0uMLYMRlerGsc8EDdicWtR22+n1Hw+ruW
         j6UFsVPYQHBH3n+6hGZ68YpRNRYzZLfWcLrQ2qD9mCznNTWepS48L21OmXZwmJ+2Kh7u
         NlSwMs8/ncfypp5/U8iOJmIJ3Z3XgmdHsez16P3tkkk5fv79Ct+pTBEHUuKgroeoHJ35
         59+g==
X-Gm-Message-State: AOJu0YxcevoVedU1vKKlzi1WALz8mzvSRZWblRF+KNWoUT4C6BRiyyM9
        6TcBhyOJ94YL5TEemyZdFJR9pA==
X-Google-Smtp-Source: AGHT+IFlStz432lwAjsuSr/+troe7G5Li7J95LcHwvH6pVQdhQSvB40tJvf/Q8ymE0iPVul6ltWuqA==
X-Received: by 2002:a05:6e02:105:b0:349:385e:287e with SMTP id t5-20020a056e02010500b00349385e287emr12041151ilm.1.1692061420997;
        Mon, 14 Aug 2023 18:03:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b6-20020a92c846000000b00348c7617795sm3563764ilq.49.2023.08.14.18.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 18:03:40 -0700 (PDT)
Message-ID: <f4848ba1-39ac-5d1e-307f-1fba3ee3786d@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 19:03:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 00/33] 4.19.292-rc1 review
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
References: <20230813211703.915807095@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 15:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.292 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.292-rc1.gz
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

