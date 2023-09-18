Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA67A55B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjIRWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:21:41 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03591
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:21:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7950d0c85bbso56781739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695075694; x=1695680494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0YhvdHFMerPFgTasHZONWV02qA1rGQ8gwzTFXSB750=;
        b=RorE4YN/kZ1bXF2ZayBuoY3jeqO5skiqbMMq+CL+yhFmk51FwxdSNQQU7U7qQrrNQN
         ztDYuN4LRr74OFp8plK+9HTMC1GvLIYmux/4u7XE541Y2zK0SLR8DCYOZD5Wst2dQH4C
         +zFPPy5puWHAeZPoF5WLmf7SGgIIPeM766yzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075694; x=1695680494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0YhvdHFMerPFgTasHZONWV02qA1rGQ8gwzTFXSB750=;
        b=DPxB3O/TBpFoSajESXnFb+Rgcpv132L9T13jGWISqGVlx5jdTqHYLYHibMV49jJqGX
         0+F3JpW3ewqY7Ck5i6g9XIh485M9WXbmY9XOw+VYk+r091Q2AVJSzdUsuFSlUe7TWQZK
         nb/hPXmBgDhbEM+4sR/l4G31jKgbCmallnTaiOYvIWrvUWRJ6WOSWclN1T5BXch5CumB
         /U1ZbiL2oykWRrWDeSZYpXCTlOU024+4OIq/2yAfXUV4wUZWRJj2670Xbt4AyBZJ7+K9
         armNry1CLNvnWDBcbYpshpoDy8JlAs0Nk24X2vWhSsT0aSUpvBBmESN2v8n1IYBQIsES
         Z9yQ==
X-Gm-Message-State: AOJu0YxSVoyK1Fooe1Npb5QozxaKR99RpFC+4neB5qTEpR4XOIWNLWD0
        AZC/tM+qcKlC4bijzD8wUD0HDw==
X-Google-Smtp-Source: AGHT+IFM5+C8inBth6aEvK356DZMrK/A4rOkvCd+6QkQFdSUI5BGN3NxFIV+oJEKDQ8JCYJYV2wwlA==
X-Received: by 2002:a05:6602:3996:b0:79d:1c65:9bde with SMTP id bw22-20020a056602399600b0079d1c659bdemr8027440iob.1.1695075694407;
        Mon, 18 Sep 2023 15:21:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v4-20020a02cba4000000b0041d859c5721sm3101989jap.64.2023.09.18.15.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:21:33 -0700 (PDT)
Message-ID: <ff41df83-f4b1-a557-1289-965676f8978a@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 16:21:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
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
References: <20230917191040.964416434@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 13:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.54-rc1.gz
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
