Return-Path: <linux-kernel+bounces-148085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E628A7D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2865EB22988
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFE6F068;
	Wed, 17 Apr 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aj6tOUU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F533CC2;
	Wed, 17 Apr 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340553; cv=none; b=anpBRcbqbqvDLcx4p+0E1RCG8FNsRf4BZxZESqfxbWE3y4R3otOZRBAD6xybbEg8m2iB3iSk3SUpw6rzXZd3C5r52ZOkCtTT3/GQHnxptB3G7a+7a+hphlgggy4mzr2/r7IOm3Yv/zwqxR/SdG8GaLK0GCDdZI7mBasAVTcwqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340553; c=relaxed/simple;
	bh=TgbiouoggRub+X4mEPgPNFpZCQsY4sCtPk19K9N4bto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONuV+0P4wrD8OQ+68ARHaKooT8cGvDpgRJULdlkhlqplRozwKOYAbYoVTDBg0vuKLQCQNrpb2+VdcHWg5f44jFoZ+PaQpZXxFKv8JPZ7LLpfav4vJ6IfbBO2ehYTnRkAyFvfYAG8QeJ/R/wDdODCTJ5hcM8zZxy1UcPIIyoNNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aj6tOUU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1ECC072AA;
	Wed, 17 Apr 2024 07:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713340553;
	bh=TgbiouoggRub+X4mEPgPNFpZCQsY4sCtPk19K9N4bto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aj6tOUU8dPw3YrHFPsXp6bKHxKwZ573hGO11WNkwVFz+qZjDShzBUEIF97vlmr3AE
	 CnfEDH8BrEljaPgpYdOKiejozIEGUcT+a3lS4RxeIuE410W+euCq9c8VcFNhcWHLSL
	 FipEi/4UwZHHKOb17f3VrFnp48z1u2AQmGXe1/cw=
Date: Wed, 17 Apr 2024 09:55:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: helpdesk@kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <2024041736-earmuff-luster-a9ab@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>

On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
> Hi kernel.org helpdesk!
> 
> Could you please create the email alias
> do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
> just like stable@kernel.org does?
> 
> That's an idea GregKH brought up a few days ago here:
> https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregkh/
> 
> To quote:
> 
> > How about:
> > 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> > 
> > and we can make that address be routed to /dev/null just like
> > <stable@kernel.org> is?
> 
> There was some discussion about using something shorter, but in the end
> there was no strong opposition and the thread ended a a few days ago.
> 
> The goal is to have a tag that developers can use in Linux kenrel
> commits that have a Fixes: tag, but nevertheless should not be
> backported by the stable-team without explicit request. The thread
> linked above explains this in more detail. Once the address exists I'll
> resubmit the patches in question that will document the tag.
> 
> Is asking for this here like this the right way? If I need to file a
> ticket somewhere or some ack from a higher authority, just let me know!

I approve this message :)

thanks,

greg k-h

