Return-Path: <linux-kernel+bounces-152453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58A8ABEAE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D381F21133
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A828D517;
	Sun, 21 Apr 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w0o5Tkaz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417773232;
	Sun, 21 Apr 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713681456; cv=none; b=p8RznX+ErWhCO8qOizSU61T0MMZFqwsa4mfIEZGb/Y3PTbIvgg+ib3HBE0AuwdCpA/IFxpV9vBoJWuciR9nuPK25IL06cODnfj8cKy81W8A06W/ev9w0bBvsZTU5pH5GU9/ljTJAo0vMIwa54RXHAOLMm/yEuccJS9nlLeD9VwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713681456; c=relaxed/simple;
	bh=wm32zSJnxIx+mTfYm0WIFmhVPlrSiGKpBbBskUNBm00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgUZXz5xzEbelWsYzph8FC7tuEUd12+JE9PXAjTKsyLxZMl5wlmXDqj8wpWj/gKJQP+hfPNPSzw1TxorMXTYKvUrFIgkEXMBFRLj9phRjxHqgCuxA7M3uTcQEaoiEpB8lo4TlGrMCWMaYIKojh6qmKp8Ph7+r6TpxWIwC6LZOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w0o5Tkaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32181C113CE;
	Sun, 21 Apr 2024 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713681455;
	bh=wm32zSJnxIx+mTfYm0WIFmhVPlrSiGKpBbBskUNBm00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w0o5Tkaz5ez7Ajvz6MN4Wxpc0CdOjLKbIcPVaAqPWpoc4eK5AJu54b3IeEFUmVaeG
	 WgPOoVCgUSxFSYnLCZLzLmTtKiO9JbGXKG9PkeWmluBwRm4a+oVxlR2neRJJ+ePhYo
	 w8tY0Wk75a8m1po/yPv+yh11EqjJJtOxRQgxZ0dQ=
Date: Sun, 21 Apr 2024 08:37:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sundar <prosunofficial@gmail.com>
Cc: heikki.krogerus@linux.intel.com, neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v3] usb: typec: mux: remove indentation for common path
 [linux-next]
Message-ID: <2024042151-tingle-bronzing-983c@gregkh>
References: <20240421011647.3027-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421011647.3027-1-prosunofficial@gmail.com>

On Sun, Apr 21, 2024 at 06:46:47AM +0530, sundar wrote:
> Added check if pointer is null and removed indentation for common path
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: sundar <prosunofficial@gmail.com>
> ---
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

