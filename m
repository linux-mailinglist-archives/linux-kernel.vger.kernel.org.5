Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9578FE26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349707AbjIANQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIANQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF00E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB4DD611AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 13:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34DFC433C7;
        Fri,  1 Sep 2023 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693574199;
        bh=RjTV67R/hEUDAWI1b46V7RZdTKpGue2kHHHLhIT4Rug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfnugBdvRcgYCREvcZmXmsRCq7aPgcyZ8nvkofATpt9NATglKGsEhuXX9O+VPT3bD
         97vM0qo/oPU7Srha4l07Of7Vo20Q8bGzmOvcqo5wd8ZOPL9vBuxZK7zq/pGI7nRshZ
         6IbsX0SBvuqy8eCdh6dRmTvpqqWf+OVsxe/jYtZQ=
Date:   Fri, 1 Sep 2023 15:16:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Type encoding info dropped from names
Message-ID: <2023090158-dimmer-jokester-f895@gregkh>
References: <ZPHfqlTmHWGnLrMr@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPHfqlTmHWGnLrMr@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 06:27:14PM +0530, Pavan Bobba wrote:
> 1.conversion of formal argument names from camel case to snake case
>   for below functions:
> 
>       a.SROMvReadAllContents
>       b.SROMvReadEtherAddress
> 
> 2.conversion of local variable names from camel case to snake case
>   in function SROMvReadEtherAddress
> 
> 3.all instances of W_MAX_TIMEOUT replaced with MAX_TIMEOUT
> 
> Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c | 12 ++++----
>  drivers/staging/vt6655/card.c     |  4 +--
>  drivers/staging/vt6655/mac.c      | 46 ++++++++++++++---------------
>  drivers/staging/vt6655/mac.h      |  2 +-
>  drivers/staging/vt6655/rf.c       |  6 ++--
>  drivers/staging/vt6655/srom.c     | 48 +++++++++++++++----------------
>  6 files changed, 59 insertions(+), 59 deletions(-)
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
