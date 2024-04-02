Return-Path: <linux-kernel+bounces-127789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B47895102
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E78B23B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5F5FDDB;
	Tue,  2 Apr 2024 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VNu7cS6I"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F6605BA;
	Tue,  2 Apr 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055396; cv=none; b=qCvLL8SxaWToRjG8DYTaWnzPdG1CV5VwwTN4/foX1P1FL10recUxnlPIu5mL/02yZsCn+SrAbr/RRgVPJ6tUHtwy77oVaMkxHvgarJJlNlc4w3yDtxcPxPGi8UbQkfMs69BYFO4pY87PIFAj/fujeI+4D0Gch6q0O82R9P0zlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055396; c=relaxed/simple;
	bh=ZsQBIyXKKSheuF7mF3S6XPB3YrTCv+P0r+MuG3O/sww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/px1oBa4HdlOGejlsfOQhSUM+BPuT0Pk80fQxbnC+kKx1pxn/08QgT6LmkzzDvHuWGk8OdGO+GII6+n2DoppJiiQ9iUDSQLmRAYI8k99oZspy2G01N1/Y+m7zI7r16CKp7Kdz18eLlg9hEECe+Qi1kl0H4zzpC96u4ymmDtTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VNu7cS6I; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=HL6yYIAfmTq4orQz8KSraMu08Ey5PkjYaek7rExViLg=;
	b=VNu7cS6INVdcwM+6pNaYKAjz3A2GHUDmyqhZWbK0VIuHzo3qOD2TYP6ttmW+WW
	5G48e74VnTMRoqYxj503QRPPyOYOO2x1V4SqFTj2ev6EzArNOowif4jDTu27L7hS
	Or5iqK9IVHUewtXmEY/uHA73Qu626ycrTUftGDkl05PNk=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAD3HyBE5AtmXiWkAQ--.64379S3;
	Tue, 02 Apr 2024 18:56:05 +0800 (CST)
Date: Tue, 2 Apr 2024 18:56:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock
 order
Message-ID: <ZgvkRFxkNzQ2Z8re@dragon>
References: <20240322164706.2626088-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322164706.2626088-1-Frank.Li@nxp.com>
X-CM-TRANSID:ClUQrAD3HyBE5AtmXiWkAQ--.64379S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1rZr43Aw4DJryfAFWrKrg_yoWkKwb_Xw
	18Xrn5KFZrurZayF95ArWxu3y8K3W7Ar1UJas2yr4xXF98G3yUCr1UJ3yrurn8WFnFqws8
	AF4DJrWkJryS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0kwIDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQe0ZVszXX2VXgAAsY

On Fri, Mar 22, 2024 at 12:47:05PM -0400, Frank Li wrote:
> The actual clock show wrong frequency:
> 
>    echo on >/sys/devices/platform/bus\@5b000000/5b010000.mmc/power/control
>    cat /sys/kernel/debug/mmc0/ios
> 
>    clock:          200000000 Hz
>    actual clock:   166000000 Hz
>                    ^^^^^^^^^
>    .....
> 
> According to
> 
> sdhc0_lpcg: clock-controller@5b200000 {
>                 compatible = "fsl,imx8qxp-lpcg";
>                 reg = <0x5b200000 0x10000>;
>                 #clock-cells = <1>;
>                 clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>,
>                          <&conn_ipg_clk>, <&conn_axi_clk>;
>                 clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>,
>                                 <IMX_LPCG_CLK_5>;
>                 clock-output-names = "sdhc0_lpcg_per_clk",
>                                      "sdhc0_lpcg_ipg_clk",
>                                      "sdhc0_lpcg_ahb_clk";
>                 power-domains = <&pd IMX_SC_R_SDHC_0>;
>         }
> 
> "per_clk" should be IMX_LPCG_CLK_0 instead of IMX_LPCG_CLK_5.
> 
> After correct clocks order:
> 
>    echo on >/sys/devices/platform/bus\@5b000000/5b010000.mmc/power/control
>    cat /sys/kernel/debug/mmc0/ios
> 
>    clock:          200000000 Hz
>    actual clock:   198000000 Hz
>                    ^^^^^^^^
>    ...
> 
> Fixes: 16c4ea7501b1 ("arm64: dts: imx8: switch to new lpcg clock binding")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


