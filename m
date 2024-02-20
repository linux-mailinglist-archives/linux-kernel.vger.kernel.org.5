Return-Path: <linux-kernel+bounces-72691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF0585B75C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4234D1C240DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F660BB7;
	Tue, 20 Feb 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="TW18YElw"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE275FEED;
	Tue, 20 Feb 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421260; cv=none; b=iAYBZejE3QCXDjiJ5iozCfdmaiv/KE7dCCc9qafkc7Unj0QjnoWPNLDqgJzGq501PFwsmGIh9txHEAV52CSAKm4vPjebWRNXi3u4m7Wiwi7Dwbqk+t7g91BY3ID+cAdjbkeY28B9DwmeVUd0vhh9fg/SIjT4NqDagWHd1ybEOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421260; c=relaxed/simple;
	bh=tK0P0Hc1PBVUxV0yawRjY2jZZPz5jqknAUvE8cKFy5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbLxXNeSBV/YiJXRWlTEqv1vIhXXg011If90WEiypECfP9eFEuU1E+bOO2wkB7dY+aZdX2xWnkQB7Wr5RnkkjYek49x8KOyNQj4PmsnodMHhLdRx9l1wUZOMuIAglR4IcYU4GeO3ag4dyAruSOqGneObuY0iiy2M1DSTofMID/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=TW18YElw; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 4E6C6603CE;
	Tue, 20 Feb 2024 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708421252;
	bh=tK0P0Hc1PBVUxV0yawRjY2jZZPz5jqknAUvE8cKFy5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TW18YElwcSz1lcRuZqF3wzTR8mxEfy7t204cpr/wybOgRqIkRjMncVAx65/OteWCS
	 Nb3YUfjj37dmFbGddVXrcOheMsvMt08I42L6jc98fCZcYxroPPi68zoS3vyiwNU+5k
	 En7VpWhiAQOSK/S7BVo4CV49Pc3jkfGC+G9tbVKYYSjHbs0ncsE78wm8ArOU0cSrvE
	 dZWo5eSc7fDtCVFglCWZ+2C2s3IlQ64upxnjKzp9pjEGlzaItwe7pxPA7ORXZRRbSK
	 bQHqkJObKZvQTyaILqsxDiqF8xF2ayCSXPrPe/4BLPTo3D1yUe/SDYKueNFQv2DFrg
	 RYuujGwdDdDMg==
Date: Tue, 20 Feb 2024 11:27:05 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 00/10] clk: ti: Adjustments for eight function
 implementations
Message-ID: <20240220092705.GU52537@atomide.com>
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
 <ZYxTS6Cfm_c0WgXS@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYxTS6Cfm_c0WgXS@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [231227 16:39]:
> On Sun, Dec 24, 2023 at 05:33:53PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 24 Dec 2023 17:03:21 +0100
> > 
> > Several update suggestions were taken into account
> > from static source code analysis.
> 
> Unneeded churn, if you want to make it better, switch the code to use
> cleanup.h.

Yes cleanup.h sounds good to me too.

Regards,

Tony

