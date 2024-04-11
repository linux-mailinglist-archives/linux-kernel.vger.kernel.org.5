Return-Path: <linux-kernel+bounces-140558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7466E8A162C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158161F21ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F8152172;
	Thu, 11 Apr 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os45frAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4914D6F5;
	Thu, 11 Apr 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842948; cv=none; b=ACr73MGEPj/wFoXyHbiCzF2LYweKwxB6Uy5juqTljgGrt42mr6kIg0NIxvkHKS8FeKoh1KTyl40K38OOqvDiK9wVTn+kuphiDfNxBHBI6/RrtlKYmzqQWIpktTlUpJPn0c+JUbVbczJ1GXfnfzAcE52BbZ6OJGBPi4wraVVjCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842948; c=relaxed/simple;
	bh=9V6B2FO1AfQz7iRZm7KKOdCMjIz0pjVVA3oJL+1fQF4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=J+HWteeFLgkbWzB8QrjpVAUTE+ISZzW6sGCuHJWXMfMleUlIxrDzeCpBTxV9vs5AnUYxIIlonpRtGQRscVM8yvzrOSmdUnmSPkVsoNZCYEhwh3SXpjqQ2CIuZY9Nhw5qu3gLx1xyZsFiJmMb9G1WAthGQTcy4oF+0sO3LR9gKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os45frAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43270C072AA;
	Thu, 11 Apr 2024 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712842947;
	bh=9V6B2FO1AfQz7iRZm7KKOdCMjIz0pjVVA3oJL+1fQF4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=os45frAuxivL5UsqOsX4nD5FYkvM/2X1ZsSxyIUqlc7AuDOhSZWqJyGbYnfOSiO90
	 T2jZxaacChyTVSyDlq11VS7GMf2svoz9p2lPvGUqMZl0fC7SI8xYnKJDMA07Q2j3PX
	 0mKwZnm9AnbLjz3cvjQliddfwjNvyHUuxRTu95R1V+KQYZR/Exqc5D4wlFrtab/7Fk
	 9aZNU/Uw2BSpkqMxqigBAYeRCYdvPrfV/XlPcgtEmE7SjOC0GkY2z+VshzcV71heIu
	 LQhIC1RkZa/voGfaQtyI3pzcJLXjF7VCtu0Gg6+Fml8L8NI4garqzB2K3kK5+CiwBm
	 h90uWPp1TbuBQ==
Date: Thu, 11 Apr 2024 08:42:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
References: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
Message-Id: <171284284762.3456856.9357372275932519811.robh@kernel.org>
Subject: Re: [PATCH v5 0/2] Samsung Galaxy Z Fold5 initial support


On Wed, 10 Apr 2024 23:28:32 +0200, Alexandru Marc Serdeliuc wrote:
> This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
> 
> ChangeLog
> 
> - v5
>   . Added ChangeLog
>   . Added missing Acked-by tags in their respective section in ChangeLog
> 
> - v4
>   . removed a spurious new line
>   . removed pcie_1_phy_aux_clk as requested
>   . removed secondary pcie1 which does not exists on the device
>   . changed firmware extension from .mbn to .mdt
>   . added missing reserved memory regions required by firmware to properly load
> 
> - v3
>   . added b4 version 3
>   . removed address and size cells in device description
>   Acked-by: Rob Herring <robh@kernel.org>
> 
> - v2
>   . added both but added an extra v2 in the subject line instead to b4 subject header, was requested to send the patch again, along with following mods:
>   . removed whole bootargs line
>   . fixed underscores in reserved memory by removing all reserved memory regions
>   . added missing idetation to  spash_screen remark
>   . validated the dts with "dtbs_check"
>   . removed all comments at the end of nodes
>   . moved status of the node at the end of the node
>   . reversed pin control name with control numbers
>   . ordered the  nodes alphabetically
> 
> - v1
>   . The initial request was split in two patches sent due to the following checkpatch warning, was requested to re send them together:
>     WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>   Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
> Alexandru Marc Serdeliuc (2):
>       dt-bindings: arm: qcom: Document the Samsung Galaxy Z Fold5
>       arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 593 ++++++++++++++++++++++++
>  3 files changed, 595 insertions(+)
> ---
> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> change-id: 20240410-samsung-galaxy-zfold5-q5q-d31cdeeac09f
> 
> Best regards,
> --
> Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
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


New warnings running 'make CHECK_DTBS=y qcom/sm8550-samsung-q5q.dtb' for 20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com:

arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#






