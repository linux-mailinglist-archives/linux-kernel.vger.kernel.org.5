Return-Path: <linux-kernel+bounces-154491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8A8ADCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D765B2155B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEBB1D531;
	Tue, 23 Apr 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnESWfqq"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFA18AED;
	Tue, 23 Apr 2024 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846161; cv=none; b=fQh8wcO2Ds2vj0iu8Bon/ZXaJqmaDL2duPwzbuPswLhAMimrc1Ue/vTtZQ7oJ13WDz/R984mamzqPcdsuom9eB8NxMqqbt8wTMv/KN7kX+Vjj18UFY8/1ojs+ryzH56RB+RynpPQR0ZyQ6Bm3OZSpdh+IB7XXFtaD/bHR4+U4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846161; c=relaxed/simple;
	bh=5nWlXKGNzpbPvMYgzwa7Agut73MM3uPw54rc22XINyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm1Jh6ICuj0J8uANgviRnlgyvb2thorUcCs+kSSZhvFwgb9ff+HG46gVGnlOd1TtRAiNOf+pzR8dSe3ymaKC1YNFsKP5evX3En8xd9zQvpgcfrqCGOZNf/ix8i3fkXknwXrxaUMVRXnrwcI3tVIhAfviJkzud3eN4J//JHVkPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnESWfqq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a557044f2ddso566397866b.2;
        Mon, 22 Apr 2024 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713846158; x=1714450958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUs2RUZvYrbt0djestVEkcsXv+XeS/wmMn/FMr80SwM=;
        b=PnESWfqqXvBOoTvVXyFSsl9cQHSgD7N4ckW/WGfm8ZORq6+9jahTlHVEpXaaFshiSB
         eiYwITfrYdLDiFRyYsCXlbz5ecfA1658CRg9IewxZ6DF2F70+Kjrdn+unPn6D14NrUXj
         uJBYHHuFKJJmNT5PHvcN8Lfba5pBrE6ogO0F/yhtbJC8Et0KizP6+cI0mYg3Y/1RRInd
         CNXzag3rr8hKQX9jegn4cnXODNwWSVaycvMTQVAyWLjQw2JszF2s6J8gbEM91rUWHpQ4
         81chkubWAiY1N5fPc1cdBlYObu76EktOOpxSoL3Ei0XBXPZeT2kNZ40tLgBNgBFJlUWg
         uDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846158; x=1714450958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUs2RUZvYrbt0djestVEkcsXv+XeS/wmMn/FMr80SwM=;
        b=MQZyKbb1UrpyUTGy4qbxmEpqYydcbSG278mtItqQrw7EjxQJobMIt/K9EBKWtQJOS8
         dlCCsGXH+qLdpEMrOJi9Ui2w6H14Bxfjciiur/Q8+dmEq9CN8aSLq6/zAve2UOdtA2Mi
         HBtVqft9Z4lNG5xZ9MC+yEV3HW49+/zxAjBot/5gYGqVubOgurtq3Pr38J6lZp3fj51D
         Rc5bXo7LwmYYPAXStlB/lzqGn6sb89+OxtywKzFSgdGrrumH+Sd/FCsur5eSDsH+VFV1
         RFmOc8TfOb9R0ha13AMa72yQsiNZFLKBxOmM0HJgbfqMF23hnJJj9BSBjMJBgGmc2njC
         anXA==
X-Forwarded-Encrypted: i=1; AJvYcCXlF3meYXu4wAoPiPzbtp/4jMB36MA9J0fAud0oVyq20uqvPFhWv3w/aiCkt0lYUH0V9yDO0FnJ6rqAbum5LTkCZoK+biwvFGut6KEgjkv6+E4iNdjgrQBR/cV37tuzi1IBsAOjV50rpsFRIgFsVrBIIwvn7/4SZuxpH2IX1eIAVxTViLdL
X-Gm-Message-State: AOJu0YwPif0YHJ86cUYoK70R8tJmeqpohIB4JQ11WcZBgwrGHdv1HH7N
	XYV+GdMfz66ROi7JywEZDVej8KllBxpJBsCxofEZj0cv9BbWUJyA
X-Google-Smtp-Source: AGHT+IHNB26jxIYXuLgkHDTr7cigbRb6NRaEhxNW9klXv6JV7oErenfbZDVtvg93kbkJoHjeXqljJQ==
X-Received: by 2002:a17:906:3502:b0:a52:277d:c1c9 with SMTP id r2-20020a170906350200b00a52277dc1c9mr8047023eja.50.1713846157921;
        Mon, 22 Apr 2024 21:22:37 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id 17-20020a170906311100b00a5599f3a057sm3847028ejx.107.2024.04.22.21.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 21:22:37 -0700 (PDT)
Message-ID: <c6a8fdc1-0230-4438-8b80-c07daf80f1ce@gmail.com>
Date: Tue, 23 Apr 2024 06:22:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] dt-bindings: media: convert Mediatek consumer IR to
 the json-schema
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240209085616.1062-1-zajec5@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240209085616.1062-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mauro,

On 9.02.2024 09:56, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files. Introduced changes:
> 1. Reworded title
> 2. Made "bus" clock required on MT7623 as well
> 3. Added required #include-s and adjusted "reg" & clocks in example
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

could you take my patch throught your tree?


> ---
> V2: Extended "IR" in title
>      Made "bus" required at MT7623 needs it as well
>      Updated example
> 
> Thanks AngeloGioacchino!
> 
>   .../bindings/media/mediatek,mt7622-cir.yaml   | 55 +++++++++++++++++++
>   .../devicetree/bindings/media/mtk-cir.txt     | 28 ----------
>   2 files changed, 55 insertions(+), 28 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
>   delete mode 100644 Documentation/devicetree/bindings/media/mtk-cir.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
> new file mode 100644
> index 000000000000..c01210e053f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt7622-cir.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Consumer Infrared Receiver on-SoC Controller
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +allOf:
> +  - $ref: rc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7622-cir
> +      - mediatek,mt7623-cir
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: clk
> +      - const: bus
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt2701-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ir@10013000 {
> +        compatible = "mediatek,mt7623-cir";
> +        reg = <0x10013000 0x1000>;
> +        interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> +        clocks = <&infracfg CLK_INFRA_IRRX>, <&topckgen CLK_TOP_AXI_SEL>;
> +        clock-names = "clk", "bus";
> +        linux,rc-map-name = "rc-rc6-mce";
> +    };
> diff --git a/Documentation/devicetree/bindings/media/mtk-cir.txt b/Documentation/devicetree/bindings/media/mtk-cir.txt
> deleted file mode 100644
> index 5e18087ce11f..000000000000
> --- a/Documentation/devicetree/bindings/media/mtk-cir.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Device-Tree bindings for Mediatek consumer IR controller
> -found in Mediatek SoC family
> -
> -Required properties:
> -- compatible	    : Should be
> -			"mediatek,mt7623-cir": for MT7623 SoC
> -			"mediatek,mt7622-cir": for MT7622 SoC
> -- clocks	    : list of clock specifiers, corresponding to
> -		      entries in clock-names property;
> -- clock-names	    : should contain
> -			- "clk" entries: for MT7623 SoC
> -			- "clk", "bus" entries: for MT7622 SoC
> -- interrupts	    : should contain IR IRQ number;
> -- reg		    : should contain IO map address for IR.
> -
> -Optional properties:
> -- linux,rc-map-name : see rc.txt file in the same directory.
> -
> -Example:
> -
> -cir: cir@10013000 {
> -	compatible = "mediatek,mt7623-cir";
> -	reg = <0 0x10013000 0 0x1000>;
> -	interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> -	clocks = <&infracfg CLK_INFRA_IRRX>;
> -	clock-names = "clk";
> -	linux,rc-map-name = "rc-rc6-mce";
> -};


