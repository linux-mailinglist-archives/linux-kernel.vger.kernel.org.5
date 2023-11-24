Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4427F8340
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjKXTPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKXTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:15:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138BB2683
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:15:35 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d7e51638e7so1317490a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700853334; x=1701458134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2MveOECZmWaMqUFClvcSgbtbFksGGBQJiQIt0r94rRA=;
        b=n9iPvhPgK9Rn3gKO+coiKQfmFKFeUwyYz7vlEoAO0v7qiKsoGJcdQM+5p9DhhzuPf8
         JBldxG8+5HTZvbJrydcl20vB8Eo5XcBy/SPvtOKfPoxAZpGVR/9Oni6R8dKhoiAxrmjY
         kiL/Xf0tA4tPvnRoqREuUx0NPRzAWWyCYjhalHWWdvoshhi0g1xEcexTvYgPvBhyMBvT
         8QwIDM6GW5xGRi1/IH5BLTSpDv2Es4UCX4G9KPLvcXyplUCSLYuj2MZULeLtQnaS7+dw
         3z2HIEnsM5rGlrscP05g5Fz2JBYn9InRmW2GUbs8rr/jkfycR5drodBTdLimsyS2hNg9
         Lr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853334; x=1701458134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MveOECZmWaMqUFClvcSgbtbFksGGBQJiQIt0r94rRA=;
        b=KBQiG/yjC4C11B96PZdFz06tlmKHuM+Ne5n+7vn1+wS8nN/6ClmTjyqqjrb9hDLZl3
         aKM29pVJTb2I4HTfRLNCb4IAt6G+BE6v7Pjurz/zdAy/etVZ44b50Z8kVONgNupmPDlX
         3RtWfgzs80elBi9+83lRoJ+VgPFxy3Jh1CmVxYg2c1Lpz9W+6fkSQCDoLmymgSwKFVlO
         Xpk9aqdaDheTE15JJL+1QckyqqWQLYRmctLoUDINZReFUnsm765dyOKTT5cXf4sApnZD
         Hdph8XkLAJISTgjO16GEc37OpeomQezMaiBP3RI+OgopSN5wXZ4hqCs8eXdW45D+/8mb
         JOjg==
X-Gm-Message-State: AOJu0Yx/MczYMZU/2lye5DaK+ay3LfxwAy+yKZZUqtyIXAfRDXKn8qoB
        5B4cBk0/QzyIzzFRK4Twmd4+5YpYR2A29+V0xNq0Dqs+0PId1H5+2dg=
X-Google-Smtp-Source: AGHT+IEnWmBT7sz0OtChNm7SYIKXzLwrJzaYutL5Cr4YoEx+Z9lPQzssPXUErmDHSGOelffPe1qHLBX232hzer90JT4=
X-Received: by 2002:a05:6358:e48b:b0:16d:bc40:3055 with SMTP id
 by11-20020a056358e48b00b0016dbc403055mr4793780rwb.19.1700853334076; Fri, 24
 Nov 2023 11:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20231124172024.664207345@linuxfoundation.org>
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 25 Nov 2023 00:45:22 +0530
Message-ID: <CA+G9fYt27vXw5po2gtEqi8=hJSR7Ge3+XAS+fAHt4MiHbEXfpQ@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/491] 6.5.13-rc1 review
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 23:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 491 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build warnings / errors noticed while building the
arm64 tinyconfig on stable-rc linux-6.1.y, linux-6.5.y and linux-6.6.y.

> Zhen Lei <thunder.leizhen@huawei.com>
>     rcu: Dump memory object info if callback function is invalid

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:

In file included from kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Links,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YdNC69sBYUq3cp4iEDo4eom9RD/

--
Linaro LKFT
https://lkft.linaro.org
