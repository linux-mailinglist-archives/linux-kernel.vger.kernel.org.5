Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D656B7BB766
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJFMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJFMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:15:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF162C2;
        Fri,  6 Oct 2023 05:15:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52027C433C8;
        Fri,  6 Oct 2023 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696594523;
        bh=1PPdkbMc/MyaGwiSwvJ6nfyD8SFhjrbhkH6vIXGUf7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUPW4UKophvwwFf4GMEXgZF7s5oJPpS2SYkLgBXXXAI+umJUE4mCKyAm8uCiNkAEC
         JUj5gUX9rH7CPAQzSSu+y62VuBaTOSB/TpffvfkzQG+VMilGWatfrYuKsqC5CNaV3g
         ErPOR04B8HQCNALB5DJwHCvg8eQMJiPaDVdwgf1J4VRvHGzxYFCPE/r2HR7eWMRY+u
         zHlMm+PF9XvZVvmJhjY2u3+0Y7j5VpwVFphTixIyT00X9wMESy2n+OflKWsz3PRRoP
         jfqF9wJ3RNLbWuSwdzCTuQZxtX/nlumbxNFQrUwgR+0ZAI7rTRqA5ChUMLHqacier9
         YmR/uFz0XjAEg==
Date:   Fri, 6 Oct 2023 08:15:22 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <ZR_6Wl_pNbdF9M-k@sashalap>
References: <20231004175203.943277832@linuxfoundation.org>
 <ec06c2fb-6737-489f-8439-307e0d84687b@gmail.com>
 <2023100601-ending-prevalent-c8d4@gregkh>
 <9fec75ba-a319-027c-6cf2-b65e703d3ce7@oracle.com>
 <2023100610-purge-pupil-b754@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023100610-purge-pupil-b754@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 01:03:30PM +0200, Greg Kroah-Hartman wrote:
>On Fri, Oct 06, 2023 at 04:07:14PM +0530, Harshit Mogalapalli wrote:
>>
>>
>> On 06/10/23 3:55 pm, Greg Kroah-Hartman wrote:
>> > On Wed, Oct 04, 2023 at 11:43:46AM -0700, Florian Fainelli wrote:
>> > > On 10/4/23 10:53, Greg Kroah-Hartman wrote:
>> > > > This is the start of the stable review cycle for the 5.15.134 release.
>> > > > There are 183 patches in this series, all will be posted as a response
>> > > > to this one.  If anyone has any issues with these being applied, please
>> > > > let me know.
>> > > >
>> > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
>> > > > Anything received after that time might be too late.
>> > > >
>> > > > The whole patch series can be found in one patch at:
>> > > > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
>> > > > or in the git tree and branch at:
>> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>> > > > and the diffstat can be found below.
>> > > >
>> > > > thanks,
>> > > >
>> > > > greg k-h
>> > >
>> > > perf fails to build with:
>> > >
>> > >    CC /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o
>> > > util/metricgroup.c: In function 'metricgroup__parse_groups':
>> > > util/metricgroup.c:1261:7: error: 'table' undeclared (first use in this
>> > > function)
>> > >    if (!table)
>> > >         ^~~~~
>> > > util/metricgroup.c:1261:7: note: each undeclared identifier is reported only
>> > > once for each function it appears in
>> > > make[6]: *** [/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o]
>> > > Error 1
>> > >
>> > > caused by c1ef510a0f2a879bf29ddebae766ec9f0790eb8f ("perf metric: Return
>> > > early if no CPU PMU table exists"). Dropping this commit allows the build to
>> > > continue.
>> > >
>> > > I had reported in the previous cycle that 00facc760903be66 ("perf jevents:
>> > > Switch build to use jevents.py") was causing build failures:
>> > >
>> > > https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/
>> > >
>> > > do we still want these commits to be included?
>> >
>> > No, I'll go drop them now, thanks for the report.
>>
>> Thought:
>> It's not the first time we see build failures in tools/perf -- would it make
>> sense to add this to your own build tests to reduce the round trip time for
>> these errors ?
>
>Last time I tried to build perf, I couldn't do it at all so I just gave
>up trying to test for it :)

Same... I've also removed perf from AUTOSEL for that reason.

-- 
Thanks,
Sasha
