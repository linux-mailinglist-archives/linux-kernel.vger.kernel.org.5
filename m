Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1C780619C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbjLEWVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjLEWVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:21:51 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF8188;
        Tue,  5 Dec 2023 14:21:57 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b898c9b4cbso2045703b6e.2;
        Tue, 05 Dec 2023 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701814916; x=1702419716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Cm00+NsimWLmQhdVNiamoI86kNbnX3twGr4LUKJDhM=;
        b=Nf9RAEBDQIemb5FZRx6PjzZVwR05w/WLE84VV1+X9b45lj+UZf3ZgmkinzJ+snV91Y
         erlAZgWPENOYCjiOH83azGAnfF6TjNAAfzcY7puxRI3i5293iwy331w6vFcVWO1PYBU6
         T//zBj4SLYzfZISj6+RNoJX2wPktgd8cmuDh7ErTp65hT5sCqLbkmZD9YNnkwgOeXllb
         21kezIp2RZA8uHBo6FvHI2JowgCXzloSZAP/Nmv+SH/+ZGNPteF3iIK91BrlusF/Q5FR
         VWx1pVyGxxGOflAycEPxSsnpWyBTscklzhrosiL29DiaZhafwXoTtXmTsP3aCmyHyBxB
         hxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814916; x=1702419716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cm00+NsimWLmQhdVNiamoI86kNbnX3twGr4LUKJDhM=;
        b=WrwositaNuGxh07DjhoXn7RxnH0emhV0fZvUuU0B+IE977xIkkVx68sAY9K0dja63m
         yX0sbh/6Sr/GK3NAEJrkXzvh5Cza3u2fZddVssqs9ObhTDX6o/SbKHqS4XFEKxSL6Zfv
         u3BAi+SSQq4YCvFbqiPSdZcj/nh73jsafc9xTzHSNLwIB5Z2RLVeninVU8ipdZNiFypT
         VA5MVHbf421OqRDtzYmMUpqdp8PgHQzKqlgJWJbboH3ZUI/YrAAaHndRbQEeAMrdKkcU
         WbkqZOKxAlb3OQfD+qVraRh08hpjwi55YQlMKJ80VkXu+KDw5eP8586tmApfid9il42/
         dNgw==
X-Gm-Message-State: AOJu0Yw++vJlL9qlIJcLV/QxW0wbshMM6uiSlD8OaoT9H1Axjs/x7TL0
        BbNuZ3/Aqlmgj0E3aVpA0Nw=
X-Google-Smtp-Source: AGHT+IF4bbGVePAgZJY4DL9eEdSzz00zGPhOiVdsVZDaC3YBbOyIuRcnhDp84gZ5xB8AdhJzkfis4w==
X-Received: by 2002:a05:6808:20a4:b0:3b8:b063:892e with SMTP id s36-20020a05680820a400b003b8b063892emr4300608oiw.60.1701814916133;
        Tue, 05 Dec 2023 14:21:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g5-20020a05620a278500b0077a029b7bf1sm5433609qkp.28.2023.12.05.14.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:21:55 -0800 (PST)
Message-ID: <96e7ce15-bcdd-45a4-ada6-bc21a37f2279@gmail.com>
Date:   Tue, 5 Dec 2023 14:21:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231205183248.388576393@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

