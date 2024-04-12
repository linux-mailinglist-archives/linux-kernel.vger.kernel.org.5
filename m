Return-Path: <linux-kernel+bounces-142760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1338A2FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E6286778
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620D8625D;
	Fri, 12 Apr 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdX13nya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB984FDE;
	Fri, 12 Apr 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929608; cv=none; b=r6Euz3/32DIJqSXm/7TvnRudekNqeO2P3ountfP2rexpcUe3mxc4lXgNOoaXhLsTRdJWwNzxxbvsTrnBI3G5dX4HFyaQ7da8H1/5MmjyGI3stAXDGhUwEpT+dhPZ8AtiazC4ETPyVDsKRxe1NZtb9jg7PkjNXQ2Nxw14nz1eVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929608; c=relaxed/simple;
	bh=vEEY3AGinDnDeeuhInApNTJ4S0n7P2Anr3rVK7OzMyY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=a+YIJ+vsFS6hPlWFxpFDqy5HjiNr1H46qAl6Dlal+3oyy46BCevFar4uMVf77daqC6pqspQ6YtUtZ6MsX/9as3ij+arudUXgrsO9R7Z00uNrQZMtIJRTGzvJg3LdbBc0nx8cwvtysbgUHHh7v75xf8t29W27uAwH7K+6tvPmBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdX13nya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F8CC113CC;
	Fri, 12 Apr 2024 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929608;
	bh=vEEY3AGinDnDeeuhInApNTJ4S0n7P2Anr3rVK7OzMyY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SdX13nyaJMAR7xYET8O32p7aqARGsbRVpMIiihdbXibTVdkmx3q/2EG7WhzVuHS7m
	 Rndyx+5e39+PGJNwuQR6hqnZKoPq25yJ73FhpUs/ltqFEbPwdxWH1b71NIF2X1XZ54
	 ljfEmcSif9poArN2EyaMfX8nuKKZfBc30Ip/kkx3Xy35JydjE8UShWweo09MOCvhIp
	 l4PTO8k/lt64SNhv+tFZCiLhm+TyoIHa+qFVZnayCSqev+Eng08uKhUwS6XJ1TlvFy
	 LaC+9GKo65QSEBKaQ7ULE9Pg/CUaeH4QU7ZO2Oh/S60ZbpImp5Fx6RvOYW3d9N1pR5
	 czRjfFZmB/k2w==
Date: Fri, 12 Apr 2024 08:46:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Judith Mendez <jm@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
 Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20240411231130.386222-1-jm@ti.com>
References: <20240411231130.386222-1-jm@ti.com>
Message-Id: <171292930759.2308742.5353517001403145586.robh@kernel.org>
Subject: Re: [PATCH] arm: dts: am335x-evmsk: add alias node for uarts


On Thu, 11 Apr 2024 18:11:30 -0500, Judith Mendez wrote:
> The AM335x SK routes the PRUSS UART pins to the Zigbee header.
> PRUSS UART is enabled and can be tested using the Zigbee header.
> Since there are two UARTS, add alias node to be able to test PRUSS
> UART reliably from userspace.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm/boot/dts/ti/omap/am335x-evmsk.dts | 5 +++++
>  1 file changed, 5 insertions(+)
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


New warnings running 'make CHECK_DTBS=y ti/omap/am335x-evmsk.dtb' for 20240411231130.386222-1-jm@ti.com:

arch/arm/boot/dts/ti/omap/am33xx.dtsi:20.10-43.4: ERROR (path_references): /aliases: Reference to non-existent node or label "pruss_uart"
  also defined at arch/arm/boot/dts/ti/omap/am335x-evmsk.dts:32.10-35.4
ERROR: Input tree has errors, aborting (use -f to force output)
make[4]: *** [scripts/Makefile.lib:427: arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb] Error 2
make[3]: *** [scripts/Makefile.build:485: arch/arm/boot/dts/ti/omap] Error 2
make[3]: Target 'arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb' not remade because of errors.
make[2]: *** [scripts/Makefile.build:485: arch/arm/boot/dts/ti] Error 2
make[2]: Target 'arch/arm/boot/dts/ti/omap/am335x-evmsk.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1392: ti/omap/am335x-evmsk.dtb] Error 2
make: *** [Makefile:240: __sub-make] Error 2
make: Target 'ti/omap/am335x-evmsk.dtb' not remade because of errors.






