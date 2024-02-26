Return-Path: <linux-kernel+bounces-81383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29830867532
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D441F23F17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93A7F7C4;
	Mon, 26 Feb 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oG6Wk+Kz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DA4E1CC;
	Mon, 26 Feb 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951160; cv=none; b=fBOpcvZawg5hVDW8qmx94QjQK27nDGJWaAKDU/nJs3P96GFhwu3xdhExTz8Z+6ye7QnJS7ir2i9XaxoAXOzy+JTf2z0JsDeUZKcVENXt3vlwNuxIRMsGlX40Wx4FwNRS3nLPlPw7b2OyHS+iVVScwhL5txnep3U37VrRbpdZI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951160; c=relaxed/simple;
	bh=jZDjZz16a7jYDqF/ga6VZUm7J/5zMDjmn/buH8/I2Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAu8Y0xLJPowO+GjVRvawmzsnnNaQ2wsEYskLE3mxEXNbKUNNj68F+rqpBrZeQ2WBY3V0j8J9dlQYBLrUK9KN14x+XsLqhil9zEEqsuWK7uadJsOW0mdzjgW2PympN/olXNmiyW+7QHMJWk9Km6q5ImKfr5Y5yQHoIgeLmIJgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oG6Wk+Kz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708951157;
	bh=jZDjZz16a7jYDqF/ga6VZUm7J/5zMDjmn/buH8/I2Ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oG6Wk+Kzl1QHp140YXlMFVxLcC2trHNBIcOFA4v9jMBdMXKuFTeb/s36KUUqhaVsZ
	 0Un+pP6SHNGUhSZKr5vc6qqh0nzmU/2Stk9q/8foCCWhYxpB3gTk5+fNR8xT3CukTM
	 XAXPyUK/7ylpry+QkwCI5DuG285oeob87xOQ1rDXFNt1WeBdfCNyrmwsXCLAo1+aDa
	 w625iJrgaMcBv8oxa/2tGmhkiWJOVmypyYsZsAE7LRRsYlJVBp6Pp9yEidqseWkZ90
	 Nor5FqRkpjku/Fewqlng8Y9DtyvsWKlZ45bOKoCSGQJhESKN4M4FYoo2uYOd3taddm
	 Rb1JZnRcUsW6w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 17C6A37803EE;
	Mon, 26 Feb 2024 12:39:16 +0000 (UTC)
Message-ID: <3354332e-7e9c-4caf-a38a-a7b26eba76cc@collabora.com>
Date: Mon, 26 Feb 2024 13:39:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/mediatek: Rename mtk_ddp_comp functions
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
 <20240226085059.26850-11-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226085059.26850-11-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 09:50, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename functions of mtk_ddp_comp:
> - To align the naming rule
> - To reduce the code size
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>

Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>



