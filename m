Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727E07FBB64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbjK1NZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344830AbjK1NZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:25:09 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55B90;
        Tue, 28 Nov 2023 05:25:16 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4ac0d137835so1744985e0c.2;
        Tue, 28 Nov 2023 05:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701177915; x=1701782715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZrP9a46FvVK83LWUKH5z9MFb7/rqu3GX5jpGe7sb8o=;
        b=F+y1RWDyTheJCTcsnzralxkQY/y8Q7uSuL4CicPW4ETaDCnNoGtg6I7ExwzLy0TTP4
         HV0YjVKVxU3BLxTNMo/Xa/zUaeeIaDDqFVZ+lFjJP8z2XefwtirCDcXzRxXUUWinH8w4
         3G8kooOa93aNZn3tn9ZzGThfdxBpgRAe9S//Fyro/cJw/OBzlAHZJ3qPRs+4equ3AYx9
         3Ep70wPUH7todSAbC3CMK5rXgPHdnz0TkKoqMcYwuJQ4RWO3bzRwMt94t7PCRA7rbe0w
         122m4MFIauGQ7asq0p0t0A0wrQvYhk7jhFkkqgGu55jjhx1tngt/SNTBntRXkCg1rgvz
         ZJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177915; x=1701782715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZrP9a46FvVK83LWUKH5z9MFb7/rqu3GX5jpGe7sb8o=;
        b=OSHQwEODPfBHvZVhalJE692IDzJbpQ0ffs7GH9Of6cH2wSxDx5F0xpgvLZh7kiMdSA
         hoHbjOJYW4I+EqabTU7wGrZ3Yg83X9o+ygGTmroR7Hqi/kccACMT4mEHOPfX5mN12n2m
         kQCF1/s2MvPY0bibIcjAUxQc/3bKOxOPov9weqvtOi7LZNcGKy3gu/K0/PjzOxbHEDOL
         LJnthzPwAP574jTj3c/D4akE/dhAELwv/1CoFOVNM93d9ZjXaXkbn8dv4Fr2Dk8kFDW5
         IiPe6bMdwyaSJizO/nJkv/PAD195ZPJ2wSng0SGcgl8aiUKREk2vwhtiGeyupgPLssS5
         qvKA==
X-Gm-Message-State: AOJu0YxYPJIDUaN+U/NWOEuCxu2ZHpBHxwv8lywLi/s96+y3iF8zELA+
        0p+ivEueYlwnYfMyGTZAqJta4PMwpYiPLcD2F7U=
X-Google-Smtp-Source: AGHT+IGfF5ufbqwsLkM7y/tE9HdjIvjY0fJ1ryH/bxiCfeHLeH6bnf/4/F7mDu7k06N+J0PK6TetzL1xv38Qkya7qfg=
X-Received: by 2002:a1f:4ac2:0:b0:495:febd:9187 with SMTP id
 x185-20020a1f4ac2000000b00495febd9187mr12281525vka.0.1701177915131; Tue, 28
 Nov 2023 05:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20231126154359.953633996@linuxfoundation.org>
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 28 Nov 2023 05:25:03 -0800
Message-ID: <CAOMdWSKic3ZvWRsTW4Lo5WWLtS-RFNH0cKKth-WbzZw_5rZM+Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
