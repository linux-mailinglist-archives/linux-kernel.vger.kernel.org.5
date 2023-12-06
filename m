Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1515E807485
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442657AbjLFQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442809AbjLFQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:05:25 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD621717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:05:28 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso3255965ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701878727; x=1702483527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfHqMdgf8sbyN9wDJxguz1/nkkr9jhupgPfkwuG+lCA=;
        b=GPHA6hV9RC7C8MrH5c1bOjiM1MBiFvbDwpjdKTSDwrUDN/Y79V8eW+/caykL7gGtL4
         hFOTrfOYENi7jsil0mRIIZN1AHf0mFTPdQkaHQxnKvfVR2E3PbozH6AqbS2caM23PJcS
         MeYbPbnsDbaKQHi3y+KcvoiZsuWQpZUd5wJ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878727; x=1702483527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfHqMdgf8sbyN9wDJxguz1/nkkr9jhupgPfkwuG+lCA=;
        b=kOLLQxTOTu9h332r3bj7w/lFpebjrbjDhC4yH7wcF/P4Q3AmxO4gr5GQobytrVR6ro
         tmPvoSkmfCTlSzOHYh8R6AY8ldg43XATwNPvKKz0T1eaemtoiivayu33BuR0diilGsHG
         7di6IYQscaZk0xuKja3+xdLO6+eLDUC4ef2AC3StsJLuHk52zdbDMtQR/VFAXt/Sn4cN
         t2PUExV6c3zTX/Jt3M+7Rn6vO9qWjg5jkGEXiN7stAaYRxbqQWoybR1CHkQb/M8mHK0M
         oNJt+bsHT11YgJXnagmua3Z26V/nU89nOY1I7z5pp8h49laCClaVWnBlIjm5EaQrN7Sk
         2+bA==
X-Gm-Message-State: AOJu0YwCEMo69UJ3HwoVYEmpU6VYzmx9TN6K+GJQxP4h+iVwsjM6soyx
        WGzvYnAnVh9ZFmVVnGnwciSzdQ==
X-Google-Smtp-Source: AGHT+IFASU5mVUojmqPOHR421PqQSolVDnYHY3+2N0sJLwISiUfCDxIOYhj/aS9mI7+r2gxbxcKFsw==
X-Received: by 2002:a05:6e02:1d94:b0:35d:5779:4a5 with SMTP id h20-20020a056e021d9400b0035d577904a5mr2508931ila.0.1701878727344;
        Wed, 06 Dec 2023 08:05:27 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id c17-20020a92b751000000b0035b186a19f7sm60492ilm.23.2023.12.06.08.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:05:26 -0800 (PST)
Message-ID: <543a9e8b-275c-4ac8-b4d0-13a08d8433a9@linuxfoundation.org>
Date:   Wed, 6 Dec 2023 09:05:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20231205183241.636315882@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
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

On 12/5/23 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
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
