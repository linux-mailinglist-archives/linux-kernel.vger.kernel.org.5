Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393477D0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjHORIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbjHORH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:07:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486C219B4;
        Tue, 15 Aug 2023 10:07:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26b0b4a7ccbso3040084a91.2;
        Tue, 15 Aug 2023 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692119276; x=1692724076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfnBPQmR5aKREIriV/5IUmnU6LBPlzSZxgIT4j/hHjY=;
        b=g1o+GBOmqgdPyGBdCrc4qUhlPgRGJy5a49DnyQByaEtsFFeSA/55HbCEWVCMXZ5Bo/
         xWETpO+2e/nWDuVv2yRhTC49zjLIvvPHe0xVquBbH7CH5FRbJ0y/duopQ7z2mh4Cfl0W
         2fG4k/IDyBk9kjmmu85L5viegl/46BgvM7n1tMFNawIx1MbNcRg4KDjpq1uAXdZgqfTR
         z8y0uacEkPKVLpfrRhvvYBluyya6U2annLUZu70u8j9+iw066oSFl3KqNJnyXZKpDVKr
         2A38zXfwmRuAT+pZYlLgL0SwXlpfLmrmZVjWkDLUQ4co2O48W0lHgH83xBAAh5gO/AY1
         zzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119276; x=1692724076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfnBPQmR5aKREIriV/5IUmnU6LBPlzSZxgIT4j/hHjY=;
        b=VSoskYIxAOJ64YqXxkD4JIRN6L9bh2FhOapF7VCaQy/7U9Jln7PpM/CQpgIB36lkvr
         8Yt472v/X20eckO2lBoVmmOZ5sLxCkt/JBKvoKE4ZXuqMynuuCx9aIMjvLYa5N+kU9OP
         /wJLAnbcv1ro/cehevSdMtf6BqVA1z7CEXWrbWggBH9StYz4kBUFLSB4ki3EvlMhGmFb
         ddxF4Mvj28O84rLi6NE4wU78q/0MYWDrz0Za5PqMWi9i/u8+Zi/frzLuPABz8bd1S6Uy
         TEkSvttCN3vtcfuFPJEOaoMKYX/bcLffzd7OQcIHNurqvtXOaIeTP1hQ8Li78tP1ki2r
         S9+Q==
X-Gm-Message-State: AOJu0Yxoghvv0rzedixB5EVtxiPWaBZTYPmlE/yI7rbKAyB2Y3rmp5GC
        u512+KcN+ZpQ5N/qAV6fVgybs4WlMDyROMdFNhI=
X-Google-Smtp-Source: AGHT+IHbZrHeipVo2piqPvyBgSPpQA68tJvSvWC79m9yJlxEIGYRdt46+9nXHa45IhR9nYBoQxcxdmEleaN9Qgt03no=
X-Received: by 2002:a17:90a:69a1:b0:268:2c60:9969 with SMTP id
 s30-20020a17090a69a100b002682c609969mr9886712pjj.47.1692119275603; Tue, 15
 Aug 2023 10:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230813211710.787645394@linuxfoundation.org>
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 15 Aug 2023 10:07:44 -0700
Message-ID: <CAJq+SaCcK5iPN4+Ow+aMz=f5BGQkLbo7zfkLsoaLsCergLHMcg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
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

> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
