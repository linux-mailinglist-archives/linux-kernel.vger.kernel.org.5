Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4363C7ABED3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjIWIWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjIWIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:22:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38DA180;
        Sat, 23 Sep 2023 01:21:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E5AC433C8;
        Sat, 23 Sep 2023 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457317;
        bh=cgt8U+WuuxOkmJa3l0IV5IeSzT0CfYQS+6r9yIt3bBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfOegEcpcTy5DHqp01qhSo77COjWJ3g2/zHIxlfCtbXUuMy4ms/kZo6fA7oUvniIX
         1199CzYW5/E80ozvNxhTqctlYB6WiAMLOodHDWtQJKs/P2N3bt4IFK4/XXq80jUC97
         iLmSgk2Tbx6FNZYftZZYRwNvJ2i2NRBAzoTLZRM8=
Date:   Sat, 23 Sep 2023 10:21:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
Message-ID: <2023092349-hamstring-galvanize-2318@gregkh>
References: <20230920112830.377666128@linuxfoundation.org>
 <6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:47:17AM -0700, Florian Fainelli wrote:
> On 9/20/23 04:30, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.133 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.133-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Same thing as with 5.10 on ARM, ARM64 and MIPS:
> 
>   CC /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events.o
> fixdep: error opening depfile: /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/.pmu-events.o.d:
> No such file or directory
> make[5]: *** [pmu-events/Build:33: /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events.o]
> Error 2
> make[4]: *** [Makefile.perf:668: /local/users/fainelli/buildroot/output/bmips/build/linux-custom/tools/perf/pmu-events/pmu-events-in.o]
> Error 2
> make[3]: *** [Makefile.perf:238: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
> make[1]: *** [package/pkg-generic.mk:294:
> /local/users/fainelli/buildroot/output/bmips/build/linux-tools/.stamp_built]
> Error 2
> make: *** [Makefile:27: _all] Error 2
> 
> reverting 95466975f143df7423bbf4905348c7b6260f4d29 ("perf build: Update
> build rule for generated files") and
> 12ff96780ebd93d1aacb396994e3a32b50dccecf ("perf jevents: Switch build to use
> jevents.py") gets us going again.

Now dropped from all queues, thanks!

greg k-h
