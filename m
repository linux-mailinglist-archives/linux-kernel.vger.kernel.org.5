Return-Path: <linux-kernel+bounces-67005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F58564E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF74CB25228
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4113173A;
	Thu, 15 Feb 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoFIFb1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F912B144;
	Thu, 15 Feb 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004673; cv=none; b=ETABrmof6LTeTG1eow5865zkbFypiSDS4bXvytJpvfBPgdX0lb5lHnoOc5Yvajwx07p++dMALMqzHedVKr/Uyp7slhDL4kObXvj+nhYx+QMHxTjOjxbrv8redoCN32XO9DZ69urOriSJeSv2lII3D8TAUjHhXOlVnaELJd97IWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004673; c=relaxed/simple;
	bh=HKfR9ylXwCI1xaOSoIMnYxGSAZTtAAZJXYwyP3U/bBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A65bcOlcrf10trIwuuAqBGnvU1gL6/4zRkmt5m71m8oY6O7ZAAEOwDLLvq12K9vRG/ftLHJjpGbMfh1BspW5YHsbhbVJz1i+J2XT9xSF38aeLz85N3KRqe9zJ6LYEoiV1dfDkmu66mfVU3nzzCkbb5i2W9N2W2C73zkrw41WADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoFIFb1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D0C433F1;
	Thu, 15 Feb 2024 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004673;
	bh=HKfR9ylXwCI1xaOSoIMnYxGSAZTtAAZJXYwyP3U/bBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoFIFb1gfGpzhXLWHgopbqFUm54/XRWvj+EGtSeiX40FqFJ+fAmIP5zwI2aFOKRa/
	 SQTGvZJ58jU0qgqVV4lw+o/CcaeqUFovii3/As0PrLbnHbttjwnAGDaIS2HsKG+eaf
	 jrmqgxVFmPGvy0/ANDctHBjdZH+ZptvDDu6r2lnF78l1y8TptIEExgp+gN+hukfdVp
	 RPAkPrGF873g3oimQhHvhf2LhbRaVeaAKbrdet7lxvTWdcm2+/or9ROpULdFKCcsz+
	 9J2ZhiiPeRibTs9K9xS/EVi0/1p2TXF3HlHbEoj4Z/+PgTGnAd3dXgx3czILC5zBxr
	 zI1DuUZx6Tu+g==
Date: Thu, 15 Feb 2024 07:44:29 -0600
From: Rob Herring <robh@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	manisha.agrawal@ti.com, hnagalla@ti.com, praneeth@ti.com,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	conor+dt@kernel.org, aviel@ti.com, perex@perex.cz, pdjuandi@ti.com,
	linux-kernel@vger.kernel.org, tiwai@suse.de,
	devicetree@vger.kernel.org, tiwai@suse.com, mohit.chawla@ti.com,
	13916275206@139.com, s-hari@ti.com, soyer@irl.hu,
	broonie@kernel.org, jkhuang3@ti.com
Subject: Re: [RESEND PATCH v4 4/4] ASoc: dt-bindings: PCM6240: Add initial DT
 binding
Message-ID: <170800466884.4134047.16156792945843659627.robh@kernel.org>
References: <20240208114049.1429-1-shenghao-ding@ti.com>
 <20240208114049.1429-4-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208114049.1429-4-shenghao-ding@ti.com>


On Thu, 08 Feb 2024 19:40:48 +0800, Shenghao Ding wrote:
> PCM6240 family chips are popular among audio customers, in spite of only a
> portion of the functionality of codec, such as ADC or DAC, and so on, for
> different Specifications, range from Personal Electric to Automotive
> Electric, even some professional fields.yet their audio performance is far
> superior to the codec's, and cost is lower than codec, and much easier to
> program than codec.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> Change in v4:
>  - Rewrite the subject to match something similar to other commits.
>  - And none of them are compatible with something.
>  - minItems, then maxItems.
>  - Drop reset-gpios description
>  - Remove the repeated reg descriptions and reg constraints.
>  - Drop redundant spaces.
>  - Add missing line breaks between blocks and additionalProperties.
>  - Correct compatibility issue on adc6120 and pcm6240.
>  - All these chips have only a portion of the functionality of codec,
>    such as ADC or DAC, and so on, but their audio performance is far
>    superior to the codec's, and cost is lower than codec, and much easier
>    to program than codec. Simply one or two register settings can enable
>    them to work. Init for these chips are hardware reset or software reset.
>    As to some audio filter params for internal filters, it is up to the
>    special user cases, which can be saved into the bin file. The default
>    value also can work well.
>  - Add blank line before reg.
>  - remove unneeded items and if branches.
>  - Add missing compatible devices, such as adc6120, etc.
>  - Add necessary people into the list for DTS review
>  - correct misaligned.
>  - Remove dix4192
>  - simplify the compatibility
> ---
>  .../devicetree/bindings/sound/ti,pcm6240.yaml | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


