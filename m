Return-Path: <linux-kernel+bounces-50460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC88847937
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD61C22DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5815E5BA;
	Fri,  2 Feb 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRMhjrr6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0E15E5BC;
	Fri,  2 Feb 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900714; cv=none; b=WWcyWtxf/6edcyGwURs2akDCVblxf6fJ1OcU3eYkiPXHqgFzdTd1N2yOMh1nUioKN1XFAtYFiW6NjIBrohN4Nil4yris79/cPouYXu8FusSOeRYtKHs+U8QJZBRYH6SGePNo+qiosW+4ncHse6xNZeI1iVhHT2MkrWXaaRZdrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900714; c=relaxed/simple;
	bh=PbcZ6/Uc6nEWpeypOwRFRtOhlGrseI91iIhICRGZBak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJR0Y+5z+2jKXv8LfhUSYK/J0/y64Xq6BhPjbuN4tof1E6uO9YilyhZhBucfhmLo2l1qajqTAKuADLx5HGrrEdBGQ27rNIOuby0uc34IZVlfCfRlkssMntdGBuf0fyzmTQbPXNIKpWGNpZfGjNcMZ4zdW0/zKFV1mTECuQ3F53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRMhjrr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54A4C433F1;
	Fri,  2 Feb 2024 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900713;
	bh=PbcZ6/Uc6nEWpeypOwRFRtOhlGrseI91iIhICRGZBak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRMhjrr6RV1qjDeZR87YJLcjcavrxpWwnfciJGxNbphzpqEBEavTsIE2QBYvax3os
	 SmnPa3J35rc6mLeAHQN6BWSaJWj/Wfi9O9sona9JIZCXIkLhz53oGEdUTxjyNL3AjM
	 hpgM3OMpgaVHazqEn+8Ce8hg/BmQniFXHAA3Tgambv61pO9rzcITnIjiiW+auyypCA
	 OTDO1SEB+mia/A8rC1AwhOXvsBFXJeldtzQrxVA7+5PJ0h6/7IiiKwZOChosOsc44k
	 mvXdDkoM/OBfXFc1W/ZK7l8cQKXrMlzjFvJgG1JmbAwEP4MBq7R4Dna0vmErgFyPyz
	 /hF+mTF+B0v8g==
Date: Fri, 2 Feb 2024 11:05:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Wei
 Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
Message-ID: <20240202110511.135d26b7@kernel.org>
In-Reply-To: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Feb 2024 15:22:40 -0500 Frank Li wrote:
>       dt-bindings: mmc: fsl-imx-esdhc: add iommus property
>       dt-bindings: net: fec: add iommus property
>       arm64: dts: imx8qm: add smmu node
>       arm64: dts: imx8qm: add smmu stream id information
> 
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  3 ++
>  Documentation/devicetree/bindings/net/fsl,fec.yaml |  3 ++
>  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  6 ++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 41 ++++++++++++++++++++++

Any preference on whether all these go via a platform tree,
or should we pick up the net patch to netdev? I guess taking
the DTB via netdev would be the usual way to handle this?

