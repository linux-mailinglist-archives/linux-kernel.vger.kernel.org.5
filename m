Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523737FFFE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377390AbjLAAJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377367AbjLAAJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:09:22 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7379D133
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:09:28 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fa3828b66fso299346fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701389368; x=1701994168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fHHUuDWZn9YqqYK3EYAhJra7nQxFC5yxmzo6hYrotQ=;
        b=F1E3cbMw7WdlGcPDREoA6iDs/vuMRsVzWyNJuAMxcW+/TC4SweAp36wrGw1IQJi14l
         3HW9zwhKYuCGKdgGBq2GTnKwWilPReEBSXtPdku8YHiQttkiZbl+389ACj/Pzob01lik
         nAEG9+fRoLZ8ACEBrEKl4GqHPkAYMLnbVwMyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389368; x=1701994168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fHHUuDWZn9YqqYK3EYAhJra7nQxFC5yxmzo6hYrotQ=;
        b=pGqzWAfsgnB3+LdI+8KMPvtYLZhvckLjVqJjX2KwVqXgcxA+eSfJQ7d6jrIrnfcGHe
         UDZLJWeZPqjsG9qQXCiFxaC+i1+z8cNAPurxJ50JT6sDp53RrQXiWzD7K1yrgIS78lo2
         688shznmDfjh4n5NT6zOO7V6o2rAmSGURogrIhxIrD5zthpYyGl6dGgm/GKi2Xy8F3v7
         sKzU6IgIgq5cCgeEG3eK5Gs9lxAU2m4B7cPk/oPHclLxm/Xfwh8851iB/vAfe7QssJHT
         8SnlZuYuU8zO/stKx9OLp4cWCra7vL90YHTMwyC5Q+X4dddrt1Ozv0zK0Qlq0mtDVIUt
         gwPA==
X-Gm-Message-State: AOJu0YzPemhTTzHaLcDE+Xayv6hgxzTtT6rhmu8KBm3nr1HLGvy5p5Bc
        brieAt5LltHQjsvz8viXsOdkwA==
X-Google-Smtp-Source: AGHT+IG8zzeD/auPSzGDXSrUbTz7+QRxnqkXG7XFtfKuRtBOeOFYfWJ5FDWCIruPxeg5QPBDml1OIg==
X-Received: by 2002:a05:6870:4c12:b0:1fa:3b7d:157d with SMTP id pk18-20020a0568704c1200b001fa3b7d157dmr4532394oab.1.1701389367779;
        Thu, 30 Nov 2023 16:09:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm315807otj.61.2023.11.30.16.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:09:27 -0800 (PST)
Message-ID: <30b73319-4958-4089-8dbc-7c72e66cccec@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 17:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
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
References: <20231130162135.977485944@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 09:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
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

