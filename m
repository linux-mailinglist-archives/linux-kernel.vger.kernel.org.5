Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1579CB18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjILJGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjILJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:05:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691310DE;
        Tue, 12 Sep 2023 02:03:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7080DC433C7;
        Tue, 12 Sep 2023 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694509434;
        bh=mvXVHwykddISCxjGxd+zXeSEBkkTdccCqUNjt0wXkhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3aItyTpPCH0WRFAATLYobcHCumrLbWrZEHwtiVvodGHMsJpMzaSf8aEc+40cJA2L
         OYWJtJL9QrDtBoYC5UVaeIVoFbIvtEG+a31XZuVLsY832sGU5fhJEtBpcMh0XoEtdm
         oZksLI0Rm9veRFQqi218uTHCwq048bfiMRxuxoYA=
Date:   Tue, 12 Sep 2023 11:03:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     jack@suse.cz, stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
Message-ID: <2023091217-reflux-playroom-017a@gregkh>
References: <20230911134633.619970489@linuxfoundation.org>
 <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
 <CAEUSe7_XA16yZAHA+YTbJygwaUYkU5gs=FnV9BAmQRYzwgVjvQ@mail.gmail.com>
 <CA+G9fYsiWEKSV0EeU0cXsJZ3U75fbdGyCmDx07ksFMUW5jouyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsiWEKSV0EeU0cXsJZ3U75fbdGyCmDx07ksFMUW5jouyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:19:34PM +0530, Naresh Kamboju wrote:
> On Tue, 12 Sept 2023 at 07:55, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> >
> > Hello!
> >
> > On Mon, 11 Sept 2023 at 14:58, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > On 11/09/23 7:40 a. m., Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.53 release.
> > > > There are 600 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.53-rc1.gz
> > > > or in the git tree and branch at:
> > > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > We're seeing this new warning:
> > > -----8<-----
> > >    /builds/linux/fs/udf/inode.c:892:6: warning: variable 'newblock' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > >      892 |         if (*err < 0)
> > >          |             ^~~~~~~~
> > >    /builds/linux/fs/udf/inode.c:914:9: note: uninitialized use occurs here
> > >      914 |         return newblock;
> > >          |                ^~~~~~~~
> > >    /builds/linux/fs/udf/inode.c:892:2: note: remove the 'if' if its condition is always false
> > >      892 |         if (*err < 0)
> > >          |         ^~~~~~~~~~~~~
> > >      893 |                 goto out_free;
> > >          |                 ~~~~~~~~~~~~~
> > >    /builds/linux/fs/udf/inode.c:699:34: note: initialize the variable 'newblock' to silence this warning
> > >      699 |         udf_pblk_t newblocknum, newblock;
> > >          |                                         ^
> > >          |                                          = 0
> > >    1 warning generated.
> > > ----->8-----
> > >
> > > That's with Clang 17 (and nightly) on:
> > > * arm
> > > * powerpc
> > > * s390
> >
> > For what it's worth, bisection points to 903b487b5ba6 ("udf: Handle
> > error when adding extent to a file").
> 
> I see the following commit is fixing the reported problem.
> 
> commit 6d5ab7c2f7cf90877dab8f2bb06eb5ca8edc73ef
> Author: Tom Rix <trix@redhat.com>
> Date:   Fri Dec 30 12:53:41 2022 -0500
> 
>     udf: initialize newblock to 0
> 
>     The clang build reports this error
>     fs/udf/inode.c:805:6: error: variable 'newblock' is used
> uninitialized whenever 'if' condition is true
> [-Werror,-Wsometimes-uninitialized]
>             if (*err < 0)
>                 ^~~~~~~~
>     newblock is never set before error handling jump.
>     Initialize newblock to 0 and remove redundant settings.
> 
>     Fixes: d8b39db5fab8 ("udf: Handle error when adding extent to a file")

Ah, the Fixes: tag lied!  There is no such git id in Linus's tree
anywhere, so our scripts couldn't match this up at all.

I'll go queue this fix up, thanks for digging it out.

greg k-h
