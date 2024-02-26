Return-Path: <linux-kernel+bounces-81388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9E867545
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA801F25F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D58663C;
	Mon, 26 Feb 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xz02KPGR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745880C18;
	Mon, 26 Feb 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951164; cv=none; b=secPFraO68sqfGvGYLah4Qga1dNQpRisryHoM6S21bkmiOk9NLxQhdZ1jC9svpFj+eAUJd6a7tfVglV7mNWYx5L4bZ6hbNhrm9g+afnGXbeVFsb5+pVRknghDQCz48fG8iMft1io22BF2eqcdF90o7IprB7Rd9D3nIDMTkJQGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951164; c=relaxed/simple;
	bh=Vb2OybRb6EbpquqUXrX2fpZBgmRePi8veZhFDg0yXtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pU8wtn9+AvRZrdR5tlc5igu+wg6OuDD6XUn1Tsq7FCe5goC7RAdJ4tYOwBesoLY1VooXueixNpFSVRCucQnlb+aMH634p2IkuVDp1z0c/F67qsOWRgPWqK1Fd/5Vd34aAk0I7qE013Xt+bhGsEUPOe2Zm3x1NLIzq3mF0hHsiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xz02KPGR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951161;
	bh=Vb2OybRb6EbpquqUXrX2fpZBgmRePi8veZhFDg0yXtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xz02KPGRNIGVOdyyV41Fi7rJ7IasD2HnHqqOJxzWTlYkynqEtaFajqBmBItrpg+8g
	 FlDYRJpPukRP2tFmKT5z6VlHKZNXlYjqXonZuLL9SM4cwDH6XLvvqlvI+Tg+tzQzG+
	 GZNjifZrVw5nAhHP99UC4en/vf2EXKLVLncFt3xEunPoD92P4z9j5wbvo0ADkx7qzd
	 7RZ1Tfs5D7u5fH7vkgDVdS5Ts6Dsdd7iEha0lYXC5DkkhiVi5LJ6oP2jLKYAWyg3Kc
	 E9Rl+Hq0AG7Im5astKl2yHniiwC9YQM+ekticvYsEZIXTvDpCuwbDswCA2yBvRAwOJ
	 px0ddrg79oipw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED26237820D4;
	Mon, 26 Feb 2024 12:39:20 +0000 (UTC)
Message-ID: <2a980f3b-616a-4371-8799-818367f7f65c@collabora.com>
Date: Mon, 26 Feb 2024 13:39:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/mediatek: Rename "mtk_drm_gem" to "mtk_gem"
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
 <20240226085059.26850-5-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-5-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_gem" to "mtk_gem":
> - To align the naming rule
> - To reduce the code size
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>


