Return-Path: <linux-kernel+bounces-109822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD588561B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED2128259E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8C41AAB;
	Thu, 21 Mar 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="il4T5zrz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F740BE2;
	Thu, 21 Mar 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011528; cv=none; b=KwrbKZy9JYORhSnzK8Fdii+crppFW5YdpBzEuLRALp2IDJpF0uXHZEJVKmzqJVUlfPxBtkH1C9mSuEx+9AIhQx6XJYvN/sAwAAAUVFh0t/xClc4aAm6YU9eyZmd+pfde0DOzXQILCk949t1u1n2kCOeymG1S2aHy4uMpb663+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011528; c=relaxed/simple;
	bh=0McerFxltJL+1DQ8q/eKcM6q/K4N01ogbaM2+Zm5fr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfYOblYOq1Sd4RVonicNuUDOevtfrLOhF1iHfDPpx6eDVNwLgb+ljoWp2BMUVF18meU1xuEZ6tyi+IHgzD8x0Rw5NymhT3epyTjaKLqhqRFn4pbeM+7UeOXZYstZnoHHc7fcrhB+dKf7D4BeAguqxnthZHvrmiDLtbWw5wXVBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=il4T5zrz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711011525;
	bh=0McerFxltJL+1DQ8q/eKcM6q/K4N01ogbaM2+Zm5fr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=il4T5zrz5aHxyx2Cow1i1RHOWEQvW38z+g0pmT3DDfNEBz2lgq9DSYd2tl3RSQYsY
	 1bmFMKCXH2s5KywWVn05K+6fR1vCWTi1eUXopl/Cw4koS2OJgdpR+iSBrVXBgDt3KT
	 JuDOzwTyeXoSDvDO5TGRRCHJ/yHo9RP/8kMmIt8Y3BoI/C384o37HgbNxlJb8FSSSO
	 4bXjhpkPrgon+UYl7D1B3WMXA9OiK0hLKe/fyeyyXmYulvE8LDNQifKzGzecU+TYfO
	 yRGubQtXK+JLPisHevflTZc09b3KjggbfOvnhL/EuGSSEAmrvm7FRUgNRQUZMItB7r
	 i3pMfr3bRdNlg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC3D537814A4;
	Thu, 21 Mar 2024 08:58:44 +0000 (UTC)
Message-ID: <5ec12d01-e229-4a4d-abfe-da069d052adb@collabora.com>
Date: Thu, 21 Mar 2024 09:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: spi-mt65xx: Rename a variable in interrupt
 handler
Content-Language: en-US
To: Fei Shao <fshao@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
References: <20240321070942.1587146-1-fshao@chromium.org>
 <20240321070942.1587146-3-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240321070942.1587146-3-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/03/24 08:08, Fei Shao ha scritto:
> All the spi_transfer variables in this file use the name "xfer" except
> the one in mtk_spi_interrupt(). Align the naming for consistency and
> easier searching.
> 
> While at it, reformat one memcpy() usage since the coding style allows
> 100 column lines today.
> 
> This commit has no functional change.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



