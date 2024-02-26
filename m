Return-Path: <linux-kernel+bounces-81391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2863B86759F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF67DB22712
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7A21292E0;
	Mon, 26 Feb 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OjQXnoSi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0096127B6E;
	Mon, 26 Feb 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951168; cv=none; b=a9d5lVlVEyI+g2bia7ssdRUr3l0ZsEgStyZafuzJ80EtNiXPIkbWM/BrFU+6jln+8xiKF5ut/u7Jv2n/CU80o6AOCNX4xkBgEKgcZ+o5pl5f5Tx/pGZjdOC1xeID41sq2itQSFCx6x/llE6gONfVG6Zb4KdM18x+ipmzEIWg8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951168; c=relaxed/simple;
	bh=al4+qYrl72W3EO7KsAna7TNnccJdret+KOW9g3y48Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hj7ExndRo39FwEMYpch+6GvNM+r7DDlAgiU1F08CoW0Jt7zUOyy8IxwTACaal/ag8WDPnKEvtiVX7tvyovaWeYsk6jT/MrOK7Po7JoVd76Gt7Fc1oaCsHbIqD0QlF0a8UytpHNCm1d7c6F3Yn9szribk4AWXf6qw6qrv0M1et1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OjQXnoSi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951165;
	bh=al4+qYrl72W3EO7KsAna7TNnccJdret+KOW9g3y48Nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OjQXnoSi0OFcAXmbFW6QSbMsDToYG21H/yq1bFjspi76CzDzLBubNZvXD+2lfPnim
	 9wk41cuSv8Q7aMhAVtpkGiGpC7z+K3QsqOgHCc7ZFgxyZKrxj/TJUUUX2NrEjJEtbn
	 Hednai7bVfDW5UpkMovHV9M66TD8dLhg++iJsnI2SvjwIjzYBw7RJ2yufexirNo1XD
	 DOFQj44F/bZ3Y74T8fX2ExO9SXEJ2mfathrJqPabT6ncx78w7WoV60sOphDXo9ts8t
	 4/Zdz9PyWqSAqyr92Bbrt0HbyMAfzIRPx40iXw3uc/BtN0W2GZy0BaLlmGFYzFWJev
	 OHkhkm5m9SL+g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3505337820D2;
	Mon, 26 Feb 2024 12:39:24 +0000 (UTC)
Message-ID: <93fdbd08-2096-44f8-a623-b85e0ebe9ecd@collabora.com>
Date: Mon, 26 Feb 2024 13:39:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/mediatek: Rename "mtk_drm_crtc" to "mtk_crtc"
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
 <20240226085059.26850-2-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_crtc" to "mtk_crtc" due to the following benefits:
> - Lower the matches when searching the native drm_crtc* codes
> - Reduce the code size
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>



