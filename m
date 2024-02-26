Return-Path: <linux-kernel+bounces-81392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7015867580
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46A3B24EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1999129A7C;
	Mon, 26 Feb 2024 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PlHqoQnQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A251292FE;
	Mon, 26 Feb 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951171; cv=none; b=qcgvsb4UlBR//M8GxDtD/2etifrlqYfKqD1ZlAure+OiN5vvwWgjgEF4PPvESOsL2EzpoAOi9pGUZQBmzquO47p8dyMq0Mrvj48ZyK1YSd96l/5iQ8sFPJfAPO4ih/D8QaPEFOYZc8AykUlR8N4F9uetowgdl+nGCFxfR7/gzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951171; c=relaxed/simple;
	bh=88dR6h9lJ9zsblqbl116lycqd3kac8LDpJzTZ64nA+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d30eJ2Qi6G/bOR2REpXkqaBangYlXORCpbWuEUElSk5M8tPVNM+LDE5/Up6jZwiLTMcn9ROJ8H2gdCR28pDx1AqzaRhppZMUlOhaA+/5BWqpKCyQdQhNAwPyqD38qDLjggBfnMumgRf47xlNda0ufcrIUdIuxrlV9Jh+SSNLkpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PlHqoQnQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951168;
	bh=88dR6h9lJ9zsblqbl116lycqd3kac8LDpJzTZ64nA+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PlHqoQnQ+yYx2ziy2vXnJ7AoZBjp/IkAsdrR4FyFfJ8IqrZw3KTEZJiv3Qk/5nBk4
	 5LlFB4Ol+5Wmwk7XpcpwPj1f5e8N8vJOazW4U4YPrZMx/0mo/+rKasSljVBjXgqWMc
	 hXrDN3j/VlWrKOvbEY82xsbocK241BO/9PjVvtWbguUvNd3wEZ7fzfiNpWe6lCPnIS
	 IeEPSinFX+dbo7hLCSqLPdjjLMaukQkExQuQboshEC+Prn0ViDwK5sYAd9HpKQJz0w
	 JJKeamiVzq0zEw6YdL3bqx3MAX6NAI2z1hpEXIFtOEHJ/87xWXfW1tgHQkhBZdaTSW
	 BkeckRP/QcW3A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 69B7537820C6;
	Mon, 26 Feb 2024 12:39:27 +0000 (UTC)
Message-ID: <e36b420e-28b4-4544-b877-75e0ddcd0abb@collabora.com>
Date: Mon, 26 Feb 2024 13:39:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/mediatek: Rename "mtk_drm_hdmi" to "mtk_hdmi"
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
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
 <20240226085059.26850-6-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-6-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_hdmi" to "mtk_hdmi":
> - To align the naming rule
> - To reduce the code size
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>


