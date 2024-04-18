Return-Path: <linux-kernel+bounces-150604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141818AA1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451A71C20FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446F177981;
	Thu, 18 Apr 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl3+85A2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82C16ABE3;
	Thu, 18 Apr 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462971; cv=none; b=RABPFEPdjjHoZWMxVO6ByjhFAegyccdalCK35vIjhPSadHwvo3jcGuVF1L8IDpKcEX4nrf3ODywPZPJY+xksU869gtivDonsvlkj5Yw/HYO1ZNyciE1sSlghOepZB0JNnSbEodS87C7X7glfazvSQOgGif6Qmzb8xB7tF/J0eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462971; c=relaxed/simple;
	bh=XpzujCcdERmPu46sGe08R4iOXBIo+a+jF5r7W8EodEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5gWgk1NxbjzkzOIyAWgphSu3sIbcvCkEqSg/x6Re1QHFvlF+U1KxSFe5BXsnuW6qibvHlNzO0FHmBlrP1JqE3DNt9g3YINyYCx1lFJb3+mixsKTQw94zAQhxqYoYC5+2EEMR/iWdiuXMeNupn8Jhi5hmBa+x2DmhYQy4lJ0zUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl3+85A2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713462969; x=1744998969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpzujCcdERmPu46sGe08R4iOXBIo+a+jF5r7W8EodEg=;
  b=Nl3+85A2TMeMf1+nBZd4PxEqTXIl07t5bDHlPs1XlFTLO8yL7Ffj7e00
   so9RWMt5Q9OBl0ODqrWEShKovkyZ3Q5xvSri4n7v0CGNLmmaZd/nEdCf0
   7Vxf2/P4MDcmUanbrUOysT1S4xf+D2mPGzvBoiAfSspg20JrHBi0Rg2g7
   bPk8/t9CWOJv+6dwW5FXSeQhODLOWGovLVB7GmHWRGAv+330X+6yDgl2L
   gUCXodlmjTqpc0vLd89/sVJO4pVwey0nwX/DC4WvoGLMhaLV8efs0Zw4/
   Bg/ItpBa/Ml854rQdvUDuuNQND0KA2RXf9k/67Z596+Y3QCVdI1v2SJ5W
   w==;
X-CSE-ConnectionGUID: /QR6ouoBRrqGsv+MtHN2xQ==
X-CSE-MsgGUID: kXn03Xl3SiK2/9/4lze0Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19731724"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19731724"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:56:09 -0700
X-CSE-ConnectionGUID: Yb9aLvwNRdCdiwqvS6t17Q==
X-CSE-MsgGUID: JM/vJdMCRmqAlyYd7dEfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27628220"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:56:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxVzP-00000000Qam-2nCw;
	Thu, 18 Apr 2024 20:56:03 +0300
Date: Thu, 18 Apr 2024 20:56:03 +0300
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
Subject: Re: [PATCH v3 0/3] add support for EXAR XR20M1172 UART
Message-ID: <ZiFes8AQgcj_SZ5V@smile.fi.intel.com>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418170610.759838-1-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 08:06:04PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> it has additional register which can change UART multiplier
> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> flag to guard access to its specific DLD register. It seems than
> other EXAR SPI UART modules also have this register, but I tested
> only XR20M1172.

> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> or "DLD - Divisor Fractional Register", calling depends on datasheet
> version.

I see, interesting inconsistency, but that's what we have to live with.

..

I just have noticed that you haven't used the updated base for your series,
you need to take Greg's KH tty tree and use tty-next / tty-testing branch(es).

Speaking of base, start using --base when preparing patches, it helps CIs to
test against correct branches.

-- 
With Best Regards,
Andy Shevchenko



