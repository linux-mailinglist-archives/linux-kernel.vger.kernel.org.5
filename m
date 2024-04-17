Return-Path: <linux-kernel+bounces-148301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520B8A80A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E291F222A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB413B29C;
	Wed, 17 Apr 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vDSbxNMs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D713BAFA;
	Wed, 17 Apr 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349167; cv=none; b=aO060FmopPLkDl/7J8geOXSIsTY5VvLJ5sridD4bvPlympvjsrLzrhC/octF1ZiyS/z3/+gRKudJAJaDk+tVerNLSIYSN5piacYMmAETZFiHd9z6bnbvvn1VzR3TzlIkLJjhK8y7u2OQWe3C3ZUDt/o044BGee5FWiKuWT02eSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349167; c=relaxed/simple;
	bh=OivqhnUpMqFeeojlBGSOYUiH7mtq6DFbxtNBz50s9KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKETZ6/fvDWANHhJq3R4RvTqLJeSgN4bfc3qAMGxTR/+NknJcBbfbZz1i8A573ABqlmWAHJeLrK72Zg8ydM47SYrqeN5VxVvjBmVukUOZUHwwp0QbhzC/EBI74FQRMXsxVwpP9QqS+Zk22OxJWzHmoOREND6OuyiaCsewm255dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vDSbxNMs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349162;
	bh=OivqhnUpMqFeeojlBGSOYUiH7mtq6DFbxtNBz50s9KE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vDSbxNMsN7AlnShyxPaIdVFfJAizJwHxb7CHyTuNez0PGEXedmuKR/TrTFdQ8vcOb
	 URBWG0/Ac6t2FtI7M6o5/OiR/Rp8XxVsLMwaPB8AkAl0RkfZbTZiTaWppHIe51AEpX
	 q6FqVBkFlT8Nd+usZZutHbQ3LFD8OIW772LC8dtU2G6j0WIJgUea+J+nzAp1zfAfaK
	 Tp3Y+fx6A+jSMvbsHIr/LHfdYPJpXrwTAia6oZ5hso+P8MSoBKaoIISzuMm0DSNBpQ
	 fHNuft1TaDzDzbLxU1o9PIkhSzOcEtXRz+l7bFu0yBSOqVKMHCYhBG/rLtqE6C5T7S
	 1jXDtIoHVwOXQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 73CB137820F9;
	Wed, 17 Apr 2024 10:19:21 +0000 (UTC)
Message-ID: <86cb43d7-1c1c-48f6-8848-04340e04603a@collabora.com>
Date: Wed, 17 Apr 2024 12:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] dt-bindings: display: mediatek: rdma: add
 compatible for MT8365 SoC
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-10-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-10-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the display Data Path Read DMA on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



