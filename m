Return-Path: <linux-kernel+bounces-32715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10033835F48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15601F24C43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82A3A1C5;
	Mon, 22 Jan 2024 10:16:25 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6400B39870;
	Mon, 22 Jan 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918585; cv=none; b=LrXJM66DxhCSfTZRorAqjiWUVrsOYu2osKY2kW23E1+EnnCb0cymLLfpzkHDWpZKA4HDRhOHqmzPAAqRIW3H1HCAahgDHLtRvPhg8bQ9Qthk+RoFjy6ZCBgVBcLJ3Omu80fIic9dKFipzbMdG8+1cbE/J4mG27LLsrNMkg4u86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918585; c=relaxed/simple;
	bh=Q6pXhV1/wZqc7CK5fbkIxuGOLOcfjuFU1vLu+/ZkKAg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAJMCEHKqOXuRmRvwIgvWf+KIeZmjoToLryrM/4Kr1ARyuKQe6SCRSf9pQU1zcR6L9pt4PL4HsVcFvEqdSLvLFw9ouR+qlYXXX4qXIbm2NvdCz/0X/PPwAB7qLb0aowcHiokJ/QbY/akCGpR07Hd3Gymhwr62xnNXFprYDjsn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rRrLi-0000SY-00; Mon, 22 Jan 2024 11:16:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 7994EC04B4; Mon, 22 Jan 2024 11:14:48 +0100 (CET)
Date: Mon, 22 Jan 2024 11:14:48 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: sgi-ip27: Fix missing prototypes
Message-ID: <Za5AGLuh80adaR6j@alpha.franken.de>
References: <20240119133216.83220-1-tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119133216.83220-1-tsbogend@alpha.franken.de>

On Fri, Jan 19, 2024 at 02:32:16PM +0100, Thomas Bogendoerfer wrote:
> Fix missing prototypes by making not shared functions static and
> adding others to ip27-common.h. Also drop ip27-hubio.c as it's
> not used for a long time.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/sgi-ip27/Makefile      |   2 +-
>  arch/mips/sgi-ip27/ip27-berr.c   |   4 +-
>  arch/mips/sgi-ip27/ip27-common.h |   2 +
>  arch/mips/sgi-ip27/ip27-hubio.c  | 185 -------------------------------
>  arch/mips/sgi-ip27/ip27-irq.c    |   2 +
>  arch/mips/sgi-ip27/ip27-memory.c |   1 +
>  arch/mips/sgi-ip27/ip27-nmi.c    |  25 ++---
>  7 files changed, 17 insertions(+), 204 deletions(-)
>  delete mode 100644 arch/mips/sgi-ip27/ip27-hubio.c

applied to mips-fixes
Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

