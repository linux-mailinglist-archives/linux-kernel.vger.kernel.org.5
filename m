Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2B7D4A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjJXI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjJXI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:29:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CE111;
        Tue, 24 Oct 2023 01:29:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C96C433C9;
        Tue, 24 Oct 2023 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698136144;
        bh=S1fwa+yKgN2831wmbt3TORT2cVCQu6P6j/8mqIFK6ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jk1li0BECE3y8TirWrmyaRYD0ryon3PDbLqOR7a6XcFu+wIiNv1KuNOH1xhbnReNz
         urHqp0nRd+oG3SGHNTtO8brhHxTPtAFgp4ibvZXZRPEryJpIRvDDfNVW1s6zWWVetR
         VAThb7H1lrwTA7dJuTvTr2unF5vKyFKrH7ia4a9U=
Date:   Tue, 24 Oct 2023 10:29:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Pais <stable.kernel.dev@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
Message-ID: <2023102451-little-zoning-37c3@gregkh>
References: <20231023104820.849461819@linuxfoundation.org>
 <CAJq+SaDcwDtnLL0AHaBjXqXtPHo2RF9xVp2HptmSot67PV+Zkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq+SaDcwDtnLL0AHaBjXqXtPHo2RF9xVp2HptmSot67PV+Zkw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:04:38PM -0700, Allen Pais wrote:
> > This is the start of the stable review cycle for the 5.15.137 release.
> > There are 137 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> I see the following warnings too:
> 
> arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable instruction
> arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x43:
> unreachable instruction

This isn't new, right?

thanks,

greg k-h
