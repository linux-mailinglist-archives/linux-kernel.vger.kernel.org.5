Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBE7854E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHWKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjHWJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D8171A;
        Wed, 23 Aug 2023 02:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2210963E5F;
        Wed, 23 Aug 2023 09:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABE1C433C7;
        Wed, 23 Aug 2023 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692782786;
        bh=ITHYbCSa8xC05AhgVVAUPq+ran6o4m6ijJRCtqyDnaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=19arubAMz5JMa7tD64e+VmEucN4mlbKn4q1cPGDyJhN/7esJfQK1t6Ke8snvHrPfO
         RWssWDdFjrz8xrCedGg3agVoWv6o0vCV7P8gBSwZuTWJCu+h5dRj18lAwTPdwiR0tt
         O9kYIF86By6hESVzoIC8dtSJNhqe7ShOhGoOhlOA=
Date:   Wed, 23 Aug 2023 11:26:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2023082303-musky-plastic-335f@gregkh>
References: <20230821194122.695845670@linuxfoundation.org>
 <ZOXJVamgYV1Mb+7S@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOXJVamgYV1Mb+7S@debian>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:54:45AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi Greg,
> 
> On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.47 release.
> > There are 194 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > Anything received after that time might be too late.
> 
> Build test (gcc version 12.3.1 20230625):
> mips: 52 configs -> no failure
> arm: 100 configs -> no failure
> arm64: 3 configs -> no failure
> x86_64: 4 configs -> no failure
> alpha allmodconfig -> no failure
> csky allmodconfig -> no failure
> powerpc allmodconfig -> no failure
> riscv allmodconfig -> no failure
> s390 allmodconfig -> no failure
> xtensa allmodconfig -> no failure
> 
> Boot test:
> x86_64: Booted on my test laptop. Warning on boot, already reported by others.
> x86_64: Booted on qemu. Warning on boot, already reported by others. [1]
> arm64: Booted on rpi4b (4GB model). No regression. [2]
> mips: Booted on ci20 board. No regression. [3]
> 
> [1]. https://openqa.qa.codethink.co.uk/tests/4765
> [2]. https://openqa.qa.codethink.co.uk/tests/4773
> [3]. https://openqa.qa.codethink.co.uk/tests/4772
> 
> Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> -- 
> Regards
> Sudip

One question about the warning on boot, all still works afterward,
right?  Or does the system not work?

thanks,

greg k-h
