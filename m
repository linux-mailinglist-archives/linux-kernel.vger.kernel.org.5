Return-Path: <linux-kernel+bounces-48678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44F845FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C855828BA0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA284FCD;
	Thu,  1 Feb 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1xZbfJA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169684FA2;
	Thu,  1 Feb 2024 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811236; cv=none; b=bWz1mTG7niRErTNP0TaKvtj3emvC9qhSb4l4EIjli+xTFRxLrw4xVC2gUfgswYq+CREIremTZZRisxaDMODbI69TMMwz3GFyEt5VIyKYb7R1Crh5qMhS+2AS0QcfsVRCcN5YiZlu/OS/U44sDo5fmMAoBokF8sq0UT7LWo6xUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811236; c=relaxed/simple;
	bh=3ki3KLcA2OZwr8NvX0sMBhEWEgW/VJbJviiZ6WHEuto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoG8kfrhLxNywKT6F4/M9vr19oNL9/dmLijH5v/9m7Ct+0jTbYrU5tWMsb92qhAbcVef+a8ZabFWqeAzrkgygk3eYzdWEk7+BiWrHAzfMoCp550cJPUAzvnm1yYUumguv87QDrci7/FPnfCNn29lPugoN+j9S66Qja4O4w/MFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A1xZbfJA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XOePr+OYvYzqSZnZ35ODcA4OURkyQHKBFI56p+iHw8A=; b=A1xZbfJAtIzJvVfHqs3vsOfbVj
	XjjYt63Qu15QSEu8YC+uxegK3l8ghefN585hTFjKylJQsPf3QbqVSHD9XN9TY/dFuue4NfVcEtSax
	btLeRwaRC/q8+VcMVrDSypOfxi/1L08ilBGFihMvMlDnK4qrdVIL149mMhu7I44ylCBmEyEdB+xNd
	9yiCWWjMmUyFNvM0OYUgOYrJcI01T32HPUZFrdCLOl3FNcOuNoswzaLahsUVfZKybOiuft7QLxw5q
	SDgVBprDENverfirEq+3yLBEx4JV9nTHZDPO5PgB4hwomnmovXVPl17xYXTIslDdLTanSQ3j3lg79
	TDTRfpoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVbZS-00000008yHo-2F4n;
	Thu, 01 Feb 2024 18:13:54 +0000
Date: Thu, 1 Feb 2024 10:13:54 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
Message-ID: <ZbvfYqIKKWkTWLf9@bombadil.infradead.org>
References: <20240131190251.4668-1-andrew.kanner@gmail.com>
 <20240201052958.GA14943@lst.de>
 <65bb648c.190a0220.d431d.4f63@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bb648c.190a0220.d431d.4f63@mx.google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Feb 01, 2024 at 12:29:46PM +0300, Andrew Kanner wrote:
> On Thu, Feb 01, 2024 at 06:29:58AM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 31, 2024 at 10:02:52PM +0300, Andrew Kanner wrote:
> > > Prototype for __symbol_get_gpl() was introduced in the initial git
> > > commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), but was not used after that.
> > > 
> > > In commit 9011e49d54dc ("modules: only allow symbol_get of
> > > EXPORT_SYMBOL_GPL modules") Christoph Hellwig switched __symbol_get()
> > > to process GPL symbols only, most likely this is what
> > > __symbol_get_gpl() was designed to do.
> > > 
> > > We might either define __symbol_get_gpl() as __symbol_get() or remove
> > > it completely as suggested by Mauro Carvalho Chehab.
> > 
> > Just remove it, there is no need to keep unused funtionality around.
> > 
> > Btw, where did the discussion start?  I hope you're not trying to
> > add new symbol_get users?
> > 
> 
> Of course not, no new users needed.
> 
> I haven't discussed it directly. I found the unused __symbol_get_gpl()
> myself, but during investigation of wether it was ever used somewhere
> found the old patch series suggested by Mauro Carvalho Chehab (in Cc).
> 
> Link: https://lore.kernel.org/lkml/5f001015990a76c0da35a4c3cf08e457ec353ab2.1652113087.git.mchehab@kernel.org/
> 
> The patch series is from 2022 and not merged. You can take [PATCH v6
> 1/4] which removes the unused symbol from the link.
> 
> Or I can resend v2 with my commit msg. But not sure about how it works
> in such a case - will adding Suggested-by tag (if no objections from
> Mauro) with the Link be ok?

While you're at it, if you want to try it, you could see if you can
improve the situation more by looking at symbol_get() users that remain
and seeing if you can instead fix it with proper Kconfig dependency and
at build time. Then we can just remove it as well.

  Luis

