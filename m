Return-Path: <linux-kernel+bounces-158249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4648B1D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7672A1C22EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C18839E5;
	Thu, 25 Apr 2024 09:11:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD241C64;
	Thu, 25 Apr 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036314; cv=none; b=WILM4lWymG3WzASEBDK8lRmq+Fddx/jbzQz6fnmGYkLZPAiXPTNWoU83uOmuHpGVvXjtVhJWTPo/fHbDTAiYT9U3BB+xwaZ0Ehdpfp/LPZ/mUTVIb8XPVfOeEWPNBqoMgbPfSss2As0Q4vYKjbwTXTUA9k2Tw5ZUYdJhZymFH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036314; c=relaxed/simple;
	bh=2BiK9cirnO0J3vdykzdZ1+Q8/T/xoaz14pvT9WYFNUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu6vU8HFq0WaoSS+wqNawwbLv7v2NyBaEzB0OR4neP1LzNuUWYaMtjOizCtLPEfKwpghcIsTcIql7H0BKCgqTu5zEkZ2sMzGtszJkNbSRGIjS+KIRjD/3PTh7I5bceJb5XIk1b6ERLKDsbxXeaWWq3jjLUSUyMLHOPsH0T0hQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 97sgVFwlQ4+tdU3CNxPW0w==
X-CSE-MsgGUID: xjKMEg+XTdyNAHY3AB5sMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="32200219"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="32200219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:11:53 -0700
X-CSE-ConnectionGUID: 2Lwo97tmRT+PGdVSDmeNcw==
X-CSE-MsgGUID: Y6kuxSRyRSuWA6KyLwJFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="24999126"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 02:11:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rzv8o-00000000wF7-1EEi;
	Thu, 25 Apr 2024 12:11:42 +0300
Date: Thu, 25 Apr 2024 12:11:41 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org,
	conor@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org,
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
Message-ID: <ZioeTQZ6i0FbcDIv@smile.fi.intel.com>
References: <20240424191908.32565-1-rilian.la.te@ya.ru>
 <20240424191908.32565-3-rilian.la.te@ya.ru>
 <CAHp75VfpRBDTjnZCdOKK+YWZKJ+wbjsg-n4wxjA7qVE0L1WSxw@mail.gmail.com>
 <CAF1WSuxAFHbSVAV1r2cDzZms=T_Qg6y3qbgU5rrjySuAd3FUNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1WSuxAFHbSVAV1r2cDzZms=T_Qg6y3qbgU5rrjySuAd3FUNw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 10:25:41AM +0300, Konstantin P. wrote:
> On Wed, Apr 24, 2024 at 10:34 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Apr 24, 2024 at 10:19 PM Konstantin Pugin <rilian.la.te@ya.ru> wrote:
> > >
> > > From: Konstantin Pugin <ria.freelander@gmail.com>
> > >
> > > EXAR XR20M1172 UART is mostly register-compatible with NXP SPI UARTs.
> > > It will be handled by same driver, so, it makes sense to add DT
> > > definition for these block into driver's documentation.
> >
> > blocks

..

> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >
> > Hmm... Did I? IIRC I only reviewed patches 1 and 3. Am I mistaken?
> 
> I think it is my mistake, not yours. If you want, I can do a new
> version without a tag.

Yes, but give a chance to others to have a look at the code and the rest.

-- 
With Best Regards,
Andy Shevchenko



