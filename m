Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDF378DB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbjH3Siw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbjH3Mcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626AE8;
        Wed, 30 Aug 2023 05:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B1A360FDF;
        Wed, 30 Aug 2023 12:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C991C433C7;
        Wed, 30 Aug 2023 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693398769;
        bh=Gme2F4CM/b8pnooL5v5ewDM1ffflJ+thkiYRkALsA/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wsm8ax3IiR5ntFvzMrk4E2L7rHY6+e64HTINNSLyBvuwj6kHsvNIHwfFt8zchjo0T
         UO8H9W7yOETOr/fV2zTKc4M63JF05rWxyEbaiGs72yseN1QsVQKa8pj4zoHMqLkVhP
         oHJvXuoWF9DjtXxGcbds+u1A2ES3zPnEdpO11L68=
Date:   Wed, 30 Aug 2023 14:32:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, nathanl@linux.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH 4.14 00/57] 4.14.324-rc1 review
Message-ID: <2023083038-antennae-expand-4afc@gregkh>
References: <20230828101144.231099710@linuxfoundation.org>
 <868cd8e3-2e7e-7b98-0a6e-e5586cb6ab0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <868cd8e3-2e7e-7b98-0a6e-e5586cb6ab0d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:01:41PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 28/08/23 4:12 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.324 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.324-rc1.gz
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
> >      Linux 4.14.324-rc1
> > 
> [...]
> > Nathan Lynch <nathanl@linux.ibm.com>
> >      powerpc/rtas_flash: allow user copy to flash block cache objects
> [...]
> 
> We see this build regression on PowerPC with GCC-8 and GCC-12:
> -----8<-----
>   /builds/linux/arch/powerpc/kernel/rtas_flash.c: In function 'rtas_flash_init':
>   /builds/linux/arch/powerpc/kernel/rtas_flash.c:717:22: error: implicit declaration of function 'kmem_cache_create_usercopy'; did you mean 'kmem_cache_create'? [-Werror=implicit-function-declaration]
>     flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>                         kmem_cache_create
>   /builds/linux/arch/powerpc/kernel/rtas_flash.c:717:20: error: assignment to 'struct kmem_cache *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
>     flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
>                       ^
> ----->8-----
> 
> That's on defconfig and cell_defconfig.
> 
> Bisection points to "powerpc/rtas_flash: allow user copy to flash block cache objects" (5190538c66e5). Reverting that patch makes the build pass again.

Now dropped, thanks.

greg k-h
