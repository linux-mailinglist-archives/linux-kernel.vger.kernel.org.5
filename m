Return-Path: <linux-kernel+bounces-151104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76078AA928
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D4C1C20FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4346452;
	Fri, 19 Apr 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UjQ/y3ac"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938F3B7A0;
	Fri, 19 Apr 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511683; cv=none; b=OqDizHZwGCEdsnLPPsssi2DJJdf4odgIPhZgtpVHL4PbjIUnuK8HeZtxxf9AtAPd8uc4JJKQROkP6WtB0st1+Ms6eS1fkUxzf/rGzAERx5I/ohn5vN71EqBlXF0SkXv14kthqwl6TIlMqGCUTe7RmJaP4xxcVbLCs2tNxQfAkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511683; c=relaxed/simple;
	bh=zw7eqyLTCYpzLSY9EaMU3gS3464AZcknyXMq4TOLyec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh+L6VLhPBHfrr6on3wCFmMKyiBNAvIwWIuuCJRwrbF00TqztnWFEfuxhQ0HbdwHT5rfT66S5kcX7BJwu92vYWTbbvQoPYs9JqYvjJ9v8/QYq4NcBdbxus5PXSgoF2viKvzYkcqQDO5ngyJwDJqQxiCxousbJXK63amJnDA/sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UjQ/y3ac; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713511680;
	bh=zw7eqyLTCYpzLSY9EaMU3gS3464AZcknyXMq4TOLyec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UjQ/y3acphHaIV9MFM51DsH35E4dA1gORYFEcz4Qnyf/dk/UoB2DoB0FpEp5wfqEo
	 tVQ5/EoySNnmwXsb/XsERTyqU9vQkDZ1XY2VuMK69r52P/tP4nBmVoRfdPMRT/SCBl
	 hxyv+E5Lt/zNe56ubf6Yia265rxvNCyledkMfHhlMwWgx4EQwj4tkapmC9biiO3oVh
	 hwZhmhZ8+RtHkaeMOc8k4s1N6Kn+t8UGVH0lFT6ey+Pr2B0+lRuOIhQ/u3LSt4ZU3P
	 UKdIj6jc9ec/RSlrXve14FNY5jw3H0P0so9o5kvctHy9Rv7PAt2pGGpBLu5XoZiYd2
	 HPa3xeGW8lJMA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C3E23781104;
	Fri, 19 Apr 2024 07:27:58 +0000 (UTC)
Message-ID: <49399153-bf70-4709-b020-f40e2654a53e@collabora.com>
Date: Fri, 19 Apr 2024 09:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
 <20231023-display-support-v3-7-53388f3ed34b@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v3-7-53388f3ed34b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/04/24 16:16, Alexandre Mergnat ha scritto:
> Add dt-binding documentation of dpi for MediaTek MT8365 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



