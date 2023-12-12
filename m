Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7934A80E94B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbjLLKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLLKjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:39:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E561AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:39:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C8AC433C7;
        Tue, 12 Dec 2023 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702377559;
        bh=7J/iASUnp7xTZsZQunpbTLmqyWpQWJW0GO1PUqdKOYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CMtHpd6FRuxwyQIfifTWLRrd2RXW/vI/dr/9eCz+ge2FqNNhFC12ANMfyVTZ2cvKb
         mJXK+F8M6CJnp3PejWqvFA7T1nUj1LAKkYlz5FNL7s3mJalvOvrP5dmYPiDqSWTM/x
         x6iAeal0Ei8HDQ1WORQmsPWbQJHDloYn+VEdwpV4=
Date:   Tue, 12 Dec 2023 11:39:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, arnd@arndb.de
Subject: Re: [PATCH 4.19 00/55] 4.19.302-rc1 review
Message-ID: <2023121207-lubricant-humility-e328@gregkh>
References: <20231211182012.263036284@linuxfoundation.org>
 <ff65c696-1fde-4e4c-b964-356e81495cab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff65c696-1fde-4e4c-b964-356e81495cab@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:04:00PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 11/12/23 12:21 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.302 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.302-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Same problem here as with 4.14. Here's a list of failures:
> 
> ## Test Regressions (compared to v4.19.301)
> * arm, build
>   - clang-17-axm55xx_defconfig
>   - clang-17-defconfig
>   - clang-17-multi_v5_defconfig-aa80e505
>   - clang-17-mxs_defconfig
>   - clang-17-nhk8815_defconfig
>   - clang-17-u8500_defconfig
>   - gcc-12-axm55xx_defconfig
>   - gcc-12-bcm2835_defconfig
>   - gcc-12-defconfig
>   - gcc-12-lkftconfig
>   - gcc-12-lkftconfig-debug
>   - gcc-12-lkftconfig-debug-kmemleak
>   - gcc-12-lkftconfig-kasan
>   - gcc-12-lkftconfig-kselftest-kernel
>   - gcc-12-lkftconfig-kunit
>   - gcc-12-lkftconfig-libgpiod
>   - gcc-12-lkftconfig-rcutorture
>   - gcc-12-multi_v5_defconfig-aa80e505
>   - gcc-12-mxs_defconfig
>   - gcc-12-nhk8815_defconfig
>   - gcc-12-u8500_defconfig
>   - gcc-8-axm55xx_defconfig
>   - gcc-8-bcm2835_defconfig
>   - gcc-8-defconfig
>   - gcc-8-multi_v5_defconfig-aa80e505
>   - gcc-8-mxs_defconfig
>   - gcc-8-nhk8815_defconfig
>   - gcc-8-u8500_defconfig
> 
> * arm64, build
>   - clang-17-defconfig
>   - clang-17-defconfig-40bc7ee5
>   - clang-17-lkftconfig
>   - clang-lkftconfig
>   - gcc-12-defconfig
>   - gcc-12-defconfig-40bc7ee5
>   - gcc-12-lkftconfig
>   - gcc-12-lkftconfig-64k_page_size
>   - gcc-12-lkftconfig-armv8_features
>   - gcc-12-lkftconfig-debug
>   - gcc-12-lkftconfig-debug-kmemleak
>   - gcc-12-lkftconfig-devicetree
>   - gcc-12-lkftconfig-kasan
>   - gcc-12-lkftconfig-kselftest-kernel
>   - gcc-12-lkftconfig-kunit
>   - gcc-12-lkftconfig-libgpiod
>   - gcc-12-lkftconfig-rcutorture
>   - gcc-8-defconfig
>   - gcc-8-defconfig-40bc7ee5
> 
> 
> Failure:
> 
> -----8<-----
>   /builds/linux/drivers/tty/serial/amba-pl011.c: In function 'pl011_dma_tx_refill':
>   /builds/linux/drivers/tty/serial/amba-pl011.c:644:20: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function); did you mean 'DMA_TRANS_NOERROR'?
>     if (dmatx->dma == DMA_MAPPING_ERROR) {
>                       ^~~~~~~~~~~~~~~~~
>                       DMA_TRANS_NOERROR
>   /builds/linux/drivers/tty/serial/amba-pl011.c:644:20: note: each undeclared identifier is reported only once for each function it appears in
>   make[4]: *** [/builds/linux/scripts/Makefile.build:303: drivers/tty/serial/amba-pl011.o] Error 1
>   make[4]: Target '__build' not remade because of errors.
> ----->8-----
> 
> Bisection points to the same commit:
> 
>   commit 6afe0d46b25850f794626c70aac55cc7f9b774e2
>   Author: Arnd Bergmann <arnd@arndb.de>
>   Date:   Wed Nov 22 18:15:03 2023 +0100
> 
>       ARM: PL011: Fix DMA support
>       commit 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5 upstream.
> 
> 
> A revert helps the build pass.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks, now dropped.

greg k-h
