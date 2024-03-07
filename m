Return-Path: <linux-kernel+bounces-95853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10B875418
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91E01F2314E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4829C12F598;
	Thu,  7 Mar 2024 16:21:53 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CF12BF3B;
	Thu,  7 Mar 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828512; cv=none; b=jenulQo0bgshR0YxH5t6A6Z6IqJrwee++CuztLfdbFSJQaksD2A8H5bHyI7W5VsesjqmVDtB+xfKX0+OJ+gs2DWrMmnd9Z7IFe/DITZN81AB6tPxMpEUE6JqsdGRKAkI9nH7I7FrBWMZA/H4CDTFMvnEc04Ii8+XU33JlZBBWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828512; c=relaxed/simple;
	bh=gdJDe1BXXrgX49DR3AvgGtzBWCMhgn8H6/h82lF6zqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFmUOFk+nuJsx9llpSjKuKt6CH7whbMqX/Jf31TuqGO/iPy+/GANKCDqzobnmkjx8zH9QM2SjaXEDfNJXWHb2GUwudovLxtQLeB05BPg6sg5YmYv4A3TM6E1GVicVpRrnfh6iJCnKrlBhhaL49fq6W3LmfOKWm1eS52hGUGyk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1riGV3-0003HB-00; Thu, 07 Mar 2024 17:21:41 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 4844BC0267; Thu,  7 Mar 2024 17:21:14 +0100 (CET)
Date: Thu, 7 Mar 2024 17:21:14 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] mips: constify struct class usage
Message-ID: <ZenpepiQjc+rNvDS@alpha.franken.de>
References: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>

On Tue, Mar 05, 2024 at 10:37:49AM -0300, Ricardo B. Marliere wrote:
> This is a simple and straight forward cleanup series that aims to make the
> class structures in mips constant. This has been possible since 2023 [1].
> 
> [1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/
> 
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
> Ricardo B. Marliere (2):
>       mips: mt: make mt_class constant
>       mips: sibyte: make tb_class constant
> 
>  arch/mips/include/asm/mips_mt.h     |  2 +-
>  arch/mips/kernel/mips-mt.c          | 14 ++++----------
>  arch/mips/kernel/rtlx-mt.c          |  8 ++++----
>  arch/mips/sibyte/common/sb_tbprof.c | 21 +++++++++------------
>  4 files changed, 18 insertions(+), 27 deletions(-)
> ---
> base-commit: fdf0df8c936c0822570e067009dee6824ff3a2be
> change-id: 20240305-class_cleanup-mips-a77ae01ea4fc

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

