Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9358E7CA13C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjJPIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPIGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:06:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2770DE;
        Mon, 16 Oct 2023 01:06:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FABC433C8;
        Mon, 16 Oct 2023 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697443613;
        bh=H2UJnjnsQ05QQo/guMGEnLx/+oDV2MPXthqNff1/rik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7N4LfnlwZR1xK+R/oDA+fjTFeRR9oKuAmoCF6LLY8wI7H7jydIIL/UV7HZgxw7Wj
         T8cjOwI+FfAEL6g0Ld/Q5DXTGXcMr+sKR7Ai+EbfZ4XBlZsipy42iN5OxkX5ffbksL
         2WIDz4GcsR9sR8pNCjj/1ZqMU1zrgY+49YR/pI9c=
Date:   Mon, 16 Oct 2023 10:06:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <2023101641-judiciary-custody-d56e@gregkh>
References: <20231004175203.943277832@linuxfoundation.org>
 <CAEXW_YT6bH70M1TF2TttB-_kP=RUv_1nsy_sHYi6_0oCrX3mVQ@mail.gmail.com>
 <2023101110-resurface-nuclear-bfee@gregkh>
 <CAEXW_YRf0e6V6PcGJ-LWiS=ERgy4yxHoSG4d+DHLjXZ8Ah7kJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRf0e6V6PcGJ-LWiS=ERgy4yxHoSG4d+DHLjXZ8Ah7kJA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 10:25:40PM -0400, Joel Fernandes wrote:
> On Wed, Oct 11, 2023 at 1:44 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 11, 2023 at 11:58:49AM -0400, Joel Fernandes wrote:
> > > Hello Greg,
> > >
> > > On Sat, Oct 7, 2023 at 9:00 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 5.15.134 release.
> > > > There are 183 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > [...]
> > > > Liam R. Howlett <Liam.Howlett@oracle.com>
> > > >     kernel/sched: Modify initial boot task idle setup
> > > >
> > >
> > > Let us drop this patch because it caused new tasks-RCU warnings (both
> > > normal and rude tasks RCU) in my stable test rig. We are discussing
> > > the "right fix" and at that time a backport can be done.
> > >
> > > Hope Liam is also Ok with that. I am happy to do that future backport if needed.
> >
> > This is already in a released kernel, a bunch of them:
> >         5.15.134 6.1.56 6.5.6 6.6-rc3
> > should it be reverted from all of the stable releases, or just for
> > 5.15.y?
> 
> Just 5.15.y. The others don't have an issue with the patch per my tests.

Ok, now reverted, thanks.

greg k-h
