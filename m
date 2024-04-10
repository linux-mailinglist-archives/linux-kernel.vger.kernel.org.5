Return-Path: <linux-kernel+bounces-139235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C848A003C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249BE1F23647
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD19180A82;
	Wed, 10 Apr 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBobSbem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8834180A65;
	Wed, 10 Apr 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775818; cv=none; b=rYLEfJKXbVn2QhuUw+s+jmDMUg5KaJSmC97IO32mokoJ9ca+NbDOOGNv4AvSorcIDb2LeD0lRvXIB+GA1jRlLfmHFt7tSDr3GtsuNFp5EGqujPSgVafwdCMgtjpDSXlTLTU2OcJf3VYMnxewAev715ccFnIRjkZvo4RdaXHImS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775818; c=relaxed/simple;
	bh=S8NmEXKVaI1r9fUCrU6f1WB8Na0Z5mpdO3VRO7eiavM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIi5rtP4kjtXfRQBc63M6NKn4ByS0RPL9Y+yYy5wZ6cXnQy8q38rGxFN5fI6kIhiROrXD+Q5PuHgT6c5Fz3hu5RrHQ6Upv7AniOZBEsKuH0FtCQsm+w9GzmDXMvZBBmECOoGdXgGbD1gn50e6vCe0beJ4+q1v6QG20sH5zI+bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBobSbem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F84CC433C7;
	Wed, 10 Apr 2024 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712775817;
	bh=S8NmEXKVaI1r9fUCrU6f1WB8Na0Z5mpdO3VRO7eiavM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBobSbemzs62QSNAqv6HwSPxAY2iptSYLmY76ryN7CKtLmeUHJD0d1Zo0yPgfldGm
	 ygQf7JOl5ys2YYW6DAlSIB5j9HkOi4nhKHyP44e/zUGk2KMFBGg2TUDONVEJDgfbz0
	 6jE5fbOci7aRvBaGUsO4LwCp8ixP9h+lZUlygfwQ3oo7RqXEXsDm35FLMAuxTD93G/
	 gj8MxGApB/orbGD567KXmLcPoTaWK2OZ03bdVes8WFxu2J5ADmrOjED965se7CJ1nd
	 DYxOHbCdx3fCyn1E1YQEcnz1VXvagqkwRERnXPFxi4Xbt35hPmbV5tSb+bcNmvuJj2
	 IR+uK15oettKQ==
Date: Wed, 10 Apr 2024 14:03:35 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
	shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
	ck.hu@mediatek.com, jitao.shi@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: display: mediatek: Add OF graph
 support for board path
Message-ID: <20240410190335.GA890682-robh@kernel.org>
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <20240409120211.321153-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409120211.321153-2-angelogioacchino.delregno@collabora.com>

On Tue, Apr 09, 2024 at 02:02:09PM +0200, AngeloGioacchino Del Regno wrote:
> The display IPs in MediaTek SoCs support being interconnected with
> different instances of DDP IPs (for example, merge0 or merge1) and/or
> with different DDP IPs (for example, rdma can be connected with either
> color, dpi, dsi, merge, etc), forming a full Display Data Path that
> ends with an actual display.
> 
> The final display pipeline is effectively board specific, as it does
> depend on the display that is attached to it, and eventually on the
> sensors supported by the board (for example, Adaptive Ambient Light
> would need an Ambient Light Sensor, otherwise it's pointless!), other
> than the output type.
> 
> Add support for OF graphs to most of the MediaTek DDP (display) bindings
> to add flexibility to build custom hardware paths, hence enabling board
> specific configuration of the display pipeline and allowing to finally
> migrate away from using hardcoded paths.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,aal.yaml        | 40 +++++++++++++++++++
>  .../display/mediatek/mediatek,ccorr.yaml      | 21 ++++++++++
>  .../display/mediatek/mediatek,color.yaml      | 22 ++++++++++
>  .../display/mediatek/mediatek,dither.yaml     | 22 ++++++++++
>  .../display/mediatek/mediatek,dpi.yaml        | 25 +++++++++++-
>  .../display/mediatek/mediatek,dsc.yaml        | 24 +++++++++++
>  .../display/mediatek/mediatek,dsi.yaml        | 27 ++++++++++++-
>  .../display/mediatek/mediatek,ethdr.yaml      | 22 ++++++++++
>  .../display/mediatek/mediatek,gamma.yaml      | 19 +++++++++
>  .../display/mediatek/mediatek,merge.yaml      | 23 +++++++++++
>  .../display/mediatek/mediatek,od.yaml         | 22 ++++++++++
>  .../display/mediatek/mediatek,ovl-2l.yaml     | 22 ++++++++++
>  .../display/mediatek/mediatek,ovl.yaml        | 22 ++++++++++
>  .../display/mediatek/mediatek,postmask.yaml   | 21 ++++++++++
>  .../display/mediatek/mediatek,rdma.yaml       | 22 ++++++++++
>  .../display/mediatek/mediatek,ufoe.yaml       | 21 ++++++++++
>  16 files changed, 372 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index b4c28e96dd55..623cf7e37fe3 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -61,6 +61,27 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      Input and output ports can have multiple endpoints, each of those
> +      connects to either the primary, secondary, etc, display pipeline.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: AAL input port
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          AAL output to the next component's input, for example could be one
> +          of many gamma, overdrive or other blocks.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
>  required:
>    - compatible
>    - reg
> @@ -88,5 +109,24 @@ examples:
>             power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>             clocks = <&mmsys CLK_MM_DISP_AAL>;
>             mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
> +
> +           ports {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               port@0 {
> +                   reg = <0>;
> +                   aal0_in: endpoint {
> +                       remote-endpoint = <&ccorr0_out>;
> +                   };
> +               };
> +
> +               port@1 {
> +                   reg = <1>;
> +                   aal0_out: endpoint {
> +                       remote-endpoint = <&gamma0_in>;
> +                   };
> +               };
> +           };
>         };
>      };
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index 8c2a737237f2..71ea277a5d8e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -54,6 +54,27 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      Input and output ports can have multiple endpoints, each of those
> +      connects to either the primary, secondary, etc, display pipeline.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: CCORR input port
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          CCORR output to the input of the next desired component in the
> +          display pipeline, usually only one of the available AAL blocks.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> index b886ca0d89ea..61d040a10c08 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> @@ -64,6 +64,28 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      Input and output ports can have multiple endpoints, each of those
> +      connects to either the primary, secondary, etc, display pipeline.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: COLOR input port
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          COLOR output to the input of the next desired component in the
> +          display pipeline, for example one of the available CCORR or AAL
> +          blocks.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> index 1588b3f7cec7..3d4ab3f86294 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> @@ -55,6 +55,28 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      Input and output ports can have multiple endpoints, each of those
> +      connects to either the primary, secondary, etc, display pipeline.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DITHER input, usually from a POSTMASK or GAMMA block.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          DITHER output to the input of the next desired component in the
> +          display pipeline, for example one of the available DSC compressors,
> +          DP_INTF, DSI, LVDS or others.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index 803c00f26206..6607cb1c6e0a 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -64,13 +64,34 @@ properties:
>        Output port node. This port should be connected to the input port of an
>        attached HDMI, LVDS or DisplayPort encoder chip.
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DPI input port

Strictly speaking, 'port' is equivalent to 'port@0', so it is already 
defined to be the output path. It is a little odd for the input to be 
port@1, but that is why we define the numbering.

Same comment applies to DSI.

Rob

