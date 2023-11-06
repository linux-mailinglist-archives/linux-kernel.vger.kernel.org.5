Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31237E2CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjKFTOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjKFTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:14:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D895DA2;
        Mon,  6 Nov 2023 11:14:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so4412590a91.0;
        Mon, 06 Nov 2023 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699298086; x=1699902886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjfMvuwNwCbN01EOU/kgUhQ5Db+LEXDJHgnY99KXI80=;
        b=AAJdc8tUzIQXURjBL5DL2ltgsUNg9UoNQ6uqWhTzUTdJ5igKuATDaRkQwLamSKM69L
         za4LOJyXsOHyRhKH2m/953sibjr5S8rkyGktMmWrPyFdva0KUQlzIXdq18jyaKidjhii
         aSTKIdS6xw649n4JVRi3FW33eAKKtsGpRC1HxOlZiTTK5S57oI//0Q5D4iVbcfgnJplZ
         4mnvgLjZXeBoiq9z3I7FP31Y7tkovhhBJobknbf9lJPz6nknz9wsg6FBamKTqEitSVYd
         KlgjlH9iv4OoUeuf1Ml9/UUW3Es/MU+PKJ+WWcp3H6bTuMGhsdB7+rEhbv+YZ2OPwE+F
         qoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298086; x=1699902886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjfMvuwNwCbN01EOU/kgUhQ5Db+LEXDJHgnY99KXI80=;
        b=dlMWzBI7epTGtsQVeWLLdAxnnasm31t0pfwM1g4oHSMCexwkbR+SZJh1JyLxfNwOj2
         dw6MVOSOaYiziq4ddMyRC7thd/OaIPkn+1V2n63oZl1z2Mlw9FlYX3pxRsaYhOB5BnZw
         dk/F9+zAFXaH5aWBBPAuKVumhNIVd0GlkIiy0tI2qJhpFUWLAW3Ra5ebuXEnDJadWAaj
         iqrq1sAHthqtgzVQ5Uw0WGUqDrDvhHau6C2ciLu0t9+zKPB9r2b/2BiJArlkmL2ONIO3
         REeJp0j37a+D2NgGmeP8Nn8SgNeuOxHMraZjFYWh1JYnjI88CGo7LLqx3+3pU5z9k4Lf
         iRZQ==
X-Gm-Message-State: AOJu0YyImB38umAXoAtoWwvJGg2mijGuyb5PB7Xz6YkZ11J82j1mglGG
        9GGtsnCnIMNgL1DVj172F7+Nd0pf2MnnGeq3JaY=
X-Google-Smtp-Source: AGHT+IG0wwbQtoWmqA5Czskad87T0bV50UldJpeLWxZVbB58I+00z0I6QkKffEoj1MNniHfiFo2sdc/rE0gjIs7KsJc=
X-Received: by 2002:a17:90a:cb8e:b0:280:29d0:2c6e with SMTP id
 a14-20020a17090acb8e00b0028029d02c6emr23351427pju.11.1699298086269; Mon, 06
 Nov 2023 11:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20231106130301.807965064@linuxfoundation.org>
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 6 Nov 2023 11:14:35 -0800
Message-ID: <CAJq+SaAh97zV4xwgxVbKqYZY4ZL7qnBufYzMBnjRehWn13iT6A@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
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

> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.62-rc1.gz
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

Thanks,
Allen
