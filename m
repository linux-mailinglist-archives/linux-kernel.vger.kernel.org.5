Return-Path: <linux-kernel+bounces-100455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C778797C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF81F2327B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8C7CF1C;
	Tue, 12 Mar 2024 15:38:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20997C0B2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257909; cv=none; b=AforkQqpr668Bw6XdgdszGWcuiCKshxc/V5BTRiojICg95xI2ZLkJG6qitksRmIY8KztbIyOyPqFlYgUDJnZl0VctzQivoPBmFgj/4md1tEEHOWw54NjwzQ9TlRgumJYegT+YUae+XBhXHDq4O5YtsScloFPnibNcK1ieaCsxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257909; c=relaxed/simple;
	bh=Qmb/J/71t1f40+UHTg1KaoGDofb1fNGn8OjvQR8BHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l31n0haeXgXh2sAmNpLSwQI0apE5uYSgYpbEs3PjvWIxeDJTRSAbk4R9Zh9AP7xnNNAECIZNutWr4oZfd8yPa6bDtXJYXvNeYd6UrZOwUzslIi61Otu2LC9WbHLL/7gEJbPDXN0V8sb4L9hbDqGsrOEHot7kbqMu///xoBCALpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4827490"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4827490"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:38:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914399992"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="914399992"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:38:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rk4Ct-0000000BvqL-1Rx9;
	Tue, 12 Mar 2024 17:38:23 +0200
Date: Tue, 12 Mar 2024 17:38:23 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH 0/3] auxdisplay: Convert to platform remove callback
 returning void
Message-ID: <ZfB27-QS2nm1xkp9@smile.fi.intel.com>
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710194084.git.u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 10:59:21PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/auxdisplay to
> stop using struct platform_driver::remove(). See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> All conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
> 
> There are no interdependencies between these patches, still I'd expect
> them to be picked up together. This is merge window material.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



