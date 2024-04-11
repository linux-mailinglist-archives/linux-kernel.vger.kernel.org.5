Return-Path: <linux-kernel+bounces-140147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61818A0C05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28E71C21B99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907EF1442FE;
	Thu, 11 Apr 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VU+jY1w8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4A13FD92;
	Thu, 11 Apr 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826830; cv=none; b=mqap+kwkU7X/wBx/ay0kBvz4TWJi0V3wBMvT9C0v7wQKLjmyl3bRpa7hkreyrmKvM5DWtt8yJct8bllns0OSile0ZolrbEUU2IrcO9njt/HCEx8ur2nQK1Z5FVCu+FVZB8wbO1PTpgjqrSVMN7iAT3RcUlpDra7pPk7dbqzWJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826830; c=relaxed/simple;
	bh=s6ENZFSjQ6+ecFmzLviY1DdLzFy5bePidVMCMUX/CCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OacCzb3wjj/c08meEJzCGpY4UQvwL2oy8VnrH0e2jKt1NmjVm44ndfHI+tpvt50Fc2EePKaMlb1OqKUKtPTP/jzKTiSfB6oUm+gHWItA9hRM97oitoI1/uoD9qIvRnlqfge0UcLZlzUX+5MUC69qUopJuRPDcpqRgfgr5n8cbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VU+jY1w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D233EC433C7;
	Thu, 11 Apr 2024 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712826830;
	bh=s6ENZFSjQ6+ecFmzLviY1DdLzFy5bePidVMCMUX/CCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VU+jY1w8SnngczpBjeisADAOlFiQt+mnZyyaSXoal63iv1oWfNFuT5wUNFa6/bx6d
	 6sOpq7E26LO4OSN27yU1D21HuzSLLg/kTMyzAjTjgXf7c50ZrSc4D4/lWtmXz/0hxN
	 NN5qWk70uMBZRHprUxJroUkre9AgGyUFhUUep91s=
Date: Thu, 11 Apr 2024 11:13:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
Message-ID: <2024041159-undone-deacon-3170@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh>
 <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
 <2024041123-earthling-primarily-4656@gregkh>
 <dad33d1c-77da-4b97-a0ec-4bf566f8d861@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad33d1c-77da-4b97-a0ec-4bf566f8d861@leemhuis.info>

On Thu, Apr 11, 2024 at 09:50:24AM +0200, Thorsten Leemhuis wrote:
> On 11.04.24 09:40, Greg Kroah-Hartman wrote:
> > On Thu, Apr 11, 2024 at 08:59:39AM +0200, Thorsten Leemhuis wrote:
> >> On 11.04.24 07:29, Greg Kroah-Hartman wrote:
> >>> On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
> >>>> Some developers deliberately steer clear of 'Fixes:' tags to prevent
> >>>> changes from being backported semi-automatically by the stable team.
> >>>> That somewhat undermines the reason for the existence of the Fixes: tag,
> >>>> hence point out there is an alternative to reach the same effect.
> > [...]
> >>> I do not understand, why are you saying "cc: stable" here if you do NOT
> >>> want it backported?
> >> Because the only alternative the developers have to make the stable team
> >> not pick a single patch[1] is to deliberately omit a Fixes: tag even if
> >> the patch normally should have one. Like it was done here:
> >> https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/
> > That feels odd, but ok I now see the need for this for some minor set of
> > changes (i.e. this has rarely come up in the past 15+ years)
> > 
> > [...]
> >> E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That was
> >> the best term I came up with.
> > 
> > Thinking about it more, I think we need to be much more explicit, and
> > provide the reason why.
> > 
> > How about:
> > 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> > 
> > and we can make that address be routed to /dev/null just like
> > <stable@kernel.org> is?
> 
> Totally fine with me, but that feels somewhat long and hard to type.

I want it long and hard to type and very very explicit that this is what
the developer/maintainer wants to have happen (again, because this is
such a rare occurrence.)

> How
> about just 'no-stable@kernel.org' (or 'nostable@kernel.org')?

More words are better :)

thanks,

greg k-h

