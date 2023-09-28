Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54B7B1EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjI1NjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjI1NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:39:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B3F196
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:39:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0CDC433C7;
        Thu, 28 Sep 2023 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695908340;
        bh=kcmwzW2IIJVnBuCoNp/lp1IUZNdyRI0uPY886JTtMRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4O1htFwjhJw0Nadh0TQ3nCUtRzqoaHBJhaZ7MUW6qFbCMB2FX8klweJPKFuBB2Ty
         lWgigvhtLupl2IqoxcJH7NHQxgcqEZasc+jtqa6TbZiR/1P7yOk5LRg8I0dW7912mR
         PlI5jnjpTUbVRD6WOCOkXNt0fW8NofN3b4LaAM1o=
Date:   Thu, 28 Sep 2023 15:38:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Earl Chew <earl.chew@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        peter@hurleysoftware.com
Subject: Re: [PATCH v2 0/3] tty: Fix tiocspgrp() related races
Message-ID: <2023092838-banking-sturdily-8e28@gregkh>
References: <20230901015030.2469062-1-earl.chew@yahoo.ca>
 <20230928130658.4045344-1-earl.chew@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928130658.4045344-1-earl.chew@yahoo.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 06:06:56AM -0700, Earl Chew wrote:
> This is a resubmission to correct errors and warnings
> called out by the kernel test robot.
> 
> Earl Chew (3):
>   tty: Fix __tty_check_change() and tiocspgrp() race
>   tty: Serialise racing tiocspgrp() callers
>   tty: Move task_pgrp() after tty->ctrl.lock for consistency
> 
>  drivers/tty/tty_jobctrl.c | 47 ++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> -- 
> 2.39.1

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
