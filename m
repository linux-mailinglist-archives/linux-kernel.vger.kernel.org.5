Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79595784640
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjHVPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbjHVPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:51:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90FCFC;
        Tue, 22 Aug 2023 08:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1DBC62767;
        Tue, 22 Aug 2023 15:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173BC433C7;
        Tue, 22 Aug 2023 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692719490;
        bh=8r5wK6+p4g5NPBO4n/lgQBJ1t2Fb8idUoSt4ISx/GiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DatrFVi5zbxUmHfmOKsvyAGuIpDe1jIiBfQ+8c07La5XX0piFg/qBzizNzxLLYg6E
         zXDWMPo305fjxLtDzak+sK05CHiifu4RafF/f0whYp8L0AXWuMnp0rAfrHUm7RudpA
         eAnz0wt2CN6Kq+AlRu918GbcxIggGBZnx8CV4SoY=
Date:   Tue, 22 Aug 2023 17:51:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2023082241-extradite-overpay-1754@gregkh>
References: <20230821194122.695845670@linuxfoundation.org>
 <CA+G9fYvkBSb-i_6unB3bRLwRibVtZ3snYDe_gG+bsZehu3Hv3w@mail.gmail.com>
 <ZOTTxsW5IGhOO8IW@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOTTxsW5IGhOO8IW@eldamar.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:27:02PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> [Adding Peter Zijlstra to CC]
> 
> On Tue, Aug 22, 2023 at 04:25:22PM +0530, Naresh Kamboju wrote:
> > On Tue, 22 Aug 2023 at 01:21, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.47 release.
> > > There are 194 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> > 
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > 
> > NOTE:
> > Kernel warnings noticed on x86_64 while booting the kernel.
> > Paul E. McKenney reported this last week [1] and discussions email
> > thread provided here.
> > 
> >  [1] https://lore.kernel.org/lkml/4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop/T/
> 
> Seeing the same warning for the 6.1.47-rc1, which is missing
> 4ae68b26c3ab ("objtool/x86: Fix SRSO mess"). Unfortunately the commit
> will not apply cleanly to 6.1.y. 

I tried, and failed, let me try again...

> I guess we need at least as well dbcdbdfdf137 ("objtool: Rework
> instruction -> symbol mapping"), but not sure this is enough.

That gets messy fast, I tried to backport all of the 6.4 objtool changes
to 6.1, but ugh, the changes were highly intertwined with many other
things.

greg k-h
