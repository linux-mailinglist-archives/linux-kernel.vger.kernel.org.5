Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05177EE732
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbjKPTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKPTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:12:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487ED4A;
        Thu, 16 Nov 2023 11:12:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so1119872b3a.3;
        Thu, 16 Nov 2023 11:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700161922; x=1700766722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2cblImVlnKbNpSaIwvvqPSRGRUsM1AEekZ58ABcA3o=;
        b=HYQF4bUE5yyoeYXWoOL+Ze0SQb+lt5zR9QZLXl2GXRj12PFeshPsPUWkpxmGfW3llC
         9Hj4bYf3GtOSjXY6s0riO5YeXVDI5EZxz4VeGJa9VcT6NCgu8VokanLYoWkF5tYyn9ku
         HY8b4pyvXeBfSiLUV6dsLgnpa9hkNWzK/DixcYk7JlWjcOFkMInHn8i9uvTKqmSneL3r
         O0WGeDHIgjoSFgGI9iDMZRhXSNDM7UPqOMRfPCsKUjQpnv5hlcNT4IOLM/Ibfc1b8uwI
         YxkcXC/xK05vHXbO06Y/kST0kHiP+eCUmabyS7AJsPTeWqPnzA7AwRcYIn6jew+dFYSW
         pGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161922; x=1700766722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2cblImVlnKbNpSaIwvvqPSRGRUsM1AEekZ58ABcA3o=;
        b=boW6lIZWSJneW7TA/7l1NCmE0veQgOYvxV/JPCeuDsPde5uK8XnegvlL3WTSzYWTug
         Et8rqZ4cwSYo9CD+4FgxJT4cXg3hNd0lTmybJeU2DryWmEK6YzI/+X+zBZpunAf+MfFk
         CsJzqk/X6h0DXoJ0bkp5aIBSzi2XKOuIPcTxgE9iXfRdJjznKmurOTh9GgqQ4NLhjOKC
         94zvxv4z7X8EgkPY6tTsJ3Y+WMmpbj5mVq6Vk7984mJMtJvxaruvEh8Kp8bvcC0D4igG
         8EQ7ddigMu/vJDlkQsb2kQl2f7ODWSeIyhdCcMeTTeVZsdHMtOW6iJJGq8NJsv4tWBdS
         alUg==
X-Gm-Message-State: AOJu0YzioLweBJAJGtalsH1TAnpYAv/I0wiIdvph+EHAWwzVs1Vsdttp
        oYJ3J8kaw2e1EVhziBJlo6g=
X-Google-Smtp-Source: AGHT+IHljXn8CNIViSbTqu8jUg5uWKAMgIY9NhPSyqrB0LWUb28+6OTJH9Lt3SqhQ2ZX7wtujCOtZA==
X-Received: by 2002:aa7:84d2:0:b0:6b2:6835:2a7f with SMTP id x18-20020aa784d2000000b006b268352a7fmr17373822pfn.22.1700161922269;
        Thu, 16 Nov 2023 11:12:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bn2-20020a056a00324200b0069ea08a2a99sm68710pfb.211.2023.11.16.11.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 11:12:01 -0800 (PST)
Message-ID: <17487dc6-2c16-4065-8df1-7bb5b7696ca6@gmail.com>
Date:   Thu, 16 Nov 2023 11:12:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/119] 5.4.261-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115220132.607437515@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 13:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.261 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 22:01:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.261-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

