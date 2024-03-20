Return-Path: <linux-kernel+bounces-109108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAE78814B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167631C213AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CCB524B7;
	Wed, 20 Mar 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abSMw8WC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C023B0;
	Wed, 20 Mar 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949048; cv=none; b=O5eFt+JEnNXRK+HVhfJ6mGZmDaFfcyrNn1N1F+poKQuTPeM6kV+GqVSFahexo+dGRK6x0b8+CI0tIUbtwluxHUFXnupoqSHLuO2ZLHW44vY8N3PrUINdLwayS4HGR1ssDCk3oSDc4JdC/DmK73gAmYZ1em76aM63gN1OMdr7NB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949048; c=relaxed/simple;
	bh=fmLM09aW3YMSQUrUIHkdieapEFOUqgns1Zezwr2fW5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtBX5cCPevKUFW1iP7JFV4il61ZzHOou6Y5soyClJfQeFRMrBmKv96/l72+l7lMGfiKSot594OEzb2jVd+IYhP5WfIFjuY0pq5fHthi1Js6nuhuvYqg8wFzLCFxHFOUnn5MKF5t645L5qM30AgnqE/2DEAZbY7wg4ZdFbRtAJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abSMw8WC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2401C433C7;
	Wed, 20 Mar 2024 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710949047;
	bh=fmLM09aW3YMSQUrUIHkdieapEFOUqgns1Zezwr2fW5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abSMw8WCvv/cRC1zXjoJEzMk+LxTZ7NCQqlpkGarPVeeMTqrG30+9LUHHk5+M4lqK
	 Qgj2QSrZLK23wcbpLpb1A1T3vEBy08/EAgtQYDrAxLdigXL1dmZXfgr7NoZ2u3mUBy
	 T6Mei1P5bZrRO8uk8K+ZMJ7jRnF6+o5mR6gkhyIUxcSCsBrKRGGRTiAWxJqidiLdo0
	 NQA/YDRHd9ccTWHBy4dLgp0LFWn/A3aA+BirQ0Oun8nL0vYn9nwL9JzAq1emPemesx
	 AnTJd2KX/aZd5N2+dzNOmFd7EeRzhd/n1F3Qo8+JUjUT9/bP845TrqCFmJ1/vJTThR
	 +5/QHr5JEJ1wQ==
Date: Wed, 20 Mar 2024 10:37:25 -0500
From: Rob Herring <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Vishal Sagar <vishal.sagar@amd.com>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs
Message-ID: <20240320153725.GA1771730-robh@kernel.org>
References: <20240319-xilinx-dp-audio-v2-0-92d6d3a7ca7e@ideasonboard.com>
 <20240319-xilinx-dp-audio-v2-2-92d6d3a7ca7e@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-xilinx-dp-audio-v2-2-92d6d3a7ca7e@ideasonboard.com>

On Tue, Mar 19, 2024 at 10:22:37AM +0200, Tomi Valkeinen wrote:
> The DP subsystem for ZynqMP support audio via two channels, and the DP
> DMA has dma-engines for those channels. For some reason the DT binding
> has not specified those channels, even if the picture included in
> xlnx,zynqmp-dpsub.yaml shows "2 x aud" DMAs.

New required entries is an ABI change. This message kind of indicates it 
was a mistake, but should be a lot more explicit. Are things broken 
without the entries? Need 'Fixes'?

> 
> Add the two audio DMAs to the binding.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> index 554f9d5809d4..6b754d4f260e 100644
> --- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> @@ -100,12 +100,16 @@ properties:
>        - description: Video layer, plane 1 (U/V or U)
>        - description: Video layer, plane 2 (V)
>        - description: Graphics layer
> +      - description: Audio channel 0
> +      - description: Audio channel 1
>    dma-names:
>      items:
>        - const: vid0
>        - const: vid1
>        - const: vid2
>        - const: gfx0
> +      - const: aud0
> +      - const: aud1
>  
>    phys:
>      description: PHYs for the DP data lanes
> @@ -194,11 +198,13 @@ examples:
>          power-domains = <&pd_dp>;
>          resets = <&reset ZYNQMP_RESET_DP>;
>  
> -        dma-names = "vid0", "vid1", "vid2", "gfx0";
> +        dma-names = "vid0", "vid1", "vid2", "gfx0", "aud0", "aud1";
>          dmas = <&xlnx_dpdma 0>,
>                 <&xlnx_dpdma 1>,
>                 <&xlnx_dpdma 2>,
> -               <&xlnx_dpdma 3>;
> +               <&xlnx_dpdma 3>,
> +               <&xlnx_dpdma 4>,
> +               <&xlnx_dpdma 5>;
>  
>          phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
>                 <&psgtr 0 PHY_TYPE_DP 1 3>;
> 
> -- 
> 2.34.1
> 

