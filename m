Return-Path: <linux-kernel+bounces-150254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8334E8A9C58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391CD1F22D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C4165FCC;
	Thu, 18 Apr 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXkt8eRl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019B1411E4;
	Thu, 18 Apr 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449574; cv=none; b=mp6DsBLFPIrscneVxHyKton20pcMOhi2DsJ8nC8rpKJ53PYT3JJPtukhvF8ixQgv8r4NMKAkvcJFipksAXjisXxe/1usSqX+E/ZwDVxFFvW9b0LMMJoJD3P6xZU6wc+wmj9U/YpTPWNpFNWWdbpO0GS6e0CwfYEKZzP3vgmt47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449574; c=relaxed/simple;
	bh=jnDfVi6EWylq7MqzNCSDDOiuGvArZd8NwgzHsM3Atd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXtLrhwmd7MsyymbcJTzNr9DvM+UEyZrfGncuuulu6Zuu+rRmBKgiGCZJx2l5irIOdXudi/tt/tRR+PzUh3u8xQxlrJTMqHR4BfIORKb1x1omU4He4lMtOxm+6KkQ7k3i3ZvblSN6vF3waaZ1vMUJbfnAbmVPO27B0Ge3J3sKSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXkt8eRl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713449572; x=1744985572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jnDfVi6EWylq7MqzNCSDDOiuGvArZd8NwgzHsM3Atd8=;
  b=gXkt8eRl+noGWhnbPq9GA3Z79KjdgCbMI++MxEYiRYy8FIseJaqc3pw3
   /ZxP1uma6gglnuqh34++Y5P/MWg7Sj4GqXFpd4ijFmnOaH5IWXcXg56+P
   DoKzC4pc88VJlKjcouvE+jnDsoebEUpXk0shokIrjn4FUMCILKRWzBnUX
   Sxcy4Zk1P664k65tc5wp4D+Pi5+8KIizxvg3lZxvXk6HS7PNTAZv6VY48
   BtV95VZl0bmhKg9mj+RH32jwszmshZBNqnKPoPoiSzDewk92zBaY9sEy9
   7upMJRbIRH5OXdo4yzFrqx5/Au9ZQPdtpb93LDll5Sd7ZYugcN/dlUXfs
   g==;
X-CSE-ConnectionGUID: bHdwsw2cST22AFItuzSeIA==
X-CSE-MsgGUID: 03W4SY6WSkmaooxPr95Udw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12785093"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12785093"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:12:52 -0700
X-CSE-ConnectionGUID: muIKI36OQy+4EDVekWZf2A==
X-CSE-MsgGUID: qPbRWa3STYWcitOWH/M2CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23045756"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:12:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxSVK-00000000LbY-2WHh;
	Thu, 18 Apr 2024 17:12:46 +0300
Date: Thu, 18 Apr 2024 17:12:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
Message-ID: <ZiEqXkw_IvavCPVS@smile.fi.intel.com>
References: <20240418135737.3659498-1-rilian.la.te@ya.ru>
 <20240418135737.3659498-2-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418135737.3659498-2-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 04:57:32PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> Hardware supports both modes, but after

The hardware

"both"? Please elaborate, like

"The hardware supports both (A and B) modes, ..."

> commit 4afeced55baa ("serial: core: fix sanitizing check for RTS settings")

the commit

> we always end up with SER_RS485_RTS_AFTER_SEND and always write in

write to

> register SC16IS7XX_EFCR_RTS_INVERT_BIT,

the register

> which breaks some hardware using these chips,

Please, rewrap these lines to be approximately same width. Yes, you may split
commit over the lines in the body of the commit message, but tags (like Fixes).

Also it seems you forgot to add Vladimir's tags. It's your responsibility
to do that if you send a new version with only cosmetic changes done.

-- 
With Best Regards,
Andy Shevchenko



