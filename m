Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB17BB4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJFKNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjJFKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:13:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C78F7;
        Fri,  6 Oct 2023 03:12:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127D4C433C8;
        Fri,  6 Oct 2023 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696587178;
        bh=5EsPB5exUzDSp/zAgvqbx2CniTkzicOjf46c+7+WITE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIrcs0lTEIfYgc+vHhjNSyLZdIZndHXdeloDkkAVJHH1oWsxWfggKbcgh5+NvMind
         L+vqXUw6eSPV904cvLjBIl/IxrXR6PcwlMb3RHwSAOHyeHEfWiZcav8t8jF8ngL8QC
         VGxYFuFYpyZIur+qFb5Bkx3BttuI/8271HrVtlOk=
Date:   Fri, 6 Oct 2023 12:12:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <2023100648-lizard-briskly-f6ac@gregkh>
References: <20231004175217.404851126@linuxfoundation.org>
 <20231005081746.D7B7.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005081746.D7B7.409509F4@e16-tech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:17:48AM +0800, Wang Yugui wrote:
> Hi,
> 
> > This is the start of the stable review cycle for the 6.1.56 release.
> > There are 259 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> 
> This 6.1.56-rc1 failed to build on rhel7 with dev-tool-set 8, but 6.1.55 works.
> 
> Build error message:
> gcc: fatal error: no input files
> make[3]: *** [pmu-events/Build:33: pmu-events/pmu-events.o] Error 1
> 
> After the revert of 'perf-build-update-build-rule-for-generated-files.patch'
> the build works again.

Offending patch dropped, thanks.

greg k-h
