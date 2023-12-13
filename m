Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68339811B53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441849AbjLMRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:37:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BAE99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:37:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7905CC433C7;
        Wed, 13 Dec 2023 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702489075;
        bh=viG7AGNHVM+j/Siqe34sl7MtKrSza3x0N/RnzU7GrTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXMl99mb+3U6hbUTcdKvaoTXYjVfUtH/NB7jCFXl+PpYGZJZiL6tEx3PWkO5KbyU6
         hOengl1NuXpCaAQ+cbxH5ERo+Hrid2EHIhLsLtu/B0C/Q0NxmMFhextD1NDC3SFAhQ
         3TLE1spIGzsT2J9ZKFqhrNUbyKHv0amQBb5R96Ec=
Date:   Wed, 13 Dec 2023 18:37:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Pavel Machek <pavel@denx.de>, Guenter Roeck <linux@roeck-us.net>,
        grundler@chromium.org, davem@davemloft.net, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1
 review
Message-ID: <2023121322-mortician-superman-54a9@gregkh>
References: <20231211182036.606660304@linuxfoundation.org>
 <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
 <a6af01bf-7785-4531-8514-8e5eb09e207e@roeck-us.net>
 <ZXliuTqyO_IjlIz7@amd.ucw.cz>
 <2023121342-wanted-overarch-84a7@gregkh>
 <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WK52EjYh0nn8e0PEvY5ovUOn9rymnY09B7SQNgUXymPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 07:16:52AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Dec 13, 2023 at 12:50 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 08:52:25AM +0100, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > > This is the start of the stable review cycle for the 6.1.68 release.
> > > > > > There are 194 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > >
> > > > >
> > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
> > > > > >
> > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
> > > > > >
> > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > >      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
> > > > > >
> > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > >      r8152: Add RTL8152_INACCESSIBLE checks to more loops
> > > > > >
> > > > > > Douglas Anderson <dianders@chromium.org>
> > > > > >      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
> > > > >
> > > > > Central patch that actually fixes something is:
> > > > >
> > > > > commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
> > > > > Author: Douglas Anderson <dianders@chromium.org>
> > > > > Date:   Fri Oct 20 14:06:59 2023 -0700
> > > > >
> > > > >      r8152: Block future register access if register access fails
> > > > >
> > > > > ...but we don't have that in 6.1. So we should not need the rest,
> > > > > either.
> > > > >
> > > >
> > > > Also, the missing patch is fixed subsequently by another patch, so it can not
> > > > be added on its own.
> > >
> > > For the record I'm trying to advocate "drop all patches listed as they
> > > don't fix the bug", not "add more", as this does not meet stable
> > > criteria.
> >
> > But the original commit here does say it fixes a bug, see the text of
> > the commits listed above.  So perhaps someone got this all wrong when
> > they wrote the original commits that got merged into 6.7-rc?  Otherwise
> > this seems like they are sane to keep for now, unless the original
> > author says they should be dropped, or someone who can test this driver
> > says something went wrong.
> 
> Right. The patches that "add RTL8152_INACCESSIBLE" to more loops are
> bugfixes, but they're not terribly important ones to backport. While
> they technically make sense even on older kernels and could
> conceivably make the older kernels unload the r8152 driver a little
> faster when a device is unplugged, it's not a big deal. On the first
> version of the recent patches I didn't even add a "Fixes" tag for them
> but I was asked to during the review process.
> 
> The "add RTL8152_INACCESSIBLE" patches become more important with
> commit d9962b0d4202 ("r8152: Block future register access if register
> access fails"). Once you have that it's possible to end up in the
> "INACCESSIBLE" situation in response to normal (ish) error handling
> and thus you want it to be faster.
> 
> Based on our experience in ChromeOS, commit d9962b0d4202 ("r8152:
> Block future register access if register access fails") is a pretty
> important fix and I would say it should be backported to stable.
> Certainly we've backported it to our kernels in ChromeOS. In our case
> we made things easier on ourselves by backporting pretty much all
> patches to the r8152 driver.

Ok, as lots of fixes seem to be needed here, do you have a list of the
git ids that we should backport to bring this up to a workable state
like you have in your tree?

thanks,

greg k-h
