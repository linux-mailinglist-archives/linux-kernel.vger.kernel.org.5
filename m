Return-Path: <linux-kernel+bounces-69940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFB85908F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7710AB21758
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716057C6DB;
	Sat, 17 Feb 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="c8zhbCIQ"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506147CF09;
	Sat, 17 Feb 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184435; cv=none; b=jqfE3pmimnKkgVovrrB0Ymr6d1hAiTZlFUP3JHrRzl17cNRMTNX0/Fold6efyok2sKsyo8nEd2yWC8XxQczR7XMUQ+CxCa+PYiErjgoidUataWYmblPOnijNbC8QrFTgxiOJbHChjPCcxzC+TMyb6IVNcceT6UilX+wQKNEyI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184435; c=relaxed/simple;
	bh=7TO0o92Ga8ESXmzM9toUqaahOhxbAM7ETu+ddZ/IHu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkXssfLIaPipfht583Mex/iIotpLdkSIeacuGqE68bt+MnCPmtRBICshk+NHUT/QqfepSWSQxDXimam0As3JCvy+wB3GJpmYJD66d1JHylOAxxtI8FWRq5VSOjz+yQrtCmu7oPG3FXfziFmi6CDTaMQ/0gcnOx11KeUWLO1JRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=c8zhbCIQ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708184421; bh=7TO0o92Ga8ESXmzM9toUqaahOhxbAM7ETu+ddZ/IHu8=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=c8zhbCIQmEAlYlfZryIDbVnOrvVE5qQTvKvzp79t50tnCHR9oegobZcaN2U+tTTeg
	 2NzqC+amgujhFcqLXCnAAPKsU2/rcgk+4OzmKn1+SCxRCbnL50VeJLHhCEWnIAQOfw
	 ZaEH1fUS2VOTJnckIlyPE5VcoY51YmAOLYWnpndI=
Date: Sat, 17 Feb 2024 16:40:21 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: typec: tcpm: reset counter when enter into
 unattached state after try role"
Message-ID: <ratkc4fo3mqwuzsbxsiwq54jclnarnjl3x7ts64elx6hguvbay@ihelujsnzd6i>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240215193352.1026707-1-megi@xff.cz>
 <2024021739-self-pencil-b932@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024021739-self-pencil-b932@gregkh>

On Sat, Feb 17, 2024 at 04:32:54PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2024 at 08:33:50PM +0100, Ondřej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > The reverted commit makes the state machine only ever go from SRC_ATTACH_WAIT
> > to SNK_TRY in endless loop when toggling. After revert it goes to SRC_ATTACHED
> > after initially trying SNK_TRY earlier, as it should for toggling to ever detect
> > the power source mode and the port is again able to provide power to attached
> > power sinks.
> > 
> > This reverts commit 2d6d80127006ae3da26b1f21a65eccf957f2d1e5.
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > See https://lore.kernel.org/all/odggrbbgjpardze76qiv57mw6tllisyu5sbrta37iadjzwamcv@qr3ubwnlzqqt/
> > for more.
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index f7d7daa60c8d..295ae7eb912c 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -3743,9 +3743,6 @@ static void tcpm_detach(struct tcpm_port *port)
> >  	if (tcpm_port_is_disconnected(port))
> >  		port->hard_reset_count = 0;
> >  
> > -	port->try_src_count = 0;
> > -	port->try_snk_count = 0;
> > -
> >  	if (!port->attached)
> >  		return;
> >  
> > -- 
> > 2.43.0
> > 
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - Your patch does not have a Signed-off-by: line.  Please read the
>   kernel file, Documentation/process/submitting-patches.rst and resend
>   it after adding that line.  Note, the line needs to be in the body of
>   the email, before the patch, not at the bottom of the patch or in the
>   email signature.
> 
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.

It's a mechanically generated revert of upstream patch. It has no authorship.
I did not write it, machine did. :)

But I can add a sign off for the commit message I made:

Signed-of-by: Ondrej Jirman <megi@xff.cz>

kind regards,
	o.

> thanks,
> 
> greg k-h's patch email bot

