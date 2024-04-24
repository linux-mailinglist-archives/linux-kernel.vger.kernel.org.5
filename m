Return-Path: <linux-kernel+bounces-157766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C38B15D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AA41F22FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD615FCF9;
	Wed, 24 Apr 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApFuSyjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80744745CB;
	Wed, 24 Apr 2024 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996581; cv=none; b=leZg3Tshnp4HZ1OgFb5glIFRGxX2AtDvLhcKyna4iVtDkhhsyEOqGW1gYDWHTGDdVu15GYsmyNcn0MEQTxJylpEmeCWfJc63iN5v9C/9y3EU9ZrFyQPz9KHIEGGQsDNj08TnH9CfOcb3cS/FK9V4wtApQRMjFm/Ue6fDaZS2ehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996581; c=relaxed/simple;
	bh=ExYTNrxfugrhIWVYfNvtgskoCvyzSUXyHaRHNzgT6cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXqrou8VPk/qIema3zI3/Byydz2tMPVYGuLDVKUAGBvxJzycY0waAWsRQeOLW+olZKNPjewuBjrPw+ptSa+Dy08Q3bF+AFyYH9u5unF5SnorfWCdpr1Oc6H08TOU8aRykqZT3JMkLhz2uG15gqY4O+aVZiBkSSEYi45rb1S1+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApFuSyjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238BBC113CD;
	Wed, 24 Apr 2024 22:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996581;
	bh=ExYTNrxfugrhIWVYfNvtgskoCvyzSUXyHaRHNzgT6cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApFuSyjNVPdocS/7StT99K5TtfZqnnwZQegHWaTaixUwynKV5imy4C98u+3EFQPfU
	 WtHQVF551P8TlCqbX+xqG/EMnr+0yHvatoFkT635hS2mj56TyfPt4xhLcJRdGJZuiI
	 c+dYKK4XDdsmUtMcUiKKKKaC0OtrZFzAnJCMwucDRWXl3zQoATpNpGIViIKIOqxPEb
	 JY3/tNENaCojjthoYJL2w+DD9gpm7Rt50lTxuseZ3C41nTU0eBnxSqKO+atnry9aUD
	 /5Nj8q3y+Xbu6+LT8Zej/5l+ai+loBG47wsY8s77knRaCCpUAUIH4r8J9eFfFiMr5s
	 TDuqu7oRUGlog==
Date: Wed, 24 Apr 2024 17:09:39 -0500
From: Rob Herring <robh@kernel.org>
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add Blaize vendor prefix
Message-ID: <20240424220939.GA796655-robh@kernel.org>
References: <20240424133124.19101-1-nikolaos.pasaloukos@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424133124.19101-1-nikolaos.pasaloukos@blaize.com>

On Wed, Apr 24, 2024 at 01:31:28PM +0000, Niko Pasaloukos wrote:
> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
> programmable Graph-Streaming-Processors for AI and ML.

Something is wrong with the threading of your series as lore only gives 
me this patch. It looks fine, but I need to see the user. Maybe that's 
next up in my queue...

> 
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index b97d298b3eb6..746ff14028d1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -214,6 +214,8 @@ patternProperties:
>      description: Shenzhen BigTree Tech Co., LTD
>    "^bitmain,.*":
>      description: Bitmain Technologies
> +  "^blaize,.*":
> +    description: Blaize, Inc.
>    "^blutek,.*":
>      description: BluTek Power
>    "^boe,.*":
> -- 
> 2.34.1
> 

