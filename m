Return-Path: <linux-kernel+bounces-100522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D39879909
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F201F22696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DDA7E586;
	Tue, 12 Mar 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WHwTMZ7D"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51A32C85;
	Tue, 12 Mar 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261365; cv=none; b=g9knDFrSV10nDIWTItBt/TMrt+elGdn7PLU6dSSmMB8Hy9QyLeahj4IsUrIrZXQmQWlyVIqRPJM265b4qPnBXjJN29VzqnLnQMW3qenhSF1B8aDuSR7aYPbu4/DFPu9kkYvyQQvbjDPkZON5y5gtq5CRNbCRAWGK0J/WvOH5KQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261365; c=relaxed/simple;
	bh=T69s4z2/Pz7KrsIkKDfhH6XQgMeAXd8VOP95OvHFy5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLIT2BKR1aeR7Nx4NgKlAc1XZvEkDeF70QZpyFr1iXPhQRN6EGIVaMCUzM+8nHUHZGAdnczaGhK/Cn6dotXque9izvrZ1bhvL7lP5LintfDlwEPqi/w4OHU+HcDQuhPSUbtsiBb/huDtuqT28ldtHU1I8E7Tt+OCYkh1Ol5KhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WHwTMZ7D; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 963D3C0002;
	Tue, 12 Mar 2024 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710261361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6bQhCQE01Ujonl7Mz5FErOFVrta+uGBf3aUm0L3jnc=;
	b=WHwTMZ7DdNvrjxS9IFff9ymsTmtxtVRHarnqh+NztlsUettExo9mOfUA7XQ8siPUb7K8dI
	HRhgJdeu326fz7VRcznToh7VKdgGQvPOv3LaFEVUPeV4XKpuBxv5tqBryc0pLVsV2OxD3Z
	qL6UUkWbHZSx8nc/VIp1rhUSKFK8z8/xav/F1K7Eyj1YGKRzW6e6XTn2hHKZgm4Zw2AEfz
	bXZfgrrbvP73Rzj7N7VTqHQIVuLCj9hm2EVjnViDHmSELWX06cwgI35obakl+C7puUdDYx
	dJ9iJxcfJllPjccG3TbcmQiKmtAoDFWYcAmERb6cn+T962/z+a4z28TMX4h5gg==
Date: Tue, 12 Mar 2024 17:35:56 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <20240312173556.4727ebbf@bootlin.com>
In-Reply-To: <ZfB4BOknvWRFbn6O@smile.fi.intel.com>
References: <20240312085403.224248-1-herve.codina@bootlin.com>
	<ZfB30-rLXEnJtjrY@smile.fi.intel.com>
	<ZfB4BOknvWRFbn6O@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy,

On Tue, 12 Mar 2024 17:43:00 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Mar 12, 2024 at 05:42:11PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 12, 2024 at 09:54:03AM +0100, Herve Codina wrote:  
> > > The make htmldoc command failed with the following error
> > >   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
> > >   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> > > 
> > > Move the visual representation to a literal block.  
> 
> ...
> 
> > > This patch fixes de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> > > available in net-next and linux-next  
> > 
> > Not sure about rules of net-next, but I would add Fixes FWIW:
> > 
> > Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")

I think I cannot add the Fixes tag as the de5f84338970 commit is not yet
merged in Torvald's tree and I am not sure that the commit hash will not
change during the merge process.
  
> 
> And probably Reported-by...
> 

Regards,
Hervé

