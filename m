Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6227789B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 07:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjH0FtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjH0FtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 01:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A76121
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 22:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E69B60B36
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 05:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF65C433C8;
        Sun, 27 Aug 2023 05:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693115346;
        bh=zU2OZjeNZeUgz0oyUUk2xOzC7VimSyXciicKURU48/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7GHOjzniW+ejQHzLRi92RCA2GrYVkO7XtJWYwEczC/EhnqqSDt4YgTvoanC/uGzn
         OUPPSr52uoSyZMyWW5gkcHzYCXJRNlf98gC/C4AgmlzLU8A14SpYYZ7xHIsO2dQq81
         1rWwkYwovyrwATRWFVR1hZYMe5TVZgG5LaBNvO/M=
Date:   Sun, 27 Aug 2023 07:49:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ozlinux@hotmail.com
Cc:     colin.i.king@gmail.com, sumitraartsy@gmail.com, nhuck@google.com,
        u.kleine-koenig@pengutronix.de, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] Clean up the octeon ethernet driver
Message-ID: <2023082729-clang-cause-cdc3@gregkh>
References: <PH7PR11MB764393FA00BBB83B25B8853EBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB764393FA00BBB83B25B8853EBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 08:49:47PM -0400, ozlinux@hotmail.com wrote:
> This patch cleans up the octeon ethernet driver,
> and makes it better adhere to the kernel coding
> standard.
> 
> I am sending in this patch as part of the 
> Eudyptula Challenge.
> 
> Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> 
> ---
>  drivers/staging/octeon/ethernet.c     |  6 ++--
>  drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
