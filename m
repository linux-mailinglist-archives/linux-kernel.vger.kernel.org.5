Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E66805BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbjLEPyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbjLEPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:54:05 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236BC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:54:11 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db537948ea0so4127794276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701791651; x=1702396451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpCZZN7ifzLhrwAYxkGqYDBB1FuZ2YnYQt+7H4zDU+Q=;
        b=ZjZ2Ra2m9jCfp3zsDGaiueJ0GfvHiEPOHTWwRqGZ8tpVqnnWAuhjaJ2MxBVazJYwo+
         AvqN3VKfF/m7dzicuf1H1AYbzhYSWM1LLAr2/AEYMoTlhtrVy0rtsv59pRNu+WirrgfW
         t5Z6tUNjbsR6HEKGvk50G70sW/U+XJUT8hPTEPmdECqUXHa0F6CLEW0/P36hxi8zyWaI
         aLVJfaSSm0lGJvzbDnn7ujPsWQQIL6E8N3pmut+fQyuccoJLvyzht/wlD6Di7PvEyBgo
         qZiJRkgkul5MtSSx4Cdv0OrvQGdUKA89Px7RGKQcmcR7Z/ALRcTd/wnyUNV03y69/tS8
         4+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791651; x=1702396451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpCZZN7ifzLhrwAYxkGqYDBB1FuZ2YnYQt+7H4zDU+Q=;
        b=JgX7RmbuLWBdy8XTAgcFnwU8Fd2aeoZY0bL46mH0kqzAXLwQW4DZiJDR6HU31e5tRX
         7Pweh3ABjBIfPvQLK3M8vqpBEyJPqQbIS12NR4RkmQzuKnZYaZv+Y7kwugmmCZAV7G1w
         gLKo1rhXPmS+s6FcVpJ8TKl9e274vdw35rrF++wJZ8d9xrKp/bxjjIV2XajUIICMwI8C
         ChvxjGc/ZWSkjtiyqV1zzM9oJXiTI5oIgry11CsEGZ6nOD0d1m7f1YEhbqgBCVbv7xDS
         AdrMpVoj9+gmYxvdkJm3pqbRmyM4gUhXkPjKMtkqtzVctzjqk7tQ0iRQSaX3gZzJJ8dg
         1HIQ==
X-Gm-Message-State: AOJu0YxICVsiCFCrNgmfxLZWDkO8KDzNazix0end6W4OrDLQ4cAwsVeT
        bLTr757rOON5fcqB5WG8vfit7wc306603P59SyAxGQ==
X-Google-Smtp-Source: AGHT+IGCJb6NJTexBLiNBzgMwl8doc7Qk7WTAXljr3GKe9KFhu9oJQpIiiYrofNfQQq+O9e/tLSF6yqkhku8Pwwo5cc=
X-Received: by 2002:a25:b293:0:b0:db7:dacf:59fc with SMTP id
 k19-20020a25b293000000b00db7dacf59fcmr4225994ybj.112.1701791650893; Tue, 05
 Dec 2023 07:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20231205031535.163661217@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Dec 2023 21:23:59 +0530
Message-ID: <CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_ZUOhF9QRiOg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 at 08:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The x86 allmodconfig with gcc-8 failed but passed with gcc-13.

x86_64: gcc-8-allmodconfig: FAILED
x86_64: gcc-13-allmodconfig: PASS

Build error:
------------
In function 'nl80211_set_cqm_rssi.isra.44',
    inlined from 'nl80211_set_cqm' at net/wireless/nl80211.c:12994:10:
include/linux/fortify-string.h:57:29: error: '__builtin_memcpy'
pointer overflow between offset 36 and size [-1, 9223372036854775807]
[-Werror=array-bounds]
 #define __underlying_memcpy __builtin_memcpy
                             ^
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Suspecting commit:
-------------
wifi: cfg80211: fix CQM for non-range use
commit 7e7efdda6adb385fbdfd6f819d76bc68c923c394 upstream.


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4-135-gb0b05ccdd77d/testrun/21509070/suite/build/test/gcc-8-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4-135-gb0b05ccdd77d/testrun/21509070/suite/build/test/gcc-8-allmodconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4-135-gb0b05ccdd77d/testrun/21509070/suite/build/test/gcc-8-allmodconfig/details/


--
Linaro LKFT
https://lkft.linaro.org
