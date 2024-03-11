Return-Path: <linux-kernel+bounces-98655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4A877D73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF2E28126C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE31B5B7;
	Mon, 11 Mar 2024 09:57:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB411C92
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151051; cv=none; b=C39Cp0pykjWWtEKSTU2S2L+jEtMdlNz5wsg7popH6ySnBLis5XVaVcpZmqbkADCJGp3/q/6Ku4uP4L0M6W06VO7kkYkMjHuXmwiT0nN2visgJeH8Vm7WIMTuaz5qQMJJh5n+ODKjOZPP9ZCe3RUWB3LA5Sem/onjlQSUBGIG8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151051; c=relaxed/simple;
	bh=2vuKp+KDsTG17ZrXBaCobVy0VRyFIZv2frWIqn2rFco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjFdLiA9kg7/yAaPxRB8q5uw7vFMHF0L7zvQ5zOkM2NvIFN/w2Yh94tmRMZdz40PF0sFQc9iTUAXTYTzvFGPtpeWtehNc5GbnzeLMDBlwVkWkp/D66x08bOpLJxxmwFhXYpNZL8h4dWA8e9X9DukdltEW+9pZOB4bCGBOHsMgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4940783"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4940783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914354392"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914354392"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 02:57:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rjcPN-0000000BaML-3sAR;
	Mon, 11 Mar 2024 11:57:25 +0200
Date: Mon, 11 Mar 2024 11:57:25 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: seg-led-gpio: Import linedisp namespace
Message-ID: <Ze7VhbLL9WaMYjrN@smile.fi.intel.com>
References: <20240310211304.1190913-1-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdUO_C73AufgWj3qxFbArgWFq8LSr-gdcBaKcCSnqaOeKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUO_C73AufgWj3qxFbArgWFq8LSr-gdcBaKcCSnqaOeKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 10:46:17AM +0100, Geert Uytterhoeven wrote:
> On Sun, Mar 10, 2024 at 10:13 PM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> > The seg-led-gpio driver uses symbols from the linedisp namespace. Ensure
> > these are imported.
> >
> > Fixes: 899383f9ecf5 ("auxdisplay: Add 7-segment LED display driver")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202403100401.IDre04gu-lkp@intel.com/
> 
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



