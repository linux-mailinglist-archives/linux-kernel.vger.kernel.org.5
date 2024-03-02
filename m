Return-Path: <linux-kernel+bounces-89404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C804A86EFEA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C661F22586
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1314298;
	Sat,  2 Mar 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VGVz1U2W"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0D1428E;
	Sat,  2 Mar 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709372975; cv=none; b=LU+wcLCBEsvXJXbrnePK4C5bFAgn/U03JkxZysvoFjbtnNV5Y+/uEvWWnGcCbJLASchZhdcR4KpvNA5vvGF8GwwlmAlM3eZe5Knk92TgUsNp1Ho4Hkj+SrUkO3yaCnQRnjint6qWkxmtB5o3gyIyxqcUbVg3c1pEn9nHmTuCM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709372975; c=relaxed/simple;
	bh=4bOVk3Jsi+XgVSsjNQU0nnIrGaxrtw2pZNas2Q+Oqak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj+sXedLdSi27F9NScwESJ1X0F6w0tldmNQXJF8hJ9gIaw7qlzNaeJ67FKHOKGznhRHRnty2XNyhH3SbmKExHNKZxHAT8oZHHI02+XX5mzPm3Mv2AhUgOrojwZZ/JGjwWoeA6QRgCdQMapO+RqfG+F/Vh88+bjCkzDblw8KkRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VGVz1U2W; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EBB0640E0185;
	Sat,  2 Mar 2024 09:49:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6G_Eqa0qWae7; Sat,  2 Mar 2024 09:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709372964; bh=LkqWu/QTwwhlYcmHJp3Psffz8XCiVniXghlgoEdJxlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGVz1U2W6jvB+glKnu+odzzgts2hD+fzHROWCQ0i7dsQurnerlhzJW6YIfEh7eTg1
	 XWUh+bu2kfOitHORJuVbfm+roA2g9BkGplYqldD92wSN9UxuXh4bGMhfpwYtrFWH5Z
	 rBzIB8hV6vdJWyoHeOvFZPLcjg78EF6wILwwozPIKXuFClN5IHPyuVLG/qLEym2VOa
	 Z9jEhQYaQ3VseEqVxO+4GFcBfesNHtPVnXXwWImSR1PtGmDqXoR1gDQqax8FasRTSG
	 PpwMfU8EQdpd4avs1z5bIUoTIYu/2QDHY+eJF3jGlBjYUTxIsQo+j5kub6gvPXA2Qu
	 zbQ3DGHq0obvR02ozQU1hEuxUSYRwZUl5Yx2Y9O9i5MqMjFTk6KO27t7o4fmMJ0DRr
	 3wzxJUYMnaTofncQ70hRgpf1WrnzJFiTMax5ir8+gFcjhFMLIIsimo/xOavkUfnbb0
	 kfk7K35R6FuOV0pXkDqgAczTwWhCF2I7tksqS2Qz9pDcLGSU3KacOkef5tz6GKVqET
	 mDmEwZPq9ZfIBtUOAxPWdvVOV+9QgECJ9rb+qF6/6RE5RyIdeJaJ9kcjI1WrUrkyRI
	 kWUIQ7IujhVh0rrggMLocyaaTUT3VdI7b5mEAX5B2Xs7ZWqH01MaY+Q221Ks9PGMVS
	 g6k2cuYuFgIWBi5b7CnV0TBA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED13F40E016C;
	Sat,  2 Mar 2024 09:49:14 +0000 (UTC)
Date: Sat, 2 Mar 2024 10:49:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com, sathyapriya.k@amd.com,
	naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 0/3] FMPM Debug Updates
Message-ID: <20240302094908.GAZeL2FAON8R00Cyzt@fat_crate.local>
References: <20240301143748.854090-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301143748.854090-1-yazen.ghannam@amd.com>

On Fri, Mar 01, 2024 at 08:37:45AM -0600, Yazen Ghannam wrote:
> Hi all,
> 
> This set adds two pieces of debug functionality.
> 1) Saving the system physical address of a recorded error.
> 2) Printing record entries through a debugfs file.
> 
> I'd like to include Murali, Naveen, and Sathya as co-developers, since
> this is based on their previous work from here:
> https://lore.kernel.org/r/20231129075034.2159223-4-muralimk@amd.com
> 
> v1 Link:
> https://lore.kernel.org/r/20240226152941.2615007-1-yazen.ghannam@amd.com
> 
> v1->v2:
> * Patch 1 replaced with suggested patch from Boris.
> * Patch 2 update variable names and some code flow.
> * Patch 3 rebase on changes from 1 and 2.
> 
> Thanks,
> Yazen
> 
> Borislav Petkov (AMD) (1):
>   RAS: Export helper to get ras_debugfs_dir
> 
> Yazen Ghannam (2):
>   RAS/AMD/FMPM: Save SPA values
>   RAS/AMD/FMPM: Add debugfs interface to print record entries
> 
>  drivers/ras/amd/fmpm.c | 199 +++++++++++++++++++++++++++++++++++++++++
>  drivers/ras/cec.c      |  10 ++-
>  drivers/ras/debugfs.c  |   8 +-
>  drivers/ras/debugfs.h  |   2 +-
>  4 files changed, 215 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

