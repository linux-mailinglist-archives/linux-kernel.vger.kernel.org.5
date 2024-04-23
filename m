Return-Path: <linux-kernel+bounces-155359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F58AE950
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB761C220A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D12E13B582;
	Tue, 23 Apr 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnW73mnG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45113776F;
	Tue, 23 Apr 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882037; cv=none; b=MML2xjhvSs6jTFBYdoEs5bLzUXfOtrA5DGZLjYQfjJ3ut93qU5phaUyoEye4tBl6YkiFFLsn9iBKvN0lJ1wiutvbBxmoTUi2GgmX/5/PlvhYmRsn32MFzF3WLZ9Irkm++Gm3hFxqlImIHso1CeCCKM7Xyzh2e2+ejeehrm3Vs/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882037; c=relaxed/simple;
	bh=zLC/Cfeda05MZAEngIc01iWcAOs4ICPgoAY1ea19gwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMOMc1cbpl3g9d8bnGd+i3lhC5QdCjLgDrxk19O/i+Y6wmkw5CGhXzSUNKKPSHBuqWqk24MXm73yVlFyzNG981BDHFl/gb0F4mQDuxwosyXeTam3uiVaomxpQcGas/RsYODUnAIIrUFRf7Q0Bjr0wlS/LOyt5sdGSUAXv6fbNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnW73mnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46EFC116B1;
	Tue, 23 Apr 2024 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713882037;
	bh=zLC/Cfeda05MZAEngIc01iWcAOs4ICPgoAY1ea19gwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnW73mnGmamG9IFaewuH5XSilHmTIw0l6vRolCW1Kia0k5zrXRgEZr4/igfT1/YrR
	 wRbPwfZPsoSmNeBZuEgOkk3BCF66U+ebX5NNBbzhxfnZg7LVmPhTGqmTvU3nqj0Teh
	 6spRECGs34isnlUhTPMenIc+f0mrfkHDoXATGmR+UAfs6PyzIdyxiJztBLcW9oZxxp
	 pQiZgZ93UAl5KQrvgQa1at5YmznpCr57P+5mHra0cwKsNUHEwfU9wmXLMnIZHRLhx7
	 vQG4fuRbpKEDLUL4PfAGDo3SGbg7p4JKoPu7MOT11jSnaGrcRl7O+NonO/ZD6kvv2d
	 o0X/1j8lLBAdQ==
Date: Tue, 23 Apr 2024 16:20:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 i2c-host-fixes tree
Message-ID: <qn4mvuemt3wblgntqx7rit4syvgkfipne26d63do4ef2jalpjd@vsvxdg36r3xf>
References: <20240423083145.771dddf5@canb.auug.org.au>
 <20240423091728.06d9ad30@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423091728.06d9ad30@canb.auug.org.au>

Hi Stephen,

On Tue, Apr 23, 2024 at 09:17:28AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 23 Apr 2024 08:31:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Commit
> > 
> >   86eb98127332 ("gpio: pca953x: move suspend()/resume() to suspend_noirq()/resume_noirq()")
> > 
> > is missing a Signed-off-by from its committer.
> 
> That commit is also (still) in the i2c-host tree.

Ops... this patch shouldn't be there at all.

I think it ended up by mistake while I was testing the series.

I will remove it.

Thanks a lot!
Andi

