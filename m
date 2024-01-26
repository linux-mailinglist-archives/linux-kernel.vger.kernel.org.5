Return-Path: <linux-kernel+bounces-39780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8583D5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF32282021
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E547129A9C;
	Fri, 26 Jan 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="s01lj1Lg"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C3129A70;
	Fri, 26 Jan 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258382; cv=none; b=Ol+Ucr/nohYTx5fqYwfJNdGN2RzOyW5eVdHYrBAemVP4E9OvLwFsZCAsXV6cfUcJraoK76JsXH9GUUZkghiCKEy2vHWGIBqycIz8MnNQ8aESbHfOs1/oY5AmxBd3EfUG3VUNGVuVbLHU9S5RONF9D/xfvgT/XfUqmvFDLYPK5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258382; c=relaxed/simple;
	bh=4119ntIEbSWPwOmkZIPbXTBkQezHNjkv+CbBk/2069g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilr7CjVoljIyE+aE8mLljMctx+KPUPqbgyD/tuWsDnqjUbJjU0Hs9ck4kCtK+FuD4wsG2fSKWGNSzk11+odoytvAJ7grfaDxMkLgZanEAG1ZQPzbIw8x+ddYf7dIEXXIyxG7AdK0eNHlJUs7rQVLomQC6RTt3CdTbBJj1Xp/MyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=s01lj1Lg; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 007656042F;
	Fri, 26 Jan 2024 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1706258378;
	bh=4119ntIEbSWPwOmkZIPbXTBkQezHNjkv+CbBk/2069g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s01lj1Lgbc+Rf0pc+azpeZ2T/04v6llGGWwxVy5IoS6wwHxkd6qTq/3tOISOWy8+q
	 yPFdW7ZwOiVe5oMQOOvDXO65gsBuTvPzOLbOEtj5RybonI/tDkZj3RDM6D9cNSlXRb
	 xQi5QI2E/s6A+r1AiN0thDVYMZSH703ah3vW4N+C9EbRFnQmyUOc4TWY896Tfi0Nwn
	 ftGvCjOrQLHoEoeJj/Kb+TuECnq563bZaYkojUBuIuPk1A9e2WC16lJvflAitaLcDr
	 Kj/4iMNQcq5NfP8KIuutIg/colSfHmcE6t+Vx4eikCsmvyc1P30nhomS5/vf/1hbeg
	 X4MLfTK1xw6og==
Date: Fri, 26 Jan 2024 10:39:17 +0200
From: Tony Lindgren <tony@atomide.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk,
	Paul Walmsley <paul@pwsan.com>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 00/13] ARM: OMAP2+: fix a bunch of kernel-doc warnings
Message-ID: <20240126083917.GV5185@atomide.com>
References: <20240117011004.22669-1-rdunlap@infradead.org>
 <20240117131305.GP5185@atomide.com>
 <e6692a04-142c-4df4-83dc-534ab27a55f6@infradead.org>
 <20240118085717.GR5185@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118085717.GR5185@atomide.com>

* Tony Lindgren <tony@atomide.com> [240118 08:57]:
> * Randy Dunlap <rdunlap@infradead.org> [240117 16:52]:
> > Yes, please go ahead and apply them.
> 
> OK will do after -rc1.

Applied now into omap-for-v6.9/soc branch thanks [0].

Tony

[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v6.9/soc

