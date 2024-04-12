Return-Path: <linux-kernel+bounces-142827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB8C8A308E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED435285354
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAD312BF2E;
	Fri, 12 Apr 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s435lT6c"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C88626D;
	Fri, 12 Apr 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931796; cv=none; b=Ft4TU/HgKQqe988FRsxm8AHDa2gBfKWCrYEncsUiOhFC9iutRFLC3YpRBqQ1oMq7nNBNN54RmYiAcS+9sUXZnTnpmVTm4IHRpr+2Nk3kofnhpO12bp4GlwZkkV7SIXAWpbX+pRxlEVuTs7mS1SJMkQEyXCFpDi+ygr4NQLdzMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931796; c=relaxed/simple;
	bh=DQA4V4gIf1C2JgezzhvnSZNIUVVDSKNVaC3t+8lT5aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2L/HRkJCqUagY75cUqNr/Nunj6NQTymEtkXx8yQJEGIWs2wAMHGQVgTsajBPvdUNPiIsOjqDEY3RRZw+szCLY8QHRYZohXX8wlUOJ9hRgrPh6lD9KgR3pT0fTSlwavjZmau39hLEIAny+Cbh8qlFOTQ1bC0/j2EXDTvwXygs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=s435lT6c; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (ip-185-104-138-69.ptr.icomera.net [185.104.138.69])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD34FA12;
	Fri, 12 Apr 2024 16:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712931749;
	bh=DQA4V4gIf1C2JgezzhvnSZNIUVVDSKNVaC3t+8lT5aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s435lT6c/MZaeuDhpd4ZJ7mRTJzbG4v1HiJAa/ZWQ/BCoTbwzcsgQrWvhoszhPIr0
	 BQKq0L63bDlPXFEpglR+JE7GMOe+7Ap7algEN0MQ7dXUmRMS6CviqroQ8oJ9yVYW1f
	 twlp57JhBjOs4nL8sKtPCli6bEMOWRB7alZQjN7Y=
Date: Fri, 12 Apr 2024 17:23:02 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] media: dt-bindings: nxp,imx8-isi: Refuse port@1
 for single pipeline models
Message-ID: <20240412142302.GD26231@pendragon.ideasonboard.com>
References: <20240412095549.258870-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412095549.258870-1-alexander.stein@ew.tq-group.com>

Hi Alexander,

Thank you for the patch.

On Fri, Apr 12, 2024 at 11:55:49AM +0200, Alexander Stein wrote:
> In case the hardware only supports just one pipeline, explicitly refuse
> port@1 in ports node.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> This is v2 to patch series [1]. With 2 patches dropped, only this one
> is left, hence no cover letter.
> 
> Changes in v2:
> * Dropped v1 patches 2 & 3
> * Collected Krzysztof's A-b
> 
> [1] https://lore.kernel.org/all/20240223140445.1885083-1-alexander.stein@ew.tq-group.com/
> 
>  Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
> index e4665469a86c..4d5348d456a1 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
> @@ -84,6 +84,7 @@ allOf:
>            properties:
>              port@0:
>                description: MIPI CSI-2 RX
> +            port@1: false
>            required:
>              - port@0
>  

-- 
Regards,

Laurent Pinchart

