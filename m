Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C577D014
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbjHOQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjHOQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:25:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E16DD1;
        Tue, 15 Aug 2023 09:25:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5654051b27fso4265445a12.0;
        Tue, 15 Aug 2023 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692116736; x=1692721536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=li9W0TPphaLFM4THwDEEy6SPFHkTHwvo/HLHwG/PjCg=;
        b=rObTB0IZ4E1BH0rxcZYxyz6CHfP87BIXOY6IuFUicK4m7Cwt+LeNjwPCqfDtr6TJW1
         uWVj8HBtUyJZUpHxo91ycqbUbKMx4FHnEWobCwbu2xghBK8Mw87B5mX4MbFNXZPuX6aO
         hd8+H4FZjlldBsQ/FaeBwQBwcTfFxT6OxV+fF9IVpcwHVWGZxvSvcxb36ed7M4DjrgTy
         8N6qekmuJ/0Yfj5D0FiWHnz+omDO2eaRBuvF4b0mq9xagk4JMouTwjfiBC5K1JtCkUjw
         bKL5zwsh0ool6jdim1tpmv54JwgWcSjWORGyhZssJ17G7ie6N7BZSA0+dfxKkRPZuf0J
         H5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692116736; x=1692721536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li9W0TPphaLFM4THwDEEy6SPFHkTHwvo/HLHwG/PjCg=;
        b=EOZp5ZUO9ZCmJRFNvgcmWYzXi2d11C1BVY2B6/HW+n94yZV9Inh9Z+hxrP37V7UWsp
         KRShlFxP1Z/nFhhGrQAIT6jwh4W8McISScKDBG6u4VQDGiwYJyO4SfUmf3vgJcEXefLH
         whhbl44Lm8ZZViAs3OYI5haqwndjmB8d0rQ7nB6kGSilA9cMtF2mk3MgdXmRtucE0yvp
         PdXVMtTD5q/5kICdVuvKEgfnUwCy/Ql6FRQGy8UZ/FrUPVulqAHFvKXYS0/P9cMEBabz
         hNmvt5CVnjAsHFIutwXKEuzGqHdc816x+q/1E+gY3RpEFrVJhPAuIVxBozevNLRG8gQd
         Iwdg==
X-Gm-Message-State: AOJu0Yxrcx88PiTv7B80s1Ux9svLKG1JjE09RUbrE6UT66YOtG0U57r9
        QIRWrhLyi/frZUhfnU5BHOY=
X-Google-Smtp-Source: AGHT+IHQAUsRMIZ+kLKJZc/JkXEB4hYY7dN+HC9oKh2e/SL5o59OIKdHmR2+tl+T4wp4DRRiNwfNYQ==
X-Received: by 2002:a17:903:110f:b0:1b5:2fdf:5bd8 with SMTP id n15-20020a170903110f00b001b52fdf5bd8mr16481704plh.8.1692116735943;
        Tue, 15 Aug 2023 09:25:35 -0700 (PDT)
Received: from [192.168.114.133] ([107.119.56.177])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001bb04755212sm11416802plb.228.2023.08.15.09.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 09:25:35 -0700 (PDT)
Message-ID: <20251557-0436-cdf5-4af6-f13bf0de4d0d@gmail.com>
Date:   Tue, 15 Aug 2023 09:25:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230813211718.757428827@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 14:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

