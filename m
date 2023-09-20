Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482487A8E83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjITVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjITVei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:34:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013599E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:34:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79e27406225so5495739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695245672; x=1695850472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZcOhuXoe1gvgX0lflx3x1E53NWpGWz/sBp6zn2k6es=;
        b=EwbGL457jeLeOHtNqTClei4abQTVaab0CjPjKVxDyTBg6CNL0p1befabguavDJyx9r
         ABollCjSKzYuUtyWoLUKcvbSSJ/Zrjsalw6y6TvvkeGd0sAFjElBdZOOES72psdeLDA/
         ZIzmYjOxGlQzai/7nPZbig5vJ61v0lff1xZkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245672; x=1695850472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZcOhuXoe1gvgX0lflx3x1E53NWpGWz/sBp6zn2k6es=;
        b=jI8YyUq+ZjAUhe8Btlg541eeboxZB1eaw+iYxcTDZZwzLxPw7rlPejkCLmmDy3oKDL
         /GecaFkHPrDpLROmWHC1XEXL52wOcqNgAHfqipqF0CsWnbg4u8voBpxGjEfyyV485r9f
         Ro0C/yRwRYI9FZvSTaHmtmIiILzzw6Ng7x86rIyNdhVEm/DRHzHO9qUBh/X9pmvji2tz
         K493V8m7WyzcdzLZ2vryBfXl9uek5o7DoSHTVpmWdOwUJQAr53MDNdxLvjwn/gd+Tjh0
         BHsPrtYKbI8aRbH9Zcln5egtBipj7DvY1uubHa6EBslgaEjxxduRl7oc8aM0IHJQ3zPr
         zENw==
X-Gm-Message-State: AOJu0Yx5uOHiKZR+Tlr42G8L2cALJZE427vHf+PPoQe6TJ/A3SGfa8QM
        1j7sc5V7jPvFqyGSc3EaSOItPA==
X-Google-Smtp-Source: AGHT+IHZIwy+JQtTgVsOLxJ3jEekSdJ9SwDsE2HJCj2NjdFGCxnOF2RbXLzpAV0P4Tq3GpqHK/XQKQ==
X-Received: by 2002:a05:6602:3420:b0:794:cbb8:725e with SMTP id n32-20020a056602342000b00794cbb8725emr5260386ioz.2.1695245672330;
        Wed, 20 Sep 2023 14:34:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x2-20020a6bfe02000000b00777b94e8efasm20792ioh.18.2023.09.20.14.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:34:31 -0700 (PDT)
Message-ID: <86515fa8-bd68-df5f-3848-9d3b9264dfba@linuxfoundation.org>
Date:   Wed, 20 Sep 2023 15:34:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
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
References: <20230920112830.377666128@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 05:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.133-rc1.gz
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
