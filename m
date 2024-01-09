Return-Path: <linux-kernel+bounces-21145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD8828AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6229B2386F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6163A8EC;
	Tue,  9 Jan 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDVnUPUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899333CF4;
	Tue,  9 Jan 2024 17:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C14DC433F1;
	Tue,  9 Jan 2024 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820112;
	bh=U4kYmlfjVvuQFaFjurJRQqErQEHZxXtOV/EVfh6l9Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDVnUPUY+hO8m/NE832mRMfIOiDiDHGGrXkRec40Pqq1ofrwJUQnQawFV8f8V+JS3
	 mCBAytHgBSMuG5jql7YA9PJ77DSEdduU3rQEv7S/y+DDfbCZQcPEbq0LV2+qcVfYPC
	 yqRHYq4X9cQ5O3W7VSP/B92++WeYMLWjA10O4oa9nZPbR56O48FLIWrgTWEzz50pC2
	 KxJden1uNhLtH861Whm9ALpE+fIFOlV136ui9EDqbBOC8TWXPLxzBFCKxbJk1I3pbX
	 KWJSgWFUTNyu6UGC/vVn/WMcd0y4nIabA/bOhfY9J5iMI9LfZivDdHabqSNCbIuM6a
	 Pbx0PV+QnlzbA==
Received: (nullmailer pid 2778514 invoked by uid 1000);
	Tue, 09 Jan 2024 17:08:30 -0000
Date: Tue, 9 Jan 2024 11:08:30 -0600
From: Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com, benjaminfair@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m
 clock  property
Message-ID: <20240109170830.GA2772086-robh@kernel.org>
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108135421.684263-2-tmaimon77@gmail.com>

On Mon, Jan 08, 2024 at 03:54:14PM +0200, Tomer Maimon wrote:
> The NPCM8XX clock driver uses 25Mhz external clock, therefor adding

therefore

> refclk property.

'refclk' is not a property.

> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/clock/nuvoton,npcm845-clk.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> index b901ca13cd25..0b642bfce292 100644
> --- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> @@ -21,6 +21,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    items:
> +      - description: 25Mhz referance clock

reference

> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +
>    '#clock-cells':
>      const: 1
>      description:
> @@ -30,12 +38,20 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - clocks
> +  - clock-names

New required properties are an ABI break. That's fine if you explain why 
that's okay in the commit msg.


>    - '#clock-cells'
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> +    refclk: refclk-25mhz {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <25000000>;
> +    }; 

Examples don't need to show providers.

> +  
>      ahb {
>          #address-cells = <2>;
>          #size-cells = <2>;
> -- 
> 2.34.1
> 

