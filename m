Return-Path: <linux-kernel+bounces-18938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EE82656E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ADF281F9E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904913FE1;
	Sun,  7 Jan 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOlCscH+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F513FE4;
	Sun,  7 Jan 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e4398266aso7339695e9.0;
        Sun, 07 Jan 2024 10:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704650438; x=1705255238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKyStk0haCbQVEo8Al8QRs15264C+ZMsxxJKHUPR7Pc=;
        b=fOlCscH+/wvZ9wOm2lyS2QqAzIU3M9c5tJ1RhAoYufcNTUvI61VuoalfD67wPmFRd5
         G1W05GPHUpbWf3Mc+pNGUCy8DRhR35Iw7YucHdZscf0bGPzm47dBVyDAtXIoKxUmg/sU
         mr+brFjkz/AcH7f/w16J7ygmy6NgUTa84ftQtwQhinpWtl+YvVCr4U475qC4Os3DMBWe
         aaWqYL/QTBZ3r2xBM3+qbpCuIhhGdwStvDflup7wAaqTvubzDQBHbFf2dSU/xKuf8+WE
         o1gz2jbncUFKiI6iKNkDX1F+igMOA/0pDT461F5yVVFn1x1kJGBRll+WB33+FqzBZdd1
         aIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704650438; x=1705255238;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKyStk0haCbQVEo8Al8QRs15264C+ZMsxxJKHUPR7Pc=;
        b=W5uZ9Kg4HNh9CTHImrObKFFqcALXv6yDAqqimTP+QP0AYO3+hnYSFzvzr5NuUGpdyJ
         8V9TgFEDaXjcn4wGYL5rVoeSAw8pTDn/C4Mo98k9z/ml7jOUanSr7hzoeZlHDm4vT6tG
         wptVKAJdGrVbDFBNPs8KPNnP1o0BPI8R238B59E3Bn1NKieKA1V0nNRy0qhhnIqdn7Tb
         DXzcyDwCMlhATXxXFE+4bvzyC9sbXn65pwkRb7DeAxbNLbvspx/zRpi+nP2spwKMhI2V
         mqjqp1v+eUQWvcMDXidwsJ5afOkwi8s8vtHMt6MMWM+9B7XvNxc7/kcSyQoqua/pVmDD
         qoag==
X-Gm-Message-State: AOJu0YxQtq46JEjlw0N7cvTEyRm7VMl6RZ7R4cuuvDj+cnZsY+KPc3MB
	rGZcH/fWmLEhJWgcmf5ldTY=
X-Google-Smtp-Source: AGHT+IGhqqCvDdoBIyU84SWyNgbazpRv9+3/tHjLax2Xn+swSXh47IxcWIaFtdx7zrKMSJxkodAKfQ==
X-Received: by 2002:a05:600c:a05:b0:40d:9237:dada with SMTP id z5-20020a05600c0a0500b0040d9237dadamr1376192wmp.103.1704650437606;
        Sun, 07 Jan 2024 10:00:37 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d434c000000b0033761b2de64sm3547257wrr.76.2024.01.07.10.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 10:00:37 -0800 (PST)
Message-ID: <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
Date: Sun, 7 Jan 2024 20:00:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
Cc: Luo Jie <quic_luoj@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20231126015346.25208-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian and Robert,

thank you for this great work!

Let me ask a couple of questions regarding the phy package conception. 
Please find them below.

On 26.11.2023 03:53, Christian Marangi wrote:
> Document ethernet PHY package nodes used to describe PHY shipped in
> bundle of 4-5 PHY. The special node describe a container of PHY that
> share common properties. This is a generic schema and PHY package
> should create specialized version with the required additional shared
> properties.
> 
> Example are PHY package that have some regs only in one PHY of the
> package and will affect every other PHY in the package, for example
> related to PHY interface mode calibration or global PHY mode selection.
> 
> The PHY package node MUST declare the base address used by the PHY driver
> for global configuration by calculating the offsets of the global PHY
> based on the base address of the PHY package and declare the
> "ethrnet-phy-package" compatible.
> 
> Each reg of the PHY defined in the PHY package node is absolute and will
> reference the real address of the PHY on the bus.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   .../bindings/net/ethernet-phy-package.yaml    | 75 +++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> new file mode 100644
> index 000000000000..244d4bc29164
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ethernet PHY Package Common Properties
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  This schema describe PHY package as simple container for
> +  a bundle of PHYs that share the same properties and
> +  contains the PHYs of the package themself.
> +
> +  Each reg of the PHYs defined in the PHY package node is
> +  absolute and describe the real address of the PHY on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"
> +
> +  compatible:
> +    const: ethernet-phy-package
> +
> +  reg:
> +    minimum: 0
> +    maximum: 31
> +    description:
> +      The base ID number for the PHY package.
> +      Commonly the ID of the first PHY in the PHY package.
> +
> +      Some PHY in the PHY package might be not defined but
> +      still exist on the device (just not attached to anything).
> +      The reg defined in the PHY package node might differ and
> +      the related PHY might be not defined.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ^ethernet-phy(@[a-f0-9]+)?$:
> +    $ref: ethernet-phy.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@16 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "ethernet-phy-package";
> +            reg = <0x16>;
> +
> +            ethernet-phy@16 {
> +              reg = <0x16>;
> +            };
> +
> +            phy4: ethernet-phy@1a {
> +              reg = <0x1a>;
> +            };
> +        };
> +    };

So, we ended up on a design where we use the predefined compatible 
string 'ethernet-phy-package' to recognize a phy package inside the 
of_mdiobus_register() function. During the V1 discussion, Vladimir came 
up with the idea of 'ranges' property usage [1]. Can we use 'ranges' to 
recognize a phy package in of_mdiobus_register()? IMHO this will give us 
a clear DT solution. I mean 'ranges' clearly indicates that child nodes 
are in the same address range as the parent node. Also we can list all 
child addresses in 'reg' to mark them occupied.

   mdio {
     ...

     ethernet-phy-package@16 {
       compatible = "qcom,qca8075";
       reg = <0x16>, <0x17>, <0x18>, <0x19>, <0x1a>;
       ranges;
       ...

       ethernet-phy@16 {
         reg = <0x16>;
       };

       ethernet-phy@1a {
         reg = <0x1a>;
       };
     };
   };

Did you find some issues with the 'ranges' conception?


And I would like to ask you about another issue raised by Vladimir [1]. 
These phy chips become SoC with all these built-in PHYs, PCSs, clocks, 
interrupt controllers, etc. Should we address this now? Or should we go 
with the proposed solution for now and postpone modeling of other 
peripherals until we get a real hardware, as Andrew suggested?

I'm asking because it looks like we have got a real hardware. Luo 
currently trying to push QCA8084 (multi-phy/switch chip) support, and 
this chip exactly contains a huge clock/reset controller [2,3].


1. https://lore.kernel.org/lkml/20231124165923.p2iozsrnwlogjzua@skbuf // 
Re: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet PHY 
package nodes
2. 
https://lore.kernel.org/lkml/20231215074005.26976-1-quic_luoj@quicinc.com 
  // [PATCH v8 00/14] add qca8084 ethernet phy driver
3. 
https://lore.kernel.org/lkml/20231104034858.9159-1-quic_luoj@quicinc.com 
  // [PATCH v12 0/4] add clock controller of qca8386/qca8084

--
Sergey

