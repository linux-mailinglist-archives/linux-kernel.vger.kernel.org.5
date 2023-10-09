Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2197BEE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378870AbjJIWtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378935AbjJIWtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:49:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17514B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:49:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so64926339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696891746; x=1697496546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MD4vOLEn+ODCKC4aNr/ZHy2GXrVIqzwTElTE2Jci6B4=;
        b=ZrU5yRX2J2eXOkMg60zXeLgk77jtjR+7w+8y2Fw/UbxRNKnbxpIRSQQ+9d/6VEGKuU
         6LV1gAGBkLNRwMSGLur66ppFtsyb1LjxL2IsvzCJAJOo8cUWoWlkqfWR7DpGg23H23w2
         y7TetbbPep0qRH9ULJJyCEliuHVnP7EI7xjtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696891746; x=1697496546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MD4vOLEn+ODCKC4aNr/ZHy2GXrVIqzwTElTE2Jci6B4=;
        b=R9zpG5KcczPKoTc+DOZd5Col9LbkeUASreiK/BtdsyRWKNMhVj7/0arqq9X8MyrNSf
         BGfsyW5mDqbTYqeMinYZKst1Ye9Xpy7AbGCUyVDbuky+54+Y08F/m5WfBM1BXxXbZpqc
         5TfZvQf7RaTKgy0CP1iaR2xvjcGKKK0IZmWdmCDOLfMxJiEQiOScZWXrEy+GpoIuXrFD
         /e1Z6JmhzOmRWNpC3pcWL/qFhQpc3GCMbBDksta5/cf1ptzDHzDIszHy00v7e/hQHwAW
         IrRfMy/Y99AsMNaZihX1mjrvEKR8jYG8Qad4+1bu0uhH4Qp8vBaUHWxDFXFs/vJXPIFx
         xBfQ==
X-Gm-Message-State: AOJu0YzcbNY4OozHD3jJss1jxdPss5AwecFxCcwacJBELTsMfL/xv6kf
        mhjWgGMs3/Wjr0onqyFqXXzDvA==
X-Google-Smtp-Source: AGHT+IGLHs++IFJz8wlEpI8qgfbggIA6BhZ2M0hqNsP9yD+fAKnhBOBLIGGd5dJqyph0EZxYxePapQ==
X-Received: by 2002:a05:6602:140c:b0:79f:a8c2:290d with SMTP id t12-20020a056602140c00b0079fa8c2290dmr22053272iov.0.1696891746444;
        Mon, 09 Oct 2023 15:49:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a02a306000000b004290985a1efsm2344564jai.43.2023.10.09.15.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:49:06 -0700 (PDT)
Message-ID: <92b78aaa-1ea6-4040-ab81-e30a8980fcf9@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 16:49:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
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
References: <20231009130122.946357448@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
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

On 10/9/23 06:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
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

