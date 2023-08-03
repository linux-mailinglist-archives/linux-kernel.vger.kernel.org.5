Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1C76ECBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjHCOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjHCOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF071BFD;
        Thu,  3 Aug 2023 07:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA47461DCC;
        Thu,  3 Aug 2023 14:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC28BC433C9;
        Thu,  3 Aug 2023 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691073336;
        bh=Sjjp7XGndfBwRu6tpBhweKgUIA9vJyDPGvO41Nk73gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f95oYBHelHYMdKIS9MPC2IhE4cVfy6q77OUwlvLtythihYTZFGy8lo4ivrNPt9r0O
         zJ8ZK4JaAbnmyLQRNMLswmbK0CrErfYbZSEUSqXdRbQK6WlKSxAuStf/PJk9rOZDWR
         Fb/HZzjjAXhssJQ+lrUPwCiRyU9c2Z0f4fOP5JSI=
Date:   Thu, 3 Aug 2023 16:35:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
Message-ID: <2023080325-smoky-grimacing-58b2@gregkh>
References: <20230802065510.869511253@linuxfoundation.org>
 <e5e1bccd-8e73-43c6-bc7c-052428e7c3d3@roeck-us.net>
 <2023080308-mountain-gyration-06ff@gregkh>
 <874c28aa-63da-df09-e44d-c6079771606b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874c28aa-63da-df09-e44d-c6079771606b@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:17:45AM -0700, Guenter Roeck wrote:
> On 8/3/23 00:32, Greg Kroah-Hartman wrote:
> > On Wed, Aug 02, 2023 at 04:18:19PM -0700, Guenter Roeck wrote:
> > > On Wed, Aug 02, 2023 at 09:41:55AM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.43 release.
> > > > There are 225 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > Build results:
> > > 	total: 157 pass: 157 fail: 0
> > > Qemu test results:
> > > 	total: 521 pass: 519 fail: 2
> > > Failed tests:
> > > 	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:rootfs
> > > 	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:rootfs
> > > 
> > > The failed tests crash while attempting to boot from a f2fs root file
> > > system, suggesting that f2fs support may be broken.
> > 
> > Thanks for letting me know.  I've now dropped the f2fs patches from this
> > queue.
> > 
> 
> Confirmed that v6.1.43 does not have the problem.

Wonderful, thanks for confirming!

greg k-h
