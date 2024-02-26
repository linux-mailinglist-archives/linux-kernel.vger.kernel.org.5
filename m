Return-Path: <linux-kernel+bounces-81385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E193C867598
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C20B28B08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710780053;
	Mon, 26 Feb 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WD6sijNu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B077E59E;
	Mon, 26 Feb 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951161; cv=none; b=mHyZJ6ovJIe7LLPKautI+mlyRRZnrZWF9O3Hwu8OZUr38iRPZOlkXVKETSD9v1Xai2arYHMySa2WdPRGUayc0s+naqEkLSPIAfeLqB+NbnEFbz6nrUrisEhs0cQCWwsLF16LFkNvUJhirazAIaT4ms5ULz/o4DM2Jd555TSqorE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951161; c=relaxed/simple;
	bh=zWqIhRQomq+Rh9bLslaOnZhfog8T1JQg0iJ7/d0GPd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcG4IAcfNBuTqxrS7m3fUJ9EbpyuIZXhURJeZb7ti8MFEPcSybhA9W5jUX9HPejpHKwXj3/Z03TPy52kEouz58unmn9C1cy6ApmGd+YIq4/1AbGsO22CDWCvpw3paOL/gXpfgPtSlOWodgk/6qWBe8zCjgt8mqEumTp+avu5x7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WD6sijNu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951158;
	bh=zWqIhRQomq+Rh9bLslaOnZhfog8T1JQg0iJ7/d0GPd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WD6sijNuZnnQtTu35pRonXDaVFGxoPRTZxZ5rm4CcuzIkAfa6wrwnLRsPPjvmu99c
	 HklfblJ8KPo2km9o8/f82uy3DKNj1eIA7jh+yl8XR4t7lOG0UcM5Jp04JkwNQ5gqnA
	 BUoV99J3lsa2Zpoa/aw+XaE0CEVILQx3HaOjSvMvsZDQZ98AE9l1/RRdxU9APe2qsk
	 kYBc5wGZqE47O8+0tUVzgOgQGLJ0PQPlsRjMGDFSKNodprbBF8zh6lrTugKPvfAbvr
	 d9qEZk6qsEGv7OWPjDMy3OUdPhFLVk23RYTSWBKNcmUg8xuTpVKYCTCGu3TLCInodf
	 nOQbA07w+jB+A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C697B37820C6;
	Mon, 26 Feb 2024 12:39:17 +0000 (UTC)
Message-ID: <9e007c06-333c-4618-98a5-17eb9283fda3@collabora.com>
Date: Mon, 26 Feb 2024 13:39:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/mediatek: Rename files "mtk_drm_plane.*" to
 "mtk_plane.*"
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
 <20240226085059.26850-9-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-9-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_plane.* to mtk_plane.*.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>


