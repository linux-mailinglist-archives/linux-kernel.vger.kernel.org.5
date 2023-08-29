Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3487B78C77D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjH2OZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbjH2OZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:25:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05238EC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:13 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34cb4b85bacso3135615ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693319112; x=1693923912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJUbKroilkzyrqQ/wNhMzuPxZ1aCqcwh3ID9A8N21Sw=;
        b=h+kESRJR7EX2Lm3X7qOlFyuGak16wWPHO9UMMj4+e8vnSl7yh4yzTovZ3U2mWhRhG3
         d4KLUKylxTSsH2yty2CO0Q49jwyxyqiv2wcufXMoLMGThrQwig4CvDIiMloAIXoyDACg
         XhEBS0ErOzN24m/Xrg5lFlTEAT4nhG8qV0vOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319112; x=1693923912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJUbKroilkzyrqQ/wNhMzuPxZ1aCqcwh3ID9A8N21Sw=;
        b=Gh20XTdoplJq28JYi1O5fGs98or+zTQklqizihtbWHeh1hHiXkvExB2PBJhpCouT3N
         ULu7L1GXhfSSu4va6WkvZX5TdJc+ZSyqM/LAmF5qM8YLoG9HwOuUMEerOYzXdDVgkXxS
         lvdm6Z6TPKPyTP0BRlYXQMBeomQynp0alp6YAlcJWCzTSDVakHnC7SyHtCUsYBap9HlU
         oNLSStfFC9J3C1bTIukZ5u7+q4x4hJGwmhxB79tJ47hO1Dy2QT3A3yN9F++aP59dZrL6
         mEpqKYadHhvPOQl/t4PYYP+kX0kk6o+CPnBE6qeCO1fhR41BNPhRNv18wokgmoPhT/GQ
         HEdw==
X-Gm-Message-State: AOJu0YwlS9u/UDJON2m+T3CXScwjZ6rtJje7BCszlGD/fLb5MB8PHuK2
        LOm99b0+yXQNjNcZryEtFo4ohA==
X-Google-Smtp-Source: AGHT+IGioKGtNYseqMY3QKnFM+wN6+jVP8+G9cx4AbkiotekfO41AUVYB6ybiKtuUIGn8RBVFuF+lQ==
X-Received: by 2002:a6b:c982:0:b0:792:8a08:1bf9 with SMTP id z124-20020a6bc982000000b007928a081bf9mr11373255iof.0.1693319112367;
        Tue, 29 Aug 2023 07:25:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z6-20020a056638000600b0042acf389acesm3083550jao.71.2023.08.29.07.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:25:11 -0700 (PDT)
Message-ID: <7a4aa9cd-29dd-e1bb-3100-833e4a2df100@linuxfoundation.org>
Date:   Tue, 29 Aug 2023 08:25:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
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
References: <20230828101157.322319621@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 04:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.255-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
