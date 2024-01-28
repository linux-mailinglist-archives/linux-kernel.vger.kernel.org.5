Return-Path: <linux-kernel+bounces-41488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F583F2A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880311F24450
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A71373;
	Sun, 28 Jan 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+Nxv/JU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9107FEC2;
	Sun, 28 Jan 2024 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706402855; cv=none; b=JVLew9A99JUbRQd8f7B8lCE3ofzCxX7h+Pe9/TZ7FnlS+U2xS0xzLvFJbv/fADyigzpWBZDHodnsuRWjHTGsBG8+9koLfiUdDPCFvefrG/QT90b4KI5qtcPITNf/PnsmL2TyegB3hZYK84ceYVEvoNQjQxIMerddm0IMwxJ/kxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706402855; c=relaxed/simple;
	bh=Ll5TYvKcRN50mYE19nzxBLP/t8etE5RepKGeDrO+Tdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy+4s73gFl+YTJBgV9Rb3VKDUkah1a9MaHYF8ogcicYB5lJmCh1aDaI5Kg25pK6gncwNlkn4IBCM4CoIo63NOcKESjc7nyHs1COLKj2X7TR6bpYGpmdxtj1a54wHl6J8L5PKurzjXYFpNegoMlI2eo8VVoWGDOPkSA1aee2yNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+Nxv/JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F359BC433C7;
	Sun, 28 Jan 2024 00:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706402855;
	bh=Ll5TYvKcRN50mYE19nzxBLP/t8etE5RepKGeDrO+Tdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+Nxv/JUNTBlkIWP3jhkdakei+RdxWlhYEtFqPC2yZJnMThEO5VTDOibobtlSQyOH
	 BPkes4/y8nOxQSHqdHPz6VpecYIzWqRSEqA378gFvVeIStRLvxStYGIy4WvjH0xnsv
	 bwkdAeXDPnozcJKGF9PQxv2LT2YuE3ConGynMwrIal5Ru6VHryfTyal1TVbcuQdksx
	 f8eVZsnfmiKJ+ESfDvPyl1TA27Dvw00uSuhzx16PWzdCTBXkM2bya1Xee80Ry02znH
	 y8YN+FsmdZQdoAOEFwWMxBUlTNwNk9Md1TkEyN4NxBkpbKTszXEkwLIhYHQVB1keHT
	 biNice+7Ru3wQ==
Date: Sat, 27 Jan 2024 18:47:31 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Raymond Hackley <raymondhackley@protonmail.com>
Cc: linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Walter Broemeling <wallebroem@gmail.com>, 
	Joe Mason <buddyjojo06@outlook.com>, Siddharth Manthan <siddharth.manthan@gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 initial device trees
Message-ID: <th4btdwcsvvfbipshjeplvd7kuyd6qxuv5odbksydc23zfls47@awgmdy3u3ck5>
References: <20240120095715.13689-1-raymondhackley@protonmail.com>
 <20240120095715.13689-3-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120095715.13689-3-raymondhackley@protonmail.com>

On Sat, Jan 20, 2024 at 09:57:50AM +0000, Raymond Hackley wrote:
> From: Walter Broemeling <wallebroem@gmail.com>
> This initial commit adds support for:
>  - fortuna3g (SM-G530H)
[..]
>  arch/arm64/boot/dts/qcom/Makefile             |   4 +
>  .../qcom/msm8916-samsung-fortuna-common.dtsi  | 170 ++++++++++++++++++
>  .../dts/qcom/msm8916-samsung-gprimeltecan.dts |  26 +++
>  .../qcom/msm8916-samsung-grandprimelte.dts    |  15 ++
>  .../qcom/msm8916-samsung-rossa-common.dtsi    |  16 ++
>  .../boot/dts/qcom/msm8916-samsung-rossa.dts   |  15 ++
>  6 files changed, 246 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-fortuna-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gprimeltecan.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-grandprimelte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-rossa.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 39889d5f8e12..1abd25e19a1f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb

This is missing from the patch.

Regards,
Bjorn

