Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C07E4645
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjKGQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjKGQk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:40:58 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A019AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:51:34 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a9447c828aso3374539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699372294; x=1699977094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAzxkP10OQDM9YOWOWaJJRML05AHefjemOIWQGzk+qI=;
        b=NXD+GXMygJbxokOI9+pUGnO4C9RUv1da8ZVPhePattmiJrKqbAeCt0sCuGtXKEJ8E1
         n2Prvim4rXxGJuhqPhucPB9eesKfuYVzePKIo6ifTMn0L4fmq3x723ChpW1dXwQyigt8
         qqjyYn93pZt4YxNGkrOKSCPRWAYaewDscE70M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372294; x=1699977094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAzxkP10OQDM9YOWOWaJJRML05AHefjemOIWQGzk+qI=;
        b=oSF4xDoDn/nStkIt45L38p4SZK0v7wh9hszx7QkJdh0tcDK6EIy8LHl1006cg2snup
         0cug5VkjrErSNgz9fNrWzDb1A/3u+Jr1f1b5vA3ZZ2WZlKx3cZUPzW5ccvG14SjzGY5Z
         VrGhCc0s1B4O6AKq4oncuD9Fcy5XZjTFRWUxLdZoGHlwUlHGck44D9LMWltbPRKwPVA+
         HyyS5uJ+im94FHjbfN7oog8iCZzJPJW1ZUAWNEEaibqNXu0K7ZdW9VS0Tawqq2pokjvk
         v/Ha1WAvTobQsLayTUf/X4XVIJidcQdRcyDwx4DBg26B6+BXR1dJI99TO+Kc02scEqW9
         hu2w==
X-Gm-Message-State: AOJu0Yy6r7xhH0ORouvpJs7buC+xAEM5iL86ILEicZOpphmNB9HCNXQc
        +7SKhPFbMckYCR1PcRp71DSlsQ==
X-Google-Smtp-Source: AGHT+IGv36r+ShQUykCndJzyqw+Ib+370gxiK90Ut8FZCZBzlh3wm4c/To1ndWM2b46rlfXQKkxINA==
X-Received: by 2002:a5e:a80c:0:b0:792:8011:22f with SMTP id c12-20020a5ea80c000000b007928011022fmr36342555ioa.0.1699372294206;
        Tue, 07 Nov 2023 07:51:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m8-20020a6b7f48000000b007a278f16881sm2899101ioq.42.2023.11.07.07.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:51:33 -0800 (PST)
Message-ID: <ae5bf8c4-23b8-43cc-b6bb-ce89076fef4c@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
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
References: <20231106130301.687882731@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
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
