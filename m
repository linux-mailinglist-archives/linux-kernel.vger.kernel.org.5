Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8C756E02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGQUNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:13:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EB123;
        Mon, 17 Jul 2023 13:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A1E61248;
        Mon, 17 Jul 2023 20:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F31C433C7;
        Mon, 17 Jul 2023 20:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689624822;
        bh=reGWOw1zaIBmN1HJn1jgl6IT8kaZg+aTKCsct6D9QoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWIcM5ugv3qbf9chkKtpx0QC5+O6exp28KztSGb0JRGxWWqGvG2ghLKS5BOKIuhEr
         rWMYg5rz7WIRRDdzvD0Q25T5LYk2vJVZSGNSiZiuj9F2+a5BjCSROmobo9VBqNt0jQ
         k9j41Z0LiSYO39G5srQsneQGje71vNoKV2PmHM+E=
Date:   Mon, 17 Jul 2023 22:13:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/585] 6.1.39-rc2 review
Message-ID: <2023071758-sizzling-cake-92bf@gregkh>
References: <20230717185609.886113843@linuxfoundation.org>
 <5f514ecc-a0ae-ece1-a212-e392c128fb35@roeck-us.net>
 <2023071742-jailhouse-rambling-7311@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023071742-jailhouse-rambling-7311@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 09:31:11PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 17, 2023 at 12:18:05PM -0700, Guenter Roeck wrote:
> > On 7/17/23 11:57, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.39 release.
> > > There are 585 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed, 19 Jul 2023 18:55:09 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc2.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > -------------
> > > Pseudo-Shortlog of commits:
> > > 
> > [ ... ]
> > 
> > > Sergey Shtylyov <s.shtylyov@omp.ru>
> > >      sh: Avoid using IRQ0 on SH3 and SH4
> > > 
> > 
> > This patch is applied without its fixes. That means almost all sh boards,
> > including the one testable with qemu, are broken. Fixes are (at least):
> > 
> > 7c28a35e19fa sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ
> > 3d20f7a6eb76 sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux
> > a2601b8d8f07 sh: mach-highlander: Handle virq offset in cascaded IRL demux
> > ab8aa4f0956d sh: mach-r2d: Handle virq offset in cascaded IRL demux
> > 
> > That list may be incomplete.
> 
> Oh wow, something went wrong with my "find the fixes for the patches in
> the queue" script, let me go figure it out and run it again here...

Yes, I didn't run it against what is in v6.5-rc1..v6.5-rc2, so it caught
fixes for this.  I'll push out -rc3 versions now.

thanks,

greg k-h
