Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FCB7CB11E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjJPRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjJPRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:11:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36D7D83;
        Mon, 16 Oct 2023 09:58:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42050C433C7;
        Mon, 16 Oct 2023 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697475515;
        bh=3qHXcmJIKLhL1W+OzhIxa9DzVfCA8XVPdgV3E0lUH1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6Ft+uqNVHPf8a49PWFkg4hO3X8LT7hexKWo+emfUE+t/5pRB9wk2mJbVXZrG5P0h
         hGE3vw6Yx/7RJQ7G76vZPpy72s5VmB1T5PNi5wuA8/8Kiu9t3jSwhnFuNvVE6DYk6Y
         c8c7LBT8eng0YZHDSDkpGHRIn4adPh34MIUf82vI=
Date:   Mon, 16 Oct 2023 18:58:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Message-ID: <2023101655-throng-rickety-ff79@gregkh>
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:23:36PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 16/10/23 8:44 pm, Greg Kroah-Hartman wrote:
> > On Mon, Oct 16, 2023 at 07:06:20PM +0530, Harshit Mogalapalli wrote:
> > > Hi Greg,
> > > 
> > > On 16/10/23 2:09 pm, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.136 release.
> > > > There are 102 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > I am seeing a build failure while compiling tools/perf/
> > > 
> > > In file included from tests/genelf.c:14:
> > > tests/../util/genelf.h:5:10: fatal error: linux/math.h: No such file or
> > > directory
> > >   5 | #include <linux/math.h>
> > >   | ^~~~~~~~~~~~~~
> > > compilation terminated.
> > > 
> > > Patch 43 in this series is causing this.
> > 
> 
> Sorry for the confusion.
> 
> > What is patch 43?
> 
> It is patch 42/102 in this series
> 
> https://lore.kernel.org/stable/2023101641-resource-scalding-3e1d@gregkh/T/#m70a2a03b6204085af187184af911570681e744f5
> 
> Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
> 
> 
> > 
> > > Why is this not reproducible upstream ?
> > > 
> > > Vegard bisected the commit which makes it not reproducible upstream and this
> > > commit is missing in 5.15.y:
> > > Commit: d6e6a27d960f ("tools: Fix math.h breakage")
> > > 
> > > Backport request for this was made here:
> > > https://lore.kernel.org/all/CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com/
> > 
> > And that commit is in this patch series, so are you sure that was
> > correct?
> > 
> 
> Cause for this build issue:
> Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
> 
> And this issue is not in upstream due to presence of commit d6e6a27d960f
> ("tools: Fix math.h breakage") in upstream but not in 5.15.y

Ok, I'll go drop the patch entirely, I can't even get perf to build at
all for me on 5.15, which is why I've given up on it even mattering
anymore :(

thanks,

greg k-h
