Return-Path: <linux-kernel+bounces-73096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03EB85BD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A7285EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA306BB34;
	Tue, 20 Feb 2024 13:48:54 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09FF6A348;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=I2MWgxHTZuy6rgT9Z0wX/6FK06xQWRibTa2KSa9kEZhXOEskjR0suve3uMVpQx8M4IrcD+gWLhkbTDFSKA3mJw0NFWog6e8pxzLxEiiuTj2vWQp+UcCpXp2qF6ybG/nwO/mg7J2j1aD3whBKeSa39dvdiBZ2OX3D0XA6cO+E9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=8GvFNVF9duq/2bUVAkBo5DWH41frpnACDn9XWjN8Zj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcHCww2t04Lo7oD33q1djZ38xZ78ygIQV4P5lEZfUR8gUp9eKkeyDutpns3FINC5YLkJl96D47x4Uy8so5/egDnDfZIN36Ntwk5mnGNITv/H697DtLdb+m9Kj6QY8JNyxzJ6TivMxeHl6zqNkPVSJ+y1fhwELnUogzYtczI/4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007Of-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 4C9E7C0AFC; Tue, 20 Feb 2024 14:40:10 +0100 (CET)
Date: Tue, 20 Feb 2024 14:40:10 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mips: bus: make mips_cdmm_bustype const
Message-ID: <ZdSruvrpmTydq+M7@alpha.franken.de>
References: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>

On Tue, Feb 13, 2024 at 11:49:24AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mips_cdmm_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  arch/mips/include/asm/cdmm.h | 2 +-
>  drivers/bus/mips_cdmm.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

