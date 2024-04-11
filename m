Return-Path: <linux-kernel+bounces-140456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA268A14E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D10E1F21C30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA91740C1F;
	Thu, 11 Apr 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ia/qNr8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A3E1EF1E;
	Thu, 11 Apr 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839532; cv=none; b=GkShqsxvhW3zFU2M+g1QUtQmn/t/tQ63b5ywQSlSVNzLjtlHDJ4D33YujrFr03xucn32vogAEG4R/OR2xGoC9aISmJFxySAgywEqvsXSwX9ulLEtTS6Kmc/zjmstwbw5+lHS9A7ab1kqMJOd11jKRuNCwBt5WKFH1r7fRGxxLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839532; c=relaxed/simple;
	bh=TUAFmNOg8ko8L/rZMOo1RHLUk6ov5w7Zi/WvSRN48vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw7ecMV2BvbX3IbObiLi0+Yt0d7pw0ZTLxXMzKd3Vtb6TjqH1sKO100Lnt500PNKb1Th213dcmyg3pHNIPyTtw1qnl7/QpTw7WKzIpzS1fLz7o5PlqEeZIw2sBsmtVek0nBL35uiR3uvkb+4RPsXFfBTABL63rOcwKsALzSsG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ia/qNr8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEEC433F1;
	Thu, 11 Apr 2024 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712839531;
	bh=TUAFmNOg8ko8L/rZMOo1RHLUk6ov5w7Zi/WvSRN48vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia/qNr8AHfRHgODE+CRBlgQBvNKQsy8PE4MnupLaRWLynA6ee5v5scgxosHXBZ9Cp
	 THFGXnqYipqv4XnS9Kpnxbua6CDk1YOGj89zkeVuhJXBJPO5jAi9cGuwheGND9+hH6
	 MKFaNOG4T1GckHJ/LexTanKiCaQMHUIe4flepk3g=
Date: Thu, 11 Apr 2024 14:45:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.9-rc
Message-ID: <2024041115-compile-zipping-c17f@gregkh>
References: <20240328131501.641457-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328131501.641457-1-djakov@kernel.org>

On Thu, Mar 28, 2024 at 03:15:01PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains one core and one driver fix for the current
> cycle. The details are in the signed tag as usual. It is not based on rc1,
> but on a previous tag that you pulled, because i got these fixes during
> the merge window. All patches have been in linux-next for more than a week.
> Please pull into char-misc-linus when possible and propagate further when
> you have more char/misc fixes.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 5464e7acea4a6c56b3c5c2d7aeef2eda92227b33:
> 
>   interconnect: qcom: x1e80100: Add missing ACV enable_mask (2024-02-04 23:36:06 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.9-rc2

Sorry for the delay, now pulled and pushed out.

thanks.

greg k-h

