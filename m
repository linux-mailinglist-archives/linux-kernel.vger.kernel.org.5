Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FF7CB22C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjJPSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:18:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D676A7;
        Mon, 16 Oct 2023 11:18:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7742da399a2so345224385a.0;
        Mon, 16 Oct 2023 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697480329; x=1698085129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0+23Fn6CiP/g+dQfRG8xl52NF86Uz+lwAsDx297zss=;
        b=CtiEsDR7N4+qDFzsxRJu7Jvv/smp4dd00gb2xYwZQDGv9a4y6tsAKQDwtYOec9ItMM
         qfPAOEhXjIiqLGRcE5bUK1aPk/0GvBXdyz/vLmpziIdO0Kv1v0MSt/cYXkqsqnMUd/+U
         RDqO1vknOUM9eRth5dUZit5sFinmbc5b9VGovMuOdjeMcf6cOTZkfhJWFgm66Do6mamn
         LPxhhHXXLFrN62afgw4nqd3lXzoyGyshm/4DDgCjHdl9ywt8mNtjJ1dyZrAeSxeEXsF5
         aJlH9dcO1m/dt0A+j9o+wATcqRq/Fab1cKtAOoBvJ6Lp/h5ycsZ1V3OOHM9goOilJnVT
         /itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480329; x=1698085129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0+23Fn6CiP/g+dQfRG8xl52NF86Uz+lwAsDx297zss=;
        b=TLwsHR1yBOUa3vZv77J/LCU4i7RA5IQkIIAodaEhbiuQDkwZAwkif4Pvx0iabC7KXo
         gZL257wQSdUoFvP/AGLflrbHwzE0+IdPaXYrKhjIHrIjBtH9u8gUT+xc5Gk6latN8fCU
         eAhD9NgJXvXNnQW7v8VwVp7CFEWluexUziUH0hSqZxpljn3DJngyDULbyrYYCjj9K3rb
         DOhmV1wzaiumTez2KZJVvnHAqALXV4R1+e4pvhRJypKL/V5955rpTbKz+uB/KGWoMxXr
         Rk6Y2QvfVdKdwgHssZHebBVQUUa16d22K5oxZLuSENOLlwXdGecJyPM5d6PKyloxPnN/
         Ew3A==
X-Gm-Message-State: AOJu0YwBL/yahA2d9x59FI3t91/T9qJEsRZJPmV2lFBRZ1myBRf8YZXK
        gidkHxqDmA4Ah8h5c0ebRKg=
X-Google-Smtp-Source: AGHT+IGMWmgLTif/PBalpBzsVrrNEHY9Pqo2S9IsbzUv3tw52i2Vpylh3QS4xSmg+q0NbiuFzKRNqA==
X-Received: by 2002:a05:620a:1359:b0:76d:95bc:7aaa with SMTP id c25-20020a05620a135900b0076d95bc7aaamr33010257qkl.29.1697480329067;
        Mon, 16 Oct 2023 11:18:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dt52-20020a05620a47b400b00767721aebc0sm3202573qkb.32.2023.10.16.11.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:18:48 -0700 (PDT)
Message-ID: <bc778791-5923-471a-bca3-00320ac67428@gmail.com>
Date:   Mon, 16 Oct 2023 11:18:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231016084000.050926073@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
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

On 10/16/23 01:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
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

