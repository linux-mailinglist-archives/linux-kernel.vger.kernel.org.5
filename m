Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0218D7D5939
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjJXQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjJXQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:58:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92788111;
        Tue, 24 Oct 2023 09:58:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so3716352a91.2;
        Tue, 24 Oct 2023 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698166736; x=1698771536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XApgLgJkwGLPznBBV7b3yGWrUWswEGv1qYPFUqVGFAg=;
        b=NoJO8atdeqnvz250RsKpsxgQxFsPFJof39AejiAvl/lBvwetYdhZHgOyxiHm9oU1oy
         y1CYyw4uGZB10MCuPPi4QllgwSgx3KDSUOsugC6zMtUCGlaCdfFjmXxBCcdmbEZa4/Yx
         YffGla3Rt4rMpbvs8EHkpjCKaZwYba0xFJqTUSbgQY46SmPN7lWj640Dc8sCGivKJ1u/
         rUnvAz1xSulDEd/HFkq6WZrljmrLKa2AFP2+4LFY1EaYht40Ye4f2g/d4bESnr8Hcztd
         k66xue7Bxs2Z8q+hJ5ovFslzNgojQYzVo2eqYwXGwwwMuNZ3oucxlcxIjECbjP3MpU/q
         xMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166736; x=1698771536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XApgLgJkwGLPznBBV7b3yGWrUWswEGv1qYPFUqVGFAg=;
        b=eRCCLULu1+lrlsszYpyaxEEcGU15EPG+h6q0BVuu98Vo4U7NJbvaPT92aUvfC+rX4h
         TrBcGSKoH+YeJiHbKlEjq9w8Xo5SWgy3MIqkaI9CgiAMwUnCVGUaRbNDp3v/crFjPHGj
         t606wmg1Sh2I2+Z0Vwh5eQEft/kODADpb8BsbrPEUqqT/mD2wFooA/MouH6TgHbJAvTB
         IVTUmXsTNIvo9laqft+Muvg57n0LX3IugNm0i2QcgLocMq6cbLMOG3F3PXqt89Rd+nQX
         hfSsAD6FwjAQPRenzrcqYKtswDuPqHDGAN5LiA4KvVSQLU6EXKCCEboqz85yyqJkdYFt
         B5Bw==
X-Gm-Message-State: AOJu0YyafnzQ9XbKCP9wOa8ykd52GsdveyvgcxXgqhvNpBa49fj8KLjr
        iqYdyiHz/NmjFAaBHxY6i6iqVK23fjocsnew3TM=
X-Google-Smtp-Source: AGHT+IGsqbSps0S/wo9bl6IMVr8qLMKUtaWRXnIEe8XcmwJnkZE4f4agHLIfKvZM/QQ9XcCZUPz1Go+o6cSBsnTGz8U=
X-Received: by 2002:a17:90a:17c4:b0:27d:3c75:db02 with SMTP id
 q62-20020a17090a17c400b0027d3c75db02mr12601390pja.32.1698166735988; Tue, 24
 Oct 2023 09:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231024083327.980887231@linuxfoundation.org>
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 24 Oct 2023 09:58:44 -0700
Message-ID: <CAJq+SaAYiA31Yue0oet10rBVgxbJxHyD1KuYZw8-w4segj8iGw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
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

> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc2.gz
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
