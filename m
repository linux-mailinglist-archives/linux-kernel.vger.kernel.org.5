Return-Path: <linux-kernel+bounces-78549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F120F8614D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB43283B20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEB7AE45;
	Fri, 23 Feb 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t/cX77eZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962295C60F;
	Fri, 23 Feb 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700053; cv=none; b=hf5c+6C3U3F8sSVzuVnQCk7A4GTmGZc6dbN1fGuV8C7lV2UtcKtpeOfDomtlEXQW03FudV+z39+nmQHIKGtQegfHOL4h9YjJp6QNige6+S36e6fRpUrsIJIJJllE3Sp4LjGGfYHxVC3nr76ZXa3FdWNkibvEcA7R7/4AM5ltqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700053; c=relaxed/simple;
	bh=Xtnd2ZN8TZtOQTkUB8zpzweIDbc0frEjIqge6hkd6gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWqs29ZrdMFMlUHDbEedni9Bs8n6YslliS3uNMjAedfpW/nOTSh9+Rb2hy03YW4U1oWh1/e38EUMm6KMIzR+HVAwuIyz/SHDFWfs62IZy5rQKSxgMhJtBHIc5xhS89qb7ifwTSUKJKMqsFGjlE5u45hUq2u30mbOTAzN0PLIQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t/cX77eZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 269F49CA;
	Fri, 23 Feb 2024 15:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708700040;
	bh=Xtnd2ZN8TZtOQTkUB8zpzweIDbc0frEjIqge6hkd6gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/cX77eZO5RjSpXVUDFEdjshZeLGLhJbCLFQkamF44WWxfoRg8nuZoTRUAr+0Xyzl
	 IMHYVM3hL4yRw91b1XCVK1gipphvDW8Bw+/UVhvts+ai4tpIxqDLe4f871dep6v54O
	 GbE6YROeMt8S76uY0FeKSIFrylpqwAkQlHSk4xzg=
Date: Fri, 23 Feb 2024 16:54:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] media: dt-bindings: sony,imx290: Allow props from
 video-interface-devices
Message-ID: <20240223145411.GC1313@pendragon.ideasonboard.com>
References: <20240223144746.2583749-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223144746.2583749-1-alexander.stein@ew.tq-group.com>

On Fri, Feb 23, 2024 at 03:47:41PM +0100, Alexander Stein wrote:
> Allow properties from video-interface-devices. This aligns the bindings
> to sony,imx415.yaml. Changes inspired by commit e2e73ed46c395 ("media:
> dt-bindings: sony,imx415: Allow props from video-interface-devices")
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v2:
> * Use absolute path to other schemas
> 
>  Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
> index a531badc16c98..bf05ca48601ab 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
> @@ -23,6 +23,9 @@ description: |-
>    is treated the same as this as it was the original compatible string.
>    imx290llr is the mono version of the sensor.
>  
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -101,7 +104,7 @@ required:
>    - vdddo-supply
>    - port
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |

-- 
Regards,

Laurent Pinchart

