Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A491A778AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjHKKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjHKKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D8E3;
        Fri, 11 Aug 2023 03:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B71863186;
        Fri, 11 Aug 2023 10:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D75C433C8;
        Fri, 11 Aug 2023 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691748431;
        bh=aeqmuXXvDUIdbq4Oxc6siFyRT7b8XUQDtZFkCP8sRIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCHyWTufNtkvCxeFDx1YL9GkeD9G/ebn8ihX34e/diDUo2+4RyXumT9DxTEom0IPU
         qk9ctp0HneYfxjLrpaRG/Prf51wBTMoaF1qrSUgxq8rO9IGzWkc6oL9frLdIp0yGKk
         VbqV8JatX7bYbQi+VzbgGrC6ESvyc9/CR8PkxzZk=
Date:   Fri, 11 Aug 2023 12:07:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <2023081144-occultist-cytoplast-d7b5@gregkh>
References: <20230809103636.615294317@linuxfoundation.org>
 <a800f7e3-5a59-4dba-afc8-d3ae5f39b058@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a800f7e3-5a59-4dba-afc8-d3ae5f39b058@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:14:43AM -0700, Guenter Roeck wrote:
> On Wed, Aug 09, 2023 at 12:39:47PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.45 release.
> > There are 127 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 157 pass: 153 fail: 4
> Failed builds:
> 	loongarch:defconfig
> 	loongarch:allnoconfig
> 	loongarch:tinyconfig
> 	loongarch:allmodconfig
> Qemu test results:
> 	total: 521 pass: 513 fail: 8
> Failed tests:
> 	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:rootfs
> 	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:rootfs
> 	<all loongarch>
> 
> loongarch failures as already reported, introduced with v6.1.44.
> 
> The failed arm tests crash in f2fs (again - previously reported
> against the v6.1.43 release candidate).
> 
> [    6.685458] 8<--- cut here ---
> [    6.685593] Unable to handle kernel NULL pointer dereference at virtual address 00000034
> [    6.685725] [00000034] *pgd=00000000
> [    6.686010] Internal error: Oops: 5 [#1] SMP ARM
> [    6.686209] CPU: 0 PID: 194 Comm: seedrng Not tainted 6.1.45-rc1-00128-g02a4c6c322d1 #1
> [    6.686350] Hardware name: Generic DT based system
> [    6.686467] PC is at f2fs_issue_flush+0x160/0x210
> [    6.686821] LR is at f2fs_do_sync_file+0x7c8/0xaa8

Odd that you are the only one seeing this f2fs report, does no one else
use f2fs on 6.1 systems?

thanks,

greg k-h
