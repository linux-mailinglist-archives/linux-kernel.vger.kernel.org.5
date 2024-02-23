Return-Path: <linux-kernel+bounces-78365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE424861278
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549401F23095
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980C87EEFD;
	Fri, 23 Feb 2024 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ke9j/1EX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78C7E787;
	Fri, 23 Feb 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694219; cv=none; b=fYHEb7zFZKU0kSL+sBsStCnfdChF8bMAG0nVirNUVx00d8LSlSXwO3615V74kh/sIj3vjOVGQGUudbkfW1g07K7cst83cjtUAKtpvSc45FT8yrcCIYZrGtGozXR3tsBE/4k+FKWIoa2ZU4OOy7AeLjrCLrKAexWCG8YaZU/dzik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694219; c=relaxed/simple;
	bh=kuhSbkfLotn64KU5R+E9zFCP0ypAKyPyBykBVgHSyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNe+nEkVbZ0HYZ6Hu4sSp9NqZE5lxpWyIWX28o5LFxHMy9x7Ee3mhx7v0UI/rG4olKKRD+2NZByeEsENs0/zjP8yDc9PDqtUiKUPoIde0K6RW6Y6/u4LvT4GDTj3q7cnLlp6JklSbhLMUA+ROZQZ+FhxnsI2bwxG2itedlPcKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ke9j/1EX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1B352E7;
	Fri, 23 Feb 2024 14:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708694207;
	bh=kuhSbkfLotn64KU5R+E9zFCP0ypAKyPyBykBVgHSyzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ke9j/1EXb4LXw1bMq5TnnRxr9RSZRYFXQbZIdNw/ByatKZDP53KS7sHvJLBh9BGnG
	 35siAB/rDB6PKQZR0GrUHBabYkkPgV7lbY4J6utVUSsN3kIQx4sx02s7JyTK6zECMi
	 4Is6y3V6TC+cVZpsycN5xcXzs94uuPFTrQ07XwxI=
Date: Fri, 23 Feb 2024 15:16:59 +0200
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
Subject: Re: [PATCH 1/1] media: dt-bindings: sony,imx290: Allow props from
 video-interface-devices
Message-ID: <20240223131659.GX31348@pendragon.ideasonboard.com>
References: <20240223124744.545955-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223124744.545955-1-alexander.stein@ew.tq-group.com>

Hi Alexander,

Thank you for the patch.

On Fri, Feb 23, 2024 at 01:47:43PM +0100, Alexander Stein wrote:
> Allow properties from video-interface-devices. This aligns the bindings
> to sony,imx415.yaml. Changes inspired by commit e2e73ed46c395 ("media:
> dt-bindings: sony,imx415: Allow props from video-interface-devices")
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
> index a531badc16c98..e957b5dd4284d 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
> @@ -23,6 +23,9 @@ description: |-
>    is treated the same as this as it was the original compatible string.
>    imx290llr is the mono version of the sensor.
>  
> +allOf:
> +  - $ref: ../video-interface-devices.yaml#

I think this should be

  - $ref: /schemas/media/video-interface-devices.yaml#

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Bonus points if you would like to send patches to the DT bindings of the
gc0308, gc2145, imx214 and imx415 to fix that :-)

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

