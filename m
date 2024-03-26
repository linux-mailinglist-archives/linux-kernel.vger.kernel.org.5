Return-Path: <linux-kernel+bounces-120016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CED88D03F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91991C329F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FAA13D8AB;
	Tue, 26 Mar 2024 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAPOQrsf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC073FD4;
	Tue, 26 Mar 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489311; cv=none; b=HSlPd/ssiBAa9dmK3vRLAJhnyHyXiY4yzL4cfU5j6CF75bguPOHFWxvUJcLV/RGfWgfTVsR4ezM5qgd1nt7PQV4NZ8lURsTpv+loptYml5NtlYhNPTsAMR5LCaV/NrGA81G0L1RzEUmGy5oT7lHKbIJTlnStNeKHqhcDMoa6VKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489311; c=relaxed/simple;
	bh=BzpgpbWcoTc7ijZRETE4B+xMagDt/ZzZpxxIA4FcHFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCqOpAr5QqpBZnzlEBsKpUS6wDzNSDSfxGTXHPQi+Hdj7rnsE41sK03/xqEFVuYbD99k0m2UCcv2tn0LDRJDCNB7+sqpkHVPIxXM0FGNbp6n85/p25M/V6ffWDYdR6MaTnj+bxFTRhQEvFjDxbIYmMfAUJ6JyRDSon9xB2FxyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAPOQrsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9564FC43390;
	Tue, 26 Mar 2024 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711489310;
	bh=BzpgpbWcoTc7ijZRETE4B+xMagDt/ZzZpxxIA4FcHFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAPOQrsf9xO+R4J++979fPR1mikCnDwT2YSA3eK5h6kFH5ZvtO+EH4mROmh3jCTkb
	 NdGVwPhQ9N7LaJlSmZJLUD00Wg1nn7pSzRprRip0XlPX3BVGf/+WIJ8gbGBsXJTjOk
	 ThYy/tIUsivm9/O47z73Y2hFxdek6ao2HiQIEzaTo5RxUJVx5+6KeKKedtsnb/15rT
	 rU9ZczreTQJq/5f+QievxNgsRhIn4jrmxJ0fYCh9yP+Qi8VSE2J/kzUc/IlqxqVIGi
	 HM+bdbs2HbhqJcZHe7PuQraZmQrI2a+rJBHMhI5NFCcDHUcHVpVWGiM2CgcMFDYzKP
	 1XknHlt85fr/w==
Date: Tue, 26 Mar 2024 16:41:48 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
Message-ID: <20240326214148.GA3709211-robh@kernel.org>
References: <20240326120107.13442-1-animeshagarwal28@gmail.com>
 <20240326-spectrum-talon-0fc977c32c5c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-spectrum-talon-0fc977c32c5c@spud>

On Tue, Mar 26, 2024 at 06:20:05PM +0000, Conor Dooley wrote:
> On Tue, Mar 26, 2024 at 05:31:00PM +0530, Animesh Agarwal wrote:
> > Convert the OMAP SoC SHA crypto Module bindings to DT Schema.
> > 
> > Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> > ---
> >  .../devicetree/bindings/crypto/omap-sham.txt  | 28 ----------
> >  .../bindings/crypto/ti,omap-sham.yaml         | 56 +++++++++++++++++++
> >  2 files changed, 56 insertions(+), 28 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
> >  create mode 100644 Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
> > deleted file mode 100644
> > index ad9115569611..000000000000
> > --- a/Documentation/devicetree/bindings/crypto/omap-sham.txt
> > +++ /dev/null
> > @@ -1,28 +0,0 @@
> > -OMAP SoC SHA crypto Module
> > -
> > -Required properties:
> > -
> > -- compatible : Should contain entries for this and backward compatible
> > -  SHAM versions:
> > -  - "ti,omap2-sham" for OMAP2 & OMAP3.
> > -  - "ti,omap4-sham" for OMAP4 and AM33XX.
> > -  - "ti,omap5-sham" for OMAP5, DRA7 and AM43XX.
> > -- ti,hwmods: Name of the hwmod associated with the SHAM module
> > -- reg : Offset and length of the register set for the module
> > -- interrupts : the interrupt-specifier for the SHAM module.
> > -
> > -Optional properties:
> > -- dmas: DMA specifiers for the rx dma. See the DMA client binding,
> > -	Documentation/devicetree/bindings/dma/dma.txt
> > -- dma-names: DMA request name. Should be "rx" if a dma is present.
> > -
> > -Example:
> > -	/* AM335x */
> > -	sham: sham@53100000 {
> > -		compatible = "ti,omap4-sham";
> > -		ti,hwmods = "sham";
> > -		reg = <0x53100000 0x200>;
> > -		interrupts = <109>;
> > -		dmas = <&edma 36>;
> > -		dma-names = "rx";
> > -	};
> > diff --git a/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> > new file mode 100644
> > index 000000000000..7a2529cc4cae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/crypto/ti,omap-sham.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: OMAP SoC SHA crypto Module
> > +
> > +maintainers:
> > +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,omap2-sham
> > +      - ti,omap4-sham
> > +      - ti,omap5-sham
> > +
> > +  ti,hwmods:
> > +    description: Name of the hwmod associated with the SHAM module
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [sham]
> 
> Is there really only one value possible here?
> Also, the convention is to put vendor properties like this after more
> common properties like reg, interrupts etc.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  dmas:
> > +    maxItems: 1
> > +
> > +  dma-names:
> > +    const: rx
> > +
> > +dependencies:
> > +  dmas: [dma-names]
> 
> Is this needed? Unless I'm sorely mistaken dt-schema enforces this itself
> (and same for any $foo-names).

dtschema does not. It does do the other way around. This seems fine.

Rob

