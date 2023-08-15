Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888A477D0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbjHORJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbjHORJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:09:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0E5E52;
        Tue, 15 Aug 2023 10:09:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-268299d5d9fso3049739a91.1;
        Tue, 15 Aug 2023 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692119381; x=1692724181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nJpr9HukY4Vg7bgiCdmvzVZeCkPZ6fB73+VNjgb982s=;
        b=aY2FP/mEr+BAK6pd6munt97XIiXhsVYgl3SLFtECzXyFH65Wvk/uo7RyO/MQE74N5H
         jR6Hq7IKi/mA1w+q+HwQus68PidMhFoFFzWBwLk/Mpth3qPaSik2nh2EAFtq6ZNeTuvR
         L7ZKOtln0M3BakkOftvjKCp2/Rgf/Lz3Wr0veQCPbrroGzQ972dqFvSdFLFEbqI3YsnK
         8b+pBAIBNbvX6JtdIK7NVm9g3MFYuFTnuWGCieyv0XKSUuVtQzAYlM3Xs/REDNsY7tyG
         03UadGgCC4BOnWBLyH1I4SmUPDYJY9aPhPtpTpQ7/RfxcfFNOnRxmn1la7itifEcNu71
         SPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119381; x=1692724181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJpr9HukY4Vg7bgiCdmvzVZeCkPZ6fB73+VNjgb982s=;
        b=ZBU//Jo8EU38llvkrDQPFE0wdfU4LyLXu6gnvWczm408Lw6qitYFas6W0a4JIDTC//
         gEmI55jVQK7EVc2dTZbHPTpSAc7rJLXjxeXan1XkYgxcfQp4vKa+EhInHjrB5dBFYQXN
         pGsopBEjPbiDcVxPXf99FPOnzfzWb7gQWdbh++ZKY+k/YyrsOnzAtmzfFARP5tWprTVo
         5ZPTroYrj+Yn+xfMq8G40EdZwGFRkLsbuideCuvouNv3d/XNIKrGrO5At5mhKGZAG7na
         HPs9qmZDZKsH6qfj4oD4uPAl/U54SBXv3ZhP9hC1GgT4sEJ+yRwal6dF0TM/DnpJhwzI
         nIAg==
X-Gm-Message-State: AOJu0Yxsx1tVQra7u/fSaFUC+CPuCPs10c6PsEorqrNT9yWnO/NKGUMm
        Tr1XxUWNT7FJl1i1KZxQ4mFZFaMvk1LyKwr2Xkw=
X-Google-Smtp-Source: AGHT+IFFbNOpjnmMRYNy6zDvhcYi9+4GH0eWnlghm4FvsSQH1DHu4kW6LZ5gcgP9zUG6aST98l8HpklnPw17kZqsU/U=
X-Received: by 2002:a17:90a:4e47:b0:268:3b8b:140d with SMTP id
 t7-20020a17090a4e4700b002683b8b140dmr8401087pjl.35.1692119380767; Tue, 15 Aug
 2023 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230813211718.757428827@linuxfoundation.org>
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 15 Aug 2023 10:09:30 -0700
Message-ID: <CAJq+SaBSKRgH9Ddt174vdPgOJwY2fDKibGu804VPZ4J_WjPhSA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
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
