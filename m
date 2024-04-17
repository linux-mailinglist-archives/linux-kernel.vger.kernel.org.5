Return-Path: <linux-kernel+bounces-148306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D058C8A80B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C611F22472
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BF13C9AE;
	Wed, 17 Apr 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CrLzXaef"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25113C8E9;
	Wed, 17 Apr 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349174; cv=none; b=BpFq12x2Ig8+CLW9C1GVRtZbPVlS7MpUZGT/7eYTb9YNgqgDqW1X6KsXClj6aSptUGfjJ35DW+5QT7GxqgdeqHBPvmdT9MJ9qMIsKKm4Q9NDeX/rizuJQzh2CUKkNtbnh3IuKv5HW+f6c/r/HZrlVSqQehNb5/g6eAQezBgGLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349174; c=relaxed/simple;
	bh=ykWNTq02+IjGc2GC/lrv0F7lhVMMsCt/LaiDJskhd6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjXhEwGBc+cuE/3/E0+QGbE+Zzv5E2VCLmE1Wiq3nSNlq7nEnNTPPsaHtVHmDma0tpXkkyCA9o8ed4E1Qjz2BYCqTlWWY9K5s6BLVXFNRyK0rgI1mpjEq9QaDoPI1OORFY8VOGucPT6cKiCuCRgsIjjbWCTCTYE55wPrjj4YBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CrLzXaef; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349172;
	bh=ykWNTq02+IjGc2GC/lrv0F7lhVMMsCt/LaiDJskhd6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CrLzXaef2OkiZmnwCXY17fXMTQ+PKDS7x0EJtcGl6oRzWaD5U7Tt14rKR4o2Xanuf
	 XqEDHma0874jaw2T3MA4JfwIBt/w113EHXqMS2Fj5rdxu8MKPXAoA4K/QLbDaksiex
	 rMZ/GF4aXJSkV59w4McmiWS1di+/5OycH/vK1i+Uqyz2xPWjmk59QH/urvDFSFMaWP
	 3zRQYRm0W+DZqn24Hmtv3X7cs18tENVQxxVEkZQzwjz8g+8vqik1CfinMMZxmdr1Y8
	 EmqR49d3/sglMHXUPSHz3Uk7QXcJrmRwlD6Erk1i5o2ilnRRSFFGU7tw3DUSU4fiL6
	 xj8yc1U5D+z/Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B1243782144;
	Wed, 17 Apr 2024 10:19:30 +0000 (UTC)
Message-ID: <1ec9ab2a-2e71-466a-bebf-25a50feaac52@collabora.com>
Date: Wed, 17 Apr 2024 12:19:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] dt-bindings: display: mediatek: color: add
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
 <20231023-display-support-v2-3-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-3-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the display Color on MT8365, which is compatible
> with that of the MT8173.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



