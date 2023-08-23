Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A16E785113
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjHWHD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjHWHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC3185;
        Wed, 23 Aug 2023 00:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C9564A86;
        Wed, 23 Aug 2023 07:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDF0C433C7;
        Wed, 23 Aug 2023 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692774232;
        bh=CREXmtSVm3ElNVCBgi60/kP4BfR2bXJzoUJvCekaTJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGbhFAKGEzEoNxcW4EtllY/OrEfRIxobd2x5V0x80KncOeqwWe4hbtwrj07BQvtMJ
         tVhaOqLyIo63cKtluc/YZW4nYqVAOaN2bF9zeotw9BrKXIy1SWdflrx34jVLW4mmlT
         ejXL8m4yqtOBfvfTTgoW/Oh1c8DyswxkwVs+ZZgw=
Date:   Wed, 23 Aug 2023 09:03:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2023082309-veggie-unwoven-a7df@gregkh>
References: <20230821194122.695845670@linuxfoundation.org>
 <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:49:54PM -0700, Guenter Roeck wrote:
> On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.47 release.
> > There are 194 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 157 pass: 156 fail: 1
> Failed builds:
> 	m68k:sun3_defconfig
> Qemu test results:
> 	total: 521 pass: 519 fail: 2
> Failed tests:
> 	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
> 	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs
> 
> The m68k build failure is
> 
> Inconsistent kallsyms data
> Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> 
> I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
> Nothing to worry about. The f2fs crashes are still seen. They
> also happen for other architectures, so it is not just an arm problem.
> I'll probably just disable all f2fs testing going forward. If so I'll
> send a note clarifying that the lack of reported test failures doesn't
> mean that it works.

I'll look into this later this week, next week to resolve the f2fs
stuff.  I wanted to get to the other known bug fixes first.

> For x86 I get the same runtime warning as everyone else.

Yeah, this is troubling...

Is it clang only?  I'll dig into this today...

thanks,

greg k-h
