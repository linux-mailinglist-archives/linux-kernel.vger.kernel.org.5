Return-Path: <linux-kernel+bounces-148315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC688A80D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B6E1F2120D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD713C8FD;
	Wed, 17 Apr 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FZf2J5j2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6D13BC1A;
	Wed, 17 Apr 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349274; cv=none; b=ok7AOwzCia4EevWwpenaZLwOQ5gPb85bsFr8O2bhZcD0C0JNS9u5Fjw5/DtuXZs/rWxbTFS0mxR8nrdvurkDNEe7ChmSkr1gJdjjJGtbLmrYSeWuDCiINkHBGtcGev+thSiLjeRUicBfNVlg7ShoSppes1yKUN7MlF8nslwBRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349274; c=relaxed/simple;
	bh=joxtA6/0uRZPXJAeMzV2wF8DPGHHcwx6t1T7AHClb7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkMfBGkwjLJ/s9DOcU3iw6FnmaaMhpynqbkIEwHb6VfaAQonMmfU6ykn/GBfXNKxzEj3eX8LLFqdOdGVjheOWm8MQIzKdsIUikMGkUi93aWfrHHbd2zgJfXC1k6ghSuJZSauY9cYKGh5tedbK3rZck34va0Uf8kVQufXDwAZmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FZf2J5j2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349271;
	bh=joxtA6/0uRZPXJAeMzV2wF8DPGHHcwx6t1T7AHClb7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FZf2J5j2qPVponPppon3nSlh8EUciQ+SLJONQKf/unyHzoBfaCeaClDlXrUkNh7+z
	 uWkWjMhrU1qgsg0u/9+OHuGb2CG58/eM/XqgX2yJmejqH6JS5GvXO9VRj2sqjCGBg0
	 OEgiVJVNX9WG0dEi9OmMI7c3tJR9RXOejvdDrf3ViaaukvZjHdQ4oVqn53mFFmsewr
	 5nb/dgokG/iefGwpxwooNqHhBMzXQhyQY3OYLIFbnFZXUFpxmEjT9ks6nkDDfmKvG9
	 YxZ3mKEVZpk4huDFE81C5e7/H5F2Qm7OuRfB8G0pxwVAC75jEPcfiuqGV0oGddBAZ4
	 +FGBSrcjmFRmQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DF67637820F1;
	Wed, 17 Apr 2024 10:21:09 +0000 (UTC)
Message-ID: <5aaa5f0b-4c0c-4e7f-ae73-d0c735343f37@collabora.com>
Date: Wed, 17 Apr 2024 12:21:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] dt-bindings: display: mediatek: dsi: add
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
 <20231023-display-support-v2-5-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-5-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the Display Serial Interface on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


