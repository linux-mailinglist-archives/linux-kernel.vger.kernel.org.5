Return-Path: <linux-kernel+bounces-148303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F38A80A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191BFB216FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379B13C683;
	Wed, 17 Apr 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mWZHwN+S"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BE13C3E4;
	Wed, 17 Apr 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349169; cv=none; b=ke0YxyH6ukIusWTPAqHEBCCpzUQUvIoG76u+NP7/6Y2QCJYy9Dk9JxFekEq8ag/63RnMZf1qJoBVwgKWrAlWyTV/7b0JeR4KzIqb5Bjfng2zia4tRoqkUh4s6mssSmPu2sKxPEDrv/BJKp4n+ou+fof9iJb+X5Gq/gGFYjHhIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349169; c=relaxed/simple;
	bh=Szzgxmq1uily16b3FrtzPmtlOA6Oz+XiGmAlFkhAWfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INnAdp3auhDlx+SbC8n3tg8xLfEPcXDXjQ2gwvvSgugb8+BcIzGdn4duS8UG8mBF93ATG6YmE0nBWWit7kEmB39gYdNTiJL5ARI7bCV0MBDuaMPPIvnUPym+sJ64JoOV68BWou4iWGgp/NN0mDrsTsZH9Hm4UhWYQW1W2MKHzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mWZHwN+S; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713349166;
	bh=Szzgxmq1uily16b3FrtzPmtlOA6Oz+XiGmAlFkhAWfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mWZHwN+SJSF4qii40JMjO4a0mZ0xd0frPpAsO6zE3jF5by96Ss23cKU7WPM003pc8
	 unemdGp3KvaI2VGVHed5crgnBn3c+TF+1/2mehtDuxybZMGIzchvLPTUtuSQYtqYJO
	 wOiHXXtlektNyLXF+SU9Wi25GJhuOf/IS6ycCuzqcezUJutD9gdM9Yj20n67VtSNoj
	 jJ+NNNawmROsc+pneLvoC1MzDmzLczdqMBZk+ybAmeJ3iHWKamWz92AXRl/HoziQ4i
	 Xy5+0vGmebmBs0b00R0T/z38ez5aqCSrCjwxg/InedNXHMRUAq/c0qmVqRmMmEYl88
	 bFjgmeC5t/uSg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF8443782143;
	Wed, 17 Apr 2024 10:19:24 +0000 (UTC)
Message-ID: <ecff5045-105f-4e46-b44f-a8892086d19a@collabora.com>
Date: Wed, 17 Apr 2024 12:19:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] dt-bindings: display: mediatek: gamma: add
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
 <20231023-display-support-v2-8-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-8-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Document the display Gamma on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



