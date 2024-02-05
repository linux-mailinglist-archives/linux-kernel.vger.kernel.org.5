Return-Path: <linux-kernel+bounces-51971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACA849225
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D891F217AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B955A933;
	Mon,  5 Feb 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q+qqlhrx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9D8945A;
	Mon,  5 Feb 2024 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707096188; cv=none; b=YyeBDycHcjVhl9BavLQdh4nJIu9yAQq5hmAzNGHZHStIuQ4GhbjGdAhuVzLPUCBmnLTx4i279msRKrbJjyLmKHTYlkhxWjO2uh0j11HgWEhsOTBC2zTDDa4tUKXQRbM8w82I20x8OcAZhdk3cTzeEdfsgKCBzr5hKZPRQr5MU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707096188; c=relaxed/simple;
	bh=cB4tjPWm5aMCGIM7y6QYPNhcK4ORiH+gfM2r7gszKrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUTHHcpHOhAmOxNuiQ1xDFhmXxGhNIL22PpcNuznVdXocAKpW0e4O/N9qHSGeiEGi9FcF8O3JwyFlP2rM58yKBHyirUT8RlOCaRIkx68vAtv4PHioPl31D1EdN9Sts/t+8E/UPQ/obT22o9XbB8KSv930KTn49AZn7ajDuZmLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q+qqlhrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9100BC433F1;
	Mon,  5 Feb 2024 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707096187;
	bh=cB4tjPWm5aMCGIM7y6QYPNhcK4ORiH+gfM2r7gszKrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+qqlhrxNobGzNLAzYBSy+MGsjQF0K3dkCROmjTkHJaxXkysRzaDs4FC41D3zeqvD
	 bYVKj2XgNb2vW/pYaJMSsS87VY8Qt+HfFITMczziKkwhV8FTZMvqr1h4zCwaR6/6al
	 fdY4HIjOW0QYmu69GecoAmQl5mfcm+G9DbNyda3g=
Date: Sun, 4 Feb 2024 17:23:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ettore Forgiarini <ettorenigma@gmail.com>
Cc: richardcochran@gmail.com, ozlinux@hotmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: octeon: octeon-stubs: remove all typedef
Message-ID: <2024020428-bridged-isolating-0443@gregkh>
References: <20240204153603.1373700-1-ettorenigma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204153603.1373700-1-ettorenigma@gmail.com>

On Sun, Feb 04, 2024 at 04:36:03PM +0100, Ettore Forgiarini wrote:
> Removed all typedef so the code conform with code style
> 
> Signed-off-by: Ettore Forgiarini <ettorenigma@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

Where is patch 1/2 of this series?

Also, my bot complains:

--------------

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

