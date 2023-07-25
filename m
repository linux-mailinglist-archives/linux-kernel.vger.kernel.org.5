Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD917624E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGYVwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGYVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:52:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB67212B;
        Tue, 25 Jul 2023 14:52:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403b6b7c0f7so45942231cf.0;
        Tue, 25 Jul 2023 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690321969; x=1690926769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZqXFEJOsELJuU0v49sTZz2n47Z0GHcqodEIuHlo/OM=;
        b=jdASqLsMWvG4Qq/HHjguFQkzgv3yWbJ7izVcFZgCktLOhZji2BK7pYv3EC2FHPQk+b
         bt9GfwrvagpagR5wSNI8ygUJXpc3vXfjha7HXIiPkFmy2HjGkRlVSKy9QS9r9jDIepBZ
         WGClO8mgHZTbpYv8EpoklhTXMCjKxP0iE23us6zAWOlyfIYng3Yuf7Dy8t4RmxGH4Jmj
         Fk+yCe4aKZ6pcmVtv8dSRO1NgeL65La4ckWvGFxv4b1+oSNj9JFH09Qw6jG2h6Wc4f5m
         AO/e+Rf0eSO6rgGniYRBtRnleKvwtigDN8gi/yJknjitZTK3nAkHfTGFEdxZLeEwVTYL
         QiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321969; x=1690926769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZqXFEJOsELJuU0v49sTZz2n47Z0GHcqodEIuHlo/OM=;
        b=LezgeuFSOYuWGhsO4hSzRiztFG//3pqCZKwQiiWDc9EEaJqb/b+4255bq7y+IvbQwK
         D84RWi5MoDN4VFrh+WiU/rq2KM5sYw08nOE4dMyDnAUKznBw/7MDfElj+CIrUy4BwW76
         ch57RZl6vk2fH0y8QzYGLzzF+SBOmyjASjBfYs/oCRhDBshUG9Fi+xwan+OwyJ0llIXI
         XJ95PvwJe8dgvVuwF61cBCRTD3XTQmXkvYvRpFz1eAVT5DOWvZn6AJBydKCSOntTxyhK
         97kHUufuYc4FeIRPWb+jFn9Qv9mWp/ZCQ7KT0dLjAInqfwzxvX5sbjah8IxPLzJo6EFz
         RD9A==
X-Gm-Message-State: ABy/qLZV9cKMJzXq78dvumue/ebNklHpmwpLM8Myy9izGibuS2Wki1/z
        YSO6YT/Pwu/GSx5kN+Hl/bA=
X-Google-Smtp-Source: APBJJlHL+UTOzgSHuMPKvkao4BVSCaXrW2fNQi6JzMHVXGzmCA3hn0D9VxbDjT054+BXTKzFkKlWkg==
X-Received: by 2002:a05:622a:1b91:b0:403:e919:513d with SMTP id bp17-20020a05622a1b9100b00403e919513dmr220422qtb.15.1690321969080;
        Tue, 25 Jul 2023 14:52:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r26-20020ac8521a000000b00402ed9adfa1sm4357525qtn.87.2023.07.25.14.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 14:52:48 -0700 (PDT)
Message-ID: <f0c5b6c8-8049-9172-e39d-cd7b53349e49@gmail.com>
Date:   Tue, 25 Jul 2023 14:52:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/78] 5.15.123-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230725104451.275227789@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 03:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.123 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.123-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

