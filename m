Return-Path: <linux-kernel+bounces-104593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5353487D0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98351F225D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D53FB1D;
	Fri, 15 Mar 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ5ABuXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0F210E8;
	Fri, 15 Mar 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517837; cv=none; b=RXey2WH1Ji3P04ZEUqFLDMz9K/F3lu6QuB1T8wNZ/w4typX9fFIc+MFKpnq5QZvtLc7H5nVaOksE7IA05G45yPE5Nk29t2QkNkvI4SnPBasll9OIMbiNx1KTrIgUuEuTL49FxC+DD99kgCAVpP4K/OIV78zjIz9YfJe63yL0u1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517837; c=relaxed/simple;
	bh=xVuAaUPdip4/3/PGOSlC8sQofYGfDMYAqbhEVwHY4y8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=cyM+XButrzsolxBhfxa8mkVgq0VW7JiWyUF4jswIn+FJm7W3RofceSwWaHWBwz8L6HaZlo2AIAAOxVU3xfhpe8U7i0lHSgoZRLFYFpL7f7sw07Qew31maZAZp/NGXueaVWyT2GfUVFN4lrwO09uSs5/UVKWDHFyfrw67IqEkdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ5ABuXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662B4C433C7;
	Fri, 15 Mar 2024 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517837;
	bh=xVuAaUPdip4/3/PGOSlC8sQofYGfDMYAqbhEVwHY4y8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UQ5ABuXtb6Aui9fKOITdM2oNJcgpnvut9cnqqwJpCF0U0Av8WiXbnG/jtREjsiLtY
	 8pGv/H3dwrt86EhqnZ+sZEt4HZPaJCcbUOGxx/D6nfyKN3dxzcdDxETLZEU3CORL5d
	 ba/cYFwkMhBGIHObWOJVJsBbWQjPJxZHBITqx+HwT8nTckQ/4TJVJ+km1ORMMD40rp
	 w3GjkWVUAy/47IxftHgzElD9k2jUZdjyOYm0fRV+iPO2HbiSWYoyWfcD7v6lAjOvtf
	 gTTIQoVnc6Orsb4MXNzedo8YZhNAA0VNfFkG+plMMV4W4qrv5/T0khgRAXQif0DTQy
	 PEPt/EjExo7BQ==
Date: Fri, 15 Mar 2024 09:50:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
In-Reply-To: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
References: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
Message-Id: <171051663090.1379808.10191493054068044105.robh@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: fsl-lx2162a-som: add description for
 rtc


On Tue, 12 Mar 2024 20:56:53 +0100, Josua Mayer wrote:
> Add description for an on-som rtc that was missed in original submission
> of device-tree.
> 
> Also update the clearfog reference carrier board aliases to include the
> previously disabled i2c bus with this rtc.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Josua Mayer (2):
>       arm64: dts: fsl-lx2162a-som: add description for rtc
>       arm64: dts: fsl-lx2162a-clearfog: add alias for i2c bus iic6
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts | 1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi  | 9 +++++++++
>  2 files changed, 10 insertions(+)
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240312-lx2162-rtc-a68b6ebfcb53
> 
> Sincerely,
> --
> Josua Mayer <josua@solid-run.com>
> 
> 
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


New warnings running 'make CHECK_DTBS=y freescale/fsl-lx2162a-clearfog.dtb' for 20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com:

arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dtb: i2c@2050000: Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/i2c-imx.yaml#






