Return-Path: <linux-kernel+bounces-136975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7923C89DA8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0574CB22DC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4412FF95;
	Tue,  9 Apr 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmEoXxg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537012FF81;
	Tue,  9 Apr 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669918; cv=none; b=M6tKMmxPpLowSqtigEKL3we4Dty6F4KzVNIVIHlPCVJ92Kmy/lppWg9O/ctI0248iKe/yIeCx4SERqLaJdLS6HLlACfOa4g1qoqyx7b2gMTOrU7EJTKLF5pacu2vNXfHla+qXrJtbgwonFPqf7uvDgEEjReSLy8jsOtvbNq/4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669918; c=relaxed/simple;
	bh=LH2+MZ60zszRAlWofS4xHZNyYvkyDt5kHRdPGDl7eDg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VMvyZmCcfZu63sT7g03gJVQa2qLMRAxNzEn8WfIrdl2hFD7NTczkE4Bn3vp05ohSuBgU9ajc8ts6sUXhW0odkzn7fZY293Ty06iPwwFf2fqa/HCohHwQwpGj4RciYa+/3S5e8lMFLPWaICokUuXYjd/Otr+gUQw9TixZrE2b0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmEoXxg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607A2C433F1;
	Tue,  9 Apr 2024 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669918;
	bh=LH2+MZ60zszRAlWofS4xHZNyYvkyDt5kHRdPGDl7eDg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DmEoXxg3vjS6lYG2wOO/DN1hcJODw5Bzq6hdl5Q5Jq1SCYm2nv5cwXaS3A9AnKoD8
	 MVgZeFAhmLUd9aVnxZOL1Ya3BXj1wZB0fsQwZQFG6jq82HS6W4eIm2AkW8to9cddY/
	 6dvcmCrFWoAxAssNCjB7WUPy4fAc9Wjnm6tQYjP59TgD5UHXLhmWVs03WPDznLa+SK
	 YwTEYeRaippOoG0aIEEUViHWUJM99iWa7Ga4l/6pWqcFHSOHJhnyrXIZ6OG/0k45Zj
	 qH0HencCnuol3TUHj+LoZgeGvz6YZ8qhCZFsCchIvKUBj+/V60gaS97SVkQVuy8cDx
	 75JwJ1ScmB5Lw==
Date: Tue, 09 Apr 2024 08:38:37 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
In-Reply-To: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
References: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
Message-Id: <171266958251.1032405.3082451019333889181.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property


On Fri, 05 Apr 2024 08:46:20 +0200, Krzysztof Kozlowski wrote:
> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. None
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtmitchell.dtb aspeed/aspeed-bmc-facebook-greatlakes.dtb aspeed/aspeed-bmc-facebook-harma.dtb aspeed/aspeed-bmc-facebook-yosemite4.dtb aspeed/aspeed-bmc-facebook-yosemitev2.dtb' for 20240405064624.18997-1-krzysztof.kozlowski@linaro.org:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'mellanox,multi-host' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#






