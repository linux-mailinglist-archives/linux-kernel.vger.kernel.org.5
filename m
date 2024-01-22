Return-Path: <linux-kernel+bounces-32718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534EA835F50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065A71F218ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A253B18D;
	Mon, 22 Jan 2024 10:16:27 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640573A1A1;
	Mon, 22 Jan 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918586; cv=none; b=OhfqGy/H6tXwy4orZUKSwM9MeBVaDTT55VJzVyQKlNr9sKDQawpV4/oslM8bDnuULkH6KUo6aHlVU8fl0nnli1nN5qgz7aFGluXdpeQgZEjvip7hxc4gZYG4Z+arOMCkIJNxl7fDyHeKWGfGmVXBLpJrsdqOrD9odcS2Ifbvxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918586; c=relaxed/simple;
	bh=HDJwToY7El7/XF+bPAaM3VGMAkAqOHwwFxVruZJklY0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOvvrmz6Ertj+Gc0sA4NXkcmhYPrx4stjFR/90VTnPrszGlO8fPvrWOf5BWeF0W2rNPERffArhEf22JHbva1jWMSGjWsoGXoILxczExe4uIWUxUcdZi3YhrbEAW0mWpIoP02UnCu7/X6vRWnvUGknwH5gYthxf63gymQkhwc13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rRrLi-0000Se-00; Mon, 22 Jan 2024 11:16:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id C95EFC066C; Mon, 22 Jan 2024 11:15:20 +0100 (CET)
Date: Mon, 22 Jan 2024 11:15:20 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: sgi-ip30: Fix missing prototypes
Message-ID: <Za5AOLLf4FamSQlq@alpha.franken.de>
References: <20240119133757.96563-1-tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119133757.96563-1-tsbogend@alpha.franken.de>

On Fri, Jan 19, 2024 at 02:37:57PM +0100, Thomas Bogendoerfer wrote:
> Include needed header files.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/sgi-ip30/ip30-console.c | 1 +
>  arch/mips/sgi-ip30/ip30-setup.c   | 1 +
>  2 files changed, 2 insertions(+)

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

