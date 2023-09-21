Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD27AA002
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjIUU3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjIUU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:29:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269857B462;
        Thu, 21 Sep 2023 10:37:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E54C433AD;
        Thu, 21 Sep 2023 07:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695280397;
        bh=x6BlTSESHv0WOlUjZBFf7l1hNElIvW/QK5IYHQsxdnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOG/GtzpdZ6fKTbu7bwE8JZTsAYH8Mrh0VxH+3Ui+QkMyKgVIj/fI3zUjIltrXetl
         jSCh54mrGeo6oAq92d5bWKuSxOlC9hvnDQBCnd7/Gx6FbR7aJVufEETB+FzRH0+pO2
         2X2+DOXVmYemtaJPCW4aoGbZ09JjVqo9Ic1wJqhA=
Date:   Thu, 21 Sep 2023 09:13:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
Message-ID: <2023092111-grill-excusable-f67a@gregkh>
References: <20230917191101.035638219@linuxfoundation.org>
 <07a04540-554c-4394-1e79-46ea665f8c03@roeck-us.net>
 <2023092009-angriness-sank-ae4f@gregkh>
 <27f978f3-11ca-6054-5160-ab66d4c918bc@roeck-us.net>
 <8457ff12-c28b-898b-3f12-97aa12ce6716@gmail.com>
 <ZQtEVR+Vc6CD6iUG@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQtEVR+Vc6CD6iUG@westworld>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:13:25PM -0700, Kyle Zeng wrote:
> On Wed, Sep 20, 2023 at 10:01:55AM -0700, Florian Fainelli wrote:
> > On 9/20/23 08:18, Guenter Roeck wrote:
> > > On 9/20/23 01:11, Greg Kroah-Hartman wrote:
> > > > On Tue, Sep 19, 2023 at 09:57:25PM -0700, Guenter Roeck wrote:
> > > > > On 9/17/23 12:07, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 5.10.195 release.
> > > > > > There are 406 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > 
> > > > > chromeos-5.10 locks up in configfs_lookup() after the merge of
> > > > > v5.10.195.
> > > > > 
> > > > > I am a bit puzzled because I see
> > > > > 
> > > > > c709c7ca020a configfs: fix a race in configfs_lookup()
> > > > > 
> > > > > in v5.10.195 but not in the list of commits below. I guess I must be
> > > > > missing something.
> > > > 
> > > > It was part of the big patchset, it was posted here:
> > > >     https://lore.kernel.org/r/20230917191101.511939651@linuxfoundation.org
> > > > 
> > > > Not hidden at all :)
> > > > 
> > > > and was submitted here:
> > > >     https://lore.kernel.org/r/ZPOZFHHA0abVmGx+@westworld
> > > > 
> > > > > Either case, the code now looks as follows.
> > > > > 
> > > > > configfs_lookup()
> > > > > {
> > > > >      ...
> > > > >      spin_lock(&configfs_dirent_lock);
> > > > >      ...
> > > > >          err = configfs_attach_attr(sd, dentry);
> > > > >      ...
> > > > >      spin_unlock(&configfs_dirent_lock);
> > > > >      ...
> > > > > }
> > > > > 
> > > > > and
> > > > > 
> > > > > configfs_attach_attr(...)
> > > > > {
> > > > >      ...
> > > > >      spin_lock(&configfs_dirent_lock);
> > > > >      ...
> > > > > }
> > > > > 
> > > > > which unless it is way too late here and I really need to go to sleep
> > > > > just won't work.
> > > > 
> > > > Kyle, you did the backport, any comments?
> > > > 
> > > 
> > > After a good night sleep, the code still looks wrong to me. Reverting
> > > the offending patch in chromeos-5.10 solved the problem there.
> > > That makes me suspect that no one actually tests configfs.
> > 
> > Humm indeed, looking at our testing we don't have our USB devices being
> > tested which would exercise configfs since we switch the USB device between
> > different configurations (mass storage, serial, networking etc.). Let me see
> > about adding that so we get some coverage.
> > -- 
> > Florian
> > 
> 
> Sorry for the wrong patch. My intention was to backport c42dd069be8dfc9b2239a5c89e73bbd08ab35de0
> to v5.10 to avoid a race condition triggered in my test. I tested the
> patch with my PoC program and made sure it won't trigger the crash. But
> I didn't notice that it could hang the kernel.
> I sincerely apologize for the mistake.
> 
> My new proposed patch backports both
> c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 and d07f132a225c013e59aa77f514ad9211ecab82ee.
> I made sure it does not trigger the race condition anymore.
> Can anyone having access to more comprehensive tests please check whether it works?
> 
> Also, I'm not sure whether it is OK or how to backport two patches in
> one patch. Please advise on how to do it properly.

Please backport them both individually, do not merge them together.

I'll go revert the current change now and push out a release with it so
that it fixes users of this kernel tree.

thanks,

greg k-h
