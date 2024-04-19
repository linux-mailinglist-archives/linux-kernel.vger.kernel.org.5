Return-Path: <linux-kernel+bounces-151974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7888AB680
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1157B22B41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF713CF8F;
	Fri, 19 Apr 2024 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqH218oU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4D10A2C;
	Fri, 19 Apr 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562524; cv=none; b=ZKpSkws6pM6iPSDpYx5XmR/CXqAvzmGTJBjeRoL5ZC4IpYiA6c53atUQJ6PMoihcn6NAgFSZjcx9ZwciJeBZNwS1oRTUUlqQecxZ2angq1YZqmjOf1CzjO0NB+Q77uimmLctds8UxJZScX4nQgDNezrPcrMcbohh7sx+Wa1tBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562524; c=relaxed/simple;
	bh=Cim0Tyqolfxy+LOtbTAAC3Ubb/9MUSjLwoRbLfKcucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReK3mHiTsD7WSmsMeVEpArUQMm9LXwRXBskSVwYQsDRjq4+cdFmw1suvUnd4enY6aZOJcAcqrv+FQ93yG8bGA8kFctoMQzlJNsfRmVGmDOklnQL8vlVqiQ7FVzqT9vcjRjXbEImiwXpoqrkdd0h+O43yBGo8nD1VeXx54uIg3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqH218oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2388C072AA;
	Fri, 19 Apr 2024 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713562523;
	bh=Cim0Tyqolfxy+LOtbTAAC3Ubb/9MUSjLwoRbLfKcucE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqH218oUR4+i+YduXc5KRDlATnCmUPtG6jeYE2RRlCU1eARNLBH7b+EKLNf9Wn+GS
	 WWGPJZT1SZuBfh5pNgMjuLYIb1UbpdGFii4KBUWU1msCHa7FZfieYHI0o1Oujd1PD/
	 y4kP69faY5eDIB99HTcRsbtDr/uNIqYb2e0+PJtixzvM/ulfUxaFfVD5C2oZ+wk234
	 x/w4UGvOnfGAOvh3bdE7se9sIAqaHqJJJk4lqvUCXOikf8EmaApK73SRxvcuSPBjFZ
	 F0TmJq+AyGtr51aH6AmQd6i2kFSumcfYJ4dlExL2D2YrLGn3BdAonkaqiheLTx13Sw
	 pEaYiL+R4ks/A==
Date: Fri, 19 Apr 2024 16:35:22 -0500
From: Rob Herring <robh@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: lars@metafoo.de, nuno.sa@analog.com, krzysztof.kozlowski+dt@linaro.org,
	linux-iio@vger.kernel.org, dlechner@baylibre.com,
	fr0st61te@gmail.com, schnelle@linux.ibm.com,
	marcelo.schmitt@analog.com, jic23@kernel.org,
	alisa.roman@analog.com, michael.hennerich@analog.com,
	Michael.Hennerich@analog.com, broonie@kernel.org,
	linux-kernel@vger.kernel.org, liambeguin@gmail.com, andy@kernel.org,
	marcus.folkesson@gmail.com, conor+dt@kernel.org,
	okan.sahin@analog.com, alexandru.tachici@analog.com,
	bigunclemax@gmail.com, devicetree@vger.kernel.org,
	lgirdwood@gmail.com
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: adc: ad7192: Add aincom supply
Message-ID: <171345095317.1580567.3159667531123907836.robh@kernel.org>
References: <20240417170054.140587-1-alisa.roman@analog.com>
 <20240417170054.140587-3-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417170054.140587-3-alisa.roman@analog.com>


On Wed, 17 Apr 2024 20:00:51 +0300, Alisa-Dariana Roman wrote:
> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseduo-differential operation mode. AINCOM voltage represets the
> offset of corresponding channels.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


