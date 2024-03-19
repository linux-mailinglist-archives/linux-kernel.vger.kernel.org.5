Return-Path: <linux-kernel+bounces-107440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D48687FC90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081E8282625
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410A7E77C;
	Tue, 19 Mar 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xhypjOnk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F964CE8;
	Tue, 19 Mar 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846580; cv=none; b=iFkDgeJ36RxrURWK1TTBemMPnThiW7ltHxPpKXIJEk27EnBRq/d8RVeOocVTlSpMD0Ax8Bu1TBXP9z1iKQX7G2k6ufQWDA/ARi79d8J7cmvHo0ndxCnPtCwbqJ8UD6bzm4yy7RDcXmDQ4x/pC4obT0Q+Wo6Fuv7ZT/oRd7Sfj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846580; c=relaxed/simple;
	bh=DourA/0qtqJccY0YwtslIRYxVpkSt+PiPLohgHqz3jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phJ926lBXmoZ0d47selx99AuKSYmdXLpUtGTwn0wIIdOy67utBP91Oi42B8o357qN3vrBUcLGGOy1TK2TPtDI//SACMXsLoWO6WQKqJywG8Q0g8uhIt+eciUh2kxfsiXI0J7/TjpYYoEmCQDNzk9CMm6FlWuZGWofcDUTaKdTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xhypjOnk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710846571;
	bh=DourA/0qtqJccY0YwtslIRYxVpkSt+PiPLohgHqz3jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xhypjOnk+pB7osBDF4GazIcsWVe6YP3lytU59L1UBjtopOTFqfMQcj37T+VuFvtOF
	 op0XYNLKWaJDaB8sSbTFI6h1Qf7BAkaVsqK8XpGyztkpb9k+FKBcZCQNANJtSkl/Jq
	 V54plTgPKG5RrRoh1vx6sA/mzkD7L4873YF3nzXwofFRgeNcZLwiwR8x/Agw224DC6
	 I0swBt9Z3q957naTiwIzOewJp4LQUKmNTIz8AMMPyQC0hTa6rSLZrw5okh7YJz8/rf
	 o+NEGMy28qg6ugKb0YnzzYlXmNUt4fxrP3fwZVUuyEGxxfvY/fgi2Igy1buRjla+pY
	 tOqo08tka2e/w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 38DAA378149B;
	Tue, 19 Mar 2024 11:09:30 +0000 (UTC)
Message-ID: <06bdefc8-d953-4475-b46b-4a728af58f48@collabora.com>
Date: Tue, 19 Mar 2024 12:09:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] drm/mediatek: Rename files "mtk_drm_plane.c" to
 "mtk_plane.c"
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
References: <20240319070257.6443-1-shawn.sung@mediatek.com>
 <20240319070257.6443-12-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240319070257.6443-12-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/03/24 08:02, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_plane.c to mtk_plane.c and
> modify the Makefile accordingly.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



