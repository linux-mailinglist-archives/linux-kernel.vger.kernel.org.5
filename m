Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899ED7BB5D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjJFLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjJFLDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:03:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B2CF;
        Fri,  6 Oct 2023 04:03:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79195C433C8;
        Fri,  6 Oct 2023 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696590214;
        bh=4dpi9ypq5NwCfCKs6ejpxDxyw5e1ui6rbvUNhVADCX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iap8k9+2BfdKoxzManX2E7z7pwLNnFzFY/YTlIju+84XyKTpK/c70RDTn6S8Q/V/H
         tkxTI7v8YEi17QWcToU5386tE7p++NwPuUz3dKgqnt7yf8kKKj7LsFuSdXFWVo35ry
         kJYkDwEnps1gY7dEkn1j1rV8NtklDJ5bT68ZebHg=
Date:   Fri, 6 Oct 2023 13:03:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <2023100610-purge-pupil-b754@gregkh>
References: <20231004175203.943277832@linuxfoundation.org>
 <ec06c2fb-6737-489f-8439-307e0d84687b@gmail.com>
 <2023100601-ending-prevalent-c8d4@gregkh>
 <9fec75ba-a319-027c-6cf2-b65e703d3ce7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fec75ba-a319-027c-6cf2-b65e703d3ce7@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:07:14PM +0530, Harshit Mogalapalli wrote:
> 
> 
> On 06/10/23 3:55 pm, Greg Kroah-Hartman wrote:
> > On Wed, Oct 04, 2023 at 11:43:46AM -0700, Florian Fainelli wrote:
> > > On 10/4/23 10:53, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.134 release.
> > > > There are 183 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > perf fails to build with:
> > > 
> > >    CC /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o
> > > util/metricgroup.c: In function 'metricgroup__parse_groups':
> > > util/metricgroup.c:1261:7: error: 'table' undeclared (first use in this
> > > function)
> > >    if (!table)
> > >         ^~~~~
> > > util/metricgroup.c:1261:7: note: each undeclared identifier is reported only
> > > once for each function it appears in
> > > make[6]: *** [/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o]
> > > Error 1
> > > 
> > > caused by c1ef510a0f2a879bf29ddebae766ec9f0790eb8f ("perf metric: Return
> > > early if no CPU PMU table exists"). Dropping this commit allows the build to
> > > continue.
> > > 
> > > I had reported in the previous cycle that 00facc760903be66 ("perf jevents:
> > > Switch build to use jevents.py") was causing build failures:
> > > 
> > > https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/
> > > 
> > > do we still want these commits to be included?
> > 
> > No, I'll go drop them now, thanks for the report.
> 
> Thought:
> It's not the first time we see build failures in tools/perf -- would it make
> sense to add this to your own build tests to reduce the round trip time for
> these errors ?

Last time I tried to build perf, I couldn't do it at all so I just gave
up trying to test for it :)

> Note: After reverting three patches in perf/ the build succeeds:
> 
> Patch 151: c1ef510a0f2a perf metric: Return early if no CPU PMU table exists
> Patch 81: 40ddac4ffc75 perf build: Update build rule for generated files
> Patch 80: 8df938ed8c8a perf jevents: Switch build to use jevents.py

All of these are now dropped.

thanks,

greg k-h
