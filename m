Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27976231D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGYUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjGYUQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:16:11 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3B19AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:16:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e9e14a558f8ab-346434c7793so6280975ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690316170; x=1690920970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PX7aW/22nYeI+mcs9H1DmcYS/0v8J0ILXVwKH0siU+U=;
        b=L6gBSwdNn4oeVWaIoXQeu3c8VyWxxI4RiYrg2vTatqt5GC5y5sd8H4Lyif0Z33tHQX
         x/pEzjAjiWmXykKukxfq/xNGfgFpvzv+E7s6C1Xa/F6CFUPvRquP6vXBTP+UEFRBfy7h
         1L8g21aozgirlY8rCz3wAef+bA6BwA2QWe3pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316170; x=1690920970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX7aW/22nYeI+mcs9H1DmcYS/0v8J0ILXVwKH0siU+U=;
        b=FZob/DO3hcFLKCG2D+G3cmVhMZiX5oWw+vGguYnl2B3JwpzFSRKMiys6Hmmp7lXHmM
         pJcOcl8s8kWa50j9glsTJzRFQVoE5f4Pc6fE/6O9+uKlqb5WYmDZLv34rT81RSxHgVZj
         dbLWf1TiPE/Hw/Smm5eA1aOpUA9iY+bDVah9XS0zWsy9xq7Sz7Z2WmybA3rJhLeAe1o+
         Sm6CGvlZfNElqomqw4eMi8ZcSUIyNN1fO3oOUFQwyAK6HJC+SjK9Pb4x9ik6B8YuVl47
         mQg9A3KynW7QIoZ82Z86xKkP7SoKt2qp/fM8GjPWT5lJLA5xqUbcTnUsdB+BNwUUrhOq
         0oSg==
X-Gm-Message-State: ABy/qLage/7P3jhs+pk37t57VR+nObX29tBW6u2y3qhsDZ3fzeG9gIRb
        s15QXDwOJWsJOYSr9Zln/vsWtQ==
X-Google-Smtp-Source: APBJJlEyfP4cesFT+wDNOCkHxDbidCbC3N2Xq83CBMkmTCGetKomjdP5lW1CYu4pagrsuDnlTMHVaQ==
X-Received: by 2002:a05:6e02:4c7:b0:346:3173:2374 with SMTP id f7-20020a056e0204c700b0034631732374mr114617ils.0.1690316170135;
        Tue, 25 Jul 2023 13:16:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n18-20020a92d9d2000000b00345950d7e94sm3924630ilq.20.2023.07.25.13.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:16:09 -0700 (PDT)
Message-ID: <c7578f9a-62e6-dbfa-7b3c-b33d9c5368a9@linuxfoundation.org>
Date:   Tue, 25 Jul 2023 14:16:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
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
References: <20230725104507.756981058@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 04:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.42-rc1.gz
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
