Return-Path: <linux-kernel+bounces-109110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6B8814C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C441C22218
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239465337F;
	Wed, 20 Mar 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY37uWiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444439AF4;
	Wed, 20 Mar 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949251; cv=none; b=c9U1NPns2BVHHTiQnMXvdnY0azH2kPqq2PyggBRzSIufee49BQjV/ucQr7ElY++XqiIQlIVJZZiiFMesyBfTUmo+2wPaaGsO9UVKITO6i0zGI/0+6qKCtMJR1wMMk3mhFN8ZI4WlhiAsLZwlO77+Uxar1o1+2XrRQLhk3c8myBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949251; c=relaxed/simple;
	bh=KlXhLA7jIC561PndfhSf5vnkReqlBqG0xxTFqREv5dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+sPKKEFJdwGX7gUtP9Th9KzVzc7YJQkkEET44A82nMPqIeZkl8u8dQe5SW2zmTPv/u2VxDZ/WIeqvxgR+Ah2qMIRHauQJ8prHnVksGLGDfmcKqD6HOlTBztr7L/bmGRYr2GsJJSjqfqD4nGpOnR1y4xuEU9Mfr3A0idYkc/oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY37uWiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF305C433F1;
	Wed, 20 Mar 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710949251;
	bh=KlXhLA7jIC561PndfhSf5vnkReqlBqG0xxTFqREv5dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jY37uWiqccKwyj18FIwjJkrXWW35vH2u+7rWTyhP/OGKf7P6TEtT+696WF989/cmj
	 kbVLQ9v1N+g0OpW6EwZ4bD7ytJwkhuMXJ0MNfk+INVj/8KkzA8y0T6wSvenVT/UGn6
	 t//2ht6oFHVqHZufIv1ORUPpSqnMQsj+zztLBjkhbtVs4BFHWzOiHnz80RNUhOMMUL
	 odmRPmh5tSCWi35gd/3tNJdU+fxqUbLobDIppOAKWNYmrYEHLOsZiw/HpNNCvCzJo4
	 QqIhR3Qkuim8RBkGl7WcjqDv9ynfdfP4elOhpl0cslA00gTGdMZzFknKndW4vu3BHb
	 Z8Za8tp1lnVJA==
Date: Wed, 20 Mar 2024 10:40:48 -0500
From: Rob Herring <robh@kernel.org>
To: Manojkiran Eda <manojkiran.eda@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	patrick.rudolph@9elements.com, chiawei_wang@aspeedtech.com,
	ryan_chen@aspeedtech.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	conor+dt@kernel.org, vigneshr@ti.com, richard@nod.at,
	openbmc@lists.ozlabs.org, joel@jms.id.au,
	krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
	jk@codeconstruct.com.au
Subject: Re: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
Message-ID: <20240320154048.GA1777957-robh@kernel.org>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>

On Wed, Mar 20, 2024 at 03:29:15PM +0530, Manojkiran Eda wrote:
>    On 19/03/24 3:26 pm, Krzysztof Kozlowski wrote:
> 
> On 19/03/2024 10:34, Manojkiran Eda wrote:
> 
> This commit adds the device tree bindings for aspeed eSPI
> controller.
> 
> Although aspeed eSPI hardware supports 4 different channels,
> this commit only adds the support for flash channel, the
> bindings for other channels could be upstreamed when the driver
> support for those are added.
> 
> Signed-off-by: Manojkiran Eda [1]<manojkiran.eda@gmail.com>
> ---
>  .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yam
> l
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Doc
> umentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
> new file mode 100644
> index 000000000000..3d3ad528e3b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
> 
> Why Rob's comments got ignored?
> 
> This is not a soc component.
> 
>    I did not mean to ignore, i have few reasons listed below that provides
>    information on why i felt this belongs into soc.

Fix you email program to not send multi-part (txt plus html) emails. 
Plain text only on maillists.

Rob

