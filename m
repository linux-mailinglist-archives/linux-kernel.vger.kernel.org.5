Return-Path: <linux-kernel+bounces-21469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B062A828FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28621C24F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799623DBBF;
	Tue,  9 Jan 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA+KCkts"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D353DB80;
	Tue,  9 Jan 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e67e37661so4289105e87.0;
        Tue, 09 Jan 2024 14:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704838843; x=1705443643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHficcIIFY7DUie+kBBBxCI5Hfo9wpTnRz3NE6iiBRs=;
        b=TA+KCkts1HTytHrL3asmVtWWbRz7Ff0iB6mGOZ1v5WAHNg6axOMw3v0NSST7DYuTbs
         Om5UCYNS4niCK05tfvddHHhcHYvBLPPG1Ihw6LH42Q2Av7HTbkrJHsGt+dLzlPaF1zoo
         P9Wpm/RPPlQvXGHIZzk5b1xzEhQJBoVr/4rOcGWXG1DwILM0LEXQ48c+gHdJ91Ee+Uxi
         jI/jTXZLyE4/tOVhDeMkpkeTpJIX6ZOzhfsOT6tP+qK50m+o3o52nor/o7zmyJueb/ob
         jmyQtMtI28VqkQ4t9LiUNwAYcmMUVOeUe2o+Dxg3O9cicKy2Lc6YcMre18dJ7Z2PdlLv
         6bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704838843; x=1705443643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHficcIIFY7DUie+kBBBxCI5Hfo9wpTnRz3NE6iiBRs=;
        b=OlclO4FeTwLvoMfLpYZWs+OHwq4IhCREYLrsktlttMnLuTbBWA++6coC1sCyMGgjTU
         6MKIqE1SQYWfr2lvBKa6HU53O/RFjkJuNV2mURenRxUseLXylf6velL8FvESsVx8rTHk
         eUok6SSfsb8w6QCN4XUHbhvHof74RndulQ2SSK8virD9OB3xPFrX/xh1N0hnRE+qniI5
         pv3VX5j+5tx/N2xdyXhoExQL2jEdMBK5Yo2rtAsKm5W8/viNPqy56/5vsDL0RShduRoC
         5OTbcuyFMEExRNAsoy4/3DBixKwLGCwArSDTg5KAbVOOrXKsLd2bf7K/i258fmuYcGGp
         1cog==
X-Gm-Message-State: AOJu0Yzf+EoJsW6Zaar7v4P6QdM7E1GEMxskudPZpFa/q3n4sX/UbCO1
	tiCzXc6EDqC/s39SxMy0oq0=
X-Google-Smtp-Source: AGHT+IHzUaf7cXQ3/+rzpIrUR/8dYETycPMk53CfPA2rWOWhUqHeEZ9pITM3KmFaD9xESKzduOK3OQ==
X-Received: by 2002:a19:645e:0:b0:50e:7479:79da with SMTP id b30-20020a19645e000000b0050e747979damr19306lfj.24.1704838842804;
        Tue, 09 Jan 2024 14:20:42 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512305000b0050ea1f2baeasm474292lfb.20.2024.01.09.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:20:42 -0800 (PST)
Date: Wed, 10 Jan 2024 01:20:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Leong Ching Swee <leong.ching.swee@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: Re: [PATCH net-next v2 1/4] dt-bindings: net: snps,dwmac: per
 channel irq
Message-ID: <5y3ed4greqcdz6hsepvpqstyabxupqbw7dc3eilgi64acrbkoc@oy2c7flu33gs>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-2-leong.ching.swee@intel.com>
 <ffiewfybqvh66nmri4im4veupwytvlxk5jfgdy3nbj6wldxjl2@2vwvnnu37pt7>
 <7cc4fa92-27cb-4b0d-8f1b-88091548bdb9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc4fa92-27cb-4b0d-8f1b-88091548bdb9@linaro.org>

On Tue, Jan 09, 2024 at 10:10:37AM +0100, Krzysztof Kozlowski wrote:
> On 07/01/2024 21:10, Serge Semin wrote:
> > On Fri, Jan 05, 2024 at 03:09:22PM +0800, Leong Ching Swee wrote:
> >> From: Swee Leong Ching <leong.ching.swee@intel.com>
> >>
> >> Add dt-bindings for per channel irq.
> >>
> >> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> >> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> >> ---
> >>  .../devicetree/bindings/net/snps,dwmac.yaml   | 24 +++++++++++++------
> >>  1 file changed, 17 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >> index 5c2769dc689a..e72dded824f4 100644
> >> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> >> @@ -103,17 +103,27 @@ properties:
> >>  
> >>    interrupts:
> >>      minItems: 1
> >> -    items:
> >> -      - description: Combined signal for various interrupt events
> >> -      - description: The interrupt to manage the remote wake-up packet detection
> >> -      - description: The interrupt that occurs when Rx exits the LPI state
> >> +    maxItems: 19
> >>  
> >>    interrupt-names:
> >>      minItems: 1
> >> +    maxItems: 19
> >>      items:
> >> -      - const: macirq
> >> -      - enum: [eth_wake_irq, eth_lpi]
> >> -      - const: eth_lpi
> >> +      oneOf:
> >> +        - description: Combined signal for various interrupt events
> >> +          const: macirq
> >> +        - description: The interrupt to manage the remote wake-up packet detection
> >> +          const: eth_wake_irq
> >> +        - description: The interrupt that occurs when Rx exits the LPI state
> >> +          const: eth_lpi
> >> +        - description: DMA Tx per-channel interrupt
> >> +          pattern: '^dma_tx[0-7]?$'
> >> +        - description: DMA Rx per-channel interrupt
> >> +          pattern: '^dma_rx[0-7]?$'
> >> +
> >> +    allOf:
> >> +      - contains:
> >> +          const: macirq
> > 
> > In order to restore the v1 discussion around this change, here is my
> > comment copied from there:
> > 
> >> As Rob correctly noted it's also better to make sure that 'macirq' is placed first
> >> in the array. So instead of the constraint above I guess the next one would
> >> make sure both the array has 'macirq' name and it's the first item:
> >>
> >> allOf:
> >>   - maxItems: 34
> >>     items:
> >>       - const: macirq
> > 
> > Leong said it didn't work:
> > https://lore.kernel.org/netdev/CH0PR11MB54904615B45E521DE6B1A7B3CF61A@CH0PR11MB5490.namprd11.prod.outlook.com/
> > 
> > Rob, Krzysztof, Conor could you please clarify whether this change is ok the
> > way it is or it would be better to preserve the stricter constraint
> > and fix the DT-schema validation tool somehow?
> 

> First of all this change is not good, because commit msg explains
> absolutely nothing why this is done and what exactly you want to achieve
> here. The "what" part often is obvious from the code, but not in this
> case. Are the per-channel IRQs conflicting with macirq or others? Are
> they complementary (maxItems: 19 suggests that, though, but could be
> mistake as well)? Do they affect all snps,dwmac derivatives or only some?
> 
> So many questions and zero answers in one liner commit msg!

Right. The commit message is way too modest =) Leong?

> 
> Now about the problem, I think we should preserve the order, assuming
> that these are complementary so first three must be defined.

Ok. But please note that "Wake" and "LPI" IRQs are optional. It's
possible to have a device with the "MAC" and "DMA" IRQs and no
individual "Wake"/"LPI" IRQ lines. Thus the only mandatory IRQ is
"MAC" which order (being always first), I agree, should be preserved.

> This
> however could be done in the device schema referencing snps,dwmac. I
> think I will repeat myself: I dislike this schema, because it mixes two
> purposes: defining shared part and defining final device part. The code
> in this patch is fine for a schema defining the shared part.
> 
> Therefore before we start growing this monstrosity into bigger one, I
> think we should go back to the plans of reworking and cleaning it.

If you are talking about the changes like introduced here (essentially
it's Patch 4):
https://www.spinics.net/lists/netdev/msg888079.html
I can resurrect it (rebase on the latest kernel, fix the notes, run
dt-validation, etc) and submit for review on the next week or so.
Then the Leong' patch in subject either won't be necessary or will
concern the shared schema only. Does it sound acceptable?

-Serge(y)

> 
> Best regards,
> Krzysztof
> 

