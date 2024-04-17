Return-Path: <linux-kernel+bounces-148300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A558A8096
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01501F222C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6EA13B595;
	Wed, 17 Apr 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IlCqquzr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2E13AD15;
	Wed, 17 Apr 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349164; cv=none; b=OrlIBT2OwlbirqIOjolx730Puhkg1yyKvvlQO/EHfJdUyVDMetr2E89jzfvLZx6+Yuc9ls4GuwvlIX63qjH3phbioK9jf4/eFVh6pzRCnOceRw8pbBDo49+CScGAloINHzBHEsxyMaxGWWH5SrNPPdGhYbX3KosJ8mb2XStV4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349164; c=relaxed/simple;
	bh=ZXvKnOxAWKtA1ZyEyD4xHHi6jtBiRKSNgjQUwwOb1yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6i+fsCYm/xUrrqhHDcxJ5SBx2DqEH3JieO0i/nzAxNmVG4FbxDXKtd9e3NFtSBRcDnoCr4AvqMJkfYd5GLaaKXmMK2TC555pG2UPN7/mCXQ7ayab4vhrWZCBM/tmCLQJBYLoEJkeR094mZuSz2tTCiWtUDeaWFfvLXlE78Pc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IlCqquzr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349161;
	bh=ZXvKnOxAWKtA1ZyEyD4xHHi6jtBiRKSNgjQUwwOb1yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IlCqquzrqUlQvCl+clDNR1MpbKDu6k//HytgxLI1g7MrwNNTpm5Rx0l8/2tqSrorC
	 uDwRQ7dnsfDiZIX339ue5ahjkjK4fmI4+YbZy5enye6rbMpldSSI71ZrR/av3jiGY1
	 st6A4Z3hzYqTuyxQxL8Pq81AWby27Xn7zukuc42lO9ajFKdD6UfpLHU3Xa3y+nTy9h
	 XkQSzZCCCszHy4P57NGwXnin0UpC5ur80SC2uNQhXqeb/c3Le/rcSR63/uNPCysMEW
	 PQNc4TrOySDRAStEXSJA6Sk34nRnV6Kkjln4VA42e3rfohLmBo55BWB3XjWN0Pp4fa
	 /XlPbG5u7uwPA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BCBEF37820F1;
	Wed, 17 Apr 2024 10:19:19 +0000 (UTC)
Message-ID: <1db01bd8-0936-40e5-9f1b-7ea34746bef1@collabora.com>
Date: Wed, 17 Apr 2024 12:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
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
 <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> According to the Mediatek MT8365 datasheet, the display PWM block has
> a power domain.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

It's the same for at least MT8195, MT8183 and I think MT8192 as well... so
not having that from the beginning is actually a mistake.

Please add a Fixes tag and resend, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


