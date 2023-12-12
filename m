Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C684A80E942
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjLLKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:38:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CABA0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:39:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDF9C433C7;
        Tue, 12 Dec 2023 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702377543;
        bh=THocl/173d1ePQ2YD6y4vNlV09erpFNkdAl2IklIFqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEOHN6AezbY7eQdLJXHGuDasMi+hpnst1JyeWi4NND4KXGrpS8Pp3dLJFNKc8DfAg
         G5nbTf2Lr13FGzt/7nnLHmds+FcHFxuONEhLhnpjMJEAfcMNeA0I+KuHjHuyw4bDWR
         PgJc2UcNbKRUD34DTjaigpfn/iO2xNJ+2lBzVek8=
Date:   Tue, 12 Dec 2023 11:39:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, arnd@arndb.de
Subject: Re: [PATCH 4.14 00/25] 4.14.333-rc1 review
Message-ID: <2023121251-placard-scouting-8316@gregkh>
References: <20231211182008.665944227@linuxfoundation.org>
 <f63a13c6-7e19-42a9-89fd-c37249a855eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f63a13c6-7e19-42a9-89fd-c37249a855eb@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 01:46:03PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 11/12/23 12:20 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.333 release.
> > There are 25 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> > Pseudo-Shortlog of commits:
> > 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >      Linux 4.14.333-rc1
> > 
> [...]
> > 
> > Arnd Bergmann <arnd@arndb.de>
> >      ARM: PL011: Fix DMA support
> [...]
> 
> We see a build problem with this commit (at least) on 4.14:
> -----8<-----
>   /builds/linux/kernel/sched/core.c: In function 'sched_init':
>   /builds/linux/kernel/sched/core.c:5962:30: warning: the comparison will always evaluate as 'false' for the address of 'cpu_isolated_map' will never be NULL [-Waddress]
>    5962 |         if (cpu_isolated_map == NULL)
>         |                              ^~
>   /builds/linux/kernel/sched/core.c:87:15: note: 'cpu_isolated_map' declared here
>      87 | cpumask_var_t cpu_isolated_map;
>         |               ^~~~~~~~~~~~~~~~
>   /builds/linux/drivers/tty/serial/amba-pl011.c: In function 'pl011_dma_tx_refill':
>   /builds/linux/drivers/tty/serial/amba-pl011.c:657:27: error: 'DMA_MAPPING_ERROR' undeclared (first use in this function)
>     657 |         if (dmatx->dma == DMA_MAPPING_ERROR) {
>         |                           ^~~~~~~~~~~~~~~~~
>   /builds/linux/drivers/tty/serial/amba-pl011.c:657:27: note: each undeclared identifier is reported only once for each function it appears in
>   make[4]: *** [/builds/linux/scripts/Makefile.build:329: drivers/tty/serial/amba-pl011.o] Error 1
>   make[4]: Target '__build' not remade because of errors.
> ----->8-----
> 
> Reverting that patch makes the build for arm/u8500_defconfig. We'll continue looking for other things.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks, now dropped, I'll push out a -rc2 with this fix.

greg k-h
