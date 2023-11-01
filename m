Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E767DE633
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjKASxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKASxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:53:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05EC1;
        Wed,  1 Nov 2023 11:53:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso171308a91.0;
        Wed, 01 Nov 2023 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698864788; x=1699469588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yW8TpNJSIE1qWH0YiVY3Z38EwIsy1hXM3CPZpRjT/DU=;
        b=dZ//aqwbvHZ1lWd0Wu1eb03uovyhhu7B1uljTertzmIh8K6g28Zezp4OJ8v9KrvGlT
         ZlmyrfpqSxvPRntmGqtkMu+kkaHFYpf3BSisFeVZEqsCzg51RS6j08meJ+ZHMlHOmexr
         hf7xEsqCo178cy5y2BceZiFqspn5xw5+X0vmNk3wQ4oeY7suMcR3m7kRfOi/eBFa+sLj
         oci/ZFFi5RTLLRICKRQysOfYWpWefSDSqwGa0MQelCH0KJHGcWatoOVJZ2tY9wwkYCKJ
         8AMI/uo02q9s0OZzaurFwBLn46zgEudquiR1hsFFmsXgZEBkEfcGB3yOvqE9H3K1qRjD
         nXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698864788; x=1699469588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yW8TpNJSIE1qWH0YiVY3Z38EwIsy1hXM3CPZpRjT/DU=;
        b=ArbYRqsJlSU/kmXkTrXH+AGD+fpKnpSjDI3d6lhXoNEAxwKkRkHZta8s4yO+eRl4ui
         75p1h06DbZK2lhpN9rWEqZhTTOMde793Zy3pN2mU8kU8Q9L9GDqrHtPqFby0PQQmVsE8
         wfYjS4bhgf0CDoB9jNOQfCXJ0JxVvrszJIuz1bH+lgiyRKgRflCfQBSqVfkEGzFFeFY2
         Bd72SVALfMUSJkJQG6b3LCxs7NLuwFzh8X4l4qHa3tAK6J321oSl/e07Vv2PA3lPH9YF
         T8w7+2FELyEkDqCkloieKs+gmuOH+ho9IF+WD5DSFM9krFie2J4QSbFqPimMxBSjfmBj
         V0ZQ==
X-Gm-Message-State: AOJu0Yy8LlH0EDbyxZy0n+C+OnRiav9DExf3CGkLKNaPrwdFEXNoMxoO
        T84Mtd2PcHu58nt+2mopMUea4VU4Hl1KL2TXuf8=
X-Google-Smtp-Source: AGHT+IHFXl0fP2VY4xSOBs/SAJIh9S88OfmR+A44VnFN2JhiZYKbQhDSPfkHSgyjGqx3Dpbu8DcYwy3C43465SoUQwQ=
X-Received: by 2002:a17:90a:de84:b0:280:18e8:6d4f with SMTP id
 n4-20020a17090ade8400b0028018e86d4fmr13764565pjv.12.1698864787756; Wed, 01
 Nov 2023 11:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231101120147.190909952@linuxfoundation.org>
In-Reply-To: <20231101120147.190909952@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 1 Nov 2023 11:52:56 -0700
Message-ID: <CAJq+SaBmNdJ0jh0G4auPuFBdo-Essv93b0zfjFsR-bdv5m9HYw@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/111] 6.5.10-rc2 review
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

> This is the start of the stable review cycle for the 6.5.10 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 03 Nov 2023 12:01:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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
