Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8877D0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjHORK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjHORKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:10:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A505E52;
        Tue, 15 Aug 2023 10:10:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26b3f4d3372so1659527a91.3;
        Tue, 15 Aug 2023 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692119432; x=1692724232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EYdhrRPoIlIRXXfKbw9S5JsNJe2WJ2NJpGUUcBViuhI=;
        b=pwoCagXIfl96R/opXEAUP+dHFevGyhqCbQyZxHhbAafyWu9FNPMhw2OmjEv1t1pSiS
         U5zAQBWobW7IUu+DM+vrOhF6xvBCyZeAD58gV7gvJFGzLgW7AzuW4k50n/e/2+FIjL7c
         Fd77luBmH7XX8CWWvaq5cXGwYfn7df4suDfRqizKYKCHdXwLCPDj7vB72YpqNIikSRj6
         wK2jvuxsTKr1TTm3Bi95vaucLCv9MP65OrFqtkVAQXDzokPz4sDa1vqIsw5pNFgRQ4pX
         1pzR/B/cUmglWcZpeu1geHfHKU6gTCDFsL5jNfRRubVlX4bk4mXoUzVOiyd4i3Z+5vXO
         ssEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119432; x=1692724232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYdhrRPoIlIRXXfKbw9S5JsNJe2WJ2NJpGUUcBViuhI=;
        b=RAuPUE+YONWBDV7lADJ9dUv11NEeasowC1fgOs/QEMEt+WRgtwugGvCKhRoK87Op8Q
         xQiAQaufzok0ZIXR87eEOeoCDJZEkao82qU0AkWBmMDaxG/iPmZgNwfNt2gsrSVQF9gz
         5cWmzv4/7J1+dfuKfyTp6dIkjZ2isia9bfS7T+I2WdL/fE3Vbk5OeU89IPtCc/7KBc73
         kYMKFkS0R9dGrVB7n0aRHq+PqzRBAg2QrUU3310g9qjDmJrYww0fAWGAYa9/FV0mbSZR
         IVPBgmsRn5v2reWLZgycvw3J70kABCWi94zczkzDoq6jhWKKYu53rR58fCU/HSmZE1Zd
         BybA==
X-Gm-Message-State: AOJu0YzxsyGZMb51TJlJuyWTN7pCydhzKM5C4FjfvK1N4aLGY1/vAa/d
        Rn8Q62Gkl0MnlVXMPZGnZCjXwfo8tGHblNtJ8Ok=
X-Google-Smtp-Source: AGHT+IGTrk3U+CCTZUiSw2p6YVRkpLPMX29/XVJ7rrPu9jFuVljhf6uPuYVobOSrOt2Z6Kmi5RUQe+6AhGFQuK2qS0s=
X-Received: by 2002:a17:90b:8d1:b0:26b:4f2f:6da7 with SMTP id
 ds17-20020a17090b08d100b0026b4f2f6da7mr6086242pjb.1.1692119431831; Tue, 15
 Aug 2023 10:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230813211708.149630011@linuxfoundation.org>
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 15 Aug 2023 10:10:21 -0700
Message-ID: <CAJq+SaAgxAHE2S=w=R0OQvbNx269xgoUgvk+jNfqwvwqJF6qSQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/68] 5.10.191-rc1 review
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 5.10.191 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.191-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
