Return-Path: <linux-kernel+bounces-13281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A08202E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30B61F22D04
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2914F6B;
	Fri, 29 Dec 2023 23:56:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD514F65;
	Fri, 29 Dec 2023 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F632FEC;
	Fri, 29 Dec 2023 15:57:23 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDA0E3F641;
	Fri, 29 Dec 2023 15:56:34 -0800 (PST)
Date: Fri, 29 Dec 2023 23:56:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Icenowy Zheng <uwu@icenowy.me>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module
 3H and Longan Pi 3H
Message-ID: <20231229235612.2c37e1fa@minigeek.lan>
In-Reply-To: <20231228145647.1470-2-jszhang@kernel.org>
References: <20231228145647.1470-1-jszhang@kernel.org>
	<20231228145647.1470-2-jszhang@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 22:56:46 +0800
Jisheng Zhang <jszhang@kernel.org> wrote:

Hi Jisheng,

thanks for sending this, seems to be on time with the release of the
hardware. Don't see that very often!

> Add name & compatible for the Sipeed Longan Module 3H and Longan PI 3H
> board.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 11c5ce941dd7..34d8ae484e01 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -835,6 +835,13 @@ properties:
>            - const: sinlinx,sina33
>            - const: allwinner,sun8i-a33
>  
> +      - description: Sipeed Longan Pi 3H board for the Sipeed Longan Module 3H
> +        items:
> +          - enum:
> +              - sipeed,longan-pi-3h

The picture of the SoM suggests that it cannot be used on its own, so
for anything usable we will always need both the SoM and some board.
Definitely we do for this board. So please follow the example for the
SoPine (or other SoM based boards), and just name all three names as
"const" items.

Cheers,
Andre

> +          - const: sipeed,longan-module-3h
> +          - const: allwinner,sun50i-h618
> +
>        - description: SourceParts PopStick v1.1
>          items:
>            - const: sourceparts,popstick-v1.1


