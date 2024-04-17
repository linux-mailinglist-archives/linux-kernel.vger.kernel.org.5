Return-Path: <linux-kernel+bounces-148307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898768A80BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25D21C21761
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B513CFA6;
	Wed, 17 Apr 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iaF+C9Ou"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6113C9B0;
	Wed, 17 Apr 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349176; cv=none; b=svMQxFpuTf8P7BToFLwXGwiSJLSRCK7ZFlYu84/fInki//8T0xemkV+Fr3njwLFtz7NQNRsNCeztBuKa2MHtmJ1AhCRtzlC+ng57FMwVZDU5YnSxxPmgB8EthNJu1JKkpzp+HYrCQ6o5e+xbobvBihHYvIIDQGBg8aWVpkaehlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349176; c=relaxed/simple;
	bh=AbMUUdB2IYVieAf13kzEkWKDF0aRsVSjUjsHEJERg9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ+5qedo8fQlA4G4M/cQhIvoSwHO5CTakTzzfAOM5bhV6CVqsDxFIkcFAqa1UAfEMxAw/lwZndyJzAPiSLheJPOKPzvNZKreumZKgWQnJ6Ja5c/ILmWTQ4mxtJWS7dsE1z0yQdu1SwN2ZM0iJ0TypmAUzB7n4TqYcTX1Y1M1Jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iaF+C9Ou; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349174;
	bh=AbMUUdB2IYVieAf13kzEkWKDF0aRsVSjUjsHEJERg9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iaF+C9Ou6OqTAzpznxqn7WNALU9R5RIK9MmL0g6uo0K7PNa4KwA7teuU8Oca2xpo0
	 S68zya86xq50GHDE7Q8GNDWgu8gKPYoqDclk9uEDBUZCm5UFgF/ss03q5217kR2Kp0
	 7g3nnmEk4zaAFuwt7v9a1kzT4MhcpGYwlgddN3pYbFjZtaqJsJTGM54x9ErIw1lfhL
	 kwKGLu5q+TQ4TSgiekneVqv7304yE/cxNeQ8V/wxDKtChYY9ifcsuvIVuaaG7WJW8t
	 p5R/VSBMaaw7iUhGUFLJw7ozsCwFwZUaYuMomf9/I6PxGnu+YvDqQk4qm2aaEAMO2v
	 mNX3HtC0TgK5w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3CFCE37820F9;
	Wed, 17 Apr 2024 10:19:32 +0000 (UTC)
Message-ID: <15704a21-f7cc-4e30-80a4-63af0cb67279@collabora.com>
Date: Wed, 17 Apr 2024 12:19:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] dt-bindings: display: mediatek: dither: add
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
 <20231023-display-support-v2-4-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-4-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the display Dither on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



