Return-Path: <linux-kernel+bounces-76795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155B85FCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADF91F24258
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84E1509A6;
	Thu, 22 Feb 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxLDDnTk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973B14D42B;
	Thu, 22 Feb 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616445; cv=none; b=dj2Y8Faxp5ulKZ1XzM+2BpbseAzHTMs8dSS8MtD73JXH049t8lZMvJ35gudqzt6Ar0DKeqvoF95ywgwHjHr8QGrqDknhHeudBOoJC+NAmFguIceMKNxI7r6AsAavD+xh82lxn+v1l+4X2MYKAX+kN4nvxQHF2bL+GlATQ2VC41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616445; c=relaxed/simple;
	bh=NhgsP69e5xaKaQR3joSaVyGX8rbvAFpibr82fzzEjYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWSFAS3D/c/4OVPa/XK2LPaijTkWefs0laccSqUijfo0ba+GQ/Xx5rvJTmaEnilR3pHVLlGcvCpFQ394XNkFpXXpdtXWJWbqoG7IhGF3UCZUdWStWyZBNm8ZBqj6WYlPMQD8cvaw7436gEkxupMFpx/gembqzHLhDo0Bfr1024M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxLDDnTk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708616444; x=1740152444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhgsP69e5xaKaQR3joSaVyGX8rbvAFpibr82fzzEjYs=;
  b=GxLDDnTkGHKJpmMJc4HX3pqZh/UfwHDub+r5Ow6DHzw+hQBpetvgWhBn
   Oi+UVRXq+AtaNk4hMpQTiYH5sFk91nRti2FK+uafXRYPIjGMJm2ldBVzO
   fwhCjToSppucHmXydGrRCQEV3ucSO/EDd0SxKPe7ffLT3oz2eSLZbMYpr
   JBnal4tfyEQcUXuaul+4AE15PnvhMPSoy+f6Mf3voiSYcGNnjOt6x6qS/
   xobZui73YEbC74y1gbuaihDkssNc9BmpJrZ0dF1uZVwXL8KvFM7/sANjI
   lGYLzVTKG7xpkyS/UUi47J4uJuRmwKz0iaXCjooNwszJsgKEriIfXS1kg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2985691"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2985691"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913544497"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913544497"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:40:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdBBc-00000006fMg-2Odk;
	Thu, 22 Feb 2024 17:40:36 +0200
Date: Thu, 22 Feb 2024 17:40:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <Zddq9P6B1Qy3MAlr@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-4-herve.codina@bootlin.com>
 <Zddqr3aN4rU-upai@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zddqr3aN4rU-upai@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 05:39:27PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 03:22:16PM +0100, Herve Codina wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > The original work was done by Andy Shevchenko.
> 
> Mine SoB is enough for a credit, but thank you :-)

That said, you forgot to add your Co-developed-by.

-- 
With Best Regards,
Andy Shevchenko



