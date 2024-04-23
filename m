Return-Path: <linux-kernel+bounces-155431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86E8AEA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9831F231C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1AF13BAF7;
	Tue, 23 Apr 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF9zount"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38C5820E;
	Tue, 23 Apr 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885205; cv=none; b=cWAMGDEW5/aFnpU+8uF6zWK6KNCCeIh0BEo8Y8aAYIrSyl17KsyxiKHdDsuVijia7Pwb+zZlER7PSr7AL2eT2wX1+dRYx4kKbb+iDjXxOh5ed2ORBG/RkdvZCjL4G55+YRJoeL/Ggto7CZCCMra1V7Iogrg/myCY26urIZOKfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885205; c=relaxed/simple;
	bh=GR69nV5uvqJb9NK7Thn7pjPErJQl9mvNGJ2W/80n4jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHhcEkFc2LWd8bMvJDOngjxurywB70nnsxX33EeUGhHsv467XXFyqTSFT4JCf7F2llaUomvpVWTbR5ZJNum7J5shEX6FfGMjvyE7aWjHCqM5LgnLnta4iovHd2NUnmUSdkOwu0R2iyLNhwK0mTbYfq0CisMOZqU/sJROSU5wVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF9zount; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B22C2BD10;
	Tue, 23 Apr 2024 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885204;
	bh=GR69nV5uvqJb9NK7Thn7pjPErJQl9mvNGJ2W/80n4jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vF9zountyLxq7/X17b/d+LN1V44P4WoGovQZCJYEwSAYNMDuVyky1iwxBaufgSBEL
	 jrAYCP4pEZUUoQzYjJoYKf+wOjdujady33mNtrj1ZfpSStCqsRZ+GLfaUuqaDwsxFg
	 UEDRIR0BnIN7/Oq4oiaxwBCJBDobq2BF+QvukQfhI0RAzrLCNFC6nWXNwdErh1nrzF
	 FiNqNITPjNjg9JsJ8xw0O7i+JzLVijY1jpjeOWrE0uXBbzu44xhxc13LgRU097Fwha
	 MUU7ROAErqRbgas7mhq8+QVA6DfmlQXMScaSoGx0g4CwFv2HWu4nJF2a73ONU3Wzwh
	 Oy4BCetr/YtNA==
Date: Tue, 23 Apr 2024 10:13:21 -0500
From: Rob Herring <robh@kernel.org>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: Re: [PATCH 1/3] spi: dt-bindings: nxp,sc18is602: convert binding to
 YAML
Message-ID: <20240423151321.GA273010-robh@kernel.org>
References: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
 <20240423-sc18is606-v1-1-094ef37d5a59@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-sc18is606-v1-1-094ef37d5a59@bang-olufsen.dk>

On Tue, Apr 23, 2024 at 01:35:30PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Convert the txt binding to YAML. In the example, the node name was
> changed from sc18is603@28 to spi@28 to conform with the standard
> $nodename property in the spi-controller.yaml schema.
> 
> Make myself maintainer of this binding, since nobody else has
> volunteered themselves.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/spi/nxp,sc18is602.yaml     | 59 ++++++++++++++++++++++
>  .../devicetree/bindings/spi/spi-sc18is602.txt      | 23 ---------
>  2 files changed, 59 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml b/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
> new file mode 100644
> index 000000000000..5b34fdf6148a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nxp,sc18is602.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SC18IS602/602B/603 I2C to SPI bridge
> +
> +maintainers:
> +  - Alvin Šipraga <alsi@bang-olufsen.dk>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sc18is602
> +      - nxp,sc18is602b
> +      - nxp,sc18is603
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Drop. 'clock-frequency' already has a type. With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

