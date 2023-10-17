Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D77CC59B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjJQOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbjJQOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:08:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD65F5;
        Tue, 17 Oct 2023 07:08:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81F4C433C7;
        Tue, 17 Oct 2023 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697551706;
        bh=sB/IxENRml1bMLL2KETfFO8TryY9k1wPmlB1Bd0sJhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQTnXIIpAo/WnurjNMTEEkJHkisaOG+kApNRBahR4znSOEZL8HqoAQd0cyCLjBPS1
         kRCm6GeFm5gyhr029OGaEt8SH9TA03M6+sZAw1AJG996lOt4LfRfrlREdIyKEx3SCg
         KwD7I9jdOL8KT8gAsbZss8eCnE3sHxttEHjoEFO8=
Date:   Tue, 17 Oct 2023 16:08:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Message-ID: <2023101719-anteater-deviant-bdf9@gregkh>
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh>
 <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
 <2023101716-sporting-geology-2de2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023101716-sporting-geology-2de2@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 03:57:06PM +0200, Greg Kroah-Hartman wrote:
> Sure!  Here's the output, good luck!
> 
> $ make -C tools/perf
> make: Entering directory '/home/gregkh/linux/stable/linux-5.15.y/tools/perf'
>   BUILD:   Doing 'make -j20' parallel build
> Warning: Kernel ABI header at 'tools/include/uapi/linux/const.h' differs from latest version at 'include/uapi/linux/const.h'
> diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
> Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
> diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
> diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
> diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/asm/required-features.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
> diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
> diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
> Makefile.config:1036: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1062: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
> tests/bpf.c: In function ‘epoll_pwait_loop’:
> tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Werror=nonnull]
>    36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
>       |                 ^~~~~~~~~~~
> In file included from tests/bpf.c:5:
> /usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ declared ‘nonnull’
>   134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
>       |            ^~~~~~~~~~~

<snip>

Also, in Linus's tree, this works just fine on my system, but I get this
same error above (and only this error), when building perf on 6.1.y, and
on 6.5.y.  The perl errors are not present there.

thanks,

greg k-h
