Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBDC7D1BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJUIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:32:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88AD41
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:32:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89683C433CA;
        Sat, 21 Oct 2023 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697877151;
        bh=Vpe9tfQgQxRbhCoBRZ9xHcY/STSOXh13F1NBpsIiYdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSbTag0ZKZ6MdnEnlEq/BZsN8CloPB7+s5Z6d040K+0Sinm72AYj7OBbAHw4NTa7G
         lC3Z4+TYmxt8RfOWfvePI4+PScc3q5MVvJdFXWDzkAE01tPnd7LIS9HhOKc5xVaWGo
         Wm/aSIr4Ucaay0A2rRVIUN9EYL2cd7v+P5LVMZw0=
Date:   Sat, 21 Oct 2023 10:32:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Fix warnings due to introduction of new
 typedefs
Message-ID: <2023102111-sneak-abreast-8061@gregkh>
References: <20231021081409.67570-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021081409.67570-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:14:09AM +0200, Jonathan Bergh wrote:
> This patch fixes warnings relating to introduction of new typedefs in the
> octeon driver. The following changes are made:
>  * Update the existing enum and struct definitions to remove the typedefs
>  * Update the inline and remaining function implementations to remove
>    the typedefs
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/octeon/ethernet.c     |  6 ++--
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
>  2 files changed, 27 insertions(+), 27 deletions(-)
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
