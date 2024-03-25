Return-Path: <linux-kernel+bounces-117920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F788B14B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1E1F65916
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCC46450;
	Mon, 25 Mar 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m68b8oji"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E03DABEF;
	Mon, 25 Mar 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398367; cv=none; b=JhNuSBJVdeFzvyqiNnY8GaPQI+Hdu4O0w403QoYKOf1ZesqxEoKKzhdO1/SXWu4lhFTmaxGpDcspRZ+7js+D+DOdIEZqZZ/Gg1uTIg+jXM0kupB3u9pp3dMJRRAARa0N7DHujMFmfWpoHIgO4vswJy7rbdWiMFs8K+mSW7iUU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398367; c=relaxed/simple;
	bh=ahuP5cTSDTyRzTCnReAUhrTSWcQzWcxEGNOUAM8m4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csCbaT240JXQWB8z+bY8RXK8v+ujiHo6Rbv5fc93xs1J2bIiaa+jW0lum+ge0m5VPy95qT5l0aXBnVkx1ryn8XWQWil4pPmcq4Nv+SDvtPBJLjpYK0CcShKLO2ftzEozqcUwbsnqIKrcGAE4thrqeDsmaJskflBKQiTHv4rHFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m68b8oji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6CBC433F1;
	Mon, 25 Mar 2024 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398367;
	bh=ahuP5cTSDTyRzTCnReAUhrTSWcQzWcxEGNOUAM8m4TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m68b8ojiqR+8PDZ6qymfh7FmaXvPADImGLtI2PXySB+KB0IaF7v+jYxf+LX5y4uFL
	 th0kQ3OykQe/xqFuAo03cMnWn4IkG0dpzXePKOWoecLeYgBvRSVvOdlCzXHP7RYFIA
	 l39E9QGRbFmEvZb9uagJeo9uKNiKIOJUoPuBuKGKjvvbP9iRGXpmMWXnAm/DRjG4p3
	 mq2jIhVLfRmYfCcAfJlpqmP7wvS8I/P+WEWYDACf3uZ87gEO8DTjOvMhYfKmCHrXVR
	 bsrnUejZ13MW4YJqGIWmgQ0jQ9geE3cNCVlW2U+0/M2ycpc3ekGPw/DFqBxPsoJtuB
	 +so7ZlFhX2qxA==
Date: Mon, 25 Mar 2024 20:25:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matt Ranostay <matt@ranostay.sg>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: health: maxim,max30102: add
 max30101
Message-ID: <20240325202551.08a8a877@jic23-huawei>
In-Reply-To: <b37af0e0-c707-48e0-980d-4866b9a662db@linaro.org>
References: <20240324-max30101-v2-0-611deb510c97@gmail.com>
	<20240324-max30101-v2-1-611deb510c97@gmail.com>
	<b37af0e0-c707-48e0-980d-4866b9a662db@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 13:18:14 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/03/2024 20:20, Javier Carrasco wrote:
> > The Maxim max30101 is the replacement for the max30105, which is no
> > longer recommended for future designs.
> > 
> > The max30101 does not require new properties, and it can be described
> > with the existing ones for the max30105, which will be used as a
> > fallback compatible.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/health/maxim,max30102.yaml       | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
> 

Thanks,

Series applied to the togreg branch of iio.git and initially pushed out
as testing to get it some build testing from 0-day.

Thanks,

Jonathan

