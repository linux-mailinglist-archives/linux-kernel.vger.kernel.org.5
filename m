Return-Path: <linux-kernel+bounces-88107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9D86DD67
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5EB28694
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3786A359;
	Fri,  1 Mar 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sf6YDV5o"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC56A013;
	Fri,  1 Mar 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282782; cv=none; b=V+7JnE6Zjkn9DbFqmg0JbProDQ7UTX5tO8CwIMO+06mENt3XupZKzc0y6bSCEmgxDTKLbc2Mj7/28pNoInAnCrWpJ20Tn7Lpb1RM2jDIk43J36I0A3mJwDHdkLNLnv1Fu4CvsopVbUXWMYzFTW5+IG4xP35XVamvtPi/AY0YV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282782; c=relaxed/simple;
	bh=mBbrNX9zQ1NKiLd7Z/pgJVu1yxTulmTFb/zYC3nwzCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LikZzuklOaCMeSBC19FoSCI3VKh1lO4CrpAiB+HtKTZGVSDbGWjl4WQ8UTCutM9kwcURN6pJ3TYkebM70GKxBQ4pm+4Lr93u3+NEINLjX23aqSh3G6VCI0MdpzlONglLV07o6e98hT3XmPRBDG1R7i3bWYckgHWcp6iFsSlemZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sf6YDV5o; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A0B29CE;
	Fri,  1 Mar 2024 09:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709282763;
	bh=mBbrNX9zQ1NKiLd7Z/pgJVu1yxTulmTFb/zYC3nwzCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sf6YDV5op3dLA/N3+Ozhjb7/lB0cdTcAozK5vJl8PoNVaqmgo67FXaF+27gZdQutN
	 wMPmDtaPISEj4Hl0I4h/tMNACO3DO6g1CYYglgyB3u5FFhsFYqvPf/+eLKzba4ILFj
	 WyRhPCqAmrS3sWEVaNuHzApeAXsh9v4IQZO4dpC8=
Date: Fri, 1 Mar 2024 10:46:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] media: dt-bindings: i2c: use absolute path to
 other schema
Message-ID: <20240301084620.GB30104@pendragon.ideasonboard.com>
References: <20240301084009.3030753-1-alexander.stein@ew.tq-group.com>
 <20240301084009.3030753-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301084009.3030753-2-alexander.stein@ew.tq-group.com>

Hi Alexander,

Thank you for the patch.

On Fri, Mar 01, 2024 at 09:40:08AM +0100, Alexander Stein wrote:
> Absolute path to other DT schema is preferred over relative one.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Changes in v3:
> * Squashed patches 2-5 from v2 into a single one
> 
>  .../devicetree/bindings/media/i2c/galaxycore,gc0308.yaml        | 2 +-
>  .../devicetree/bindings/media/i2c/galaxycore,gc2145.yaml        | 2 +-
>  Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml    | 2 +-
>  Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
> index f81e7daed67b6..2bf1a81feaf47 100644
> --- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
> @@ -15,7 +15,7 @@ description: |
>    They include an ISP capable of auto exposure and auto white balance.
>  
>  allOf:
> -  - $ref: ../video-interface-devices.yaml#
> +  - $ref: /schemas/media/video-interface-devices.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> index 1726ecca4c77e..9eac588de0bc2 100644
> --- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> @@ -19,7 +19,7 @@ description:
>    either through a parallel interface or through MIPI CSI-2.
>  
>  allOf:
> -  - $ref: ../video-interface-devices.yaml#
> +  - $ref: /schemas/media/video-interface-devices.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
> index 60903da84e1f3..0162eec8ca993 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
> @@ -16,7 +16,7 @@ description: |
>    maximum throughput of 1.2Gbps/lane.
>  
>  allOf:
> -  - $ref: ../video-interface-devices.yaml#
> +  - $ref: /schemas/media/video-interface-devices.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> index 9a00dab2e8a3f..34962c5c70065 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> @@ -18,7 +18,7 @@ description: |-
>    available via CSI-2 serial data output (two or four lanes).
>  
>  allOf:
> -  - $ref: ../video-interface-devices.yaml#
> +  - $ref: /schemas/media/video-interface-devices.yaml#
>  
>  properties:
>    compatible:

-- 
Regards,

Laurent Pinchart

