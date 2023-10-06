Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F97BB4F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjJFKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJFKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:12:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D605ED;
        Fri,  6 Oct 2023 03:12:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D9EC433C9;
        Fri,  6 Oct 2023 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696587163;
        bh=tqWT7Uq0aNHn7XluN41BFW9l0r892T8bAdRPiNKUR0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIPL8ygWR+RzI/1EYbHZLarysPkndwEYRqZW4+dtYrQFvpHIMCQKbg6LYfDlEnYgv
         uoG6eXY/HQc5JOzKn8oe6duZGQH6BqsDDJjNaeH3dyapR/prEZQvaUdgny4mPcmtyZ
         KDXagIhR0Xnb6OKFrxm+6EQVBF3Io9bZg4CZO2WU=
Date:   Fri, 6 Oct 2023 12:12:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
        Ian Rogers <irogers@google.com>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <2023100629-moneybags-unwound-ab7f@gregkh>
References: <20231004175217.404851126@linuxfoundation.org>
 <f0115175-975e-4fde-aa69-666568ce5c6a@gmail.com>
 <CAM9d7chUnxjPdOwZZ0imYs+i8+dd9GL=O3gqJXzaRd1VGZJxBg@mail.gmail.com>
 <d2b80a6d-63c8-46ec-bf0f-83217a7c517d@gmail.com>
 <CAM9d7cjf8uct-xMr0Sj8=3kdcH6mavx5pCCsg+G8v53d+kxWjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjf8uct-xMr0Sj8=3kdcH6mavx5pCCsg+G8v53d+kxWjA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:15:16PM -0700, Namhyung Kim wrote:
> On Wed, Oct 4, 2023 at 5:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> >
> >
> > On 10/4/2023 1:19 PM, Namhyung Kim wrote:
> > > Hello,
> > >
> > > On Wed, Oct 4, 2023 at 12:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >>
> > >> +Namhyung, Ian,
> > >>
> > >> On 10/4/23 10:52, Greg Kroah-Hartman wrote:
> > >>> This is the start of the stable review cycle for the 6.1.56 release.
> > >>> There are 259 patches in this series, all will be posted as a response
> > >>> to this one.  If anyone has any issues with these being applied, please
> > >>> let me know.
> > >>>
> > >>> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > >>> Anything received after that time might be too late.
> > >>>
> > >>> The whole patch series can be found in one patch at:
> > >>>        https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> > >>> or in the git tree and branch at:
> > >>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > >>> and the diffstat can be found below.
> > >>>
> > >>> thanks,
> > >>>
> > >>> greg k-h
> > >>
> > >> perf fails to build with:
> > >>
> > >> fixdep: error opening depfile:
> > >> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d:
> > >> No such file or directory
> > >> make[5]: *** [pmu-events/Build:33:
> > >> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events.o]
> > >> Error 2
> > >> make[4]: *** [Makefile.perf:672:
> > >> /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o]
> > >> Error 2
> > >> make[3]: *** [Makefile.perf:240: sub-make] Error 2
> > >> make[2]: *** [Makefile:70: all] Error 2
> > >> make[1]: *** [package/pkg-generic.mk:294:
> > >> /local/users/fainelli/buildroot/output/arm/build/linux-tools/.stamp_built]
> > >> Error 2
> > >> make: *** [Makefile:27: _all] Error 2
> > >>
> > >> due a80fd00cb1a7793ead4d7c3fa7d3f1e898231c27 ("perf build: Update build
> > >> rule for generated files"). Reverting that commit fixes the build for me
> > >> and then all is good in terms of testing.
> > >
> > > I think it's ok to drop the patches if it's not applied
> > > cleanly.
> >
> > AFAICT the patch applied cleanly. There was some bizarre interplay in
> > stable kernels prior to < 6.1 as reported here:
> >
> > https://lore.kernel.org/all/dcb9997a-2e8a-5eb2-7a34-f8af418d4bf1@gmail.com/
> > https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/
> >
> > Does this make sense to you that on 6.1 which does have Ian's commit
> > 00facc760903be6675870c2749e2cd72140e396e ("perf jevents: Switch build to
> > use jevents.py") that we would still get this build error somehow?
> 
> You can drop the pmu-events part of the change if possible.
> If not, I'm ok to drop the entire patch as it's intended to fix a
> corner case only.  Normal builds should be fine before and
> after the change.

I'm going to just drop the patch now from all queues, thanks!

greg k-h
