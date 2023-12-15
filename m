Return-Path: <linux-kernel+bounces-1618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E08150F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024B728B595
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822245BF1;
	Fri, 15 Dec 2023 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL47riGq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AC45BE1;
	Fri, 15 Dec 2023 20:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CBBC433C7;
	Fri, 15 Dec 2023 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702671207;
	bh=2aQpiRMUO5mKDGzE4xyj7tJtF9LOPT20cXF2V9JmSQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UL47riGqVV/oojx2TocuGK2kRpF5mrZqYx4KQHXyDQJwdcNuc01DIgIrVvaryc4ih
	 d4OLUrunn9tkbuIuAQpBLBw8eP9doIMmGlvH1HBTLfP8rsdZcQu/mxFwWJJJaiT+Oi
	 RbdamAqS8Pg0cIs6JqKhl86wntnZEZw34rqO645v8BmTf+4dW9X2FxTgReuPg7pkKJ
	 9KZKi5aQJM9zsw4YYmENPDsEUBI2hmFocWZJgM5IlKqlndPGhoHsNogsvN4ghhuG77
	 i7pGmlR9GtGVAbvbfILwkuX/gJZ/aSO8BgOp0ia3nB3eRWe/mrqww6yj901PAebZ9k
	 V2JZUOU+vr3tA==
Received: (nullmailer pid 317463 invoked by uid 1000);
	Fri, 15 Dec 2023 20:13:24 -0000
Date: Fri, 15 Dec 2023 14:13:24 -0600
From: Rob Herring <robh@kernel.org>
To: efectn@6tel.net
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, sebastian.reichel@collabora.com, jonas@kwiboo.se, Muhammed Efe Cetin <efectn@protonmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: rockchip: Add NanoPi R6 series
 boards
Message-ID: <20231215201324.GA315671-robh@kernel.org>
References: <cover.1702647349.git.efectn@protonmail.com>
 <b74f5b91693d9b1ec525fb22e06c0a8311c7cf05.1702647349.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74f5b91693d9b1ec525fb22e06c0a8311c7cf05.1702647349.git.efectn@protonmail.com>

On Fri, Dec 15, 2023 at 04:55:21PM +0300, efectn@6tel.net wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 

Commit message missing. Perhaps some detail on what r6c is vs. r6s.


> Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index ee92f0535..07c4eb828 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -225,6 +225,13 @@ properties:
>                - friendlyarm,nanopi-r5s
>            - const: rockchip,rk3568
>  
> +      - description: FriendlyElec NanoPi R6 series boards
> +        items:
> +          - enum:
> +              - friendlyarm,nanopi-r6c
> +              - friendlyarm,nanopi-r6s
> +          - const: rockchip,rk3588s
> +
>        - description: FriendlyElec NanoPC T6
>          items:
>            - const: friendlyarm,nanopc-t6
> -- 
> 2.43.0
> 

