Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5980678DF13
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbjH3TZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbjH3KxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF41BB;
        Wed, 30 Aug 2023 03:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B88C960ECD;
        Wed, 30 Aug 2023 10:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A153BC433C7;
        Wed, 30 Aug 2023 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693392798;
        bh=kXm9yQy52naWC/RvGvn4BFl6/EW0JPFepP0YEWTan7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NILBwXn0diTHmZ1KQ9Vs+pVGhOgr65/Hm4qpmEeBmI77O7PihYV6LFGKaG+n00Hk/
         GCfxx2oMcI2rQiBV2zu+IPYIfdOqEWkmiKx48BkrRh4RqYblX3QKiL/TAonQNzkZmf
         OftlAQxTQNAwwhdtvTuy60Kx5B7Hp6VvaV0EjnaI=
Date:   Wed, 30 Aug 2023 12:53:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Message-ID: <2023083041-tingle-waltz-9a6b@gregkh>
References: <20230828101149.146126827@linuxfoundation.org>
 <a47b63cc-174f-4de7-987b-16a6264ce42d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a47b63cc-174f-4de7-987b-16a6264ce42d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:24:27AM -0700, Guenter Roeck wrote:
> On Mon, Aug 28, 2023 at 12:13:17PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.193 release.
> > There are 84 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> > Anything received after that time might be too late.
> > 
> 
> v5.10.y also needs commit 4ea6fa2cb921 ("mhi: pci_generic: Fix implicit
> conversion warning") to avoid
> 
> drivers/bus/mhi/host/pci_generic.c:276:25: warning: implicit conversion from 'unsigned long long' to 'dma_addr_t'
> 	(aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
> 
> which is seen since v5.10.192 when building images with clang.

Yeah, I ran into that in the Android merges.  That's not a regression in
this -rc cycle, so I'll queue it up in a future release.

thanks,

greg k-h
