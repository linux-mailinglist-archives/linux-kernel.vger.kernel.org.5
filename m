Return-Path: <linux-kernel+bounces-110879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DE886524
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1341C21542
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517894436;
	Fri, 22 Mar 2024 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWdQxxhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA771396;
	Fri, 22 Mar 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073862; cv=none; b=UjEgzE45qnAPvwpFAGXKHpy8wHX6Y8MJ+hfBu2SRPeWgKmHliOJCbVMTjBpqiweVlhZ3DmT5fmY4A/5ybonOvsC5tZVM5J0XdoihzVEGwD+vlL9UryNxK90ig3zq4TZ/9OBOtrK0V7rSM13xfEc5mG+Ku3XpQv1aHGNBlF30BLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073862; c=relaxed/simple;
	bh=b3KFT+VyDIpm+tPl8Ceas4dzeaJGWnlNhgr2Sbub8qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFvpIY07HqTK/jqCcb7VYOaVeSS7G6fFdqGusAQt47rCzhHjBVuwo9TcUK6rWHMDKGuXx96t+2QZKVRGOb7F0ceTOc4lo6ybD5Ek71JDWrgwEodbFNH0N2jW8ZddkmlV831I48zE89ITcnxxCh9nygcEngaVsjj+4RbqBnf8edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWdQxxhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6481C433C7;
	Fri, 22 Mar 2024 02:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073862;
	bh=b3KFT+VyDIpm+tPl8Ceas4dzeaJGWnlNhgr2Sbub8qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWdQxxhjVeP3ytZhnvufek2SCCX3Q8KecK0+yjTtMqk9rmLpDDpnLcEYxTLug/isT
	 kqrtlwZgr/v8IXorzQTiaD0WKmsI00v2jAw9NweUj9M7vKcU2P16fYKQ/NF84oBqLw
	 6Cz1gA76LOl9+W2LPMssYAy/C6/B6qfBoKMlezctUZUrBJVzvqRKj9KqIBxq90ilxh
	 TRM/jcvkNQGIqyZ42+qgzF1FrxrMt6NuQtx2DH9D7VBJPJCrnf0s5UkTvp1FFZKlMJ
	 ES7IukISNnODy2x6O8JjsF3rostKL2wLkdKJAb4DEm/RS0HNSi5kzaOSqzcW8moTfn
	 5qxiDdJhNEzew==
Date: Thu, 21 Mar 2024 21:17:39 -0500
From: Rob Herring <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: adxl345: Add spi-3wire
Message-ID: <20240322021739.GA3418523-robh@kernel.org>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
 <20240322003713.6918-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322003713.6918-4-l.rubusch@gmail.com>

On Fri, Mar 22, 2024 at 12:37:13AM +0000, Lothar Rubusch wrote:
> Provide the optional spi-3wire in the example.

That doesn't match the diff as you don't touch the example. But really, 
this should say why you need spi-3wire.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 07cacc3f6..280ed479e 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -32,6 +32,8 @@ properties:
>  
>    spi-cpol: true
>  
> +  spi-3wire: true
> +
>    interrupts:
>      maxItems: 1
>  
> -- 
> 2.25.1
> 

