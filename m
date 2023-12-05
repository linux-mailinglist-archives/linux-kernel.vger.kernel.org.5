Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06884805DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbjLESXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjLESXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:23:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE193122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:23:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C20BC433C7;
        Tue,  5 Dec 2023 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701800608;
        bh=1u3S+qdTDDJpU1AH8fRxdM6v7mEapa2b3xh7jr42q/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lj3F+Ag5ozXNa3vw9pJkWyWpOZmMTl8+2HFnH4W/RwXkvCsduK0p1onlXVpCTJmp5
         2/ugFcqip8aPFmSVrmEWjpBRHj21UKjTnF8MkrqJ7vpxdii/xEfiF0vq0KD1ffM4+U
         vXh9snhqG0gpkuMFeJp3bGzqjhqHcGiGpTvTpOQ0=
Date:   Wed, 6 Dec 2023 03:23:26 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
Message-ID: <2023120610-cause-chariot-961b@gregkh>
References: <20231205031519.853779502@linuxfoundation.org>
 <CA+G9fYs-XB29+aZ2kk9psA+MTo8PCh0owWgwGRiq8JK60CuUtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs-XB29+aZ2kk9psA+MTo8PCh0owWgwGRiq8JK60CuUtg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:18:49PM +0530, Naresh Kamboju wrote:
> On Tue, 5 Dec 2023 at 09:10, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.142 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Following powerpc build failures noticed.
> 
> * powerpc, build
>   - clang-17-defconfig - FAILED
>   - gcc-12-defconfig - FAILED
>   - gcc-8-defconfig - FAILED
> 
> build error:
> ---
> arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
> arch/powerpc/platforms/pseries/iommu.c:908:49: error: 'struct dma_win'
> has no member named 'direct'
>   908 |                         *direct_mapping = window->direct;
>       |                                                 ^~
> 
> suspected commit:
> powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping
> for SR-IOV device
>  [ Upstream commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e ]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks, now dropped from 5.15.y and 6.1.y
