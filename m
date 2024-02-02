Return-Path: <linux-kernel+bounces-50543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECB0847A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EC61F2583C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CF8174B;
	Fri,  2 Feb 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvuEFcSe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64681733;
	Fri,  2 Feb 2024 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905548; cv=none; b=I1QoxcTiDZhm+ORtRQXku5KNDUYiHGtKRpdbgqKXrt8fFhuGtwMXVWBYkUxmFPoGdZll3LYHsFSBOwOb+YNhsJK//+4ZMo+DmhkzREHXhrgtJaof0GgLB17kKbNQJG3Uy0zHyL6qSIZA7o9RsWFRvEkwkFWGjOHxVjpJRH7wFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905548; c=relaxed/simple;
	bh=MxAY5Cr9y7y/S5/XsNbAVU3wBhUsOla7ylwsneRNvHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj8383eBWKrCo+NO0PmgDftdC0Ip/YBjiYDjDP2WsWdeXMFXoSocYJnp+t+7FsiRBMSl7L4VhsXnf7juLJf5YO12GRL7h2QdaILKSH/ET9KUh6wUCXdeDXA4JPVcApB1MIjaA9EdmTUHctkQMnUUsapSJX7nXTi/CeS/7f01xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvuEFcSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C772DC433C7;
	Fri,  2 Feb 2024 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706905548;
	bh=MxAY5Cr9y7y/S5/XsNbAVU3wBhUsOla7ylwsneRNvHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvuEFcSerMoxvaB1n89J940CgGMD9ZbGWrbU5KHXB6NaJQ+jZzmgg2xhE9x/GjOob
	 ihGS6Vqnv6/EqSbFnw8SKz7ZQyLX6BJELWJToO9XiyvIRCsO47pIv5+pWZSCCAWY0W
	 t96J4AvkyDEvPNsKwScqxJPYxhl0/fb6utAk9cG3k5uN/FNCmyRDk1gXh5EgDayATn
	 mzagtP0dFT+hiuPFwlAI5Pb67If5tkeaA9TiC8BtQRlQuQaOrz1Y3Zsw9VuY2Iigdt
	 c9OX+vyRmSWl0JFYs2FrR/OAh52So3r8ORVoMRu9RQr44jo5qZaVSOkXNj/er6FET6
	 HT/0b2o2GF1LA==
Date: Fri, 2 Feb 2024 14:25:45 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, michal.simek@xilinx.com,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sungbo Eo <mans0n@gorani.run>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	monstr@monstr.eu, git@xilinx.com,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] dt-bindings: gpio: gpio-pca9570: Add label property
Message-ID: <170690554482.1072178.3894093393921778859.robh@kernel.org>
References: <a8396308c995959349fd40e61199853a9b711ece.1706783050.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8396308c995959349fd40e61199853a9b711ece.1706783050.git.michal.simek@amd.com>


On Thu, 01 Feb 2024 11:24:20 +0100, Michal Simek wrote:
> Add a label property to allow a custom name to be used for identifying
> a device on the board. This is useful when multiple devices are present on
> the same board. Similar change was done by commit ffae65fb1ae4
> ("dt-bindings: spi: spi-cadence: Add label property") or by commit
> a53faa6bfa3b ("dt-bindings: hwmon: ina2xx: Add label property").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


