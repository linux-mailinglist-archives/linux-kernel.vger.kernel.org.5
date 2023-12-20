Return-Path: <linux-kernel+bounces-7006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A7F81A075
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147961C22D75
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9117438F8D;
	Wed, 20 Dec 2023 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgA9jFD5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F938FAE;
	Wed, 20 Dec 2023 13:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA80C433C8;
	Wed, 20 Dec 2023 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080708;
	bh=siuPVaQbyp9Y+DByvHYZF7aijD5vvRxGyIuV/JOPGN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgA9jFD5LL9kzW35wjHfO1U3CHYJw9R2Jft5l4/Wt57hFkdnWw7aXEgLRTjjJzhqJ
	 mhfLBCpI0Y54M6Lg5boqQpRylW9xx4yC84/MOfVDEWctvaQG7B/A3oZdonxQltyDBJ
	 UPsAoLQOLiP3VogNXjIfbzBhNO0y7b77eiQzRZU6pEHgMECZBavQhhVxE+7fnIjglW
	 As6IK8oL1WBTvpEnN+L1s61ZDS3JRfFzEFw2Voh/wmy8BrbI+4vVnfjvWlTVMbO0Qr
	 1ynjAVjlSD9lKwrMGG/xX6lg6wKqynZYIqgtPHta8W/z88wIkk1Plh5awJWRPXa6Nr
	 /+rVQAEX/qjqg==
Received: (nullmailer pid 116540 invoked by uid 1000);
	Wed, 20 Dec 2023 13:58:26 -0000
Date: Wed, 20 Dec 2023 07:58:26 -0600
From: Rob Herring <robh@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Shuah Khan <skhan@linuxfoundation.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: dac: add MCP4821
Message-ID: <170308069917.116385.808780928089948753.robh@kernel.org>
References: <20231219090252.818754-1-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219090252.818754-1-anshulusr@gmail.com>


On Tue, 19 Dec 2023 14:32:50 +0530, Anshul Dalal wrote:
> Adds support for MCP48xx series of DACs.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf #MCP48x1
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf #MCP48x2
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> ---
> 
> Changes for v4:
> - Removed 'Reviewed-by: Conor Dooley' due to changes
> - Renamed shdn-gpios to powerdown-gpios to conform to
>   gpio-consumer-common.yaml
> 
> Changes for v3:
> - Added gpios for ldac and shutdown pins
> - Added spi-cpha and spi-cpol for the SPI mode 0 and 3
> 
> Changes for v2:
> - Changed order in device table to numerical
> - Made vdd_supply required
> - Added 'Reviewed-by: Conor Dooley'
> 
> Previous versions:
> v3: https://lore.kernel.org/lkml/20231218164735.787199-1-anshulusr@gmail.com/
> v2: https://lore.kernel.org/lkml/20231217180836.584828-1-anshulusr@gmail.com/
> v1: https://lore.kernel.org/lkml/20231117073040.685860-1-anshulusr@gmail.com/
> ---
>  .../bindings/iio/dac/microchip,mcp4821.yaml   | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


