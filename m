Return-Path: <linux-kernel+bounces-69733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F69858DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBBAB2113F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42A1CD20;
	Sat, 17 Feb 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNRUKafk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BD1CABA;
	Sat, 17 Feb 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156751; cv=none; b=RiCho7pOCooT7r2ckM8INgU3lHKlYizaL0uv03r5ZWvd6eraGa9tq8RmejeBkQPDTAZuXZu4rM5Xer8finIDWHKsW4k/SOJn7JL3z6wftdAShAYfSn2GWAeRlSacyVFxJaauB9boxbxqRxiujTASFObZTxDHpqAP997GhtGUm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156751; c=relaxed/simple;
	bh=Fj0dXMKY5VCd6XyOaiCGaCBR8SMIRKG0Efhdh2fkTK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8T9za5KGcXpPdksQnasXQ9patgnU8yPVI1HvmCuuQUxzITa0NGhTb+z6OxRkiyj+Y1U1HTIcH1rgbkUeqLeBNi68j/OmbCFnMlODipR/D4cOwYxvFq1BRdRuOcrJcEEBQSaQcFAiCQavQ/cfN0WXw4fSJiRuvvFxDL8RAqsyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNRUKafk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CF8C433C7;
	Sat, 17 Feb 2024 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708156751;
	bh=Fj0dXMKY5VCd6XyOaiCGaCBR8SMIRKG0Efhdh2fkTK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNRUKafkMlqK1ALUoWMV41GexY+YTKn8UgxvIO7IcAfx06acn55JBiWLU7Qu3bP4H
	 5dIoXV8k0IA4LnxY0KfS+1ZEjYV+Ff5eutejVehiq5QiiPVL25OUnyibLKsK5BoAB2
	 Jb9SxXlM3HIGjiI48yzRhehIRidTS/2l2g7uYGBk=
Date: Sat, 17 Feb 2024 08:59:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vc04_services: bcm2835-camera: fixed several
 brace coding style checks
Message-ID: <2024021727-maritime-barterer-f536@gregkh>
References: <20240215220647.4096-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215220647.4096-1-mo.c.weber@gmail.com>

On Thu, Feb 15, 2024 at 11:06:47PM +0100, Moritz C. Weber wrote:
> Fixed coding style checks raised by checkpatch
> 
> Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
> ---
>  .../bcm2835-camera/bcm2835-camera.c           | 62 +++++++++----------
>  1 file changed, 29 insertions(+), 33 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

