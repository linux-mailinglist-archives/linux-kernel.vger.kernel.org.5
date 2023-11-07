Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3E7E4559
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbjKGQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344608AbjKGQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:04:11 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2044BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:55:31 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3574c225c14so7955235ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699372530; x=1699977330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ov71WMP8hq2Oe42YqNoTQzgfuyyeCyevcpAmAeyvKjo=;
        b=WmR7gCmIRMtw5DVr8PHsm5GV7MBORhBQadGaJ2m+22va5C3nXDPMqwjXLS+gBp6t4W
         ZrRQ5AfgnJYuooOw3WP2Uz6ZBk8srjxv9B9IEaOkkEaBjxKFwpKde/jN6S3q3XL0nwwp
         dheFl1vkA+txbSOgCYpZNxUY07td5vYJ+9Ay4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372530; x=1699977330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov71WMP8hq2Oe42YqNoTQzgfuyyeCyevcpAmAeyvKjo=;
        b=SVNt+mPMFgbAZ/DCeBqEfsFn/hUKEAYXdUSUwieXTrC2phJ9IlKvG+y9PDWxd1cqZ6
         aOjWNOov//45OPJe+b6XctxoKT2f2Q6AHcQGJ7p7rgDbGRcLsA1p5UloblfrwsjyLGeW
         3Ab7wzUkYPb8L57wJnPcbvS+RPJv92ApRFw1zIK1ISCi8oBMQcgNrZu+rPYipMi3ZS3T
         bh8WH7vUW1GfecOvh9/XVPeAn262z/4wh7eSKU00zHVf8Y2lVpQ3vG88k16hsWE0qxq9
         sL5hHaifRD2R7mRfy4MjD9B9LCql9wVUY45dmHfvJzC2owFJdLm0P13TifztJytpnFUz
         eshg==
X-Gm-Message-State: AOJu0Yxi+nxc80pK5E4zB9PeEFKgl5f0J6s1EYJGV6Z/Q7SAF1pem9Th
        dBsLJxvaR1YnIjd5oNIKlqATvw==
X-Google-Smtp-Source: AGHT+IHpUt6IWE2JUKMRqzmXV+OPPfruQ0l5K8LHQVnDjzc1ZoluSa72ODUxvOteKGchzpn9GQWOpA==
X-Received: by 2002:a05:6e02:330b:b0:359:a1d7:4e2f with SMTP id bm11-20020a056e02330b00b00359a1d74e2fmr9113913ilb.3.1699372530445;
        Tue, 07 Nov 2023 07:55:30 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m15-20020a056638224f00b004500f7a5903sm2789264jas.102.2023.11.07.07.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:55:30 -0800 (PST)
Message-ID: <efea3d00-0b3f-4f69-a3c0-94c4837c7644@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/61] 4.19.298-rc1 review
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
References: <20231106130259.573843228@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 06:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.298 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.298-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

