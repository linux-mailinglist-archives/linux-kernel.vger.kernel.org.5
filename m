Return-Path: <linux-kernel+bounces-79477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0708622C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470CC1F22845
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5B168BA;
	Sat, 24 Feb 2024 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftozVn61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5672563
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752987; cv=none; b=Y6wRGlNz0YOS5NMZ/kFhT9Clk5VP18RBK295e949cHBZmF3zGnEFNhPryhx6x1Nqwxaf95mZnru81wZsnXtCJNxphJnSQtZo4vKoybVzhJmEE1se6IVI/JzaDModaetQEO0KpxxMKOvFpre7gwlYs66ee06kVVhvOzIizfnevBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752987; c=relaxed/simple;
	bh=SZhg7tE5i98/+EMnUYLugJFuuMdbSsiVykY9ThOrPv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5EZVmMLWOOaKPdVfYkDNf6OO9wi/xwgG9U5YgPpVI3Pw4SHcLoTyPX9/NFbrHko4/KAZX5NuPE62ZHcyre4ARd2MHMJTL95NPFvE2eARYYBwYhoK1OOkwJYgUfUwQdXCZRIzP1ic1eEp2bIv6UXQ98n8TbXp+VIGTw2/xqcPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftozVn61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89300C433F1;
	Sat, 24 Feb 2024 05:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708752987;
	bh=SZhg7tE5i98/+EMnUYLugJFuuMdbSsiVykY9ThOrPv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftozVn61DHZbFiLiwcBPUh0G4pHHZHccOp/NkOi90zKOXKzTSu6hkfKjcCpPXfN4q
	 WGPR+553Rwnfq3f5qjqINNf+ZJ3J0aiD6dj8FOEK9Fc+d2OYqJJhEnCfy9oYJUx4xB
	 0TbOJ9WnBqGvyA5UH78XCAiHoJ1we3VzEIAdEbu4=
Date: Sat, 24 Feb 2024 06:36:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>, russ.weight@linux.dev,
	rafael@kernel.org, linux-kernel@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <2024022452-unwilling-pancake-3b2a@gregkh>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
 <2024022323-accustom-eradicate-8af4@gregkh>
 <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>

On Fri, Feb 23, 2024 at 11:42:35AM -0800, Luis Chamberlain wrote:
> On Fri, Feb 23, 2024 at 04:33:40PM +0100, Greg KH wrote:
> > On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
> > > On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
> > > > On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> > > > > Rename firmware_request_platform() to request_firmware_platform()
> > > > > to be more concrete and align with the name of other request
> > > > > firmware family functions.
> > > > 
> > > > Sorry, but no, it should be "noun_verb" for public functions.
> > > 
> > > News to me, do we have this documented somewhere?
> > 
> > Not really, but searching makes it nicer.
> > 
> > And yes, I violated this in the past in places, and have regretted it...
> 
> Care to share a few examples of regret?

	get_device()
	put_device()
	kill_device()

vs. a saner:
	kobject_get()
	kobject_put()
	kobject_del()

Learn from the mistakes of my youth please :)

thanks,

greg k-h

