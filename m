Return-Path: <linux-kernel+bounces-9792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B82781CB89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA838B23750
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94111241E1;
	Fri, 22 Dec 2023 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLDxFUjZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6023740;
	Fri, 22 Dec 2023 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso2406059e87.3;
        Fri, 22 Dec 2023 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703256668; x=1703861468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtUnE4xxhx15CW5JpLi7TOoE2wmO68jA2bGdTJ/24bk=;
        b=LLDxFUjZkrkpNZ/4nteSQlIob1g1VT6ZnYKWpW7UHKVoaD1zMuTqcg4T3WZ52dJw5A
         vu5Xk/BcEdstcAAP3R1vj2ZXuUI6azF84vXoRErjR3KBvBjKitE/Cv93QmJWo537k0YJ
         dU8rSW4kYfpmL3L7iu+VvUpN2sh/SmNOF6IyEckcOXwG799ch4hevZT1yNCyrc69nlaN
         GZ0IFzSx2E0q4vGgorW19JXG7kV0mC7V2LkWeYPj4eDhJonWCg+9G9ST5MVLoGqfvYnr
         h59gVs91TI/A/UuN1Y/pG2Z8mqFddzM4jCtv7Z7W+1QrTbgZdWBpnmK5Ht3ngK6P6xYx
         qyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256668; x=1703861468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtUnE4xxhx15CW5JpLi7TOoE2wmO68jA2bGdTJ/24bk=;
        b=AC9569AXhnB8lM301uYA9fmZFS34rMKnz+w6Ol0CVXY8+af4F187YMnrBnh/ywK71G
         mPgb89xv45RR7N8n5Q6JlxZWbibMXbEmpjKO4mF8SpHQcL/BqyC4jlsg2llToZ12D+kk
         ajyXyj/5Qg0WNcaT4jfJNBwDEnqyR5/4GV2W9YLmVGqmWWjkRWgO0xw1RyTNez7gAal3
         1csk8lV5sXqAS9StZls0feraJTIypOnTVqh/yazlh7ZUe1hV1mYOTr8JhaptVVBQZcUn
         fcYYFIGj0XJwQ/XThdgdLOZeoTxmbIfjb2hQ8gkd5+0s6nxgJ/ALPiH2FnxNZF4GfPGn
         mVVw==
X-Gm-Message-State: AOJu0YyGkuxmsguXYxAZmiqa21K/KU01PKLy7ysDgo3aXy26EG7wA5AV
	PBkT2Y+Bq6gE+AOSEQDpLu0=
X-Google-Smtp-Source: AGHT+IHL1Qfai+8qWEquMbFEUPJRFgvR0ti3liSz/epY51csYe8OPA6HRw50x/Gp8NzXQAMmvk8UaQ==
X-Received: by 2002:a19:700e:0:b0:50e:5a39:bbeb with SMTP id h14-20020a19700e000000b0050e5a39bbebmr393705lfc.173.1703256668116;
        Fri, 22 Dec 2023 06:51:08 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m13-20020ac2424d000000b0050e697f2d0esm192153lfl.61.2023.12.22.06.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:51:07 -0800 (PST)
Date: Fri, 22 Dec 2023 17:51:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Leong Ching Swee <leong.ching.swee@intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: Re: [PATCH net-next v1 1/4] dt-bindings: net: snps,dwmac: per
 channel irq
Message-ID: <tly7rej6uz7r36j3nm2yk6mhrbdxkvwyphj3oosar5xd3ucpey@hv4dro7emw3h>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-2-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222054451.2683242-2-leong.ching.swee@intel.com>

On Fri, Dec 22, 2023 at 01:44:48PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Add dt-bindings for per channel irq.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 24 +++++++++++++------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..e72dded824f4 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -103,17 +103,27 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    items:
> -      - description: Combined signal for various interrupt events
> -      - description: The interrupt to manage the remote wake-up packet detection
> -      - description: The interrupt that occurs when Rx exits the LPI state
> +    maxItems: 19
>  
>    interrupt-names:
>      minItems: 1
> +    maxItems: 19
>      items:
> -      - const: macirq
> -      - enum: [eth_wake_irq, eth_lpi]
> -      - const: eth_lpi
> +      oneOf:
> +        - description: Combined signal for various interrupt events
> +          const: macirq
> +        - description: The interrupt to manage the remote wake-up packet detection
> +          const: eth_wake_irq
> +        - description: The interrupt that occurs when Rx exits the LPI state
> +          const: eth_lpi
> +        - description: DMA Tx per-channel interrupt
> +          pattern: '^dma_tx[0-7]?$'
> +        - description: DMA Rx per-channel interrupt
> +          pattern: '^dma_rx[0-7]?$'
> +

> +    allOf:
> +      - contains:
> +          const: macirq

As Rob correctly noted it's also better to make sure that 'macirq' is
placed first in the array. So instead of the constraint above I guess
the next one would make sure both the array has 'macirq' name and it's
the first item:

allOf:
  - maxItems: 34
    items:
      - const: macirq

-Serge(y)

>  
>    clocks:
>      minItems: 1
> -- 
> 2.34.1
> 
> 

