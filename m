Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9947EF7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjKQTf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjKQTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:35:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E600D4F;
        Fri, 17 Nov 2023 11:35:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso2189825b3a.1;
        Fri, 17 Nov 2023 11:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249751; x=1700854551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dZRK1FfwsE2ENsrOhX95EMeeGskbRwU3bk+UNV3kNdg=;
        b=A0Oqg9H6nndby8ZJdxb79D3tkduWL0wpXuA+dYlPtY3U7oman2KNwWqHcONQNgaiYO
         RjI21WmHIYAC8VYrbMhCU8e7R3tKKMiUtkAJzRPUyIgwLd3FMLdr/fVTjTLV3KA9g4s5
         qNCZ2tMfzZkh75JC3X6CD8IdomMYkoyXH7GKqs8aWwkgp8jSs/I2S7I/CTPrrijZ63av
         UJw6RP7/8fZ7wgScy5nsgvrhzuYZ4beYnTNsd1ssSbzuZ7WOSh5dXPmEsfQuY2x2QVS+
         prIEokwrbKijAJtGOJn67NY3KUOPFwGAJ4HKjHhtE7y4+E22R2n5eG1S4ZSjUfGjeiHA
         J2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249751; x=1700854551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZRK1FfwsE2ENsrOhX95EMeeGskbRwU3bk+UNV3kNdg=;
        b=jKNQUcBn3IMB5dYxyRaa4NRdvVUjwy5pzmrUacXTSkywTTwVLWziuYsWQszPBlM+GE
         a9fjvfaPZbuOc84EuxlELy/r7KK6rMGwczv1QHWQOZVDfJ8cJQox5bdQ2+cMN/dn94Vh
         8tlRD/hzy7tfXy92Yi70Tu83+rqp+0z/Ndztn/SGo/CEXKhGVL3xanudpV+QKH8lb+AO
         FsAwkLeyJ9f+AC1ttMz645H5A/z5GZzcEu4jqamzbmAWOPtWvlZ80/jBVzJ4pGwDvSYM
         3Oct62cUZnNE6/SEJ34ageega507Rw2oxruoexPYzSTW3SVXhmUEb/0jgW3IgwxrwciV
         c++Q==
X-Gm-Message-State: AOJu0Yy8kuDG/Lqdl121PyMZYGPOiYSHgnkINQ/n7hPnOgLokhenMlki
        TJTA4e7hYnutk+5zjYZFasCoDgFN6SKj83gkIEI=
X-Google-Smtp-Source: AGHT+IGNdFDzIdqjtmNoikmTPBIaCBLF2wsKTAAXbe641EHDgwT6fDW9TRc74V0eG80y4OaWMr3E+A/xV/2xOWJGqTQ=
X-Received: by 2002:a05:6a20:72a3:b0:189:2e8f:d357 with SMTP id
 o35-20020a056a2072a300b001892e8fd357mr97485pzk.49.1700249750688; Fri, 17 Nov
 2023 11:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20231115203548.387164783@linuxfoundation.org> <04d4d38c-9130-4749-9ef8-569528939147@roeck-us.net>
In-Reply-To: <04d4d38c-9130-4749-9ef8-569528939147@roeck-us.net>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Fri, 17 Nov 2023 11:35:39 -0800
Message-ID: <CAJq+SaAruya2P9R8Y9wJc15e8p93G51zjh6dZNq5JxzDNaipiA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/244] 5.15.139-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
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

> > This is the start of the stable review cycle for the 5.15.139 release.
> > There are 244 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 17 Nov 2023 20:34:45 +0000.
> > Anything received after that time might be too late.
> >
> Build results:
>         total: 160 pass: 158 fail: 2
> Failed builds:
>         i386:tools/perf
>         x86_64:tools/perf
> Qemu test results:
>         total: 509 pass: 509 fail: 0
>
> Sam perf build failure as reported by others. Note that I see the
> same problem in the v5.10.y release candidate.
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
