Return-Path: <linux-kernel+bounces-29007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA728306B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9B91C23D70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E9A1EB44;
	Wed, 17 Jan 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="nvvCh1oj"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD11D541;
	Wed, 17 Jan 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497215; cv=none; b=Vd83xKkl7eqggzJIkmw/aQ9JTo75GNrX05TBe8N3V2Qs7J03fW/l28rIXRd10d8uVytidpB9hcxgwdX/Cypfm9AXUW7yRHO0xDva0/HKKyXKZovdIdC29OOud0WD3Ya0BKUnVEF5EuDSyaJeGFDb8owNfNBmLrBH2M2NH7PHhmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497215; c=relaxed/simple;
	bh=kWJBAgPmQlo65pN4xHfEJK8XHR+TwaEYfRJHy1S756Q=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=RTd3YE8Iyy9ZT1jVtejxEHE3G++FzwnltWjN/3UWcC7DFXnPS8gOYsFdk+AO4p9o8cvj+Q/Da2YZH1DOPaS120w3d37iwx2Jc2pLQMhDzeuvC8z6GYMIZMzDUWMDKg0OrRnDnS6Md8neOeYd6sRtlMPZEXQ6Z7N5Frc5BWZ8Ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=nvvCh1oj; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 0F46D60871;
	Wed, 17 Jan 2024 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1705497206;
	bh=kWJBAgPmQlo65pN4xHfEJK8XHR+TwaEYfRJHy1S756Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvvCh1ojRSByih4z4pujUTdTW5CSSakh2B+FqgLc5IfUHQhkK82IeDoAkkmRRrKOw
	 hA4cZiAkWPaQMLsxx0NpG8ltGjw8VTPCz91Jz3EsybA+EpPVWIdkWXTxzccADG6Ee2
	 xfZQbLbHnpmMOXifYtUQnHz4OZsKdVyNTp2dBVC/BJR5SCDIk+hPB6/IhSWEfpLbem
	 a95S9nY6ceQENUistnfewEEH6XX7ChMR6Lm0J+iIKEHxpgA1M2rGQp+Wr1FRju4wQc
	 /1bsLRqCpY4Ieb7u4NrwUGh1cbgG5EGnhRtxMb6l7tCMNbp2DStAzLZ7K49piiuiic
	 pDFVo3bZ2JAtA==
Date: Wed, 17 Jan 2024 15:13:05 +0200
From: Tony Lindgren <tony@atomide.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk,
	Paul Walmsley <paul@pwsan.com>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 00/13] ARM: OMAP2+: fix a bunch of kernel-doc warnings
Message-ID: <20240117131305.GP5185@atomide.com>
References: <20240117011004.22669-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117011004.22669-1-rdunlap@infradead.org>

* Randy Dunlap <rdunlap@infradead.org> [240117 01:10]:
> Fix many kernel-doc warnings in arch/arm/mach-omap2/:

Thanks for fixing these. These are unlikely to conflict with anything so
please queue them along with other clean-up:

Acked-by: Tony Lindgren <tony@atomide.com>

Or alternatively let me know if you want me to apply them.

Regards,

Tony

