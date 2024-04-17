Return-Path: <linux-kernel+bounces-148294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30E98A8077
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29BC1C21451
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956913B79F;
	Wed, 17 Apr 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SstsGJ1d"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A31327E0;
	Wed, 17 Apr 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348878; cv=none; b=LAh/GK1tuqn3Og2zREMEw6FWEkJ9/q/rHPXzVZFmZu3DvnFrEp1k+XXQhC7Jg8TzfMsOx8W1Hmd2xxW94izK3V4xZtJMLP8VENWwhhWM62MZrVQOvewBvEIWazkMNodf4x0QMPaZvsHsZ2C/sgmAVvxqYlvCrw7+0GqolkeDb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348878; c=relaxed/simple;
	bh=nP6Y2cH6R/RSVNj91LUL6ipM/UHgj+V1OQwPKKnkgjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwPeQLHJizVBJMD2pnQdWPFl44BskeOZa1HLQdmBQnbelIw4p3w+uKalems+60ObYi/2l+KvO/5ZVmPVElnIRnnCnYuNeHSblrFQ2Thcbz3ln0dq1sNrAwYaZifsT10Xku5mflIfQj8QGBbJr6khHwK8ZU4slpadZGv4XTYJJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SstsGJ1d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713348875;
	bh=nP6Y2cH6R/RSVNj91LUL6ipM/UHgj+V1OQwPKKnkgjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SstsGJ1d7dF0sTiCq19GAQDn9PeB6bYpjCOvzfpX6z4o9hc+KpF0FbQsPvO371n/C
	 GnsKq719DLEgjgoXZ3DGGJ1t4/BZdaJC2+Nul+USg1vFiARr9mKkfOdgbS0TXFQJPd
	 yMeow0v4fKoHqlKgNSTCpBKVdtACyjIc94RpPjpuz98RryoTV/fs61uhsWWKPp0ObR
	 jx1QJ/3wXJmNpHHHlQlmOBTtUl0HbVAl75rb9i+HKeFSTyuexydG76wDgiFvUj91wx
	 iEgJfGjVhJ30+X3lwEtXi3BX9UC5cVBWYtStI1XeOJEqgXQ6zEoon8dqvxS+GgzJ1s
	 GtCKvWnb+nWsA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E30BD378020A;
	Wed, 17 Apr 2024 10:14:33 +0000 (UTC)
Message-ID: <105c9ee8-2b9e-4117-b4d8-472982ef59d1@collabora.com>
Date: Wed, 17 Apr 2024 12:14:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
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
 <20231023-display-support-v2-7-33ce8864b227@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023-display-support-v2-7-33ce8864b227@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> Add dt-binding documentation of dpi for MediaTek MT8365 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index e126486e8eac..ebb61bc4eab7 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -27,6 +27,7 @@ properties:
>             - mediatek,mt8188-dp-intf
>             - mediatek,mt8192-dpi
>             - mediatek,mt8195-dp-intf
> +          - mediatek,mt8365-dpi
>         - items:
>             - enum:
>                 - mediatek,mt6795-dpi
> 

MT8365 and MT8192 are identical. I'll make it easy for you:

       - items:
           - enum:
               - mediatek,mt8365-dpi
           - const: mediatek,mt8192-dpi

Cheers,
Angelo

