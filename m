Return-Path: <linux-kernel+bounces-108679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CC880E55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C99528380D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A079139FEF;
	Wed, 20 Mar 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1cicMcx3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276539870;
	Wed, 20 Mar 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925752; cv=none; b=uCvP+VOpzEgZljrGOLXp9IGLfZ1EecD1qYCKcMk0Yb6KxLE9PHwVx6JvLvF/F82KF9p5Y6ZE+3oKuxV8a94gJP2mWFn23VBanuHW2RHqSA8aOLmoEW/PSFcc3twfuHd3XS60d5yH0eS/IafBU7RUSjsm3Ed9oCCAR4U/Gd/S2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925752; c=relaxed/simple;
	bh=WL++lSiQWnN695SrxzJhseXDuycH02PQhHRdBX9Zm3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXVfR64J64ya6puAyw74P8uPwmCsG1Fqx4v/gGsY1dRu1yv4vs17eZb9bA0zpIERSUpNcxiFMbhvRGS0v1VK6B/z2SS2sguzU+llqH3Vx4n5UHcErb2cl3vCioLPrUT+JH2RzgglGzJpWioU+wxw5/2Rk2P5z965OSp9VDWmdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1cicMcx3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710925748;
	bh=WL++lSiQWnN695SrxzJhseXDuycH02PQhHRdBX9Zm3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1cicMcx3GHSFdlgc4r0/Nix5DLRLaFVACMk05mRRdZKAbxS5nSRXiKiGA4MG7Lp4b
	 Er4sL+Jpu1KpJtf0c3OHDrZdiVuUuK/I0sADlM1/2KSvy9g1HQq53bTpEoxmUaxcF4
	 qDTT9gfNWqpFLlX4fwyKOJW9dgP5VsvMhEAmcvgpt8UvOeNDxKWiOSbMTGLzgzu7N3
	 az+QNeyMsn2HJbWgA9TS/skPXJhDSJ/V6qtL8WTipHpawktrmzwtgVH8TdgeUp3qpq
	 iDfihMUMIIMJk4LqJ8KB1pwH4sUO9X0fhyPCxTuFCc0DPzrHKjXKNzsmMf1BIdbSB0
	 aiRpukMe0KDzQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A713D37813C4;
	Wed, 20 Mar 2024 09:09:07 +0000 (UTC)
Message-ID: <1bc3e804-50c4-45b4-b227-1099e50f4fc6@collabora.com>
Date: Wed, 20 Mar 2024 10:09:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] drm/mediatek: Rename files "mtk_drm_ddp_comp.c"
 to "mtk_ddp_comp.c"
Content-Language: en-US
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
References: <20240320024222.14234-1-shawn.sung@mediatek.com>
 <20240320024222.14234-10-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240320024222.14234-10-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/24 03:42, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_ddp_comp.c to mtk_ddp_comp.c and
> modify the Makefile accordingly.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


