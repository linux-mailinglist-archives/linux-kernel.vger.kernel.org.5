Return-Path: <linux-kernel+bounces-68732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29872857F22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47171F264FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0612C7F6;
	Fri, 16 Feb 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Bn2HfMIH"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFD12C817;
	Fri, 16 Feb 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093123; cv=none; b=YxvEOSaLDUh+zhXyQuKd7au1o/cm+ntdBRzkrY9HD90MS4e7fmR/6hvlaRI9XSzYnEBxIcuvFOODAn837vSYiIWXTRhb8ga2z16qhvYTDusR4vfAedODf5L9HdTJA4oAr8zFGmcvVnr2ZBwblgrQwnoj5Z/zdzZfDNc5s6D9T88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093123; c=relaxed/simple;
	bh=SZZOeJbM9IqCNRzXyb/vtXg4j78a3vQTIUylqLxTqTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCbfKVvlC5J+iVWX/cgGbbfrgHX9lDtjpw316ZiEoyhZfkIHn2NKAyxgcEjRdNGW42zoH9f0nhnd7s9FST0QFcL9LaK2RxX7sZ1xnKoxUFkodgIaltnmek2oDBfNHCw/Cr++/P6F3ZnL7HLVTpxkwnByZvybH7uoSzsOLluAiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Bn2HfMIH; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2F8731C462F;
	Fri, 16 Feb 2024 15:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708093120;
	bh=SZZOeJbM9IqCNRzXyb/vtXg4j78a3vQTIUylqLxTqTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn2HfMIHDvH9l7V2fAjwpcG0c0/NmPWKIJH52PiBhofcHz6e8hQkwUtugapU8ixfY
	 nw1ZuEJanOj9/S2F+ygKSJmWhnMUU5vpY6iaIQKy5d4z3KtgYfybLAQHIXlLnXbecG
	 pdPSOZGYcFyNvyJ9pOQgyeqr1cZpPe0hdE1MZfV5VDKM0oSChLnSlbo8z7ClQiVjvB
	 KxZqriHWB9+QO3em1KHwl9W4qG96QuAMSckuNhohjqeofGvIR9ZnefA0HH+U4lXzed
	 fBy1Q+i5J6tZGSFiwmhr3rnb42eUik86OjtG7GZI/FTHiPnz6+dfDSWS8f0HTnrQPb
	 2aF35QAc5aPvQ==
Date: Fri, 16 Feb 2024 15:18:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommu/mtk_iommu: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <Zc9uv4smFRfzf_mY@8bytes.org>
References: <20240211182250.12656-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211182250.12656-1-erick.archer@gmx.com>

On Sun, Feb 11, 2024 at 07:22:50PM +0100, Erick Archer wrote:
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 2 +-
>  drivers/iommu/mtk_iommu_v1.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

