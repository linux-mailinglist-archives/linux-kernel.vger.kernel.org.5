Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265BB7C5208
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346208AbjJKL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjJKL1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:27:50 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ECEAF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:27:47 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c011e113so21840217b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697023667; x=1697628467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UevqGNo+2n91bIPy1ar4mH+fg23SQp0KUlq9TRtpdE8=;
        b=PHlQdto5NJTN2MK7DS1O/pvATtYGYcBm/oUzuj/Lqo5X2fDwZeC2mUW1srmNvSLvhh
         4rJLVp+GoIxo+Y7KWc45fzFO0OSbGkQkcYsit1FDHtdScrKVoq6mIuAw3gaydQ/sxsm5
         iJwZJMfuAFPA4mKHkfb+Ftr+IgMkZRelXLh1XVlwDd/2fGiQwm3HMgRJHbtcCtLdJE/3
         BrP5bfWKBXw0fBsVin8Ri63beHKPs1tpNg1BOXlFp1Dxo2xMUqAAIPg6pNfkRc2HlXoj
         3kKCxz/1+HfMwlbj74nnT6CV1D+tanUMjja0ICCDt8E4j+AMdYSDzr6k8g/Vy1MHq86i
         VxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697023667; x=1697628467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UevqGNo+2n91bIPy1ar4mH+fg23SQp0KUlq9TRtpdE8=;
        b=lfXBLQXyqvNNeFTRK/eoERLZ2de1IZT4nPSMow9qK033a9YhduXVhGISyg90wwme49
         BlcHOf0F0ZhwOq9r76ZcrKCQfTS2Ko/3CFB7snD9mSs/FrjRZz66qH9bhuEfFw9D2pon
         taO79JciqaIkEaAFz9PM3zxP582Knz8FWT7aeVmPeH7OXef/uVohfyoEPtAg3+78FTYC
         zIfkicNTotrAWFsg/lkSxkQOW5B0jO1pr7qsscGSTIMy43/LzG4AzokoJwhQfagclW8/
         H25xCGAfy/s0xxVp+T1uRO8hWlEqIFPD3lZjM8SHrmBPK+BLYXlagWCIre19fVJ/A878
         TOug==
X-Gm-Message-State: AOJu0Yzivze/Vg2ediCr4K3ElDIv89Jh1qSOblvYujXmfKm7oLVYkXY6
        9Hi2BEwyHNWR+uNR/onL/oKfc17FOTrfdI6hC3BlMA==
X-Google-Smtp-Source: AGHT+IHAG5omYAUeCxvMmTsCauLJr5K+wdIN6fI8uORp68jiiMJvGhoBPf7TLiRJ//ZjXiTdRuxQLeSZdGlf9lU9xSo=
X-Received: by 2002:a0d:d556:0:b0:5a7:bd2b:d4ec with SMTP id
 x83-20020a0dd556000000b005a7bd2bd4ecmr5299308ywd.3.1697023667140; Wed, 11 Oct
 2023 04:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <8f982779-d7d6-494b-affc-9ecd44b1e23a@leemhuis.info> <20231011085421.h4qtizye4m3rjuov@vireshk-i7>
In-Reply-To: <20231011085421.h4qtizye4m3rjuov@vireshk-i7>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 14:27:36 +0300
Message-ID: <CAA8EJppwG+ZTiV1pdt9Fqeq_H9G-9a=tMV_FADk7XQiaSvmo7g@mail.gmail.com>
Subject: Re: next: Build error on arm64: `modpost: "of_find_next_cache_node"
 [drivers/cpufreq/qcom-cpufreq-nvmem.ko] undefined!`
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 11:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-10-23, 10:49, Thorsten Leemhuis wrote:
> > Hi Dmitry, my linux-next builds for Fedora failed today with this error=
:
> >
> > > + /usr/bin/make -s 'HOSTCFLAGS=3D-O2  -fexceptions -g -grecord-gcc-sw=
itches -pipe -Wall -Werror=3Dformat-security -Wp,-U_FORTIFY_SOURCE,-D_FORTI=
FY_SOURCE=3D3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat=
-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-=
annobin-cc1  -mbranch-protection=3Dstandard -fasynchronous-unwind-tables -f=
stack-clash-protection   ' 'HOSTLDFLAGS=3D-Wl,-z,relro -Wl,--as-needed  -Wl=
,-z,now -specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld -specs=3D/usr/lib/r=
pm/redhat/redhat-annobin-cc1  -Wl,--build-id=3Dsha1 -specs=3D/usr/lib/rpm/r=
edhat/redhat-package-notes ' ARCH=3Darm64 'KCFLAGS=3D ' WITH_GCOV=3D0 -j4 m=
odules
> > > drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c: In function 'dpaa=
_set_coalesce':
> > > drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:502:1: warning: th=
e frame size of 4112 bytes is larger than 2048 bytes [-Wframe-larger-than=
=3D]
> > >   502 | }
> > >       | ^
> > > drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: In function 'dpaa_fq_=
setup.constprop':
> > > drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:1000:1: warning: the f=
rame size of 8224 bytes is larger than 2048 bytes [-Wframe-larger-than=3D]
> > >  1000 | }
> > >       | ^
> > > ERROR: modpost: "of_find_next_cache_node" [drivers/cpufreq/qcom-cpufr=
eq-nvmem.ko] undefined!
> >
> > A quick search on lore found that the 0-day bot encountered a similar
> > problem early July:
> > https://lore.kernel.org/all/202307030626.PUPpfATh-lkp@intel.com/
> >
> > Back then it afaics was caused by "cpufreq: qcom-nvmem: create L2 cache
> > device" which is new in todays next, which makes it a likely suspect fo=
r
> > my problem. That's why I decided to write this mail. But note, I didn't
> > verify if that patch really causes the trouble; hence if you think it
> > might be something entirely different, let me know.
> >
> > Full build log:
> > https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/next/fe=
dora-38-aarch64/06516038-next-next-all/builder-live.log.gz
> >
> > I don't have the config file at hand, but it should be the following on=
e
> > processed with "make olddefconfig"
> > https://www.leemhuis.info/files/misc/kernel-aarch64-fedora.config
>
> of_find_next_cache_node() needs to be exported for modules.
>
> Dmitry, can you send a patch for that and mention that it needs to go
> in via my tree ?

Done

>
> --
> viresh



--=20
With best wishes
Dmitry
