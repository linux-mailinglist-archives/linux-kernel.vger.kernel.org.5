Return-Path: <linux-kernel+bounces-111939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD47887303
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87381B233B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D365BCF;
	Fri, 22 Mar 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adGf2adv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A6651B0;
	Fri, 22 Mar 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131937; cv=none; b=kAvBX7Ztizjn0MQeZv+SxdxkSbLoH9P5FoJ/U0kUOlfMdyKnzq5mfSWaqje3zHPiWx6Oo8EBbsyn/MeZW6N1yopk+B9EAPArAtbFYZ9PxkLvQ6zNOIqaxbuVNTQOdMFK6h8BmC8fW8wcK3k1l+LPIaJGjvqKABBNliOCBHKMlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131937; c=relaxed/simple;
	bh=RwHY4kKkuowcYOd73RCFF27l2zk9ErD/idcQSeCbsB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oImQK/hMMoNvKLyML/58H6p7V2BLapH7P8WUgVMt8q9GiF/giPYE9RUtcYa0Tz6m1FK50WpVc4kxlyzrZBI+fzQ+pCXcEfnWgClR64ODbbcqqr1Fw9QxeQJKiPLQwdlKFBfINgO0GGFbBHZG+uk3MCM6fntVX/xpL4yo4lONCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adGf2adv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1A7C433F1;
	Fri, 22 Mar 2024 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711131937;
	bh=RwHY4kKkuowcYOd73RCFF27l2zk9ErD/idcQSeCbsB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adGf2advdH7mtPAI6LWLrCF55jo55GHScWs1R00yToTEcNFzMKUKBNCsfjLzoPPu6
	 fsof38KyLXsR8Jc6nbXPIFO+zJ1gGxMSEKyd3N08hQXpugsmaEoAwWmDPFfhujcU6W
	 zqckAd3iRoFKWrCATZtfPhgaZOPf3nyya4tx809mn4H4b/ZgU5mdwP75S7cBh+iAUl
	 tdNg4PDkwViKc0NTI/8/XZkA6lKGuXYloYtH4XEeT80jvnXJO9J37/Co+wPWwUY6TT
	 OPSTGpVi5PK3LEJP7TUg5ULsbWgUnx84qh026xrR5QOo0zASYMAtu3zxRoLqjqNsD6
	 aKyouE/5PwYxg==
Date: Fri, 22 Mar 2024 13:25:34 -0500
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
Message-ID: <20240322182534.GA1220647-robh@kernel.org>
References: <20240322025405.3340064-1-wtli@nuvoton.com>
 <20240322025405.3340064-2-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322025405.3340064-2-wtli@nuvoton.com>

On Fri, Mar 22, 2024 at 10:54:04AM +0800, Seven Lee wrote:
> Add a DT schema for describing nau8325 audio amplifiers. The key features
> are as follows:
>   - Low SPK_VDD Quiescent Current
>   - Gain Setting with 2-wire interface
>   - Powerful Stereo Class-D Amplifier
>   - Low Output Noise
>   - Low Current Shutdown Mode
>   - Click-and Pop Suppression
> 
> More resources :
> https://www.nuvoton.com/products/smart-home-audio/audio-amplifiers/class-d-series/nau8325yg/
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> new file mode 100644
> index 000000000000..6ded94c0e644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAU8325 audio Amplifier
> +
> +maintainers:
> +  - Seven Lee <WTLI@nuvoton.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,nau8325
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,vref-impedance:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The vref impedance to be used in kohms. Middle of voltage enables
> +      Tie-Off selection options. Due to the high impedance of the VREF
> +      pin, it is important to use a low-leakage capacitor. Possible
> +      values are 0, 1, 2, and 3 as per the below,
> +
> +      0 = Disable tie off resistance
> +      1 = 25 kohms
> +      2 = 125 kohms
> +      3 = 2.5 kohms
> +    enum: [ 0, 1, 2, 3 ]

Once again, use standard unit suffix on the property name: 

nuvoton,vref-impedance-ohms:
  enum: [0, 2500, 25000, 125000]

Rob

