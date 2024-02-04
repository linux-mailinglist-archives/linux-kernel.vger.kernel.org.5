Return-Path: <linux-kernel+bounces-51644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B3848DD9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8152829E6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C6224D1;
	Sun,  4 Feb 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5FBEHHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BF222313;
	Sun,  4 Feb 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051140; cv=none; b=WvPW+G0CETHFUlO3k0gUwpcmdy5ATzLMjgFY/n9F8HKY2W+Ujndd05g9cmY+ZdwYw6y5eGNqBgVl9Zus/yCaxILt9x94qQHutA59ckxaV91GVLh9f8JG9IvhkM/N730Or/SKnpAXsPxOMd1+zarAU+fpmpth4/BkoaE4UFr3pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051140; c=relaxed/simple;
	bh=iOZFSbUsvoi3perGk0p2aaqKExKH+fAFPQ0By7fcbEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwaBkInuOwScDHF88YDhFRkbCcthQxRwDo80NMYYWH7SPbSNz0hSCGsUnhQ+/L552OxehoLSsOk4hmoN54PAUfKS9S0XJcQ6mSmR2P0qjLVEQqRtkYktfQumwQY3/L2JrhoveWSyZJI0VG77ZHP3ZT3SXtCsqJ5e4BQBJlt15Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5FBEHHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE022C433F1;
	Sun,  4 Feb 2024 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707051140;
	bh=iOZFSbUsvoi3perGk0p2aaqKExKH+fAFPQ0By7fcbEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5FBEHHoqq2beDxIZKdoAprtzRlutVQzzEb9ad4cAf8MrJIp7u6T+m6TwF2HNcTqx
	 P0A75Py+hGgjxUoiSlXFiBGUhrNyz4yR7y6C8Bx+rxUm1CqCBwIA8G0J5SkwiPBh6E
	 uAX0tIB82J2OjllAnugnFxbDE5OGBKH/kSD9Qfbc=
Date: Sun, 4 Feb 2024 04:52:18 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ettore Forgiarini <ettorenigma@gmail.com>
Cc: richardcochran@gmail.com, ozlinux@hotmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: octeon: octeon-stubs: remove all typedef
Message-ID: <2024020450-rebalance-moonshine-deeb@gregkh>
References: <20240204092134.1265312-1-ettorenigma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204092134.1265312-1-ettorenigma@gmail.com>

On Sun, Feb 04, 2024 at 10:21:34AM +0100, Ettore Forgiarini wrote:
> Removed all typedef so the code conform with code style
> ---
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

