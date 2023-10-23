Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CF17D414D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjJWVBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWVBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:01:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D59FBE;
        Mon, 23 Oct 2023 14:01:18 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0252578aso22375946d6.0;
        Mon, 23 Oct 2023 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698094877; x=1698699677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbeI5inRzR7k95NjvuTc2Wfz9EEbnQ9XK4gjlca4j1U=;
        b=gC2Xu28NIoSSWgEVkek2Ez2LneJSCZmDDfZ28MeVXmDGFea9lwpr7uxoaEafqCC4fC
         a47DmxqgWR5035gB1EglssmcW+injRm5m6UsYr6HSXBVxUYZ908BCt423nolSjSuFeoh
         sCvtjHgzA3r/PdJg4FBAfc0rKUh+BU6J5wCatmVfs6Y7raJpdyzom7GNJF8YwFCNHZdO
         dDZrcTpFDHmiO5PsgjX1myRZY5RPHz2sAGsy/Pww90CsVFkgQZQOlw5Tu7HQGUn8DCwu
         D0DJAIvyW1nvw1JiXyQBXNa466urpoLuTujXDEIC4fuwkn/V80V1xe2ewjyzdXHhNe86
         mh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698094877; x=1698699677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbeI5inRzR7k95NjvuTc2Wfz9EEbnQ9XK4gjlca4j1U=;
        b=v4FvW6UH+nwFO7Dv8QxdEuD8VGSzD2ZN5jMqvdMRhoaUsl+5opcssGl+z3b90WFWN7
         x5P93wUDxyM9CfFpBRCssymAWkqzBLVoHLt9Oo1u9xnWA8FvIau/bhG0hmj6eV2FJFRi
         Sg4uxQbexaFOhRDOzIuxc9SXSglDs9Y10TFX7yYTVGqzhq0K9AvEcuaFKwb4KWRCtC73
         XLOdsGlkonEcssbqlkhdrsQUfQ/GI5MeBu/wbvFcc446x6YRm1Q4XrFecX8ljwSUHRdm
         mXd0sL32I02hzwYVbQhzyFOzpvMZnXnwHXAaZcFQUBZ52+MBIHhsxsMWP6AuTtIHAT9P
         B5GA==
X-Gm-Message-State: AOJu0YwHEAOh3KZl9HY3BMdo1J3FBKwGi5cPbfr52UL3SQj//e5VhGvP
        HQtWhw/yX05Xtgjzk2EzZEA=
X-Google-Smtp-Source: AGHT+IFpbMGlO6hn9OtY92vdiN8s8picsYdngOOf/s+eB+0K2iCLDsU98Dk3YpMsLCbHR9aWWL5o2g==
X-Received: by 2002:a05:6214:29c2:b0:66d:18ec:8e7b with SMTP id gh2-20020a05621429c200b0066d18ec8e7bmr13255980qvb.62.1698094877337;
        Mon, 23 Oct 2023 14:01:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l4-20020ad44084000000b0066cfb9cc087sm3148888qvp.134.2023.10.23.14.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 14:01:16 -0700 (PDT)
Message-ID: <0dd204e6-5f16-4c85-b8f3-949b673464c2@gmail.com>
Date:   Mon, 23 Oct 2023 14:01:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231023104833.832874523@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 03:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

