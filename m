Return-Path: <linux-kernel+bounces-123442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453E98908B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7635C1C27F00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB0137C2D;
	Thu, 28 Mar 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMVJ+HLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4816137908;
	Thu, 28 Mar 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652129; cv=none; b=tYfsZEs0fvQlSU0zyUKXftG9sDOjX9L1mQiUZIujRTJYb1LdfBYW5NEXFmCtJzLc99WBWki0acuIbrmMyjeiKOG79zKpx2zipfq+FvbmqWcU77koa+8MaHs61/yx8gYYGUoNw4fiLFyBzj2vz3/KEa+zPxyC+XHHMBhvXxsoXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652129; c=relaxed/simple;
	bh=O6RUd0FiuATOUi3p2Fr6EOtVM8/VxTL6vhWICc/xTtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAhlguzQ4pNbykAHftW19X/Rvj6WgzATmqbD+McapbIUhxoquMGI4DmOAADDE9V7wBdL36YD0XenDTuOEb2xClA7Jk9Nky/LmPzbuW3TdfkKerZgJFQKCyMz9Xlrx6TW7lK8if5q+MQbdyg9GrF15OlyYFqUiEUeovSIslznmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMVJ+HLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285F8C433F1;
	Thu, 28 Mar 2024 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711652128;
	bh=O6RUd0FiuATOUi3p2Fr6EOtVM8/VxTL6vhWICc/xTtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMVJ+HLghR8zyz+qCC2JJP7kQGIEGPxr5Ml98x4dA7YSvWIuBNBkAKz5BVNnt1cKC
	 U4X26lSPrv66WvoaSs7HO7Wjv4vJagUioEMbZYr1bzr4fbuCXEYXLEBlrzMCUfI9oK
	 7Q8cOeQUyi5lfFD2idby9yZOvPuqWB7rhehfUD0c5e1jbcPeMeCUWGyKB7TWceDNYH
	 NiCdtRDgKp5SrrIGkWBPfkU55FKLpe/A0hGW9al8izHQTEQemTRp611vGqDyI+9lvW
	 uC+e9g+wberfvYWj6IomFhK8s2kj1mbgF965VRhIRBkGAHahwkwi0j++Am1kna3fJ5
	 EFVYHhWqdN2Nw==
Date: Thu, 28 Mar 2024 13:55:26 -0500
From: Rob Herring <robh@kernel.org>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/23] dt-bindings: media: imx258: Add alternate
 compatible strings
Message-ID: <20240328185526.GA88354-robh@kernel.org>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-19-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327231710.53188-19-git@luigi311.com>

On Wed, Mar 27, 2024 at 05:17:04PM -0600, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> There are a number of variants of the imx258 modules that can not
> be differentiated at runtime, so add compatible strings for them.

But you are only adding 1 variant.

> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Luigi311 <git@luigi311.com>
> ---
>  .../devicetree/bindings/media/i2c/sony,imx258.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> index bee61a443b23..c7856de15ba3 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> @@ -14,10 +14,14 @@ description: |-
>    type stacked image sensor with a square pixel array of size 4208 x 3120. It
>    is programmable through I2C interface.  Image data is sent through MIPI
>    CSI-2.
> +  There are a number of variants of the sensor which cannot be detected at
> +  runtime, so multiple compatible strings are required to differentiate these.

That's more reasoning/why for the patch than description of the h/w.

>  properties:
>    compatible:
> -    const: sony,imx258
> +    - enum:
> +        - sony,imx258
> +        - sony,imx258-pdaf

How do I know which one to use? Please define what PDAF means somewhere 
as well as perhaps what the original/default variant is or isn't.

>  
>    assigned-clocks: true
>    assigned-clock-parents: true
> -- 
> 2.42.0
> 

