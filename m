Return-Path: <linux-kernel+bounces-148650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E668A8588
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DCF1F23B75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689971411DA;
	Wed, 17 Apr 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTCfYUSW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB1140E46;
	Wed, 17 Apr 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362627; cv=none; b=Xd733AFzdXketEM9JobTfrn5IG4i1AVIMPsSlx2c1UBBK3jt4RfZ7ZQmIc9Kqyh5dz8i5FeMjKlKVIptfBioTa/cVYXZwZF3ZIAAPyKnH3RycY9FdcJW84wDCMHAK5SXmkC2upH9rlf36Vqk4ivs86VkrWJlHoujYLg0+E4jggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362627; c=relaxed/simple;
	bh=XqGzLS6YzWodUCVd0W9Hr/EsFe20DCrl+FpyLzZkJxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIpaQmPDzcAEqcvKTR/+zq/int2HWi+JlgH0lxKuUyDTqnZl5hxAJUbYJ+WtLmB45mQTEYfp0zpLtGvOjwjeN1N66XhD+E2BsnPIEsbpjdiezthRK9teUVVqxSYObTwofoUUIsTXKXDxyeBnWQkTe2DgubUa3mUmzzATsB1eDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTCfYUSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04B2C072AA;
	Wed, 17 Apr 2024 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713362625;
	bh=XqGzLS6YzWodUCVd0W9Hr/EsFe20DCrl+FpyLzZkJxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pTCfYUSWOyYxRanDvsgEq/VVLADNHcYYhQ+GHHXyEm4ybKZ0NWnS/e4UgSOZ8qzfg
	 stIy1tLX9LQZCZzmmcf+kQMUP/NWuxPRzgznx/DB7cSedPkZMNOG3KJC1j5TUjQGbn
	 TMXWwfugIP077F9yDpEBa4PSI8i125fobGFywj63qwqGi//+ty2QKCSU5SpFIbqo3n
	 Vj/WKCG0x/OLiAazIkNvDg1v0D/7MQoIGOVRKOlgSkCAq0iSO65rShi4SW8HnU0v6c
	 R4yYO/zhmhqy3trG5VKBY0ktKmoc0K9dkPtaLbTCTBJK7ZRqtLL2/MKuFANXit4aac
	 HaqoLx2VdvSYA==
Message-ID: <2e179356-425d-48cc-84db-0ea3e6203fba@kernel.org>
Date: Wed, 17 Apr 2024 16:03:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Mighty <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417134237.23888-1-bavishimithil@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240417134237.23888-1-bavishimithil@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 15:42, Mighty wrote:
> From: Mithil Bavishi <bavishimithil@gmail.com>
> 
> Convert the OMAP4+ McPDM bindings to DT schema.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---

Please provide the changelog under ---.


>  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
>  .../bindings/sound/ti,omap4-mcpdm.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> deleted file mode 100644
> index ff98a0cb5..000000000
> --- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* Texas Instruments OMAP4+ McPDM
> -
> -Required properties:
> -- compatible: "ti,omap4-mcpdm"
> -- reg: Register location and size as an array:
> -       <MPU access base address, size>,
> -       <L3 interconnect address, size>;
> -- interrupts: Interrupt number for McPDM
> -- ti,hwmods: Name of the hwmod associated to the McPDM
> -- clocks:  phandle for the pdmclk provider, likely <&twl6040>
> -- clock-names: Must be "pdmclk"
> -
> -Example:
> -
> -mcpdm: mcpdm@40132000 {
> -	compatible = "ti,omap4-mcpdm";
> -	reg = <0x40132000 0x7f>, /* MPU private access */
> -	      <0x49032000 0x7f>; /* L3 Interconnect */
> -	interrupts = <0 112 0x4>;
> -	interrupt-parent = <&gic>;
> -	ti,hwmods = "mcpdm";
> -};
> -
> -In board DTS file the pdmclk needs to be added:
> -
> -&mcpdm {
> -	clocks = <&twl6040>;
> -	clock-names = "pdmclk";
> -	status = "okay";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> new file mode 100644
> index 000000000..73fcfaf6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP McPDM
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

How did this happen? I see this was in v1, but I am quite surprised to
be listed here. I am for sure not a maintainer of this binding. Choose
driver maintainers or platform maintainers, worse case.


> +
> +description:
> +  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
> +
> +properties:
> +  compatible:
> +    const: ti,omap4-mcpdm
> +
> +  reg:
> +    items:
> +      - description: MPU access base address
> +      - description: L3 interconnect address
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,hwmods:
> +    description: Name of the hwmod associated to the McPDM, likely "mcpdm"

Not much improved here. You miss $ref and optionally constraints.

> +
> +  clocks:
> +    description: phandle for the pdmclk provider, likely <&twl6040>

Missing constraints, so replace it with maxItems: 1

> +
> +  clock-names:
> +    description: Must be "pdmclk"

List the items. I asked to open existing bindings and take a look how it
is there. Existing bindings would show you how we code this part.

> +
> +

Just one blank line.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,hwmods
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pdm@0 {

That's wrong address. Old code does not have 0. Please do no change
parts of code without reason. If there is a reason, explain it in the
changelog.

> +      compatible = "ti,omap4-mcpdm";
> +      reg = <0x40132000 0x7f>, /* MPU private access */
> +            <0x49032000 0x7f>; /* L3 Interconnect */
> +      interrupts = <0 112 0x4>;

Include header and use common defines for flags. Just like all other
recent bindings.


Best regards,
Krzysztof


