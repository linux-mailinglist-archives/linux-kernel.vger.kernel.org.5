Return-Path: <linux-kernel+bounces-86338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2E86C413
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2602842A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7153E16;
	Thu, 29 Feb 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gacFkhRm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76515535B4;
	Thu, 29 Feb 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196470; cv=none; b=ZJBxzt2wLVmcmskJ1w/iuhY7sjBkmrQSkaVY0OiWQkt4ny43ozV6vWnXjoLAkHTVSx8jIIQ4L19TY4XaOUUGIY+np2HOSyQNVai8Dpwv5SujEFSY0O3aW2uV2dVhl+1PPapi9hm5EPeeX5v9XjsUa6Ds6tf+dgcBlOadOcAAm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196470; c=relaxed/simple;
	bh=5A1bXwY5sWGlMJX7d22/wAa19nNdvkcM+C+b89+RYZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InQ0o9ki0aHeoUIBxRy+3Dh8qjqS5vuVkkt1g8tNkyHoyuYdKuiLAIkYEakNgl+GxhVzn1AVvZUwL1r5NNp7LXPqYHXJCWZ4QjY5b35UmjJTnz2+znK7gTFpfLJF2vCW8PsjA4jyG++vHX5k5G+XCsmD9wcQ6zE9Fyib23qqisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gacFkhRm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709196461;
	bh=5A1bXwY5sWGlMJX7d22/wAa19nNdvkcM+C+b89+RYZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gacFkhRm+t8GFM5Unr3otzDdtzlpIOZ1t00Cot/CZXsDAWh1L+cghJgTdPv7Gty9y
	 GQnKfr8Ebcor7ZeMCz2CWw1oSLF0VFvf+UQ1PBI99HMdupej3erNB4ZFu811sfW7xN
	 cFvzr8OlrlRxgjqDC/Og1qvmtL7DFW9m8fB8HVPQndLTD/oktFTnPy568Y80pE/gH9
	 tyiuDmipXR/oAEBq8XvVFgHhcehH0gJBo08kNzksCYO7bZv0HTKQemKdrE0uMJinPD
	 n+B4UqY8eymDs9QKksCK3G8qFH6YIzxRPl46/OajmkKGT8PCEZ4SyN1uAbnzMYFrlt
	 CwUujzEqRPJ7Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B54237810EF;
	Thu, 29 Feb 2024 08:47:39 +0000 (UTC)
Message-ID: <a717b209-ec31-4a43-a93c-47d65a464c80@collabora.com>
Date: Thu, 29 Feb 2024 09:47:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: gamma: Change MT8195
 to single enum group
Content-Language: en-US
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Fei Shao <fshao@chromium.org>
References: <20240229023522.15870-1-jason-jh.lin@mediatek.com>
 <20240229023522.15870-2-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229023522.15870-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/02/24 03:35, Jason-JH.Lin ha scritto:
> Since MT8195 gamma has multiple bank for 12 bits LUT and it is
> different from any other SoC LUT setting.
> 
> So we move MT8195 compatible from the one of items to the
> single enum group.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index c6641acd75d6..3e6cb8f48bcc 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -24,6 +24,7 @@ properties:
>         - enum:
>             - mediatek,mt8173-disp-gamma
>             - mediatek,mt8183-disp-gamma
> +          - mediatek,mt8195-disp-gamma
>         - items:
>             - enum:
>                 - mediatek,mt6795-disp-gamma
> @@ -33,7 +34,6 @@ properties:
>                 - mediatek,mt8186-disp-gamma
>                 - mediatek,mt8188-disp-gamma
>                 - mediatek,mt8192-disp-gamma
> -              - mediatek,mt8195-disp-gamma

While I agree on allowing mt8195-disp-gamma to have its own separated compatible
as the IP is actually different from the one in MT8183, you can't do it like that,
or dtbs_check will fail validation for the mt8195 devicetree.

That one declares...

gamma0: gamma@1c006000 {
	compatible = "mediatek,mt8195-disp-gamma", "mediatek,mt8183-disp-gamma";

..Please always run dtbs_check when performing bindings modifications.

Cheers,
Angelo

>             - const: mediatek,mt8183-disp-gamma
>   
>     reg:



