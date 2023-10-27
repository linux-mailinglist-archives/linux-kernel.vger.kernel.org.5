Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E3D7D95B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbjJ0K4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0K4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:56:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57E9C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:55:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD6DC433C8;
        Fri, 27 Oct 2023 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698404159;
        bh=pp9XWSDKawl0nPkojRppEN59iTqfiee45EN0+pPOHT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3SZSOBxkJFlFbYl3NiXjgshVBHD8cZpLWMxhJvDdW6qtScQcJUsuGluFufQnc3Ar
         AdTMTARU4GPyISNLJDQ5Jumu45TW4zBk9oS3bR3jzjj4SYEpE2xoF3n7lmwuxx607q
         cQg4Xz6bCb78BlWt8bNtGl8Nh2SKlRePaHjhbzGY=
Date:   Fri, 27 Oct 2023 12:55:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuzhen Wang <shuzhenwang@google.com>
Cc:     laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Add missing initialization of ssp
 config descriptor
Message-ID: <2023102757-booting-cussed-ce58@gregkh>
References: <c2a62810-98b3-46d5-b557-2e98460729f7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a62810-98b3-46d5-b557-2e98460729f7@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:31:38AM -0700, Shuzhen Wang wrote:
> In case the uvc gadget is super speed plus, the corresponding config
> descriptor wasn't initialized. As a result, the host will not recognize
> the devices when using super speed plus connection.
> 
> This patch initializes them to super speed descriptors.
> 
> Signed-off-by: Shuzhen Wang<shuzhenwang@google.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
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

- Your patch is sent in HTML format, which for obvious reasons, does not
  work at all.  It also was rejected by the mailing list, which means
  that no one is able to refer to a public version of it on
  lore.kernel.org.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
