Return-Path: <linux-kernel+bounces-144674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AECEF8A490D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECFF1F23FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D02C1B8;
	Mon, 15 Apr 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewYPnQNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A12C1A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166298; cv=none; b=AQHVc+t/eHYFCQvWr0VHKM1v4MMC3DX4GEbXp6K7LuSaishjO/Y/XCfBjcuGglYkQZeO3JoJaBD52y9YvSZspbYg3I/hVZf4X+U+ewRtv5HmUvjctDgPDpPxlscJ7Tt1vcksEuhOcTF3gb50hs+UVGImYlZMjzvC9n9VLnNd7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166298; c=relaxed/simple;
	bh=bRZvZp6AkbOsDdblOV4GxuvFlmTw5UsTFNthgidjX1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDx3yijvdzoCk6J/T41kQ73HD7erA6H0M4B/ylkJzxU0Vm5P8+tuUGkL1FhJS4YW9zpU3EFKGEALzFL/RXlm7PABFnD18QxUzOkyNrIyjilDB3nUZ56PQxb5vGbxlfWmCVE+XntXUKHNSdq7mg9zXyQ7FBx+a7UloF8ROAnTX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewYPnQNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D7C2BD11;
	Mon, 15 Apr 2024 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713166297;
	bh=bRZvZp6AkbOsDdblOV4GxuvFlmTw5UsTFNthgidjX1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewYPnQNmpxPtDuBwc+XopJT4q2ihEQ7DTkxT3PZyBu9Kg61LPL70hAexgJuP5UeYB
	 a+U2jLbabJLkN3ALz0gvUHptdRyVfC3YHzJzjWa8cG/SGKjtd6CXKRfhDYEw7EYfil
	 +cJDXBaPU6me0o8trAfpJrG4kMm6j+pUWWwmIQXs=
Date: Mon, 15 Apr 2024 09:31:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] uio: Convert to platform remove callback returning
 void
Message-ID: <2024041517-helper-suitable-0e42@gregkh>
References: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
 <g4bpnb64ylia6rlhqbjm5xctuy3uu6wnfu5sxuqkrze24y72od@e3tpnrwwl75t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <g4bpnb64ylia6rlhqbjm5xctuy3uu6wnfu5sxuqkrze24y72od@e3tpnrwwl75t>

On Mon, Apr 15, 2024 at 09:19:00AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Mar 08, 2024 at 10:31:00PM +0100, Uwe Kleine-König wrote:
> > this series converts the two platform drivers below drivers/uio that
> > make use of .remove() to use .remove_new() instead.
> > 
> > See commit 5c5a7680e67b ("platform: Provide a remove callback that
> > returns no value") for an extended explanation and the eventual goal.
> > The TL;DR; is to make it harder for driver authors to leak resources
> > without noticing. The drivers here get it right though and so can be
> > converted trivially.
> > 
> > This is merge window material. The two patches are independent of each
> > other so they can be applied individually if necessary. But I assume
> > and suggest that Greg will pick them up together.
> > 
> > [..]
> > 
> > Uwe Kleine-König (2):
> >   uio: fsl_elbc_gpcm: Convert to platform remove callback returning void
> >   uio: pruss: Convert to platform remove callback returning void
> 
> The commit 1019fa4839c9 ("uio: pruss: Remove this driver") (currently in
> next) makes the pruss patch obsolete. The fsl_elbc_gpcm patch was
> applied.

Yes, that's why I only applied one, sorry if I didn't let you know.

greg k-h

