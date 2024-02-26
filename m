Return-Path: <linux-kernel+bounces-81387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3F86756A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B806AB290FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEED85294;
	Mon, 26 Feb 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rLiNDjNx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544A80047;
	Mon, 26 Feb 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951163; cv=none; b=cb1iKCyCuHg6aPlxU3XS+GU9dIQQ4s6O4Ca/zp4GQn3OfD67nBUPoeP4UYRfhqQBqWqdzGchZ9JWWotj31J+Cg+9UUpMQvAq+bbxXsJzmhqCPdFU/vyY+7TwtTkP4jMFCkwNeXz0FADCvy+gCv7rala6ogTORKZCfrm6UrvJ7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951163; c=relaxed/simple;
	bh=VoXuXhySGOksbT1xym2WPiq8oAm2dY6RplpAjMSYhvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecO0riZxaYq3JIwoAAWDPA3TO04ToWTrGNHdoNmMvcZ6e3h3DkP8wsqAX9PtwWLD0ZRC8Q3+k54LzP/fRvhvqVKSt+h99HkdBI3k0/7u9fPcZkXvU8BBZv8uzlTlBMmCjvRsN+Wn9eYCqj4ItZygUs9uwYRdD9Rpa+E/UDxS/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rLiNDjNx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951160;
	bh=VoXuXhySGOksbT1xym2WPiq8oAm2dY6RplpAjMSYhvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rLiNDjNx8Hs4QeG6rGy6XbCKNrMo2V3PPDTU6JaXH5nT/SaXyF+3hgJHyHsYJeZ6F
	 5BnODhrejnmwpC7wqEyflB3EDNgWctAa9rDQkBeaETc0AYCrrJcVXpgKHS6I8CcES+
	 qwQpgtybhIKDO78tUSmIELb9nPooNGIQldiV9MVdhuSQYCveM9Uk30mO0ZuZb5IREr
	 0h0L9kDoL4ZgLkUDYwdWzLvDBKXON3RBPDR071Af3dK/6QLTPqfZP5C9n4uKvcPJkF
	 fimg84YFozirSMHR8UJQA8DgOKwLrVVvdaNwFbER0V9LfWwS5sgE5A49CfPo2I7Nhq
	 UfrKYIu+vARdw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E178237820D3;
	Mon, 26 Feb 2024 12:39:19 +0000 (UTC)
Message-ID: <ab0e22c5-3ee3-40c5-8bef-313ec7a28a50@collabora.com>
Date: Mon, 26 Feb 2024 13:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/mediatek: Rename files "mtk_drm_crtc.*" to
 "mtk_crtc.*"
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
 <20240226085059.26850-7-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-7-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename files mtk_drm_crtc.* to mtk_crtc.*.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>



