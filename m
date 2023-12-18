Return-Path: <linux-kernel+bounces-3919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5074817520
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7445E28ABC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2553D57B;
	Mon, 18 Dec 2023 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8UASN/a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822742378;
	Mon, 18 Dec 2023 15:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83396C433C8;
	Mon, 18 Dec 2023 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702912720;
	bh=nQ9cMEOKFUeBWhJYdZZdQBOfkz4zr/KEjmxp1uEKoe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8UASN/awVVlAUG5eueaP46sORsYTxNftgVTRDCZ7ZBnWcfHG+UcRGzHd00cgHpcg
	 4bZy3nb7WZml9lTJTEKD81WsVLC26jrNQaF3wqG0rST+45rxNlNX8Cm/OssNfQ2vDd
	 +VL0nlA0o1srk/3Qzm3Kyx4ErxR57bfP9zJqOmFkbVpTC29jsccnfAdPl76fj1TwKw
	 tTaI6Fdk/IoBILuOEKWVz0+VAGKMNP5MxJ2UwNe8ByNVTJa2638dbS29gVaVSKszbP
	 rfRn7KE/Mli2Xjv2qvfSUIgSeZhE7SOOFBhGeDYBds7GlxWQcSaHUvg/8tZXeaIA4B
	 Zh06W4yNEK3NQ==
Received: (nullmailer pid 3835867 invoked by uid 1000);
	Mon, 18 Dec 2023 15:18:38 -0000
Date: Mon, 18 Dec 2023 09:18:38 -0600
From: Rob Herring <robh@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] dt-bindings: input: add entry for 88pm88x-onkey
Message-ID: <20231218151838.GB3827526-robh@kernel.org>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-4-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217131838.7569-4-karelb@gimli.ms.mff.cuni.cz>

On Sun, Dec 17, 2023 at 02:17:01PM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM88X PMICs provide onkey functionality. Document it.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../bindings/input/marvell,88pm88x-onkey.yaml | 30 +++++++++++++++++++
>  .../bindings/mfd/marvell,88pm88x.yaml         |  4 +++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> new file mode 100644
> index 000000000000..aeb7673189f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/marvell,88pm88x-onkey.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Onkey driver for Marvell 88PM88X PMICs.
> +
> +maintainers:
> +  - Karel Balej <balejk@matfyz.cz>
> +
> +description: |
> +  This module is part of the 88PM88X MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml.
> +
> +  The onkey controller is represented as a sub-node of the PMIC node in
> +  the device tree.
> +
> +allOf:
> +  - $ref: input.yaml#
> +
> +properties:
> +  compatible:
> +    const: marvell,88pm88x-onkey
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> index e075729c360f..115b41c9f22c 100644
> --- a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> +++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> @@ -50,6 +50,10 @@ examples:
>          interrupt-parent = <&gic>;
>          interrupt-controller;
>          #interrupt-cells = <1>;
> +
> +        onkey {
> +          compatible = "marvell,88pm88x-onkey";
> +        };

Why do you need this? You have no properties for it. The parent driver 
can instantiate child drivers. You don't need a DT node for that.

Rob

