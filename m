Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C880F21C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjLLQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjLLQOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:14:01 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396CB12E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:14:06 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b720eb0ba3so34151639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702397646; x=1703002446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bmlfvvZM9RQjnrj4u41EYEYF+Fr4h87K1fw5d/6M30=;
        b=NwE3Nbyh84NfEYDx4tKDsCVuJC27TBov7Bg4QMNgFGtgkB0WSNVTWuKXue/AbEysGh
         8Ruro0Fw6guB8dwRKld9FScg+BEXl2lpmg11YG7/6UyGYSjbSYYW/HGZTH+CpHF3hpB5
         +NZwJBaDpsLGTHcMVctyzmbePTlqJxlZ/Hp/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397646; x=1703002446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bmlfvvZM9RQjnrj4u41EYEYF+Fr4h87K1fw5d/6M30=;
        b=dAUI1e4tGjQ7OQmaOpK7y2eX9LLJgdx0eb7M1mWl4jUJz4tLDh+S3iY6YVdy7TsXF9
         B6fGJW/nNqxtc/jbb/HSOLJLO2UIFWBv8qfeEsOT8s6VHBPpCio2qSpV+wdb9QMp48bM
         0bFb+tVxKTTZy8mkaLnL5ZUYvQyooYW9OpdYt+yNUc0fGxyij0SGlXtyjdPHcv00Cfuz
         XHi55cOLKUOtIEQlA9KQtxBmVaZWhCjiDkXOlI+48qfCzSkFAbmbAqbXmADKtZRRJ8Y4
         0eZjX5pJbN+94aAeTZCJS4WWoHP/h7Jg8fErs6YS1suuGYUMZ1My71qVbOqLj5y6tXae
         ZgtQ==
X-Gm-Message-State: AOJu0Yz//kGklQeHxjATBaoQ41Zx16r9WYO593IrJHZP7+wnOAf2Xn+/
        6VknjIBJN41YQclty/O1PDYM8QFz1x2x0tQKeJE=
X-Google-Smtp-Source: AGHT+IHaG0x3XF1wweqZpO03xiSwEpRTZvLSUofRfC9gC3CFjErlqRHWOrCssJBqgyeHMnjz9O0VLg==
X-Received: by 2002:a05:6602:254e:b0:7b7:3ba4:8949 with SMTP id cg14-20020a056602254e00b007b73ba48949mr7121414iob.2.1702397646086;
        Tue, 12 Dec 2023 08:14:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007a6816de789sm3012606iob.48.2023.12.12.08.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:14:05 -0800 (PST)
Message-ID: <734382b8-9858-4c56-8c66-25d140807dc7@linuxfoundation.org>
Date:   Tue, 12 Dec 2023 09:14:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/55] 4.19.302-rc1 review
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
References: <20231211182012.263036284@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.302 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.302-rc1.gz
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
