Return-Path: <linux-kernel+bounces-108825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2E88108D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8BBB215EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCD93BBF7;
	Wed, 20 Mar 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTzS+vnB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DB79D1;
	Wed, 20 Mar 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933182; cv=none; b=YoveDZPFUrFA++U3wvR9/meS4lSV+a01eWerbqQlVgWrtcVpdAok6YHU13uCsDDu4X50jf09hrmkIkRGRbX+spN+pxh+gPm04Punp1wnPAlZvzY5Cky8R+gB+JE63mwYEcLLX7RClaIRk4b9Xs0ED0AB5KwSMDnlYnsDe4217P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933182; c=relaxed/simple;
	bh=phF0nuKu6gpYF1LZiFjmhaxtKVxdGfyoSjfL/Nmi9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNcWP0VA+ip2rAY17SrC7hQvR1AzOmQLdQETnbh8oJ7fwGNcO8sGkM/H2lNwojuALFmZSApzckSv21FrQXaNdWEnpicmwOqKFS0TWdJEONGpC17LJer3f0qpB3QNau9aGE2HBxFelU05MYhCsSevtLQ6CPQ2VO8N5FsdB9kaZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTzS+vnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34126C433F1;
	Wed, 20 Mar 2024 11:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933182;
	bh=phF0nuKu6gpYF1LZiFjmhaxtKVxdGfyoSjfL/Nmi9Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTzS+vnBTCDxuZ2CVpDo4BIj29TCRfezDGVOK87W/c4mb95mBkamdItnymmWArqiK
	 aTsSfd9641G22q9bWcg0VwIG7PuhxWcyW3C/Pif5twG/b1W8vpYSE6xCvZ7oL84K17
	 AQ54H7Z/4LjsqZPCK7K8ElUXYq8noWmPnmXyPn2uVCv5lYF4Qm+P1n9+GPhyoTMzeL
	 ucud+6GP2eGdk0mC9ITnuldm15Cvxv9BFvwLJP4IViB3es+SUKmvQqSqEWni9zjxvA
	 gzXcm2TY/nVWMe01FMUgCqSd9DrQwS3H7n/vYPCeR3/gq1CTyrvudeLMS+kmj4L2/O
	 x33LkUPosAUJQ==
Date: Wed, 20 Mar 2024 11:12:58 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: st95hf: Switch to using gpiod API
Message-ID: <20240320111258.GP185808@kernel.org>
References: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>
 <ZfloHvWaTOQErWfU@nanopsycho>
 <Zfq6GYnPAn000my0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfq6GYnPAn000my0@smile.fi.intel.com>

On Wed, Mar 20, 2024 at 12:27:37PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 19, 2024 at 11:25:34AM +0100, Jiri Pirko wrote:
> > Mon, Mar 18, 2024 at 09:39:23PM CET, andriy.shevchenko@linux.intel.com wrote:
> > >This updates the driver to gpiod API, and removes yet another use of
> > >of_get_named_gpio().
> > >
> > net-next is closed, send again next week.
> 
> Same Q: Why to resend? Can't you utilise lore.kernel.org?

Because that is how Netdev development currently operates.
A system which I believe emerged as a way to handle the
enormous volume of patches involved. Maybe it could change,
but that is a different conversation.

Other subsystems work differently, and that is fine too.

https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

