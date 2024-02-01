Return-Path: <linux-kernel+bounces-48526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63B845D40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E431F29B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21CB5A4C2;
	Thu,  1 Feb 2024 16:28:30 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876877E11B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804910; cv=none; b=sQAM1WfDyMn0/HGrsqzUMTW+mbVKeyeB1HSiA7d8oeDwbXh3wAhB09x3LPvpX93xUvc9TO2Y6hUTg4CbPe29Hu+J1HHkaq3/wM9lNAi3SmssQBpuvdP0d0BcRvMmbKYbJ3ZS486H811WzEOOX8q95ayTJG9ueSApvFN4iakJ0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804910; c=relaxed/simple;
	bh=ZseSbzamnSe6SWYZ+QyColgX/wFrQ1+jXM8CRoqmEIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sglNwp239nIoq5bmC28xGD6Mtw/6oiz9Ar3RMwoXIPhW5kcLQMU64WvCEEar4TTEcbsbIyJGMKHh6VH+2vyxEcqePJ/6+sUzbcrRYdhh1xwVTxCQL17Z79R5TuUHz1+pNJ9DolDEYN4w+BLTOa9l5P+gHKFwfT0TwPPBYh1m9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 207AA2000D5;
	Thu,  1 Feb 2024 16:19:21 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
	id 492EA8092F; Thu,  1 Feb 2024 17:19:17 +0100 (CET)
Date: Thu, 1 Feb 2024 17:19:17 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v1 1/1] pcmcia: Convert to use less arguments in
 pci_bus_for_each_resource()
Message-ID: <ZbvEhVw-k7UT7Wpm@owl.dominikbrodowski.net>
References: <20231030115053.2752588-1-andriy.shevchenko@linux.intel.com>
 <Zbu19xfahgI_dKLt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbu19xfahgI_dKLt@smile.fi.intel.com>

Am Thu, Feb 01, 2024 at 05:17:11PM +0200 schrieb Andy Shevchenko:
> On Mon, Oct 30, 2023 at 01:50:53PM +0200, Andy Shevchenko wrote:
> > The pci_bus_for_each_resource() can hide the iterator loop since
> > it may be not used otherwise. With this, we may drop that iterator
> > variable definition.
> 
> Can it be now applied?

Which tree will this go through? No need to involve the PCMCIA tree, and you
already have my ACK...

Best,
	Dominik

