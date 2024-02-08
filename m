Return-Path: <linux-kernel+bounces-57945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB484DF5F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F816B2B477
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D0771B50;
	Thu,  8 Feb 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qRwNDPia"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9586F534;
	Thu,  8 Feb 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390366; cv=none; b=r4vqrQBLH4gwuvdTi+yRU/OmezmRtYKDvT9FdtA0QtfPHHdm0wFWDO+7d3GBeHgp7sL8iimOZoQmKp+7Xibor8gpavDquFQ/zyZk9/rnOgcOVdXYpwBMeSrXTeJV3Okd1UH+KoRXPVpIsj0ruwVQ4QVfbEOnCfyyRBQ0YVDC1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390366; c=relaxed/simple;
	bh=Cs6htXQD5fBG1zCUptzHGOkqKSyu+r7Da744Jigp1lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfRz9SQB+0nqrjndgkJDhJLhT62jUqLd68vtdDr1A17E4W1bWOwrD3no7q3zyxzXOgcf8IeY+68enS17eE13etDJfoFoiLngisTm9mqy0F0nYKp68E1IeGYTwG5y+xBR9dUPIzsrIWHEtqBFCcUVQ8TY2cmU3gMT0DggMZAAzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qRwNDPia; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707390359;
	bh=Cs6htXQD5fBG1zCUptzHGOkqKSyu+r7Da744Jigp1lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qRwNDPiay9bPu9taiyTfr3AV31bGiRL/Op9Ot3D+AuExTqb251f4JjplaWTVWNYvU
	 aDind2pjljl2DpvSCkTrQXN3f8+RvV/Dn4dIZG92zqgFNgNqLX0GhLxEQU6+SCvCCo
	 4AH9xerF2qTaEqgwaikGL2ULKsJWYkXT3SSS7HH8pci9a+3NkoQFwuNG5nl1T/FWUf
	 z2ngE/s6zIKE5WQYUYbN57o1GnyRm+Y+h5JEFJe6YdQvuqsjbIv+vQPtMN/ovkhN6h
	 apnY+rXdhTJdrw4IqOERKJ4nzR9EAgtGyWyBdLjLyPgnZ1dhKUmSiGUuCZsmuw5q1y
	 FD6pMIaec+ANQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A82A1378134F;
	Thu,  8 Feb 2024 11:05:58 +0000 (UTC)
Message-ID: <7e834188-2838-40fb-961c-fc28bdfca169@collabora.com>
Date: Thu, 8 Feb 2024 12:05:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Add video decoder device
 nodes
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 kernel@collabora.com, Yunfei Dong <yunfei.dong@mediatek.com>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>
References: <20231220133302.39411-1-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220133302.39411-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 14:33, Eugen Hristev ha scritto:
> From: Yunfei Dong <yunfei.dong@mediatek.com>
> 
> Add mt8186 video decoder device nodes.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> [eugen.hristev@collabora.com: minor cleanup]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


