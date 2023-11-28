Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872DA7FB374
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbjK1IAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343955AbjK1IAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A210A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:00:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E9C433C9;
        Tue, 28 Nov 2023 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701158439;
        bh=XsSMYgbPthzsqVva9D0suVZ4nWHiEJsubyND6RHq0UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ae2am8lm7OGWz/wFSHlecym9K80fpY5DiEzAY9yJ0tRhCt54pvWrWJ5lmDEhtLdWH
         b4pTDWEtLRm7QGc4PEgiSIb0BiehAW2IibphzDtoU8yaFRG+tHskOAqwhSc/s2+NGn
         5SAB0e8+wKWVw+xdj0NfOC6od44tytRCugtR8kjo=
Date:   Tue, 28 Nov 2023 08:00:36 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roy Luo <royluo@google.com>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: gadget: core: adjust uevent timing on gadget
 unbind
Message-ID: <2023112827-repent-broadband-e557@gregkh>
References: <20231127220047.2199234-1-royluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127220047.2199234-1-royluo@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:00:47PM +0000, Roy Luo wrote:
> The KOBJ_CHANGE uevent is sent before gadget unbind is actually
> executed, resulting in inaccurate uevent emitted at incorrect timing
> (the uevent would have USB_UDC_DRIVER variable set while it would
> soon be removed).
> Move the KOBJ_CHANGE uevent to the end of the unbind function so that
> uevent is sent only after the change has been made.
> 
> Fixes: 2ccea03a8f7e ("usb: gadget: introduce UDC Class")
> Signed-off-by: Roy Luo <royluo@google.com>
> ---
> Changes since v1: add Fixes tag
> ---
>  drivers/usb/gadget/udc/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
