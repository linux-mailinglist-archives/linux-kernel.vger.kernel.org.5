Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910A7DD97F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjKAAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjKAAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:15:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A97ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:15:03 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3574c225c14so7885005ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698797703; x=1699402503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H01XgswRPGwawONIAmjiaU9xQBusRZiNk3wBO1wRmYA=;
        b=Q+n1S8UVaCm/kz6FjQB1sKgWjGJNfZQ9jUIJCHdqnKE7hBmvUPr6Nx3vC2kqSksWus
         N2bhNI20sdpzamT4mql3lTFUMoq7s00wX4NNjukUFfchtoNub3j7Bmsmfpz/9K3KM7RH
         D9a3UbVMO8r62GiYT+k2/FUR28sgU028fz880=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797703; x=1699402503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H01XgswRPGwawONIAmjiaU9xQBusRZiNk3wBO1wRmYA=;
        b=ukKlj9cXthWJX6iioDh6Qww54Y+oNyJaZCCZSHR5ZOHWSco5eMdhDrhO5TeVfCYEIz
         s0VQ2zqbb5W1RWnPltqnLjlSj0yiGvPJ95j6ce0IeX8Z/mAVtkEkx2kmQm0AtZaO6a9S
         kfVmBI8gcDvfzcoafgHrxPwgjHL/tiTCgrYmJwff/0Ww/UiifBwbXQlE+sdNG1JDAKph
         S9NYiwwtWw2pVzoGkCYcyYSl1GbnMXrpvTazXh/pYIzqCrtTymq/X7q8PUROgXZm8fzw
         UPR8N2dHLGljhfb3UUYSQExRdBr/hmsYpVDVQg6qoeyHXl8NgkuBFvYhIIS7/W8VJPim
         rz9g==
X-Gm-Message-State: AOJu0YzBXJ/IFzii+Z3kDVGmIZou45tOQ/DpAH0rtmQGLF2qKV5FGihL
        V7m2kCSMkIpS7smmmFWnaa77Bw==
X-Google-Smtp-Source: AGHT+IGl+WxhoFAyV7WnhN40xADAgliUOCfNAwIL75Rsrgz0hw4g6miD1Ry9thMYblpeYpqd4Qn83g==
X-Received: by 2002:a5e:a80c:0:b0:792:8011:22f with SMTP id c12-20020a5ea80c000000b007928011022fmr16901322ioa.0.1698797703330;
        Tue, 31 Oct 2023 17:15:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l14-20020a02ccee000000b0045ae21e7291sm614212jaq.32.2023.10.31.17.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:15:02 -0700 (PDT)
Message-ID: <1140cd7b-e1b0-455c-8219-1b31e0227bc3@linuxfoundation.org>
Date:   Tue, 31 Oct 2023 18:15:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
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
References: <20231031165918.608547597@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
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
