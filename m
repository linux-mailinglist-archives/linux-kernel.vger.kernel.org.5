Return-Path: <linux-kernel+bounces-161778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D06C8B5111
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD722830DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789E13FE7;
	Mon, 29 Apr 2024 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftO3uxKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279213ADC;
	Mon, 29 Apr 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371217; cv=none; b=qESQcnm/m/iB8b0TT2SrNcQdr6d2nxyW1xozFWsQs0gvLQdxVWEjyepuLfv9AhuO98zfQO7MMXU4R7L1ahmwTXQzUYqE9kd7yFMWio16vbJ4fGsLCKdz4oItbDflYkNwWMhD99WJx6PtTFYYxwbKBge2kNqD7uLZ3LJqQdvgQj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371217; c=relaxed/simple;
	bh=olMoaF0fyLLXi+xIJXPbcT5w0xG9yrfaILJ4F+6pn24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M51FwLeB3TM7e4Wru3Pttk2V+74GRL+EespUbRNFfK/KzgQhCBCOxYgH4POvqxxqBCF9fqG4ouZ4qynHNlKKFAr0hhtPmYUN+hbCOVyfaCvHB0s2dZSz1S/np1lK6TGSKluK4+cJ3MXjVCWXpXNjBTKAsWLXlvx4yxzC2w1bNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftO3uxKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620FAC113CD;
	Mon, 29 Apr 2024 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714371216;
	bh=olMoaF0fyLLXi+xIJXPbcT5w0xG9yrfaILJ4F+6pn24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftO3uxKYv1c6C4rlusFWdOKaYQgdVIqhr/uX1uprXBQSK/MHt46DJzRyKPHHr4yM2
	 IlowzMOpVmUu/z8vpuX+bbLOQEJUt+ToaJymPyIuKzchYB7muhS7ekzeB0TRQZ/YmE
	 ForaAuY1ZotZ8MiSrLIY1itihVcfZoXO0MneS2Do=
Date: Mon, 29 Apr 2024 08:13:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Sergio Ammirata, Ph.D." <sergio.ammirata@sipradius.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	jirislaby@kernel.org
Subject: Re: Patch:  Allow the use of =?utf-8?Q?the?=
 =?utf-8?B?IHVhcnTigJlzIENU?= =?utf-8?Q?S?= (clear to send) signal to trigger
 the cd_change ldisk event.
Message-ID: <2024042948-preoccupy-headfirst-8c9d@gregkh>
References: <76A55B35-0954-4AEF-BAEB-61F2EF32CE95@sipradius.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76A55B35-0954-4AEF-BAEB-61F2EF32CE95@sipradius.com>

On Sun, Apr 28, 2024 at 09:45:29PM -0400, Sergio Ammirata, Ph.D. wrote:
> Hello Greg, Jiri,
> 
> commit eb8cb8d62ff718d2fcf7583da8699ba29196f707 (HEAD -> master)
> Author: Sergio Ammirata <sergio@ammirata.net>
> Date:   Sat Apr 27 22:22:25 2024 -0400
> 
>    Allow the use of the uart’s CTS (clear to send) signal to trigger the cd_change ldisk event.
>    This is particularly useful for the PPS ldisk as it is common to use the uart’s CD or CTS indistinguishably for PPS. The userspace apps such as gpsd and chronyd already recognize and use both signals for timing data in userspace and will now be able to use CTS for kernel KPPS to significantly increase the accuracy of the measurement.
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c476d8843..8128f64c4 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3515,6 +3515,10 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
>  */
> void uart_handle_cts_change(struct uart_port *uport, bool active)
> {
> +       struct tty_port *port = &uport->state->port;
> +       struct tty_struct *tty = port->tty;
> +       struct tty_ldisc *ld;
> +
>        lockdep_assert_held_once(&uport->lock);
>          uport->icount.cts++;
> @@ -3532,7 +3536,13 @@ void uart_handle_cts_change(struct uart_port *uport, bool active)
>                                uport->ops->stop_tx(uport);
>                        }
>                }
> -
> +       } else if (tty) {
> +               ld = tty_ldisc_ref(tty);
> +               if (ld) {
> +                       if (ld->ops->dcd_change)
> +                               ld->ops->dcd_change(tty, active);
> +                       tty_ldisc_deref(ld);
> +               }
>        }
> }
> EXPORT_SYMBOL_GPL(uart_handle_cts_change);
> 
> Regards,
> 
> Sergio Ammirata, Ph.D.
> 
> 
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

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

