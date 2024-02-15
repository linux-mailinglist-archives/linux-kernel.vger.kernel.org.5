Return-Path: <linux-kernel+bounces-66850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EDE85625F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCFB1C22F92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF212BE85;
	Thu, 15 Feb 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bhfb5O98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AF42041;
	Thu, 15 Feb 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998389; cv=none; b=IJ7X3tK0ffNgyRI0yFz8HCxv2F7j/rPG3VrARRCPRCr10U1mIpZd63PN5ERssJ+ti49vIvB6oxen7jsTSyowO/c6F/+SvQMhU9qykAzrHc3a7JI9oRy8zYEQGiLQ9mthEY9aj/stIIlM+xM0/21xPpjyWcFNqsLlbb02vEBmR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998389; c=relaxed/simple;
	bh=dckH4nUEiMyTxqGtRHPrjbAcTVSEMyT4rF8LOmQLqc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCS2Xk7jIiasudCWB3vOaw4V6RXGwx24ZB/aKm2tol0jwms0b6/H+o5LHOcW94HCv7eYf/tjQuXmH3yEcIKG4xwI2B2cYqdK8dz1aVkj9w8rIIlmEN/MTfEXDYKcFbhARvQfdzUgmILeCb0xZBMNz8on6KH6zfko9H59dgPBB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bhfb5O98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1288C433F1;
	Thu, 15 Feb 2024 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707998389;
	bh=dckH4nUEiMyTxqGtRHPrjbAcTVSEMyT4rF8LOmQLqc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bhfb5O985jewYkmWWRzcWM9AZOSahVw2KYiCX6koypcO4fWkBwROq0e214rwatSTV
	 rSRMnJJOeLD0Qpd2G3LIOQJJLqDLMhAeBaLgRMsXdZ1ZkpLjx4wyyW648baodgQkXL
	 FERw0Cikkn4yeNCgVHaobllR2352LHVjC3rwNchI=
Date: Thu, 15 Feb 2024 12:59:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021536-immortal-amnesty-e8d2@gregkh>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <20240214-swinging-indigo-koala-a56069@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-swinging-indigo-koala-a56069@lemur>

On Wed, Feb 14, 2024 at 08:41:26AM -0500, Konstantin Ryabitsev wrote:
> On Wed, Feb 14, 2024 at 09:00:30AM +0100, Greg Kroah-Hartman wrote:
> > +A list of all assigned CVEs for the Linux kernel can be found in the
> > +archives of the linux-cve mailing list, as seen on
> > +https://lore.kernel.org/linux-cve-announce/.  To get notice of the
> > +assigned CVEs, please subscribe to that mailing list.
> 
> Since the archives page doesn't carry any instructions on how to subscribe,
> I think you should link to https://subspace.kernel.org/subscribing.html here,
> e.g.:
> 
> .. please `subscribe <https://subspace.kernel.org/subscribing.html>`_ to that
> mailing list.
> 
> > +No CVEs will be assigned for any issue found in a version of the kernel
> > +that is not currently being actively supported by the Stable/LTS kernel
> > +team.  A list of the currently supported kernel branches can be found at
> > +https://kernel.org/category/releases.html
> 
> Can just be https://kernel.org/releases.html

Many thanks for the changes, now made!

greg k-h

