Return-Path: <linux-kernel+bounces-148302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F18A80A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07E71F22413
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6532C13C3EF;
	Wed, 17 Apr 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QDMuA45s"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502E13BC1B;
	Wed, 17 Apr 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349167; cv=none; b=VSmsFEdaMmdpCeYJY262/mrfIKryY1CYbFkSxeS7HIlWQr9rfqrQEM2qFq1TaP3XGORI75/6YSdcWFbQpVQTVXn85A1dRAcrKqllQhU+7mOzDV9zi6k8vZtzuo1CY0+INIUqDHy5DbtBAak6rGkuVk0G3ngIVM6NwowIN6npurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349167; c=relaxed/simple;
	bh=qWuF7uLva8cRzxWDXt5dVkky/BlMUGkwVe4Kcq4+E1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcYMDEqSB1PFkQ3DMLp4J7qvhxHwuBbst+XMWSNlUNcw4YG9eOVJNkbv400+qn8On3TNSYKU/Hn+i8xHDTD/twf7GAK3dmFEnxPve+cPBoFA6wI4en+7S5Mh8D1jx4+wGw1L4hnXF8FOvEn8ATHgA/ZInbTRqYrzbtV1+D21PIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QDMuA45s; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349164;
	bh=qWuF7uLva8cRzxWDXt5dVkky/BlMUGkwVe4Kcq4+E1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QDMuA45sSktW1mpqP2aK+bVTQOv/hV2QPn8E+sNuIGkWUgDVV6pnL3uwlzYlvkggC
	 ZHygfI7iCqU7iRlrk9TILXVCoMusTQ+RqBhaisilG/widnvgffhiSmjfp3aHRs78pr
	 NSLdZ/XHMFItbwaO3TRXotitotAa/4IvRtuA3cp3WrgwtkgxEiIb1aF3e/HoayskzV
	 ogYamVjvcE2lKubU5XUKlax9RISp3p/023DhbYrpxWdqrfwtmgV3M6Out2FWyHnBk0
	 mHfkR3+miIcq1HIgfTqlMPjlrQLtunusxmY9eG2VGJGGW7L8K1cKGCzLGmAAAD1EBh
	 PWpFHMvLKivdQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1EF673782144;
	Wed, 17 Apr 2024 10:19:23 +0000 (UTC)
Message-ID: <7500e208-4d06-4116-836c-2e5a625ba38e@collabora.com>
Date: Wed, 17 Apr 2024 12:19:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] dt-bindings: display: mediatek: ovl: add
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
 <20231023-display-support-v2-9-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-9-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the display Overlay on MT8365, which is compatible
> with that of the MT8192.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



