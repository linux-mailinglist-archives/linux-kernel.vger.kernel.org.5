Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5A7E439C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjKGPjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbjKGPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:38:57 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989C10D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:37:26 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a680e6a921so35618139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699371445; x=1699976245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDzkQitSyi/YwAVHmkQ+3L6zd+cMnfnuVuRUDTMMudk=;
        b=bpFQZyiD419RUYxNH81Ios+c9Bveh71nTuBquDNbBbUkHyBwWSw8rXm/AnjBIFGB8j
         sbTkvggBEtwJjtqyWxIUW8oZ+vK+GE4sgY60CzknJ0IF+6K9BD34J7OMFp7cjisjiwPQ
         dAUHdHlQlFtO7tcZRSzk8+JiLzhjVNecRfj20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371445; x=1699976245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDzkQitSyi/YwAVHmkQ+3L6zd+cMnfnuVuRUDTMMudk=;
        b=d7LnDK/l9KxwfqyxcA5z83o7UKcoLLTBv5+pdJjFJShvwxh+3usm8+CijGTtnpfUa7
         f+ir9wUHjYxhV1jaNKxO0mOXAE7388yqRL8bAXypeuB3DaWyYGQy3F5SV9n4XvFjljU3
         t1tlw8H3N8xglrLO5x9xheYzMee5/rLhIEV9w27cZhnyAyPs2Ba4VNsU05i3RnWdy9bM
         ti+4glCl9EgnXXfx07CxgUR2CyLJb9XySVYucIIVpf6AyvXQoQo832OoZdLNt/mZ4jwD
         Ju662rXUYhidxfKIwHGYbEJ1qArfhB+q2tz75EPVMkXgES2e7vy7wYSj9DS3OQRc2bTd
         L+2Q==
X-Gm-Message-State: AOJu0YwA4ItvEuNr+1DaC6EkgEkBmKFLCfzMTNi+sjJYHlwOcVOdxosT
        dudGAqa7KWLImpeNpiObXU0a6g==
X-Google-Smtp-Source: AGHT+IFxxAYfY/knWpIJB5/9ALe6JFyy7qTD4vgvbpq383FXiugruIENQJikmem4+TsLENoNUajfgA==
X-Received: by 2002:a6b:5c10:0:b0:790:958e:a667 with SMTP id z16-20020a6b5c10000000b00790958ea667mr32194643ioh.2.1699371445388;
        Tue, 07 Nov 2023 07:37:25 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id f19-20020a02a813000000b0043321a50c29sm2703757jaj.93.2023.11.07.07.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:37:25 -0800 (PST)
Message-ID: <0bbc4351-a4a7-4e28-b1e7-082b29a932db@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
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
References: <20231106130309.112650042@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
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
