Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46A67AB677
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjIVQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:50:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39140F1;
        Fri, 22 Sep 2023 09:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511B3C433C8;
        Fri, 22 Sep 2023 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695401396;
        bh=0xBnXjW3loV9628S4jtACHr/cDQh7s6GnO30Dk/zW84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzSy6ZoF/w80FXor4EBOcj8a3gitrilQBH11kEMNDtoklpAIqaI6Z/OrnBloHghoX
         t+Tpq9ksXFkhNXW0slSG/HSQXaCEsMsGAKNobpy9cUMdOA8c6A8rTHoetOm0ZTNkzs
         KL38kGIfTQrdv2UqR7oSYhzbVfrQ0dUT4BYnNCOc=
Date:   Fri, 22 Sep 2023 18:49:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Message-ID: <2023092218-nacho-urgent-9466@gregkh>
References: <20230920112835.549467415@linuxfoundation.org>
 <79a96d41-1b79-51b4-fda0-743b853213b9@nvidia.com>
 <7e0355bd-64cd-f6c2-b720-e4643579078c@nvidia.com>
 <53c9f81e-55b9-b8bb-7821-cb124780d4c0@roeck-us.net>
 <CAJs_Fx6-AWA1fxgV1u=ycn2YXm3D0GnGQeC1UR8QwVXFKDGJqw@mail.gmail.com>
 <2023092216-poser-nickname-b882@gregkh>
 <2023092209-qualified-consumer-84bb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023092209-qualified-consumer-84bb@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 06:25:45PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 22, 2023 at 06:17:25PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 22, 2023 at 08:00:31AM -0700, Rob Clark wrote:
> > > On Fri, Sep 22, 2023 at 7:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On 9/22/23 05:31, Jon Hunter wrote:
> > > > >
> > > > > On 22/09/2023 10:45, Jon Hunter wrote:
> > > > >> Hi Greg,
> > > > >>
> > > > >> On 20/09/2023 12:28, Greg Kroah-Hartman wrote:
> > > > >>> This is the start of the stable review cycle for the 6.1.55 release.
> > > > >>> There are 139 patches in this series, all will be posted as a response
> > > > >>> to this one.  If anyone has any issues with these being applied, please
> > > > >>> let me know.
> > > > >>>
> > > > >>> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> > > > >>> Anything received after that time might be too late.
> > > > >>>
> > > > >>> The whole patch series can be found in one patch at:
> > > > >>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
> > > > >>> or in the git tree and branch at:
> > > > >>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > >>> and the diffstat can be found below.
> > > > >>>
> > > > >>> thanks,
> > > > >>>
> > > > >>> greg k-h
> > > > >>
> > > > >> I am seeing some suspend failures with this update ...
> > > > >>
> > > > >> Test results for stable-v6.1:
> > > > >>      11 builds:    11 pass, 0 fail
> > > > >>      28 boots:    28 pass, 0 fail
> > > > >>      130 tests:    124 pass, 6 fail
> > > > >>
> > > > >> Linux version:    6.1.55-rc1-gd5ace918366e
> > > > >> Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
> > > > >>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
> > > > >>                  tegra20-ventana, tegra210-p2371-2180,
> > > > >>                  tegra210-p3450-0000, tegra30-cardhu-a04
> > > > >>
> > > > >> Test failures:    tegra124-jetson-tk1: pm-system-suspend.sh
> > > > >>                  tegra186-p2771-0000: pm-system-suspend.sh
> > > > >>                  tegra20-ventana: pm-system-suspend.sh
> > > > >>                  tegra30-cardhu-a04: pm-system-suspend.sh
> > > > >>
> > > > >> Bisect is underway.
> > > > >
> > > > >
> > > > > Bisect for this issue is also pointing to ...
> > > > >
> > > > > Rob Clark <robdclark@chromium.org>
> > > > >       interconnect: Fix locking for runpm vs reclaim
> > > > >
> > > > > Looks like all the Tegra issues are related to this.
> > > > >
> > > >
> > > > This isn't surprising because upstream commit 136191703038 ("interconnect: Teach
> > > > lockdep about icc_bw_lock order") silently fixes it without Fixes: tag. If you
> > > > look into that patch you'll see that the the missing call to mutex_unlock() is
> > > > added to icc_sync_state().
> > > 
> > > Oh, indeed, it looks like that hunk ended up in the wrong commit, and
> > > I didn't notice because both were merged at the same time
> > 
> > Thanks, I've queued that fix up now as well.
> 
> And that breaks on older kernels, let me drop the interconnect patches
> completely and I'll wait for someone to submit a full, working, set for
> stable inclusion to add them back at a later time if wanted.

Ok, I'll just do that for 5.10, and leave it for the others.

greg k-h
