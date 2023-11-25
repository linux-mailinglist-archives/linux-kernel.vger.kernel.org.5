Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492897F8C12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKYPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:31:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97EE101
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:31:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169BAC433C8;
        Sat, 25 Nov 2023 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700926284;
        bh=Ek3M4F+99yP8QtTU54oE6BWwZNcJRhhseY6NiOiba5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6UkdCY6S2EN9D/i4YN8DY8f+1Cf8N27uqOdZaQ307PWD7aKBSfQYvB93KgHy8K5y
         VKUO95gIittl1k2LyOvosp1wPsK1jXYnSmtK0jfoB009XtzkQlVru/tGSTWhumzueq
         ORMOx+9DUV6GUMjKH3yWBS7q+71uNXSlZ/FHERsQ=
Date:   Sat, 25 Nov 2023 15:31:22 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
Message-ID: <2023112508-womb-glory-44f7@gregkh>
References: <20231124172028.107505484@linuxfoundation.org>
 <CA+G9fYtrUpJ_+-k6dBaX0yZX-dkkrz3Qg-1FRwkG83pZvN44ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtrUpJ_+-k6dBaX0yZX-dkkrz3Qg-1FRwkG83pZvN44ow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 12:35:47AM +0530, Naresh Kamboju wrote:
> On Fri, 24 Nov 2023 at 23:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.3 release.
> > There are 530 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> 
> > Zhen Lei <thunder.leizhen@huawei.com>
> >     rcu: Dump memory object info if callback function is invalid
> 
> 
> Following build warnings / errors noticed while building the
> arm64 tinyconfig on stable-rc linux-6.6.y.
> 
> 
> kernel/rcu/update.c:49:
> kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
> kernel/rcu/rcu.h:255:17: error: implicit declaration of function
> 'kmem_dump_obj'; did you mean 'mem_dump_obj'?
> [-Werror=implicit-function-declaration]
>   255 |                 kmem_dump_obj(rhp);
>       |                 ^~~~~~~~~~~~~
>       |                 mem_dump_obj
> cc1: some warnings being treated as errors
> 
> 
> rcu: Dump memory object info if callback function is invalid
> [ Upstream commit 2cbc482d325ee58001472c4359b311958c4efdd1 ]
> 
> Steps to reproduce:
> $ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
> --kconfig tinyconfig config debugkernel dtbs kernel modules xipkernel
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YdN5Tb5NAFPo7H9WWQd0APrWu1/

Should now be fixed, I'll push out a -rc2 soon to verify.

thanks,

greg k-h
