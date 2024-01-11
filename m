Return-Path: <linux-kernel+bounces-22933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C982A5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D6CB2222E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461DA44;
	Thu, 11 Jan 2024 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/t62/y/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528A28F6;
	Thu, 11 Jan 2024 01:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F36EC433F1;
	Thu, 11 Jan 2024 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704937485;
	bh=OKRetjGQLoWiGsYECHl6Shr/8v8FXWaRDdGGxsatbvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/t62/y/fhs/K+heY9fWtwp1kCVF2DvLy/cZIEF7iZ/cNqSLljWc6zDn10SE2+vdJ
	 KULsW1Ge8PVRfNZ8YxO14LeLJKyXNLGO9LcmMXydclLLw4myJHWE6adXoR3XhL8cFp
	 F7isooQIwd8SW/PLq6UTKdyfr9Cn/ANhPbXWYCE4OZSDypGMSoZ4ERcyR0Bi3a0+nr
	 OupwgC32DaJ8ardK/qLN0/qNWhS3SOlg+jcBXElhxCmvXLZG/9ZD44pWQwbL/8kbpN
	 OBCYRyqfQAT4n9EtdYINcOAS5Eo9/B7Zv8xs5TM2MyGIJ8MvCG/XWqQO8BrZUIO5zu
	 Nb0ImccpGczng==
Received: (nullmailer pid 3159538 invoked by uid 1000);
	Thu, 11 Jan 2024 01:44:42 -0000
Date: Wed, 10 Jan 2024 19:44:42 -0600
From: Rob Herring <robh@kernel.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: narmstrong@baylibre.com, neil.armstrong@linaro.org, clabbe@baylibre.com, herbert@gondor.apana.org.au, davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com, artin.blumenstingl@googlemail.com, linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v1 16/24] dt-bindings: crypto: meson: add new compatibles
Message-ID: <20240111014442.GA2984286-robh@kernel.org>
References: <20240110201216.18016-1-avromanov@salutedevices.com>
 <20240110201216.18016-17-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110201216.18016-17-avromanov@salutedevices.com>

On Wed, Jan 10, 2024 at 11:11:32PM +0300, Alexey Romanov wrote:
> Now we can use crypto driver at G12A/G12B/S4/A1/SM1/AXG.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../devicetree/bindings/crypto/amlogic,gxl-crypto.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> index 948e11ebe4ee..317003505510 100644
> --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> @@ -13,6 +13,8 @@ properties:
>    compatible:
>      items:
>        - const: amlogic,gxl-crypto
> +      - const: amlogic,g12a-crypto
> +      - const: amlogic,axg-crypto

You need an 'enum'.

>  
>    reg:
>      maxItems: 1
> -- 
> 2.30.1
> 

