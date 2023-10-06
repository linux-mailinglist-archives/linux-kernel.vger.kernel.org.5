Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8360F7BB496
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjJFJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJFJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:54:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB5BE;
        Fri,  6 Oct 2023 02:54:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0376C433C7;
        Fri,  6 Oct 2023 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696586050;
        bh=1xkOaZgWTt8wM/d9FQ2QJPZz89Bgl30gT4xlvIoDSR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGTn51ncWAoBhlIUu33RX+rKn2oQQgVhGVeCpcshlIqYB1rBwr5ngl/4+VJkeXiXf
         kLgJhsj74qQC1qhpAf76lusF2fBpNk4UIcY/XSIpEPBPtZoivBL+jmB1fie62e241P
         JD618flh3vleOkj5QJE5EyI04iXSTY/Q6PBdAe9o=
Date:   Fri, 6 Oct 2023 11:54:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, bpf <bpf@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <2023100643-unicycle-plenty-f4a3@gregkh>
References: <20231004175229.211487444@linuxfoundation.org>
 <CA+G9fYuE9Pu3QCVDywA8Ss-41jVfiy2e2kpxjhpTe3CRgmZkBw@mail.gmail.com>
 <CA+G9fYvHPnba-0=uGS70EjcPgHht13j3s-_fmd2=srL0xyPjNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvHPnba-0=uGS70EjcPgHht13j3s-_fmd2=srL0xyPjNg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:25:02PM +0530, Naresh Kamboju wrote:
> On Thu, 5 Oct 2023 at 11:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.5.6 release.
> > > There are 321 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The following kernel warning was noticed on qemu-armv7 while booting
> > with kselftest merge configs enabled build on stable-rc 6.5.6-rc1.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > > Hou Tao <houtao1@huawei.com>
> > >     bpf: Ensure unit_size is matched with slab cache object size
> >
> >
> > bpf: Ensure unit_size is matched with slab cache object size
> > [ Upstream commit c930472552022bd09aab3cd946ba3f243070d5c7 ]
> >
> > [    2.525383] ------------[ cut here ]------------
> > [    2.525743] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:385
> > bpf_mem_alloc_init+0x3b0/0x3b4
> > [    2.527241] bpf_mem_cache[0]: unexpected object size 128, expect 96
> 
> 
> Anders investigated this report and picked up the following patches to
> solve the reported problem.
> 
> d52b59315bf5e bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
> b1d53958b6931 bpf: Don't prefill for unused bpf_mem_cache
> c930472552022 bpf: Ensure unit_size is matched with slab cache object size

Those do not all apply cleanly to the tree, so I've dropped the one
offending commit instead for 6.5.y and 6.1.y.

thanks,

greg k-h
