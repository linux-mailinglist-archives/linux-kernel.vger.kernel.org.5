Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345197BEEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378972AbjJIXAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378960AbjJIXAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:00:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98AD9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:00:29 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fab2caf70so18851139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696892429; x=1697497229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2BWZbZhytBka0EffrJfj1+89PYtChbCcDgjZSFmqKc=;
        b=hF3L84veQVg3QAV90brXWtyZZSD3sRk/PdnZk27XM3fcRzpydcK6CAGqE4M0Y7/vfG
         lG5YCUM1hWos6b5B2gBx3YRmgU26NwAfz4dYNQr9xJlwd4DF6PN74FFt5NKUTk+jJQ4w
         YSIhj2EehMEFBrizv7X9pjhG4FwLlwGIsnT5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892429; x=1697497229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BWZbZhytBka0EffrJfj1+89PYtChbCcDgjZSFmqKc=;
        b=JHgCENhwfPSecCsPF1ZcUbffjnUYN0EhXpyDtm70OiQc1LEEySHeNhW4VBtRUEpc60
         X6ALeEm+8d743dSc8OYEXiPsG4gU7s861OxuiV8SexL4OMLxsz8Kw9UWvwVK6di4EB5S
         KK7Avbbpxm/3K97jIVc3x/CP+XJL4F7CPbRq86oqS369LRTCAddg42A1upDSTvvTwStN
         iFDKKx6tSdQ1eMoRDlIEqTW5lTK3F28OKfX3Cs9AMbJdn6+ReTB/TjZZzFx3rGN+95FW
         ATIw8kEOQMCqtZKk644w/p+XG1peaTQ0tqxCEpJWYlVDQMDmi8QPf1rg2dN5S/ND10Ip
         U3LA==
X-Gm-Message-State: AOJu0Ywrl0ClTdJULVCVK5yQkk5DG/uhucBBgPcwJYF8JOh0MZTDM0XZ
        7Ll8YH5o6Uxcjfvrn7hGtF5i5w==
X-Google-Smtp-Source: AGHT+IGXrpYolpV2262t6JGutia7xDeNmPzKKe5RBMLoyi0TT6PWVTZdPMb4J5AvS7LFikrBXw3jSw==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr17554425iob.1.1696892429339;
        Mon, 09 Oct 2023 16:00:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s8-20020a02ad08000000b0042b3a328ee0sm2328655jan.166.2023.10.09.16.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:00:29 -0700 (PDT)
Message-ID: <f252a3d0-8e86-4c74-818b-4d9063607607@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 17:00:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
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
References: <20231009130116.329529591@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
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
