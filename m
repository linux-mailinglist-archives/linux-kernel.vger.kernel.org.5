Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278CC7BA1B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjJEOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjJEOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501824F04B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:02:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD76FC32776;
        Thu,  5 Oct 2023 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696514429;
        bh=oYcsUn3uxmKJ/HDGfdKAQfx/1UaE5tqKuGjM/2GSh9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JS/iuPnP1Tiskhi8GTVYSOi8m1JRzmgC0Kx2xMMeHCePUGHVl3Jtk+6i/FRW5ywjz
         Xakzd2j9JfTYZkLgD2VK5m29D2s6lERDXCp4A7zAQ/OjgdSZUgtr9MpG2/cr7YWmnJ
         7ou+WWNb6XDDi0RgEoPvh5W07rf4ylUYo3jisGDo=
Date:   Thu, 5 Oct 2023 16:00:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nipun Gupta <nipun.gupta@amd.com>, maz@kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Message-ID: <2023100547-retool-chamomile-d581@gregkh>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
 <87wmw1p4g5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmw1p4g5.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:46:34PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 05 2023 at 12:24, Greg KH wrote:
> >> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> >> index a08958485e31..86df7ccb76bb 100644
> >> --- a/drivers/cdx/Kconfig
> >> +++ b/drivers/cdx/Kconfig
> >> @@ -8,6 +8,7 @@
> >>  config CDX_BUS
> >>  	bool "CDX Bus driver"
> >>  	depends on OF && ARM64
> >> +	select GENERIC_MSI_IRQ_DOMAIN
> >
> > This config option isn't in my tree anywhere, where did it come from?
> > What is it supposed to do?
> 
> 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") :)

Ok, so this hasn't been tested since the 6.2 release?  Wow, I think
someone from AMD needs to take a deep look at this and verify that it
actually is doing what it is supposed to be doing...

thanks,

greg k-h
