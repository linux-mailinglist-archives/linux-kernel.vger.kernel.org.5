Return-Path: <linux-kernel+bounces-73097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74E85BD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1CB286058
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695F6BB2D;
	Tue, 20 Feb 2024 13:48:54 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A716A34E;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=g4kV4FIz/kw3Tb7+ywwIZrfcvbyTjblVJCmlVeme6wY2eDmpx6Tyzuck4we2ZmpvzqNZCbMrIofoWCwfnZgDle5KdzPLKZGNecIR0FmVRJWybF7vZIE2RbiCdpNwqkSgQvuPCdwli0f5NVDCfKn7RQbFLHUAWWkpMmvyTZzJjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=dnHyi2krLy55hbWApPwySj7GAp6hhfw9uc+3Pp2XTQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc+xGkWMb7XoeqzbJgdBNgTa8i7LyD/Ay11+SCg0CCuK+dMDrjx80ndTyHUyIHYPHXX90fFh332yEEaMDU9cl9EkQw/5/HEGpCJwoUvtJIw7w+7QDn9KuF3X0SIfSnlKgyFf4x46Hp36q5880ILWrklc7aq2gBIs5+gkqzABO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007OU-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6BFA0C069B; Tue, 20 Feb 2024 14:38:58 +0100 (CET)
Date: Tue, 20 Feb 2024 14:38:58 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] mips: struct bus_type cleanup
Message-ID: <ZdSrclzKXvC9W/c4@alpha.franken.de>
References: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>

On Sun, Feb 04, 2024 at 12:06:56PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> ---
> Ricardo B. Marliere (2):
>       mips: sgi-ip22: make gio_bus_type const
>       mips: txx9: make txx9_sramc_subsys const
> 
>  arch/mips/sgi-ip22/ip22-gio.c  | 4 ++--
>  arch/mips/txx9/generic/setup.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240204-bus_cleanup-mips-be3d52c96e32

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

