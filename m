Return-Path: <linux-kernel+bounces-121571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEAF88E9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0B9297075
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A46112A160;
	Wed, 27 Mar 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lOcQhYo+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97412BF39;
	Wed, 27 Mar 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554525; cv=none; b=fkCFNxIpVtclQzxshCtWA+ELnRG5H+fBXduymgT1214eR+JZzdEAzLWn0g3mmzBC+EqTinolHH30yV2WVeUx2/GcnbzuvNYJBoFP81APXR3i8aJPRQmiLqE+gzpxKFjhacRH1ct29Cqq6CQn5H8ni5jPCZrG+1Dhlt/jg5dyer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554525; c=relaxed/simple;
	bh=0lBCOiGJZsLp9XozwByMVzqlaygvHpHmzEZ12pQP62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6PGR6q6g+lPUrOCc3878PKwBUjKVdLJyNk1kr9R2enL0Hl5K+kuLc8GVDxXWo65M5PjySNu6mI4mMDDN0ru+EjnsRmLFeYJXcsOZLHLfSoBp3F6avuP7YcaI1bIaTUIH9+zC4vC9mBXN7EImwAo/wr5m2+Qq2w6DK+pyR31nzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lOcQhYo+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5D8140E024C;
	Wed, 27 Mar 2024 15:48:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oZ9Y01BW6sd6; Wed, 27 Mar 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711554517; bh=6lwcTIvU4yG21aAYWM8l61di7mHTUQ1ZGvZOcNTpVH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOcQhYo++Zexd75UMv5W0EH8ORASfx7gmXW2opJ2PDN5CRCT4INNB7S7Apie/YyK0
	 G5M3vqZo/OHLgrftQAEZGDeFlt+kUBKbky6QOkTByMsOO6dZetgYzE7u1aZi5gOlZm
	 DEN0EC0dqLoQr+sEKtkd3xNP9RgcgH2+15eaDBPmhTT3blMmrtXBCq9jO6+2+Ctkpg
	 XickEM+0/1bvFc7QySjuiY2FsJAHc0v67lvJGdOXFjfc7Vc3yuyw6fK6v1xOGtTK2C
	 0K5By5XgaPnAMnnHSG6CPg5sDjvVPatzsoyZpGU2JaqtEgofANCF+C21+v0OCWKJlX
	 MEOwuBwNQN+DWJ3wrZCiQHNFeWzCkkYPGRHf13oE/as1Pq5T/AOHe2bbbGa1afbV2i
	 Fyjq6WO0qGDYRDptEdMizcYRdJaulG/gy/OxWpabHvduXi9sfI/RDad9cPyJ9Ltq6v
	 nYBLT0ooRrl2FOEZcw4+QV9QdUUlwrIxuB/ig1UW0lvrgSlT91pGi1VbrKGHGKshhI
	 XNtVjMeVKYYrBVdVHHtqh53JFd2975SCeah0JI1q4EJh8xf5bcEycoJLqf+m3T6U/s
	 lEJCGYb4q1yRuR3HxxdgqX9yLf9AO+3GQMmcy4Ey5rBTtm0ovHCFSZmD6AJ+9LC2Lz
	 mQb4KPPq7vy2CJRwBskDFuL8=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E65040E02A5;
	Wed, 27 Mar 2024 15:48:30 +0000 (UTC)
Date: Wed, 27 Mar 2024 16:48:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com,
	"anthony s . knowles" <akira.2020@protonmail.com>
Subject: Re: [PATCH] RAS: Avoid build errors when CONFIG_DEBUG_FS=n
Message-ID: <20240327154828.GAZgQ_zK1iUbWxuXd0@fat_crate.local>
References: <20240326203252.2699278-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326203252.2699278-1-yazen.ghannam@amd.com>

On Tue, Mar 26, 2024 at 08:32:52PM +0000, Yazen Ghannam wrote:
> A new helper was introduced for RAS modules to get be able to get the
> RAS subsystem debugfs root directory. The helper is defined in debugfs.c
> which is only built when CONFIG_DEBUG_FS=y.
> 
> However, it's possible that the modules would include debugfs support
> for optional functionality. One current example is the fmpm module. In
> this case, a build error will occur when CONFIG_RAS_FMPM is selected and
> CONFIG_DEBUG_FS=n.
> 
> Add an inline helper function stub for the CONFIG_DEBUG_FS=n case.
> 
> Fixes: 9d2b6fa09d15 ("RAS: Export helper to get ras_debugfs_dir")
> Reported-by: anthony s. knowles <akira.2020@protonmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218640
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: anthony s. knowles <akira.2020@protonmail.com>
> Link: https://lore.kernel.org/r/20240325183755.776-1-bp@alien8.de
> ---
>  drivers/ras/debugfs.h | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

