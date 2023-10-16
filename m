Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3897CB549
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjJPV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjJPV3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:29:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8524F9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:29:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a2874d2820so61378939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697491772; x=1698096572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HU6bIZBhi8i2WibR+y6k+ai10NOUUy9bmJLqs7d2ouM=;
        b=P68siq2zNoRMeID9zZymFetogTOaso3HI2YeIt+jBQ32BZd0Kk5mOB6B/TXWGBArF3
         I/p5jSvEjYo0EVBBLGVoZCzt84r0U4vlkyHBfT2O9PzaG8DpjR1wVAIC1+/FmY+sZOEo
         bVtMw6g+4z8yCVa1y5UM4vjP1qZCvAN6i9l0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491772; x=1698096572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HU6bIZBhi8i2WibR+y6k+ai10NOUUy9bmJLqs7d2ouM=;
        b=TnVJ0zp44ddhCRQ6+K1VEODfHAybpwOJJOjo1JFPrR4gY88nJs/g+3gewxVR9PgT5b
         Ga7ILkkvRX5ExNsLnMCMNcuDLsRMSOkXgkrlRJGdhBDmDqWtoZIsI1SzLXbr7FZHgVuj
         gWzOo2mU9ZouegMvbt9NDSA5/Lpz537kJirHGrbgrYaiOFA9iEVCNjBRQFywVF7ipCl3
         y1+/kpHojFTiYYhuBVcVQkW0V1d+EISPgxzTX12I3T3X47K7EJEgifZnq38oMJ8seq/M
         2p6JqsrLZ4nz3y+rAEoKbkSOzDUHe+d0X1cuGKCeldgVNIgJDzXZAiPJxUffDDYCL1ro
         OpDA==
X-Gm-Message-State: AOJu0Yz1hzchSvKUaMcXIt6s/nT0uTs9wmBTYy/4c8I/fwThK+PYAkYP
        9CU06KL0X/O9fA7tzRsUduKLTNIJHTFIuJsHYYo=
X-Google-Smtp-Source: AGHT+IFxb3vyzjYTa1G5fOh2PN6iZFgXoJJOqvW8aozl3/Gsg4KT86tYe7aAO0iisPm/+3gsC/Z+tQ==
X-Received: by 2002:a05:6602:340f:b0:790:958e:a667 with SMTP id n15-20020a056602340f00b00790958ea667mr505494ioz.2.1697491772257;
        Mon, 16 Oct 2023 14:29:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m9-20020a0566380dc900b0042bb1c9b59csm53403jaj.126.2023.10.16.14.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:29:31 -0700 (PDT)
Message-ID: <70f9dc29-aaf1-4626-b478-87c899f267bf@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 15:29:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/191] 6.5.8-rc1 review
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
References: <20231016084015.400031271@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 02:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

