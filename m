Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598927BA590
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbjJEQSF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbjJEQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512324C03;
        Wed,  4 Oct 2023 22:15:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2774874c3daso415951a91.1;
        Wed, 04 Oct 2023 22:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696482928; x=1697087728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWwQRb/XtfECORlbJaPIokf0S+U6RkqOPHFRazouw+M=;
        b=gk6ehihyY7L8RWQKVeiLU5hPqOL4VdBoXG4lIe6ICycBvyxQ0HhtrVl8hlSrzLCSXQ
         t2QxKLvicTx6c2AD8yTG4JRD/bKhAI2rQJ/52mEXHU/GI/ZOqgYa0e3tLBiSb74K9VcW
         I1j/Ne+lMa5fxFHJzH8inlVtaW4N2QxayTBCqtv2x4+IpycI/5usIos8RFDVTgHzC3Zj
         68qBZH78N1HI0OORdqy6hzP786SV9LRhamZe/b0+vHU6mfVQ1Gd+ft9OLYjltrFP32qn
         OgAyjM8R4Rzwxd4+VipW8wIWWodYuI1mxIXrlE2ROtyYA6DnEtmBD4XmqesLmNG2M+GM
         3THg==
X-Gm-Message-State: AOJu0YyoO8Cz9iEFwXDY6U/QdP+cd6dST7DUNzNUIrxW4YrQ0FT9o01c
        kdjh0RSaUxyDiMhbhbnZDyIS8i8g5XPQp3IHRvo=
X-Google-Smtp-Source: AGHT+IFgLfvo1oegfrzeQvDg8A+plJfnaldXDVwHe7iwyPSK91s2WY58rzBuwDkayDOgh0mRN9ApFzOpeM5z8cMN6CE=
X-Received: by 2002:a17:90b:3b92:b0:273:cec7:23ee with SMTP id
 pc18-20020a17090b3b9200b00273cec723eemr4213933pjb.37.1696482927938; Wed, 04
 Oct 2023 22:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org> <f0115175-975e-4fde-aa69-666568ce5c6a@gmail.com>
 <CAM9d7chUnxjPdOwZZ0imYs+i8+dd9GL=O3gqJXzaRd1VGZJxBg@mail.gmail.com> <d2b80a6d-63c8-46ec-bf0f-83217a7c517d@gmail.com>
In-Reply-To: <d2b80a6d-63c8-46ec-bf0f-83217a7c517d@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 4 Oct 2023 22:15:16 -0700
Message-ID: <CAM9d7cjf8uct-xMr0Sj8=3kdcH6mavx5pCCsg+G8v53d+kxWjA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 10/4/2023 1:19 PM, Namhyung Kim wrote:
> > Hello,
> >
> > On Wed, Oct 4, 2023 at 12:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> +Namhyung, Ian,
> >>
> >> On 10/4/23 10:52, Greg Kroah-Hartman wrote:
> >>> This is the start of the stable review cycle for the 6.1.56 release.
> >>> There are 259 patches in this series, all will be posted as a response
> >>> to this one.  If anyone has any issues with these being applied, please
> >>> let me know.
> >>>
> >>> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> >>> Anything received after that time might be too late.
> >>>
> >>> The whole patch series can be found in one patch at:
> >>>        https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> >>> or in the git tree and branch at:
> >>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> >>> and the diffstat can be found below.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> perf fails to build with:
> >>
> >> fixdep: error opening depfile:
> >> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d:
> >> No such file or directory
> >> make[5]: *** [pmu-events/Build:33:
> >> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events.o]
> >> Error 2
> >> make[4]: *** [Makefile.perf:672:
> >> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o]
> >> Error 2
> >> make[3]: *** [Makefile.perf:240: sub-make] Error 2
> >> make[2]: *** [Makefile:70: all] Error 2
> >> make[1]: *** [package/pkg-generic.mk:294:
> >> /local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built]
> >> Error 2
> >> make: *** [Makefile:27: _all] Error 2
> >>
> >> due a80fd00cb1a7793ead4d7c3fa7d3f1e898231c27 ("perf build: Update build
> >> rule for generated files"). Reverting that commit fixes the build for me
> >> and then all is good in terms of testing.
> >
> > I think it's ok to drop the patches if it's not applied
> > cleanly.
>
> AFAICT the patch applied cleanly. There was some bizarre interplay in
> stable kernels prior to < 6.1 as reported here:
>
> https://lore.kernel.org/all/dcb9997a-2e8a-5eb2-7a34-f8af418d4bf1@gmail.com/
> https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/
>
> Does this make sense to you that on 6.1 which does have Ian's commit
> 00facc760903be6675870c2749e2cd72140e396e ("perf jevents: Switch build to
> use jevents.py") that we would still get this build error somehow?

You can drop the pmu-events part of the change if possible.
If not, I'm ok to drop the entire patch as it's intended to fix a
corner case only.  Normal builds should be fine before and
after the change.

Thanks,
Namhyung
