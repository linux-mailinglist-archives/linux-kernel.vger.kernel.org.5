Return-Path: <linux-kernel+bounces-123626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CFB890BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E9DB24EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9013B586;
	Thu, 28 Mar 2024 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHEYohWI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696F13B297;
	Thu, 28 Mar 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658819; cv=none; b=VY0xAx2Ri9o5mDQ+LBjv2daOCN+dXlUnwzpSbSyU/37X6SDqOIHd6KfHHonKcmCIhd4rlyzEYFZOlcZgLwwP4G/scGddRaLysd3plf4i1i89tqduEZfT15eLTw/MRgz2LdxoOCUzpsK8gvhWrkEYCBnXDVGEAO0Nw+RHuggFWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658819; c=relaxed/simple;
	bh=QQYVHiy+u+KBEmbQ6gpDQCtkUEA+z81/KyKlLgui3Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp10l29ACphLhzSjSH+vEjLkVrhJQ65eM4zoS+hyvf1DXXOGBI+vgp8h+sKy5Se6w9ENqs2e7UI+fv+Coju6+WZIehr/vWMwr14X1Kd8ud8eCVyGW9dQCxOE67G8QZYhfDfiiCDPJC1MId0V1AWMEv+czRT3lgKKnJL3z6lwSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHEYohWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C12C433C7;
	Thu, 28 Mar 2024 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658819;
	bh=QQYVHiy+u+KBEmbQ6gpDQCtkUEA+z81/KyKlLgui3Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHEYohWIooI/AM2MGCX5BanOCBSCRMl/Q4bnCRxGdQYgaVYEOi7Dq23527GyBIofb
	 ji2liTpRRZBw9JFIdsiraERfPx8L+rCvHR94DVg/+VngThRPwJFGfFfDb+Jpj6o/pt
	 p+LBt90HXly2fSFQz21npyk20qZpwlSO+x9eBB4n9r4tpxlEFlgtij1jNfuibFTtOC
	 BfjXQS+nXHFv0SU2K8z1Q7pD6LF+a2kw4G+qzQ+vNzHa4Fwto9CYgUdcB4UKBDcMgi
	 K7smeT5sYKFDVnxip/T4r+CiSGpF0xLQg+8DZtt3bKop0toKMz4zvEH3qfSF9aYJOp
	 R03jYi9O93eYQ==
Date: Thu, 28 Mar 2024 15:46:57 -0500
From: Rob Herring <robh@kernel.org>
To: Luigi311 <git@luigi311.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/23] dt-bindings: media: imx258: Add alternate
 compatible strings
Message-ID: <20240328204657.GA314523-robh@kernel.org>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-19-git@luigi311.com>
 <20240328185526.GA88354-robh@kernel.org>
 <76f999a7-55e0-4676-aa75-8fcd466e046b@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f999a7-55e0-4676-aa75-8fcd466e046b@luigi311.com>

On Thu, Mar 28, 2024 at 01:16:22PM -0600, Luigi311 wrote:
> On 3/28/24 12:55, Rob Herring wrote:
> > On Wed, Mar 27, 2024 at 05:17:04PM -0600, git@luigi311.com wrote:
> >> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >>
> >> There are a number of variants of the imx258 modules that can not
> >> be differentiated at runtime, so add compatible strings for them.
> >> But you are only adding 1 variant.
> 
> I can not speak for Dave but as to why this was added here but looking
> at the imx296 yaml that has something similar where there are multiple
> variants that may not be detectable at run time but does not include
> similar verbiage in the main description. Should I drop this from the
> description so it matches the imx296?

Just change "add compatible strings for them" to "add compatible string 
for the PDAF variant" or something.

> 
> > 
> >>
> >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >> Signed-off-by: Luigi311 <git@luigi311.com>
> >> ---
> >>  .../devicetree/bindings/media/i2c/sony,imx258.yaml          | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >> index bee61a443b23..c7856de15ba3 100644
> >> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> >> @@ -14,10 +14,14 @@ description: |-
> >>    type stacked image sensor with a square pixel array of size 4208 x 3120. It
> >>    is programmable through I2C interface.  Image data is sent through MIPI
> >>    CSI-2.
> >> +  There are a number of variants of the sensor which cannot be detected at
> >> +  runtime, so multiple compatible strings are required to differentiate these.
> > 
> > That's more reasoning/why for the patch than description of the h/w.
> > 
> >>  properties:
> >>    compatible:
> >> -    const: sony,imx258
> >> +    - enum:
> >> +        - sony,imx258
> >> +        - sony,imx258-pdaf
> > 
> > How do I know which one to use? Please define what PDAF means somewhere 
> > as well as perhaps what the original/default variant is or isn't.
> 
> Would it make sense to change the properties to include a description like so
> 
> properties:
>   compatible:
>     enum:
>       - sony,imx258
>       - sony,imx258-pdaf
>     description:
>       The IMX258 sensor exists in two different models, a standard variant
>       (IMX258) and a variant with phase detection autofocus (IMX258-PDAF).
>       The camera module does not expose the model through registers, so the
>       exact model needs to be specified.

Looks fine, but I'd move this to the top-level 'description'.

Rob

