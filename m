Return-Path: <linux-kernel+bounces-150582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BE8AA138
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4102845C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38309175544;
	Thu, 18 Apr 2024 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjG2DlPI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0657171E5A;
	Thu, 18 Apr 2024 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461881; cv=none; b=qvAhlVk8uw0yfsS3c4fXuiNDswae3mK5pZlVo2ZBvvm98Wi2oTwu7NCy49qck+syFnxU/2R8Po32RMV2+oUL+TYQaLSyrF9KIquEkYNqmnwKiSxRWxQeYxc4G7krl3M2Yz/BdJvAJe5UTfZAGxh//ZmTlWSer9XrHR3C+Xg9orU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461881; c=relaxed/simple;
	bh=sov1ioee3d3W4cpmqQXXRXw1XlTvKh/lMf8Iva1ztOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB8Y/HZKGMtnN96RwWW4relcyiVF8bUyAcNXxAa9FEZn6QPx7AxlGZBFVUVPZgdPuFiNyinAaFZTMyvzLb0KxwG1p65STwrK57CpRP1byZu4YfH7TEbBj3sUYr6vIxNQ4z33OYfGUI8GeRDacRlnNu/SNjpPX2KJWRRZWiTEyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjG2DlPI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713461880; x=1744997880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sov1ioee3d3W4cpmqQXXRXw1XlTvKh/lMf8Iva1ztOI=;
  b=GjG2DlPIc+1Oxn2xxRx1sJ+AM4TVvG8nkQMyEfTXLMy/HnL2oRyVbOa1
   hQ9iIV2mWLgVnW7fb11I3ylNgxwucrZsObhBBEiIu57dOUsw4foKyZR9/
   OsliE4RA666+DOarudTJaUMNzhlv1HRgSPT+Eztlj7AL3TeKqbvwXMXrR
   5+fJrFTLjM6pa2kuHL29F+W34gMpgob2/BUaY42arYEEHMw/yCzK2u/Wu
   QI7OG1wShyl4zkGpfW/VJ9cPg7jnsRSP18iqiWak97DPBq25LUOqtOzqy
   jHo3YYaymdO/7WK11ezdz4Sw9+xhTAMcX8j8i5vVWzW130jUWqjSHyFch
   g==;
X-CSE-ConnectionGUID: Z1O1i9C6TuSq+mc4FyFgaw==
X-CSE-MsgGUID: G7EsSDIGR6G0E6zpCE8ASg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20416206"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20416206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:37:59 -0700
X-CSE-ConnectionGUID: e9B0Hp8jQeeIvlFrq5nuwg==
X-CSE-MsgGUID: 64Jn8TC/S8K5Rw/TbJjGiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23510032"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:37:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxVhp-00000000QGm-0Yjw;
	Thu, 18 Apr 2024 20:37:53 +0300
Date: Thu, 18 Apr 2024 20:37:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
Message-ID: <ZiFacIT0wzvhzaEk@smile.fi.intel.com>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
 <20240418170610.759838-2-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418170610.759838-2-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 08:06:05PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
> after the commit 4afeced55baa ("serial: core: fix sanitizing check for
> RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND and

  "...with _RTS_AFTER_SEND set..."

or

  "...with _RTS_AFTER_SEND clear..."

or?..

> always write in the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which

write to

> breaks some hardware using these chips.

..

I might have been not clear about Vladimir's tag. Please double check
if he gave it against the certain patch or the entire series.

-- 
With Best Regards,
Andy Shevchenko



