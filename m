Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61ED8064B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376480AbjLFBhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376424AbjLFBhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:37:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D265109
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:37:41 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b37846373eso27353939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701826660; x=1702431460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsMy7T3EG2zYRwsChqog9nsZDeN6t1YOUu6K4nSNjSI=;
        b=IA9/SqMeym09rw7D1p1X6Mv++GL2nwJ9jeLPnCZOq/91ai7vfqV+V3u9I4EXOgGkQ2
         UU7ZCmaUczhCg9ITw0gnXpkBatSFK6W/1gM0ZM8g391ag9AYquJhzkOj8q2VIvRyuiQk
         0Vm1uIXrUvHH/DvYtC2pNd7CuCG8g4BHOO7es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826660; x=1702431460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsMy7T3EG2zYRwsChqog9nsZDeN6t1YOUu6K4nSNjSI=;
        b=FbvmTT7jAplF2XRt6Fbfenfoa18Rm7bBidHZj2s67vyaO3t25yXYDHUJcMzrsx33As
         UP007IzjvYL3OTI+XGj2nN76OO2bU1gkQR9jYnQ9r4nKsdzI0IsvTEC0wIzxpLzWVkCX
         HK+/PeOef/SDhnSa1ON54dm5eSyJ7sShOSjC5btSMBR7OKYw2sqojZK3Gu3SQPaHHOSO
         cPUcILcXET8LweAWyidytVdwEoTApFdr0cZve0jiHMgcNM9Q3Q+6NhnuHx5UySu1Xrq9
         lfFVxUQWlQ37VSm+0nKAxneNNYn6rP17RLWOTSWQdd+LagQ+T+09h5dIlaaJHX/kqUX9
         ECdQ==
X-Gm-Message-State: AOJu0YxSb9OOHc2lwiLzADFhzKeFKslMDN7FJ3U61xfcGrVeG/5bKcW/
        PuWZOZgnd4MUcb+M6317w503FQ==
X-Google-Smtp-Source: AGHT+IHdO250DHcjWcfyqUmHLuU/KhgKLl62WKWorND1qPqtBYPDYhk8HQGQyYJRy4S6yz6f+OeeSA==
X-Received: by 2002:a5d:8715:0:b0:7b4:520c:de0b with SMTP id u21-20020a5d8715000000b007b4520cde0bmr494655iom.1.1701826660337;
        Tue, 05 Dec 2023 17:37:40 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d25-20020a056602329900b007b457549001sm931003ioz.36.2023.12.05.17.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 17:37:39 -0800 (PST)
Message-ID: <4d7e7b23-7fa7-44d1-ac5d-ea955b2aee75@linuxfoundation.org>
Date:   Tue, 5 Dec 2023 18:37:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
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
References: <20231205031535.163661217@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 20:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
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
