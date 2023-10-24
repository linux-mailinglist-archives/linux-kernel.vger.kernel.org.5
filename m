Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5247D5754
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbjJXQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbjJXQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:04:55 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA3B0;
        Tue, 24 Oct 2023 09:04:53 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7788fb06997so320377685a.0;
        Tue, 24 Oct 2023 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698163492; x=1698768292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ig+7+uPCUCps59Bni0g2YN72fr9TY5plHFKORuybG5Q=;
        b=ioN0H65V0Oxa7BtpouZiCYXdEe3GB6O4qaSis5Ezpq73BR5ivkAlwcBDQNW6jOgh5r
         1D+Xfz2HtkfYg96x/m4Y9+FrWKITRp9YAZfrgaM+ZrWHf/JRBoFxDqVMaFSoZ8En/0gd
         kfjZ/Lk9W2BRB7VSuXGUAVTFiCi9dOMVHzUMIgGu6ijJ5/toWwQ4avEjGRs/GhzS84hf
         OJAYNHDJNt91t7ZEDlhbqBJhH8MeRSoF5/xc6SVS+gWigwlfP7MiscT5BHqaelAShKdX
         9bIWXkUPnDfszhp+t4akWviLEU0am2QxEJh6TQWyyKhW3CAEq9pb43+gO4AQ8w/gIDGP
         SeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163492; x=1698768292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ig+7+uPCUCps59Bni0g2YN72fr9TY5plHFKORuybG5Q=;
        b=Icaz0+8neGaDDYkSlxxbhQJNrstQWEooH1YjfRRAHi6UU8rD/17eKvzNws2a8mH2hp
         gkbgQFdhvcSiNV/RvNb5t1SgshDqiYmuEv+EfEmx1SttIWHUNuAPTuifHtTvVIzA7p6I
         aq39O2LRYlzjYGzdXQsdGPTL/GV5w+o1C6Wnj7xU2BPQFnH69uW9ilPChs1pLoQMjF5z
         BYYLijnvbVnfuFc59hfeRq7DJfLVKW1G4OYhcPkBkHQxNQcfzfJ3XLbRcbhhAn/tlOrY
         MjwHAtgF/HTRQOfxsMG2d9QhcmukTFCduYf7FN4Z5wA5J+2sabunGXYP1WbpLvoPQfFJ
         ao8g==
X-Gm-Message-State: AOJu0YyVk6aQEhqUF7ScLNadLzky+R7vbfv1Y2vgGoot2TPLsU/VxmUf
        ipZukzEqOxTP+tzCuKT4uNk=
X-Google-Smtp-Source: AGHT+IHD9IORUj+giaVfWJ3qnW9pjv2yoTszCb5asRsFB8qN4e+DsALNO3sH3Av3/40jsW6toIqX2Q==
X-Received: by 2002:a05:620a:4248:b0:775:69b4:b4e6 with SMTP id w8-20020a05620a424800b0077569b4b4e6mr12523329qko.7.1698163492282;
        Tue, 24 Oct 2023 09:04:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y9-20020a37e309000000b007788dac6b24sm3543683qki.41.2023.10.24.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:04:51 -0700 (PDT)
Message-ID: <c14c7f3c-ddc1-401b-9866-9d07a1b1ad00@gmail.com>
Date:   Tue, 24 Oct 2023 09:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231024083327.980887231@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
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

On 10/24/23 01:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc2.gz
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

