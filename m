Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5F7EE244
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbjKPODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbjKPOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441DA1FD8;
        Thu, 16 Nov 2023 06:02:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9EC433C7;
        Thu, 16 Nov 2023 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700143355;
        bh=3d0Qc1WI2uyDpZOPa1FKam+nYjh1nVrhRDwnYe0liYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMQAzl1JxTPxFub/lrXbHVRfo2OvhFZdPwJVXRCxYXVhgC2GOwiJtDU/JkgOgurA/
         DdrXl9mbOjkW21Y2xkOXxgP/igvB73iEOGPWyBytRofAU7kJmraL8e5gyyKL7209Yq
         uBqqiKqaoKBZE+1L7pYOvs3L9leNh/p5eeMGjtZG2R42ADGdWbcOfMUGNPa1WFHuaF
         ttHGoYyoKrtDGzkaz58mVudiCi+1HugoHie2jx1dBza/WmhG2LgkwJbQOmp48T5LJs
         i3gjplA0c4Mza7Dp6MLrnkTuSBPMqwYZkj4HEM7ol112TSIoe6ffkFQ0zjUDNUk5vc
         yfcKUY0yCEkwA==
Date:   Thu, 16 Nov 2023 09:02:34 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     David Gow <davidgow@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, kunit-dev@googlegroups.com,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Subject: Re: [PATCH 6.5 000/550] 6.5.12-rc1 review
Message-ID: <ZVYg-hRRg6Npn2Gt@sashalap>
References: <20231115191600.708733204@linuxfoundation.org>
 <CAEUSe7_KQ_-Q2ADLVcuKjb9vGOpkgAEgzgq5o-Hf=7a7c9NLXw@mail.gmail.com>
 <CAEUSe7_cN0g=i_kS29zbEYdA81ruZNbAA42eYAjRdCDJFSaT+w@mail.gmail.com>
 <CA+G9fYuncLhP1=BWQv561Jh5cZH9EDmnqnH3Znugi+eua5S0MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuncLhP1=BWQv561Jh5cZH9EDmnqnH3Znugi+eua5S0MA@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 06:45:52PM +0530, Naresh Kamboju wrote:
>+ kunit team
>
>On Thu, 16 Nov 2023 at 05:30, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>>
>> Hello!
>>
>> On Wed, 15 Nov 2023 at 15:38, Daniel Díaz <daniel.diaz@linaro.org> wrote:
>> > On Wed, 15 Nov 2023 at 13:20, Greg Kroah-Hartman
>> > <gregkh@linuxfoundation.org> wrote:
>> > > This is the start of the stable review cycle for the 6.5.12 release.
>> > > There are 550 patches in this series, all will be posted as a response
>> > > to this one.  If anyone has any issues with these being applied, please
>> > > let me know.
>> > >
>> > > Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
>> > > Anything received after that time might be too late.
>> > >
>> > > The whole patch series can be found in one patch at:
>> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.12-rc1.gz
>> > > or in the git tree and branch at:
>> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
>> > > and the diffstat can be found below.
>> > >
>> > > thanks,
>> > >
>> > > greg k-h
>> >
>> > We're seeing build regressions on Arm, Arm64, i386, x86, with KUnit
>> > defconfigs (and multi_v5_defconfig on Arm32):
>> > -----8<-----
>> >   In file included from /builds/linux/lib/kunit/executor.c:225:
>> >   /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set':
>> >   /builds/linux/lib/kunit/executor_test.c:130:30: error: invalid use
>> > of undefined type 'struct kunit_suite_set'
>> >     130 |         kunit_free_suite_set(*(struct kunit_suite_set *)suite_set);
>> >         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> >   /builds/linux/lib/kunit/executor_test.c: In function 'free_suite_set_at_end':
>> >   /builds/linux/lib/kunit/executor_test.c:141:49: error: invalid use
>> > of undefined type 'struct kunit_suite_set'
>> >     141 |         if (!((struct kunit_suite_set *)to_free)->start)
>> >         |                                                 ^~
>> >   /builds/linux/lib/kunit/executor_test.c:144:31: error: invalid
>> > application of 'sizeof' to incomplete type 'struct kunit_suite_set'
>> >     144 |         free = kzalloc(sizeof(struct kunit_suite_set), GFP_KERNEL);
>> >         |                               ^~~~~~
>> >   /builds/linux/lib/kunit/executor_test.c:145:17: error: invalid use
>> > of undefined type 'struct kunit_suite_set'
>> >     145 |         *free = *(struct kunit_suite_set *)to_free;
>> >         |                 ^
>> >   /builds/linux/lib/kunit/executor_test.c:145:15: error: invalid use
>> > of undefined type 'struct kunit_suite_set'
>> >     145 |         *free = *(struct kunit_suite_set *)to_free;
>> >         |               ^
>> >   make[5]: *** [/builds/linux/scripts/Makefile.build:243:
>> > lib/kunit/executor.o] Error 1
>> > ----->8-----
>> >
>> > This is with defconfig, CONFIG_KASAN=y, CONFIG_KUNIT=y, and
>> > CONFIG_KUNIT_ALL_TESTS=y. To reproduce,
>> >
>> > tuxmake \
>> >   --runtime podman \
>> >   --target-arch arm64 \
>> >   --toolchain gcc-13 \
>> >   --kconfig defconfig \
>> >   --kconfig-add CONFIG_KASAN=y \
>> >   --kconfig-add CONFIG_KUNIT=y \
>> >   --kconfig-add CONFIG_KUNIT_ALL_TESTS=y
>> >
>> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> >
>> > Bisection is on-going.
>
>Thanks Daniel for bisecting this.
>
>> Bisection points to 3aed6e0618a9 ("kunit: test: Fix the possible
>> memory leak in executor_test"), upstream commit
>> 8040345fdae4cb256c5d981f91ae0f22bea8adcc. Reverting this commit brings
>> happiness back to the build.
>>
>> This problem is not observed on other branches.
>
>stable-rc linux-6.6.y - kunit build pass
>stable-rc linux-6.5.y - kunit build failed

Dropping the offending patch from 6.5, thanks!

-- 
Thanks,
Sasha
