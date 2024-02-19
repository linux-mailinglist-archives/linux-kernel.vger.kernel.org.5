Return-Path: <linux-kernel+bounces-71023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97204859FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C722859A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36852375A;
	Mon, 19 Feb 2024 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IipeBgPi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657B22F13;
	Mon, 19 Feb 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334634; cv=none; b=Sp0Ov/pH/Iga+hxaEl1CRkp2+dh8X9WUJ8vRFToThvHihrwTEbezwABfcCG0hS7c1bimBOR3BLgZZPH5NPIKhm8xm4NXxSTqCcepvNXLtJgH26FovzsRCdAW5+lCrO235+W0jrJ1Lg5AjQ6SBSVmqW6TtNxzCTLwwGQ5v+S85Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334634; c=relaxed/simple;
	bh=UNsW7w0/prR9kEhx1s+cnIpM0a+lTKIVqrn9LfPCP0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loBkI8gDgXV4BX2oG7qPsPchkQuA8Ye1OTeLXn9zzuwYzpz8yWJYOazVYtvblCxgjn+MMGyi2SdzQdYPyXyqI2RQuU++hNAoTpcV7HN/r/SYGsBW+3iKz7Ejffa0DuntNCPWfLTXyITsy1sra8wZvE98sGRQjnYDWo/dFTzmuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IipeBgPi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708334631;
	bh=UNsW7w0/prR9kEhx1s+cnIpM0a+lTKIVqrn9LfPCP0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IipeBgPi2Q3alaj6bk4wzwdIqZ1Hiq+F9wD9hfBZkeNBxaZFLlI4qoNZDdWRpu78O
	 oqSRPWF/IiymNW8hkstukElxe+zdWXeJEI9ChW2DSJXgollH2k661a3Em7iD052EIb
	 poytKQ+o9Bn3ap8yXP8/d+VVJose5jutlvmDYhxPZfQuhSxKVxsmDnD8flSIj524xI
	 xIRBame5zjen3wMdosL36LZzZ2ALIy7izGU44BxFd8q4v1o9FFRzsKw4gopcc+rWrh
	 pbo+QauykbEB9ODMDpCcVo7PmiVY7R2gCUjOFmp9YnFK23owWbntq7G7C/IDdLMr9B
	 UWO9BgSwxbASQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A7EB3781123;
	Mon, 19 Feb 2024 09:23:50 +0000 (UTC)
Message-ID: <ed3530f0-227a-47f2-938c-28eba90dd6eb@collabora.com>
Date: Mon, 19 Feb 2024 10:23:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240219084456.1075445-1-mwalle@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240219084456.1075445-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/24 09:44, Michael Walle ha scritto:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> v2:
>   - convert enum to const as there is only one specific board
> 
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 09f9ffd3ff7b..add167d8b8da 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -357,6 +357,11 @@ properties:
>                 - radxa,nio-12l
>             - const: mediatek,mt8395
>             - const: mediatek,mt8195
> +      - description: Kontron 3.5"-SBC-i1200
> +        items:
> +          - const: kontron,3-5-sbc-i1200
> +          - const: mediatek,mt8395
> +          - const: mediatek,mt8195
>         - items:
>             - enum:
>                 - mediatek,mt8516-pumpkin

I understand that you took inspiration from the Google Chromebooks entries, but
those are separated only because they've got "a bunch of revisions".

For machines that don't have a billion compatible strings, I would suggest to
add the compatible under a single big entry: like this, the binding is (imo) a
bit more readable .. and cleaner.

Eventually, the machine name is in the devicetree so we're not losing any kind
of information anyway... :-)

       - items:
           - enum:
               - kontron,3-5-sbc-i1200
               - mediatek,mt8395-evk
               - radxa,nio-12l
           - const: mediatek,mt8395
           - const: mediatek,mt8195

Cheers,
Angelo

