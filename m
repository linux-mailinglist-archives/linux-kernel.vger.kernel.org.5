Return-Path: <linux-kernel+bounces-32085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3183564C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083DA281D77
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE4376EC;
	Sun, 21 Jan 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO7VNNGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2032AF08;
	Sun, 21 Jan 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705850853; cv=none; b=rRwUbCd7jHs8vXMifM23LmCI88k8MUpzIUv8zSYBKjw6pNtqjN6V7z4JhdRZsPHCWe2uTdCwRQCeVXF6MlDlTmZVVfucylbP1uZJxQknSeYWnmGuwbm2AGn14J6P4gGq1e2YFXNc/EEOIx+csIGNwvabn5iG4M5XnY9W1Sl9jVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705850853; c=relaxed/simple;
	bh=jPBQlN4n2vu1yEgpL6Vpv8aaah2ReKjMEZdhrlZpMzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI6GgyStzkoEfpTQN8y5bq8oTAIV1ttzYrkjbrnjyuKitEb5ehBWJvwx15ipvrwQb9Cp9a8WrSxEVCZ1YE6lpsSB3bhKDShxoGX8fOACTJfPJHscR+93r27ooPYR1PlcXDz6Oif9aZoJtbtXHislMBbUt1IPQwiVOnhkBlMlkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO7VNNGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A18C433C7;
	Sun, 21 Jan 2024 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705850852;
	bh=jPBQlN4n2vu1yEgpL6Vpv8aaah2ReKjMEZdhrlZpMzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AO7VNNGSvK/lCBR0jpKvGsT9KKQtJOs6XP9poQO8tMUi5pHpi+rtFU5M8UsL0J+Op
	 8e/ZkuH1KRBYWRlfa9XivjSBqoE4dCO5/hgicMAXSbPzRLcoSKWSQ+sz8kMIpvMid5
	 zoXVwSlYreb0UPaV9LHG52a6XyUuSYXI8kAW0iNCZMyRqaWur114Py4JLUIsbdp3aK
	 V++DnroJovy8I8qRY1uzdXPUKmh+kywTx21aFUK3DkXD4bfzA/NOo41FXUeuXskLe1
	 mvpgQZLSOG9v85Ba/NI3Ha/b/Zj51foxhPIp4G8HXEFKYYAJL+BX3FvMvRDpSc+e7+
	 n+mQi7zDmtRFA==
Date: Sun, 21 Jan 2024 15:27:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: light: Squash APDS9300 and
 APDS9960 schemas
Message-ID: <20240121152718.35c24f9a@jic23-huawei>
In-Reply-To: <20240121051735.32246-2-subhajit.ghosh@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
	<20240121051735.32246-2-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 15:47:32 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
> file and removing the other. This is done as per the below review:
> Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/

Sounds like a Suggested-by tag to reflect the ideas would be sensible here.

> 
> This patch series adds the driver support and device tree binding schemas
> for APDS9306 Ambient Light Sensor. 

This sentence isn't relevant to this patch, so I'd drop it.
We don't need additional motivation.

>It was pointed out in earlier reviews
> that the schemas for APDS9300 and APDS9960 looks similar and should be
> merged. This particular patch does the first operation of merging
> APDS9300 and APDS9960 schema files.
You have a reference above which is enough.

"Merge very similar schemas for APDS9300 and APDS9960."
is sufficient description alongside a suggested by tag and if you like
a link tag to as above. Note however that Link is an official tag
so belongs in the tag block at the end, not inline in the text.

> 
Link: ...
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
> v2 -> v5:
>  - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
>    as per below reviews:
>    Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
>    Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
> ---
>  .../bindings/iio/light/avago,apds9300.yaml    | 11 +++--
>  .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
>  2 files changed, 7 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> index 206af44f2c43..c610780346e8 100644
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> @@ -4,17 +4,20 @@
>  $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Avago APDS9300 ambient light sensor
> +title: Avago Gesture/RGB/ALS/Proximity sensors
>  
>  maintainers:
> -  - Jonathan Cameron <jic23@kernel.org>
> +  - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>  
>  description: |
> -  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
> +  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
> +  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
>  
>  properties:
>    compatible:
> -    const: avago,apds9300
> +    enum:
> +      - avago,apds9300
> +      - avago,apds9960
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> deleted file mode 100644
> index f06e0fda5629..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
> -
> -maintainers:
> -  - Matt Ranostay <matt.ranostay@konsulko.com>
> -
> -description: |
> -  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
> -
> -properties:
> -  compatible:
> -    const: avago,apds9960
> -
> -  reg:
> -    maxItems: 1
> -
> -  interrupts:
> -    maxItems: 1
> -
> -additionalProperties: false
> -
> -required:
> -  - compatible
> -  - reg
> -
> -examples:
> -  - |
> -    i2c {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -
> -        light-sensor@39 {
> -            compatible = "avago,apds9960";
> -            reg = <0x39>;
> -            interrupt-parent = <&gpio1>;
> -            interrupts = <16 1>;
> -        };
> -    };
> -...


