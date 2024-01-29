Return-Path: <linux-kernel+bounces-42449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5836984017C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6501C22410
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BF5731B;
	Mon, 29 Jan 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GWhAUBS3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819C5A7A2;
	Mon, 29 Jan 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520371; cv=none; b=oReQNjsM0MbugGq22iWT7RxLKi25V6NkESURB77TBOvFtZQ+QlxnRJFh5NIlqqV8IrxezlqlGdVUvXVIcUgmU9AdPumdzVM1MJahva4pNAr3JjHtx/ILmw/lHvk6ZEV+K6T8ALQH+WiaEqq1iVBCoZ5R6LAHrreJLJHJ6cY/aOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520371; c=relaxed/simple;
	bh=mD3BBaDSM6iKFRlP8495Jtw65FYthsPspbosIc10CTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBZu48o3t+lZ4Z7T66OGuC2hoci1gT6cox6Lita3AOnrt36pAhiW2ywhAG8xI/4v5qKYxXnLdSSToSwCMuNS6lJMJHInCkH1GApwbULSSpCi+xsPfrZzhlTofcdzQ/NwEJxt9mA8VubXp8m3IjC9TeP6rqof7cov0/jnfMA7vks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GWhAUBS3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B8C9540E0177;
	Mon, 29 Jan 2024 09:25:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EA-2cmC2PRoN; Mon, 29 Jan 2024 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706520355; bh=qIiXCGyqKwu2QJF8jAU5+a3LK41+trpgQG/R/t4oxjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWhAUBS3cS8L2SWwymaUv/gjaVObXWOINDOJFg6HEQ5FHeirOyVJ98u9n/6yb6ZLw
	 jdfgtFZDdeK6ztDmlJjCoTKdycnkyCIlTdrGyrRzKiEYxYpu4Gehz8HgrMRz8ggYpJ
	 UjvubAIIEE5CiK6JWn1/UGpza09rPXRrr4p7ZfNy9aOMEZms1TCjnPE/HDXWWShjkt
	 HcfF8cH1g6A3hJrhiozPWoVbQqxel/YyfIslLG0CxQrrPhOtWjVeQ7zknVISzFbIFD
	 8aHH+KVVuemUW80hIP3xhnRbEdYLWzVW6uRtY8RYQG9I9ZbvbM66KgSQJ8WC1ZJgk+
	 QhrsY9dW283HuO6Lefy2jYCO5fmJLTAvOdbrQ4RPYTcK38BhXrR9dNIxG4YWsikDb6
	 ZDQHMo/Wnb6MwPAlbNCriQAvGF9s+0NP2KSIgPu/FMZ/7m3PBzFx2Xgel9lPXE2q4M
	 x64tP/3OKOdgmFlAVTXt6xIkVEHq+e3c58XxvEcg3rihLVsJXflL5Tlt7hWEXcOp2i
	 b7mrfEB67NO+0rVGscj3ivW6c/w2Fofm1YskupDKDB/YhpANUkHFiinmuTZP4EZwG5
	 G0Qg56j3ffprNxSCSJxaJ11RO290mr2HqzPWM3EGqXMO+Z0eUWTRzEunpVN/zRj2G2
	 ddpwGuDQ8kW1REHYnLka5Va0=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3D0440E016C;
	Mon, 29 Jan 2024 09:25:47 +0000 (UTC)
Date: Mon, 29 Jan 2024 10:25:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH] RAS/AMD/ATL: Add MI300 support
Message-ID: <20240129092541.GAZbdvFbXrdpENB97h@fat_crate.local>
References: <20240128155950.1434067-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240128155950.1434067-1-yazen.ghannam@amd.com>

On Sun, Jan 28, 2024 at 09:59:50AM -0600, Yazen Ghannam wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> AMD MI300 systems include on-die HBM3 memory and a unique topology. And
> they fall under Data Fabric version 4.5 in overall design.
> 
> Generally, topology information (IDs, etc.) is gathered from Data Fabric
> registers. However, the unique topology for MI300 means that some
> topology information is fixed in hardware and follows arbitrary
> mappings. Furthermore, not all hardware instances are software-visible,
> so register accesses must be adjusted.
> 
> Recognize and add helper functions for the new MI300 interleave modes.
> Add lookup tables for fixed values where appropriate. Adjust how Die and
> Node IDs are found and used.
> 
> Also, fix some register bitmasks that were mislabeled.
> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Applied, thanks.

> ---
> Notes:
> This patch is based on patches 2, 4, and 5 from the following set.
> https://lore.kernel.org/r/20231129073521.2127403-1-muralimk@amd.com
> 
> Patch 3 from above set is still needed for complete MI300 address
> translation support. This will be the first to follow.
> 
> Patch 6 from above set is needed for expanding page retirement on MI300
> systems. This will be the second to follow.
> 
> Patch 1 from above set adds MI200 support to ATL. This will be deferred
> until after priority MI300 updates.

Yap, agreed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

