Return-Path: <linux-kernel+bounces-64872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BD785441E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028111F280A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5F6FA7;
	Wed, 14 Feb 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lI0j0dur"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B9522E;
	Wed, 14 Feb 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899806; cv=none; b=Mmfr3424EQu4dreqfCRD7XbV3hdpK0TEeDneiLy6fioD8qLW9RJqXJWvL50uVNXzyp+VrnmxxVRUHmbwAb+JsvCvKDxeo1bSyIOimrxMLa/SUZVRxZ1GaDrD46zhH5uKoo7IqTMpQ/mlJosNXt7/3RYdivHEswKGbXczyJEXOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899806; c=relaxed/simple;
	bh=zQgmIhi+kQAKviTy4ChZK3tEEE/C4xNJP03WQkiuQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unmY5/inYAM00ca3TnKLIDY7f3wWinxKmBXL9TXwdnIOadPYSIKFieXL/1Akw8ThVitU75TxRQ6KjQZwfyZPF+KZ+69KJw5WmpXgMP0NOC/e5lvJHxLtjRNPPefeJC4WdCNGEDet3YmRaqEZ+luGsJ3+YG031xh6/j34YYx/a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lI0j0dur; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DC4E140E01A9;
	Wed, 14 Feb 2024 08:36:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vo1c1cekKH8y; Wed, 14 Feb 2024 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707899798; bh=siSrL0RoIFgEq/5UZFumCLQMop+BzDrlljtnxlEM89o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI0j0dury37/40BMOf2FxxhasZLvwE5jofAWPPAC/qMjiQeBbsl12GdJAIPeJCObY
	 tag1L+H/ttEsvE5kGMQu7AHOboIx5TK8VipBnZD9Uc3lzaWhjVUrRt0j92WT81AEYT
	 1gMvfZjBUsi+haW9mYiRZUzM3jXGkFiL/ar8sV81OSuGhJTZ+rr5TAAKIcWRonJryQ
	 erhkTe2AS89T1xaXYJc3Ixljxl5cQUtsyHc38t2hcfjD6Yb03UbcSU05h9fzZEqNyu
	 iW3MmWTBiLzOjFxyMsxstaSQ7XOpOnGixirDE3G3GfgOkhy9+/9Rmq4pYffm8b61EG
	 JkiaolmEaHekHTmF4mCaDS5/BkImOYXEmBRSYZbWWYzyBZLH4iFbgTkD4zbtSUdnl/
	 z/EWan+Z5pmQIdc96YEHe1oVa8/tGZO4F1Cs/6IceSX1IeaZa5SsA9efi2weMWMK5U
	 FCa3UMnJQAMz1rqMKNfzXrOR30acpGv4sHj6OvHkCxsibg6mGyY57w+7NpKhT7V9el
	 guGoq3DC9pMbmQb/IaCIniHF/e6PKGpjXeT3aMUqfRjBGVPqpnhL7zjDv0Wzj6Ud0U
	 2XyZfHZZMaDh+cVRSN89VNv3fxdNpDO9cIs76RhcWw0hPabpBa6bD73a9VyENcr0uV
	 LPVTi6UPa9y+XGImU37+Nvzo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1EE240E00B2;
	Wed, 14 Feb 2024 08:36:29 +0000 (UTC)
Date: Wed, 14 Feb 2024 09:36:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 1/2] RAS/AMD/ATL, EDAC/amd64: Move MI300 Row Retirement
 to ATL
Message-ID: <20240214083623.GZZcx7h_BcIWpoEmMJ@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-2-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:15PM -0600, Yazen Ghannam wrote:
> DRAM row retirement depends on model-specific information that is best
> done within the AMD Address Translation Library.
> 
> Export a generic wrapper function for other modules to use. Add any
> model-specific helpers here.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/Kconfig        |  1 -
>  drivers/edac/amd64_edac.c   | 48 ----------------------------------
>  drivers/ras/amd/atl/Kconfig |  1 +
>  drivers/ras/amd/atl/umc.c   | 51 +++++++++++++++++++++++++++++++++++++
>  include/linux/ras.h         |  2 ++
>  5 files changed, 54 insertions(+), 49 deletions(-)

So basically I can zap:

8be4984891e0 ("EDAC/amd64: Add MI300 row retirement support")

from

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-amd-atl

and you can send me a patch which adds the row retirement straight to
the ATL?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

