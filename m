Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC47FFFE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377363AbjLAAIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377331AbjLAAIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:08:21 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB17196
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:08:27 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d8103f3cc5so218211a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701389306; x=1701994106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TeSiz7oFzuM5XyCdaX+ONzU+lRac4jJbmIws69/sXE=;
        b=TmfBxgnE7VIjgami+sFfEJsF6B5Ol9zcfMdP7jKkdB2uHuFVvuGZ93WFU3HwLGUpjV
         XosQGB1RZi50gV88h+760PbOvcBsN0l+9V2cPPjvUrSSIAYgwbE1S45QKjFgz6XtUxPX
         fZdGc3Qhw4rxKvCHWHku6Xe9L4DwC/oYgOe0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389306; x=1701994106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TeSiz7oFzuM5XyCdaX+ONzU+lRac4jJbmIws69/sXE=;
        b=hhK0VjWkafA0rB3KOHXmAkBq5I1vTTcebn0FuGX+eOHoieyk6BXnEJLu9zjfQnCUAt
         eowcjBgSlX1TqrdkarmkO8wl9BMkL+IRV1KtF8z1FQRedD97yZ0xapjjBTGDKLsRIguy
         RsNf7B4j6hpQ66DczpBT5/PRwgpo6omS9OOvhB2z7w703hqBsNTAs7gKJqq70XJDqBAY
         hTerbibbggDSwDVlSNetkMtuqgnE2uNknQ0Zy6JlHDIDl7e8372XwfXoYwHZEQjdrlmW
         FmwztMlAl4xLaIpf95GmmahqFPPreHSo+YjeExcalHaTJlSDUuLQh5p/dxM2XgTT4Sf4
         j0lg==
X-Gm-Message-State: AOJu0Yym4X3eNuE94dvcYB6g5j7Rdy6JK1Nj+Q5agfcro7bONmFIzOYb
        yHvYFUZtlpQxyr5uDwZt9OB0+w==
X-Google-Smtp-Source: AGHT+IEjoza6H96rpiRXI/yQlfJocoSpE8YdpEW/1Kp0jxbS6nBNtuQSHHnK1i96Tjnh8gSr6g/Urw==
X-Received: by 2002:a05:6830:4888:b0:6d8:114e:9c5d with SMTP id en8-20020a056830488800b006d8114e9c5dmr23275214otb.0.1701389306333;
        Thu, 30 Nov 2023 16:08:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm315807otj.61.2023.11.30.16.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:08:25 -0800 (PST)
Message-ID: <65a8c8d3-7557-4731-8909-a6445dd58806@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 17:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
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
References: <20231130162140.298098091@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
