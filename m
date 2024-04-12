Return-Path: <linux-kernel+bounces-142761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4728A2FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DE0286CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1C84FDE;
	Fri, 12 Apr 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+HNrwRd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A478626D;
	Fri, 12 Apr 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929610; cv=none; b=EDUuY5qkDlkU/KPyYgy1p+hEJlL/dB54/I09+mYsbnUm/aiAtm5mHYHlxAtfdY2OVVf/Kp49hOxkSb/6C+HNJmmeV78hSCdoOhSwX2NJuxV+SkFTxfO3FGM3oHyKtR1PTDzF3Nl/rDL45WzvKTuL735LXp46XUNdPBL8OMwH0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929610; c=relaxed/simple;
	bh=0b2g4rJmJQJXZv5kIs4a/gjKaIcq92RCkUq9yE/1Q7M=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qQG3qlrRTUFpeIdvxLjMaHzLi/yvqeMdYzXDfipl1KbtI8Q26yPdRfNYmO1FoCTzNTyePA3oL4X9WZPme9ezjqfxNJK7YOgvKbtaDMNf3jKwvezsh70pYqOfERH6f6INnepA8hhM/sWe9lyKz8d/pZMnOu1robp0HaRc0JmhCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+HNrwRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3EEC3277B;
	Fri, 12 Apr 2024 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929610;
	bh=0b2g4rJmJQJXZv5kIs4a/gjKaIcq92RCkUq9yE/1Q7M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=E+HNrwRdSxCBgrY71qw9UqmkvHrMUMTkZDq3Sb/8gOnOrCXvHIS4w9Kbc+4x2uXv8
	 UMYLG9r/cPqvyjMCdMPzPapJ5s0gXYCY+TcwPK3RGM7XURkey6AR3v1bB6j+MBWApX
	 N9ERXqyWxSJYbNC/co50SkNVLVG7kfxr1pq8GZOkxquQpQnlED3QdOvexzlJhhoEmA
	 veoCSa8KhiEzXLZ4SYySg4GR3KJQT5xb/ZIbHc9pjYLDzI0v5kuUCK7331JMWGwmKh
	 7yepG/8IYTe6ubyYFCw5sNdVLpXpk43juCbq14uCR2ZQNow2Vo5mTPqd0EqFpfsV0p
	 tYtiFs3ZV6sTQ==
Date: Fri, 12 Apr 2024 08:46:49 -0500
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
References: <20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com>
Message-Id: <171292930790.2308782.11274555179735286990.robh@kernel.org>
Subject: Re: [PATCH v6 0/2] Samsung Galaxy Z Fold5 initial support


On Thu, 11 Apr 2024 18:51:29 +0200, Alexandru Marc Serdeliuc wrote:
> This documents and add intial dts support for Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
> 
> ChangeLog
> 
> - v6
>   . Moved Acked-by to the right  place
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
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
> Alexandru Marc Serdeliuc (2):
>       dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
>       arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 593 ++++++++++++++++++++++++
>  3 files changed, 595 insertions(+)
> ---
> base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> change-id: 20240411-samsung-galaxy-zfold5-q5q-00fac9d9faa7
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


New warnings running 'make CHECK_DTBS=y qcom/sm8550-samsung-q5q.dtb' for 20240411-samsung-galaxy-zfold5-q5q-v6-0-8142297515aa@yahoo.com:

arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: pcie-1-phy-aux-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#






