Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D97BA23D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjJEPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjJEPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:22:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A165A7;
        Thu,  5 Oct 2023 07:34:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F308BC433CD;
        Thu,  5 Oct 2023 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696516449;
        bh=5DAflvk7cbMnfEphlkIQb4Pvn2YbEBIrbMQlws3K4as=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+3sokucHjrIlIyYRnc9gdfLJNhOAfTzxxTeIfaIREAYKQIme+4rbmr4+YFyClCav
         /KlagsUdirWgfwRxhBm89m5fNiQ03SSis3/h5lrr1rz/Rlnpn5Z4S3a0rMIn3urAAk
         bTF3R7VyvRQD+0dpnmphvKXxF8hdsy38tL4rfPoESsD8YZfAYa1Qnr0VmHMcKI/Jm9
         QZT2zN6z6PWVPHCJsAqD+S5laip19lHiY/cVbHcbGPeuLiu5wM0VP6+wr+OSKd4DEu
         qsATEHjkL1VcCJMImzFpf0LDgK9GGSQYOAQDm2bqAXsWOS4mwo00J9ScGKE9wmi/m3
         MGtA3lH3OxMDQ==
Date:   Thu, 5 Oct 2023 07:34:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Netdev <netdev@vger.kernel.org>, kunit-dev@googlegroups.com,
        Eric Dumazet <edumazet@google.com>, chuck.lever@oracle.com
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <20231005073408.6bb52351@kernel.org>
In-Reply-To: <CA+G9fYuH90g8jQ5SZHE98k16iQV5n+d2-G64xT9W9wrVmpt_Dg@mail.gmail.com>
References: <20231004175229.211487444@linuxfoundation.org>
        <CA+G9fYuH90g8jQ5SZHE98k16iQV5n+d2-G64xT9W9wrVmpt_Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'd probably make sense to run the path to the test that's failing
thru get_maintainer and throw the right people on the CC. Adding Chuck.

On Thu, 5 Oct 2023 11:25:24 +0530 Naresh Kamboju wrote:
> On Wed, 4 Oct 2023 at 23:53, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.5.6 release.
> > There are 321 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h  
> 
> While running kunit testing on qemu-armv7 following test failures noticed
> on stable rc 6.5.6-rc1.
> 
> # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ----------
> <6>[ 1351.687335]     KTAP version 1
> <6>[ 1351.688300]     # Subtest: Handshake API tests
> <6>[ 1351.688760]     1..11
> <6>[ 1351.689362]         KTAP version 1
> <6>[ 1351.689985]         # Subtest: req_alloc API fuzzing
> <6>[ 1351.694360]         ok 1 handshake_req_alloc NULL proto
> <6>[ 1351.705855]         ok 2 handshake_req_alloc CLASS_NONE
> <6>[ 1351.710878]         ok 3 handshake_req_alloc CLASS_MAX
> <6>[ 1351.715435]         ok 4 handshake_req_alloc no callbacks
> <6>[ 1351.722026]         ok 5 handshake_req_alloc no done callback
> <6>[ 1351.726579]         ok 6 handshake_req_alloc excessive privsize
> <6>[ 1351.732397]         ok 7 handshake_req_alloc all good
> <6>[ 1351.732934]     # req_alloc API fuzzing: pass:7 fail:0 skip:0 total:7
> <6>[ 1351.733586]     ok 1 req_alloc API fuzzing
> <6>[ 1351.741251]     ok 2 req_submit NULL req arg
> <6>[ 1351.745979]     ok 3 req_submit NULL sock arg
> <6>[ 1351.753307]     ok 4 req_submit NULL sock->file
> <6>[ 1351.763090]     ok 5 req_lookup works
> <6>[ 1351.770057]     ok 6 req_submit max pending
> <6>[ 1351.774878]     ok 7 req_submit multiple
> <6>[ 1351.782411]     ok 8 req_cancel before accept
> <6>[ 1351.787423]     ok 9 req_cancel after accept
> <6>[ 1351.795660]     ok 10 req_cancel after done
> <3>[ 1351.799741]     # req_destroy works: EXPECTATION FAILED at
> net/handshake/handshake-test.c:477
> <3>[ 1351.799741]     Expected handshake_req_destroy_test == req, but
> <3>[ 1351.799741]         handshake_req_destroy_test == 00000000
> <3>[ 1351.799741]         req == cae22700
> <6>[ 1351.803368]     not ok 11 req_destroy works
> <6>[ 1351.804539] # Handshake API tests: pass:10 fail:1 skip:0 total:11
> <6>[ 1351.805460] # Totals: pass:16 fail:1 skip:0 total:17
> <6>[ 1351.806276] not ok 95 Handshake API tests
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257175/suite/kunit/test/req_alloc/log
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.5-322-g9327d0db36be/testrun/20257175/suite/kunit/test/req_alloc/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/config
> 
> Steps to reproduce:
> # To install tuxrun to your home directory at ~/.local/bin:
> # pip3 install -U --user tuxrun==0.49.2
> #
> # Or install a deb/rpm depending on the running distribution
> # See https://tuxmake.org/install-deb/ or
> # https://tuxmake.org/install-rpm/
> #
> # See https://tuxrun.org/ for complete documentation.
> Link to reproducer,
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/tuxmake_reproducer.sh
> 
> or
> 
> tuxrun --runtime podman --device qemu-armv7 --boot-args rw --kernel
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/zImage
> --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2WJGlCUgDzR8asQbd2BxMssFcEc/modules.tar.xz
> --rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz
> --parameters SKIPFILE=skipfile-lkft.yaml --image
> docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests kunit --timeouts
> boot=30
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

