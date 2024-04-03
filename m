Return-Path: <linux-kernel+bounces-130672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CF3897B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB341C21E92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481E156988;
	Wed,  3 Apr 2024 22:16:09 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668115697C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182569; cv=none; b=bzGoiQscU1IKHtGlRUQz3gDxj1RO0SD8so3W8wsk+2pNZks+HLegE7YuY89oLEMt4p13AVg1pcJvmhDDUvRsIJGA25aTf5UoXY0c6Sfbp1bmwaKE5tu5iD+AZdre2RvnF+8W+w0FAlXTx9qXZd9AJK80I+mmT083BnKwU2m3f7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182569; c=relaxed/simple;
	bh=ZpesLCCLmCO35nHydmDuctE+j4iFYWZ2fEjOpbOvMVc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3wOGpxbchkwgKL+Yc27oV0ORAICnAog9WoeoJD99Q54JYETRmiyeToXFKahPCt1sUBYZ2u1HOVXWzzEKhcdUIDg1OJNh5vKklcb7wRbQZsMSTHI43ZG0A86f7vplDMk+sUZVlVRD25VnyN3yrfZpxzwOmi3NrRzMoniQ/YJ6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id bfb1eb53-f207-11ee-b3cf-005056bd6ce9;
	Thu, 04 Apr 2024 01:15:59 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 01:15:58 +0300
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v1 0/3] serial: Do not count XON/XOFF in the statistics
Message-ID: <Zg3VHs-LVxHFdi8V@surfacebook.localdomain>
References: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>

Wed, Apr 03, 2024 at 05:46:14PM +0300, Andy Shevchenko kirjoitti:
> Some drivers count XON/XOFF in the Tx statistics, some do not.
> I actually a bit uncertain, but I _think_ the correct way is not
> to count them, hence this series.

Okay, it seems there are much more drivers doing that. Perhaps we need
to add that to the rest in this case (i.o.w. invert the series from removal
to addition)?

-- 
With Best Regards,
Andy Shevchenko



