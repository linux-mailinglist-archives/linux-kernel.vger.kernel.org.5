Return-Path: <linux-kernel+bounces-81386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93E86753F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C56F1C25AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD58D82C97;
	Mon, 26 Feb 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zy8VC/57"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C07F7E6;
	Mon, 26 Feb 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951163; cv=none; b=oPpn/Em3oOBjIt5ZDPWA/qk04BMJ7CHrs+5euDBHhCMg4+bzsZmCKCx8TsP1TY2MqMvu6IWV+qqaCglNv9RIN6SgOqFtpH+ysnPfXmiZ18eod/czMpGyNYS0UH9bQtQetO8BXRdLFG34sO4iuNYV+7PL7hpd5HcrNOEkthh+PRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951163; c=relaxed/simple;
	bh=H5QQImwOVHK1yLhVZI5bmy2YvP4j6L75vwOdjG6Q7oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYi8D7xesMHMmAcfDMz5wVI0JylgAxch4ctnLV7jryC0wQJqxnuQ9MoZbI4ZRCLmxoxyCf7PjHrMKqdnUKF/m6J7eN09NpwDvetXkaDLMix7KBv4gP9k46O2PY41uy+hnzMoBMU0+s4ER6bc9/8On2f6sxd5h0Fx5jBe4XOiq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zy8VC/57; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951160;
	bh=H5QQImwOVHK1yLhVZI5bmy2YvP4j6L75vwOdjG6Q7oE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zy8VC/57BMNIPNXUT2cL5Qr7lu3GSVNO9ouoQxQBANXhc6sbDDre0NLPY6wbz1wPo
	 8i4NxClv9zVNgyubH6p/bG6DVg3ZqXjFbm0b+wjh79z0RpgcD4V+qPgGUMyiKQMwLK
	 C342WjnONyqwfm9C1otr4kAWvPpVF1ATZR8KQ3MkpNTH2vSWNVGzQAMcaYSUVba7PV
	 F8rvMBgGuQnwFLsVNGSSM+6h1qF8K7htswWlhn51wBTooN1jPXx1phFln5oBvcoaBL
	 a6d25Zwl+/wHqJe7DMhRgMqwsNWYAoLS2PrM6i+5/FfNo2USp5fX/LPuAK937E/HPz
	 aA+rj2AZ/j+DQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2448137820D2;
	Mon, 26 Feb 2024 12:39:19 +0000 (UTC)
Message-ID: <ad23e108-85f2-4f0c-b281-99140e6f20a0@collabora.com>
Date: Mon, 26 Feb 2024 13:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/mediatek: Rename files "mtk_drm_ddp_comp.*" to
 "mtk_ddp_comp.*"
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
 <20240226085059.26850-8-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-8-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_ddp_comp.* to mtk_ddp_comp.*.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>


