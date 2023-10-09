Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA047BEE90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378954AbjJIWyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378939AbjJIWyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:54:10 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F0A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:54:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fb8f60374so46713439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696892048; x=1697496848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EQh9doZilTbZ+ByxkYuuzuJU5ao0hek1Op6tjYZFzE=;
        b=ZjL8X/sIoHNIuF0RdhLRrX8u5EVUPmQjWh+Byb7a/y9Z2INmeup3zGSaE8z9s3ffu6
         n+kgp25lKjQL5zcLJaXt0GVvzuZAy/9LjgwLpWNlVSnLEBOlvh1znHvPffz8GOvD4LoT
         WqW8Lq4IeY/KYLMBIdLS0C3X4gWwqL3OaPmC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892048; x=1697496848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EQh9doZilTbZ+ByxkYuuzuJU5ao0hek1Op6tjYZFzE=;
        b=fFIkbELC8gz6zjJMB1uJcRm5Ia6zC6Z+iUau01DVKiMsYIucMUctleFZw1z+9emMO9
         wHe56+5HJ5arnVxEDYxixzrM03nQZgT+2q+X0hOB4ypNnLCQB3t0yLEc7dAhH0kyse0S
         Q6CBlSZg8LfuyF8sZDuRRvHDacBxcuh6JtL1sJuXjYsZ8n6JVbfMnNHcD0w96ngEcJOw
         WAfKVxUmDWM4M5CWZSEhDOdfMwi9bDpwzgBp1LqGTQkWaVLqU720n8eqNnVFC81ApQSi
         lT0LND3XUAVotgEVfhTzUXu/tXrKXoJ5wfVYEoLtF4RAywPbAWomIcPC43PjG6tHvN/J
         2zvQ==
X-Gm-Message-State: AOJu0Yz5XIy4GjrHYd5wnqLaC7809/X2E74Tj86qBvUB8iwu7PbtgW3z
        wLeAiYMbGRwhZsCRxC3F83up4w==
X-Google-Smtp-Source: AGHT+IFEhU2CfRiEAaBi1vp7RtQW0sdMdgV7ovI04oK4dlaTCLXISJC16mF+K4QHlHlJvaCebz6rKQ==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id by5-20020a0566023a0500b007926be43dcbmr16989954iob.2.1696892048599;
        Mon, 09 Oct 2023 15:54:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g4-20020a0566380c4400b0043cbc7f9958sm2317085jal.110.2023.10.09.15.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:54:08 -0700 (PDT)
Message-ID: <e591167b-c01c-4905-976c-c7e4f06c3379@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 16:54:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
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
References: <20231009130111.200710898@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
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

On 10/9/23 07:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
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

