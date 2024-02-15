Return-Path: <linux-kernel+bounces-67007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22D8564B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A254A1F213C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6A713173F;
	Thu, 15 Feb 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWI3RpXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8512FF7C;
	Thu, 15 Feb 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004719; cv=none; b=jjzG1PfnWK/LOlxEdSrlqyRK1mFEGIY0AjXXZ7P7t3cb/WbFe2XJKg6KIm3qW1/EEWOSVFMVnUMRzQbEPJUCfqdbAe1Nx+7Z5rLSOMLCL/vIBUUgv3l12n0tL7Oz7TNNg7pCAXP+q8v1ah1Etf3l8CxRS+dJcyHSgFXbSPdFjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004719; c=relaxed/simple;
	bh=tfwPW1BfqUnBwuV7ndvI9kwgLvCcwttcwLBgnVwDmKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtstF1mphlvL6PNBS+yBq7pMxc7j3ovmSNLFRHd/JBhKuc/LMqXCAtyYrPd6JTiF7fpnpeFQsVcVutP70aQ1kEJ5/2yKmRYXH4rWYkJ7mG+TCqoUAc0c5yZQj4Q+s6Gvhjq96dsDSdTChza2WyH7kZ0S5FpHUpMN7A87ZzWxP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWI3RpXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778EBC433F1;
	Thu, 15 Feb 2024 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708004718;
	bh=tfwPW1BfqUnBwuV7ndvI9kwgLvCcwttcwLBgnVwDmKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWI3RpXixCcJyvLLteIW3OOg5247DhQ3Ti8by7iDTz8kN5iRS7jpv+OnuzuqlV2w7
	 CgAi3pjaQyB5GwdSiv6CZlST3gSTM/aTrkfzZB/4FCXzJs5+BOLDVagaKWaDtdkuiQ
	 bFMdkPN0AecQvEln2yrB2BQQaUKnxsU+Oa9ynSlzoxN79ULt94K8xdavkBbzCSNp8K
	 vBmXehqIxnl+ues2Ghq+j+L/KwUhWFkqsy9X5waRncgxlUR8kwL+YXrIA4hBzYcxCg
	 Mr52olTxr1jHI1foUKnYJttry0Z1/Eqm7B6nOKQNyTiMz8qk15+e26jmsn5QT14TSL
	 0JDJIiezJcaHw==
Date: Thu, 15 Feb 2024 07:45:15 -0600
From: Rob Herring <robh@kernel.org>
To: Nayab Sayed <nayabbasha.sayed@microchip.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-tegra@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
	Richard Weinberger <richard@nod.at>, Han Xu <han.xu@nxp.com>,
	Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH] dt-bindings: mtd: update references from partition.txt
 to mtd.yaml
Message-ID: <170800471457.4134974.8222118532104907656.robh@kernel.org>
References: <20240208-partition-txt-v1-1-4398af3b7bb2@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-partition-txt-v1-1-4398af3b7bb2@microchip.com>


On Thu, 08 Feb 2024 17:12:12 +0530, Nayab Sayed wrote:
> Commit f902baa917b6 ("dt-bindings: mtd: Remove useless file about
> partitions") removed the file partition.txt. Hence, in this commit, the
> lines mentioning this file are updated to reference mtd.yaml, which now
> includes partition{,s}.yaml.
> 
> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
> ---
>  Documentation/devicetree/bindings/mtd/davinci-nand.txt        | 2 +-
>  Documentation/devicetree/bindings/mtd/flctl-nand.txt          | 2 +-
>  Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt        | 2 +-
>  Documentation/devicetree/bindings/mtd/gpio-control-nand.txt   | 2 +-
>  Documentation/devicetree/bindings/mtd/gpmi-nand.yaml          | 2 +-
>  Documentation/devicetree/bindings/mtd/hisi504-nand.txt        | 2 +-
>  Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt | 2 +-
>  Documentation/devicetree/bindings/mtd/orion-nand.txt          | 2 +-
>  Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt     | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


