Return-Path: <linux-kernel+bounces-158744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09CA8B2462
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614141F21BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6C713328D;
	Thu, 25 Apr 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3e04xv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9B14A624;
	Thu, 25 Apr 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056685; cv=none; b=sWXAtEdg8KqhwF9ta93IWfR+r2gA+9LMAH2vpev2wJ5H46bz/V5i2YUga0B2QMyOCY97OMbDFTqCFBNKQVzEYqvPbq5dmOIrhcwOJGOlgM4voVgl4ZwDD+dDmr8VcNSdDCJvdC03sRtVEV4OCF9q6e6RDuFrUbRCJn5QfXBgYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056685; c=relaxed/simple;
	bh=P2mk7nyyi8UvY51MHZtyDTzjLJjSyIC/5T5tNcr+NkI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=U/GvPviOQTGXba+5Fwlym6KsEKkThCaQyIqEmWYTR7Uc8ohAgkUls0ZswoefjMOReB1uHOvfH0mW9ykscOStWldwDLmQNZi6PVMj6QSZ7OnpfppR3Ll2UMZQHcjBschaAeiGRDrqqB+oVDA6We6iuBGEyBcQGRYhyvWRrQyEkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3e04xv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B52AC113CC;
	Thu, 25 Apr 2024 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714056685;
	bh=P2mk7nyyi8UvY51MHZtyDTzjLJjSyIC/5T5tNcr+NkI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=g3e04xv0CftiDxpbh8XI9eUu8/886J+OSBHKAmlqmxBvW8T6xpULET2oJNhBm2Hi2
	 j7Pank9rO0KnuNbHIVoTsv7b3aFO8rAlWeFIKBZrm8R/k1zfOeusCDf2xDbykdQRh5
	 zFrVH4+YJmnMWKFSB6U2+13bNYcUDzg+4Xn+uJhyiawYpVJPZbGUbeC/6MXrzLN3FQ
	 Q0MWCLwXbSD+b+5aVBmHwGJ7bKSkkVECRbQAYt1MrshzvZgG4j8MIHKDzGXI3sR4ih
	 rNMHxR7lFdKds9XuLbKLYNB82nzlby2JQAE+MMDjkR5qoqs7npbBWcxQ1E59Lxd698
	 4QX/qGGFZ4IXw==
Date: Thu, 25 Apr 2024 09:51:24 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Venkata Prahlad Valluru <quic_vvalluru@quicinc.com>
Cc: quic_nankam@quicinc.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 quic_abhinavk@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240425071354.GA12900@hu-vvalluru-hyd.qualcomm.com>
References: <20240425071354.GA12900@hu-vvalluru-hyd.qualcomm.com>
Message-Id: <171405653305.2527744.3813895380659072690.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: enable hdmi bridge


On Thu, 25 Apr 2024 12:43:54 +0530, Venkata Prahlad Valluru wrote:
> Enable lt9611uxc bridge for qcs6490 rb3 gen2 platform.
> 
> Signed-off-by: Prahlad Valluru <quic_vvalluru@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 86 ++++++++++++++++++++
>  1 file changed, 86 insertions(+)
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


New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 20240425071354.GA12900@hu-vvalluru-hyd.qualcomm.com:

arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: hdmi-bridge@2b: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pinctrl@f100000: Unevaluated properties are not allowed ('lt9611-irq' was unexpected)
	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,sc7280-pinctrl.yaml#






