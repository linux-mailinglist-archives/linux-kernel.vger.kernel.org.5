Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C747B8DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbjJDUU2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbjJDUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:19:52 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC1CE;
        Wed,  4 Oct 2023 13:19:48 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6934202b8bdso179551b3a.1;
        Wed, 04 Oct 2023 13:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450788; x=1697055588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v3t9u9xgvHxweeBD/U81J25d0Zdsy2WU/FAEhA0NzQ=;
        b=iG9ridj3cBRo69E2JYZ8ThfXLoNpcwXYUJ+no9Dp7ZqM1b0IE7Rac0VPeShZifD2U6
         3VGc8WvnehFMCpxNqTmGcHkpOTEZ3aQPaK0DJH6ehbYOvBmY0EIoY43IT/Z68/4w1740
         y4Qi5UAcRIT69LJ8CtvKkPt+n+PiZvDJeTNXSfAmhwFZBiC1ItUJmNrRY1mbzGH9vQGd
         k5RjEjAsA2+MXIzur5wM29WNnTaxgX1+b/WItdgG32vffQDgTdOiE9yQb/Bu8SAmo2w9
         6urR2QWdRU7e565wlRd1PKmyNgNNrbYswEw3wgYJ3ifo9ZOEWT9XHswwA+TjuKLYbafn
         X9NQ==
X-Gm-Message-State: AOJu0YzXEjGHqJFO145JoLeM66aBraDKgiF/4cMJmJBAQ4zdEVsnwbmq
        0nrHHCFtXbj6gSTKOaLZrfUzMahbGgBeX15y3n0=
X-Google-Smtp-Source: AGHT+IGPv8onFbtjmjOREUljXHQuutqUtArE0vQV6pGiJVksloGH7rtiiM1slP9BD4ouPRf6YY58b/SxfW9v+Hu4h5E=
X-Received: by 2002:a17:90b:4a91:b0:274:729c:e4f with SMTP id
 lp17-20020a17090b4a9100b00274729c0e4fmr3233005pjb.15.1696450788288; Wed, 04
 Oct 2023 13:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org> <f0115175-975e-4fde-aa69-666568ce5c6a@gmail.com>
In-Reply-To: <f0115175-975e-4fde-aa69-666568ce5c6a@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 4 Oct 2023 13:19:36 -0700
Message-ID: <CAM9d7chUnxjPdOwZZ0imYs+i8+dd9GL=O3gqJXzaRd1VGZJxBg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 4, 2023 at 12:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> +Namhyung, Ian,
>
> On 10/4/23 10:52, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.56 release.
> > There are 259 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> perf fails to build with:
>
> fixdep: error opening depfile:
> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d:
> No such file or directory
> make[5]: *** [pmu-events/Build:33:
> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events.o]
> Error 2
> make[4]: *** [Makefile.perf:672:
> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o]
> Error 2
> make[3]: *** [Makefile.perf:240: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
> make[1]: *** [package/pkg-generic.mk:294:
> /local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built]
> Error 2
> make: *** [Makefile:27: _all] Error 2
>
> due a80fd00cb1a7793ead4d7c3fa7d3f1e898231c27 ("perf build: Update build
> rule for generated files"). Reverting that commit fixes the build for me
> and then all is good in terms of testing.

I think it's ok to drop the patches if it's not applied
cleanly.

Thanks,
Namhyung
