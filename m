Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B377D7E85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjJZI36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbjJZI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:29:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A610E;
        Thu, 26 Oct 2023 01:29:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B3CC433CB;
        Thu, 26 Oct 2023 08:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698308992;
        bh=dCX8OHq5uHSIRb/Tm2FFJ8vPJxRQRvuLh+p/6rWRQZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzdDxq0Z+z1LysCbhE4BuFsSiK7GEruM2/e9znnsM6IE5iOQzZ6tDY5i201knNbHp
         WuNK5v/K34Krx4ehe/noljp7PUrMuLwQmzpBpUBXurA8Y0RAvK4JWxPlRsmZBzSp3O
         J+pJl/owyT2sikfPoJcZ6tvBMumz8y+S3+6KTAEc=
Date:   Thu, 26 Oct 2023 10:29:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: n_gsm: add partial copyright Siemens Mobility
 GmbH
Message-ID: <2023102649-batch-turbojet-11cb@gregkh>
References: <20231026055844.3127-1-daniel.starke@siemens.com>
 <20231026055844.3127-2-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026055844.3127-2-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:58:44AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> More than 1/3 of the n_gsm code has been contributed by us in the last
> 1.5 years, completing conformance with the standard and stabilizing the
> driver:
> - added UI (unnumbered information) frame support
> - added PN (parameter negotiation) message handling and function support
> - added optional keep-alive control link supervision via test messages
> - added TIOCM_OUT1 and TIOCM_OUT2 to allow responder to operate as modem
> - added TIOCMIWAIT support on virtual ttys
> - added additional ioctls and parameters to configure the new functions
> - added overall locking mechanism to avoid data race conditions
> - added outgoing data flow to decouple physical from virtual tty handling
>   for better performance and to avoid dead-locks
> - fixed advanced option mode implementation
> - fixed convergence layer type 2 implementation
> - fixed handling of CLD (multiplexer close down) messages
> - fixed broken muxer close down procedure
> - and many more bug fixes
> 
> With this most of our initial RFC has been implemented. It gives the driver
> a quality boost unseen in the decade before.
> 
> Add a partial copyright notice to the n_gsm files to highlight this
> contribution.
> 
> Link: https://lore.kernel.org/all/20220225080758.2869-1-daniel.starke@siemens.com/
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 1 +
>  include/uapi/linux/gsmmux.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 0ee7531c9201..fa882c7f4770 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2,6 +2,7 @@
>  /*
>   * n_gsm.c GSM 0710 tty multiplexor
>   * Copyright (c) 2009/10 Intel Corporation
> + * Portions Copyright (c) 2022/23 Siemens Mobility GmbH

I have no objection to you adding your copyright, you all have done a
ton of great work here and it is correct to add.  But the "Portions"
line is odd, and isn't something we generally use.  Can you just resend
this with that word removed?

>   *
>   *	* THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
>   *
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index 4c878d84dbda..101ebd15954e 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Portions Copyright (c) 2022/23 Siemens Mobility GmbH */

Same here, just drop the "Portions"?

Odd that Intel didn't put their copyright here, but as we all know,
absence of that line does not mean that someone does not have copyright
on it, lines like these are lawyer cargo-cult-safety, so we play along
with them :)

thanks,

greg k-h
