Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086157EAFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjKNMOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjKNMOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:14:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91BDF0;
        Tue, 14 Nov 2023 04:14:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58753C433C7;
        Tue, 14 Nov 2023 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699964050;
        bh=lv1Pg2gEfccXVD0Fm2ZP5fMGrIlZAHX99ebAvqwyGnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/lKsuLMxJhRiasdNNvc5zb0wmEs78M25k7V8I5SvH2bu2nvPtN5ceNDpUeYKgXIq
         Y/0RAxcn3sAE2a/F9NCoQxOqZLa1B07ASSvZee8SKnsVc6JbnAOdL4fejAXYJ5DfiW
         rJ9izZXobAdjfXgVjM9nYY+LSouyn5yvLTaWuVbs=
Date:   Tue, 14 Nov 2023 07:14:08 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     jirislaby@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] /proc/sysrq-trigger: accept multiple keys at once
Message-ID: <2023111454-hypertext-anymore-f2a6@gregkh>
References: <a7308079-2605-4708-9886-2f517481d728@kernel.org>
 <20231114095557.74619-1-tomas.mudrunka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114095557.74619-1-tomas.mudrunka@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:55:57AM +0100, Tomas Mudrunka wrote:
> Just for convenience.
> This way we can do:
> `echo _reisub > /proc/sysrq-trigger`
> Instead of:
> `for i in r e i s u b; do echo "$i" > /proc/sysrq-trigger; done;`
> 
> This can be very useful when trying to execute sysrq combo remotely
> or from userspace. When sending keys in multiple separate writes,
> userspace can be killed before whole combo is completed.
> Therefore putting all keys in single write is more robust approach.
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
>  Documentation/admin-guide/sysrq.rst |  4 ++++
>  drivers/tty/sysrq.c                 | 17 ++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
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
