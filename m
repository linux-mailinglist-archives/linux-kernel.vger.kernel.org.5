Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2B7E2BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjKFSVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKFSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:21:13 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47430D4D;
        Mon,  6 Nov 2023 10:21:10 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-42033328ad0so3764941cf.0;
        Mon, 06 Nov 2023 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294869; x=1699899669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQrzTgI4HfQNrka2FNCvIJjf2ADMLYsvYWHL3HxoBJw=;
        b=QUuvRMMTqsqH6Gr970kY6W0HsC4JY7KNk6+p8aUQCTuN1AAX+0T8nZka3i7SByM/p5
         s3KJ8XnUhJdZshCdSjXW9PpI+VMsG39ONTe3uIYC5suhIL2X5GBgCYDFXb3/fDl10XKN
         nWRBjka37syCwoP8GYlvTm/emoS5sO7NZrZFJUXt5S2ko0Ol4XiSpVZdg9zEfonqY37p
         AbhHIrXZifR8Ylgi5gcTnqakzvcL5hgjutT+gZms+kLHQQoaNswPbFOfIV8fg3qiMTi8
         JOOsIuLXsnniGEJIRxAR4MvUhpQCHcc5YCYX3rgwumfIuw6hXxsS4w5jlNG/JkTvAqn/
         PEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294869; x=1699899669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQrzTgI4HfQNrka2FNCvIJjf2ADMLYsvYWHL3HxoBJw=;
        b=MSPPrj9VQpgWGy/0vIRHVXcgWLJqcgRIsZbtxTns5U31NkUmKpOjU04qYUZS2bmQ9S
         J8Ooe3PIx9MRhHAh4PCGaVFks7YHdqQDUj2D5NMY8wMpVNQOK7Ps1hP4xOfokdoO/kvW
         UMIbytOpBYtThR2xfx8XAeD4A32A9btkD/BPiY+0ztumB5Yphe7eBV8x/PQwGscLL210
         TvwzVSrLnUSuU8CrOqNGdkYakPUTfeupFy3s/brkopgKAOckiicC2/lMG7FtT4WYhopW
         oIp8z69Uh+GJG8Z6W7tHM+5gLDmU9LBzfL+WEC/oHaREPPxYYAAHb6UsARqek9aTBAF/
         NMMQ==
X-Gm-Message-State: AOJu0YyZVzPIAmC2Q59cx1jqs8LFZ5CqnNu4wnbiqf0Fw6w4wC8hZAKu
        Vh6pZWW0mg0+Zt8NA8oO0DLJFhyJIdk=
X-Google-Smtp-Source: AGHT+IG45+mtC2eYMDM6QW7spOj49kaUMAWYaUWRTi1PQTc5vrEi17GCFup6TQj0zomNY52VNMB7Fw==
X-Received: by 2002:a05:622a:1447:b0:417:9646:8e2 with SMTP id v7-20020a05622a144700b00417964608e2mr37140262qtx.17.1699294869280;
        Mon, 06 Nov 2023 10:21:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z9-20020ac86b89000000b0041cb8947ed2sm3595786qts.26.2023.11.06.10.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 10:21:08 -0800 (PST)
Message-ID: <2d007bae-c958-4693-9467-ad0f20f68bb2@gmail.com>
Date:   Mon, 6 Nov 2023 10:21:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231106130257.903265688@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
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

On 11/6/23 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

