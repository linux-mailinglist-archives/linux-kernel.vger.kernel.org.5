Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167FF7E49C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjKGUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjKGUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:22:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3F71737;
        Tue,  7 Nov 2023 12:22:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BFEC433C9;
        Tue,  7 Nov 2023 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699388548;
        bh=B+YmIgmEttrAvv5Hnk3++lIKvCuVEgeEMhcwRK+abFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKCftizdNq+DHRrrXM/Fg+I1wLwXUjiJIXIumLpGl33LNnOV11eJq470o0G9FSkmN
         aCIU9GmoPp9f/5J6g0awHWNcrR+DZgC4QnzEcEDQ880Ib40nFHJ2YOkR1YfZMpJs1B
         Slu4zqtrUBm6L8kLe58D5tVHiO3aCePzJc7aPQcY=
Date:   Tue, 7 Nov 2023 21:22:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
Message-ID: <2023110716-attic-rebuff-fdf1@gregkh>
References: <20231106130304.678610325@linuxfoundation.org>
 <f643650a-d520-4789-b67c-4f8da46fee73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f643650a-d520-4789-b67c-4f8da46fee73@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:37:56AM -0800, Florian Fainelli wrote:
> On 11/6/23 05:03, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.200 release.
> > There are 95 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> perf fails to build with:
> 
> util/evlist.c: In function 'evlist__add_aux_dummy':
> util/evlist.c:269:31: warning: implicit declaration of function
> 'evlist__dummy_event'; did you mean 'evsel__is_dummy_event'?
> [-Wimplicit-function-declaration]
>   269 |         struct evsel *evsel = evlist__dummy_event(evlist);
>       |                               ^~~~~~~~~~~~~~~~~~~
>       |                               evsel__is_dummy_event
> util/evlist.c:269:31: warning: initialization of 'struct evsel *' from 'int'
> makes pointer from integer without a cast [-Wint-conversion]
> 
> ...
> 
>   LINK /local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf
> /local/stbopt_p/toolchains_303/stbgcc-12.3-0.2/bin/../lib/gcc/aarch64-unknown-linux-musl/12.3.0/../../../../aarch64-unknown-linux-musl/bin/ld: /local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf-in.o:
> in function `evlist__add_aux_dummy':
> /local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/evlist.c:269:
> undefined reference to `evlist__dummy_event'
> collect2: error: ld returned 1 exit status

Will go fix that now, thanks.

greg k-h
