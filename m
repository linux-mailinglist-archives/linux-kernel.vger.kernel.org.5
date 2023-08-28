Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7D78B977
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjH1UVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjH1UVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:21:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77470C6;
        Mon, 28 Aug 2023 13:21:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so4776430a12.3;
        Mon, 28 Aug 2023 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693254076; x=1693858876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc3NgivyQsNp139dnzU1Tq6KsBPY/blZ0MW8AaIyHdI=;
        b=a36ExcYh3cINJVw7FO7PTE5k+34T3v54nv9nEiSP6KPRxc8EyteS7cT0sC6u7pFQXA
         fJuaaWJeJHHBtIvYpbJCJhug8/xjMInEVW+qHSGqak5Mx0QnrjRVKcE7Q8/xZ4jebBdN
         1eSvacqVfyieX/3WFWoYn/OgnfXzuDDOyMeJ8CfVEg4DY3ISU9hlZm9LbY77kgIp164+
         KvSJB4rAE9AyqktGlcThsUnUF0olkpFIRVGYo2AnxWls4P+AaGfY3P9ogU5FlsdtS+dN
         f9i3Zjz45qHwXgrEBUimI/ujf/BPx1avYKoLl1Zl9U/bg+sGDGQEVBWA3pOwjsVGmUV0
         gDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254076; x=1693858876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hc3NgivyQsNp139dnzU1Tq6KsBPY/blZ0MW8AaIyHdI=;
        b=UBQJOG2RyRYLnwfFHcrjHqfLwDQ6Dg8bOKmCVW4Sr/Bp+t1Wu0oCvKC1PgAL7I4Y0M
         tIfpV/yqPsyzx28GMfrRFLPVerinOMXaGJyADtAMY3HhzIDvhc8E8RKt1MZm3ZzFu0fd
         TFfv8MlCgC8tPuIHRr06Nvv4XKw1JTVDpgqIJrJz2zrca6xE8MVkuQ5nPuBNsX5usXcC
         02f0WUE+QABhMOLmWQEN1vUdOrH5A5IwAjdyjYF3HBu/OkKVr5EXIJKtLLRmfe8NK4Fy
         AuFfJSqgeghz2cnQn/fqsddTqlxWb4DuaGzC6TCVE6BNUbokrXAbYTkSaMldvOxlOlpi
         I1NA==
X-Gm-Message-State: AOJu0YxGyiulKB6UR6XZDMX4L90vhADzCker0IcDpKGaDjWqriG1Qxio
        lC5tXCqDqpv9cwiNprZFtFzASP2PzPuo9ji707zb+aacXTU=
X-Google-Smtp-Source: AGHT+IFn+47C20K8dPd+yjlD80JxrQ5hMIJHXTsryw2H1fQNtUVqb+t3VP1mCtSZ/4OQy0srRxA98tGIacUVrH20iiQ=
X-Received: by 2002:a17:907:75c5:b0:9a2:1e14:86bd with SMTP id
 jl5-20020a17090775c500b009a21e1486bdmr9223634ejc.65.1693254075713; Mon, 28
 Aug 2023 13:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101153.030066927@linuxfoundation.org>
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 28 Aug 2023 21:20:39 +0100
Message-ID: <CADVatmPpi8pLT=MKNuPjkTP5pLHPnCKu2v2Ms98YhzXUhAvyyA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
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

Hi Greg,

On Mon, 28 Aug 2023 at 11:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.293 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Just an initial report.

mips builds are failing with the error:
arch/mips/alchemy/common/dbdma.c:33:10: fatal error:
linux/dma-map-ops.h: No such file or directory
33 | #include <linux/dma-map-ops.h> /* for dma_default_coherent */
| ^~~~~~~~~~~~~~~~~~~~~

arm build has failed with:
arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h: No
such file or directory
12 | #include "platform.h"
| ^~~~~~~~~~~~


-- 
Regards
Sudip
