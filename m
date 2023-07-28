Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2376706F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbjG1PX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbjG1PXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313964231
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF33F6217E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D714C433C8;
        Fri, 28 Jul 2023 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690557794;
        bh=5PRrK71y7rg2n66PxfxPqm8XqnCpVt9EPKxD9EZZu6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rC0kLvBgF94x4Eah648O/bQWSBv0Os9XOVFAX1vMd2o2udNRCgewUJBhJRvS6GBzL
         f62ZSMgktxCRDhrwY0PFQw7OJHx7VdL6S4GcaIQPGGy4TITJru6orCZZU6vQPVylJZ
         v4g9hLjTlrCuiNpJ3nedyVGR4NfWzisyUmsxbZ90gwXc8jmZwua79Kq8itpmFEs40o
         3orj7h3U35G5tshHPTlHrm1dvP5kHIXTHB4o6WrakYvMGdyR1kHjooJwsvk+GV8kTk
         5LzAnSXX/RpsAZy8vH1jtb7954gdRneZTxZSIsqvjQCZxMIdOwkt/kkSHGJXuwC3UY
         sN78vGBvywnrw==
Date:   Fri, 28 Jul 2023 16:23:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: arm64: perf test 26 rpi4 oops
Message-ID: <20230728152309.GG21718@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
 <20230728141852.GA21718@willie-the-truck>
 <1620591d2201c1498f2832b32d26efd0c5cdd5cf.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620591d2201c1498f2832b32d26efd0c5cdd5cf.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:12:43PM +0200, Mike Galbraith wrote:
> On Fri, 2023-07-28 at 15:18 +0100, Will Deacon wrote:
> > On Fri, Jul 28, 2023 at 06:06:33AM +0200, Mike Galbraith wrote:
> > > perf test 26 in virgin master inspired the below.
> >
> > Ah, so this is the 6.5-based panic message below?
> 
> Yeah, that was virgin master.
> 
> The oops arrived with 2e1c0170771e, _but_ it turns out to be somehow
> config related.  The obese distro config rolled forward does not oops,
> much leaner local config does, despite cute little rpi4 working just
> fine.. for everything _except_ 'perf test 26' :)

The commit mentions HARDENED_USERCOPY, so maybe that? In any case, if
you can share your broken config someplace I can try to give it a spin.

Thanks,

Will
