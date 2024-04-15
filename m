Return-Path: <linux-kernel+bounces-145973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611E78A5DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1819A1F218B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1CA1586FE;
	Mon, 15 Apr 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrdKfelF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3532157E6F;
	Mon, 15 Apr 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220192; cv=none; b=VGSMNztqtYJfo9EnzFIxIGFe0qT53svV8SfPhcvcXtbhAIZ6mlMEcVzMco4gJNGWx0T4YwGbPLyKuhEQ8zakBpu0gS8QsKvlLdjiS3YRlPYkCw6ABsDI7FeYEnJebJMZByCMxc1yXctYef94zAOCWiy9HKhQR3SB4/H5tcC5w9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220192; c=relaxed/simple;
	bh=oAL5hcyj9PlKOMaTqchiFLUGIOOaXgtmzzsS5gDVdbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4z08FdzGiJhqlLZSU2IVj7TfE79OaTTOPCCmz+XsNu4Jx+8WewanFMhIf16Cq5YmIWBuvxVDF7K2shpe4Qg4OTYeU3kJU38+97rktiSEoRBCXsemTk9M38suSS9BaOX2EIS99PvKLGfKqfEjU9moMoqsbbd4oMaZgu8/5cIFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrdKfelF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6CFC113CC;
	Mon, 15 Apr 2024 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713220192;
	bh=oAL5hcyj9PlKOMaTqchiFLUGIOOaXgtmzzsS5gDVdbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrdKfelFnMJM+mOrZ9Woko0MRxQTEfZZPD0KjmT8iYCHyzyvYMMkbtIXmyxd75vjI
	 n/LsaDlomxyVM+mucYkE5dS/iPyp+sVtVCMYmTZ6lRdws87BbFfkv4aiQQ4PxEL5bl
	 2rLp68JPBkFyyOFVTZfz4ZnlAKePXrhdEjafL1Dpzy3o4+6DzJuxPMwXwFjrAv+Cwf
	 MsbVtEgXKQTkiQ6Awtf9oke66I5kFmDX5u9YeL0BfKdiUC5Np04E24GRBpRvmkRkxH
	 f5mfV6IowsR8pXjTu1e/DY5atTVbgOMQpnj8z0y1akgmCkn5GsL4igB16Rnw6suVIc
	 FyBtgo2pJFO4Q==
Date: Mon, 15 Apr 2024 17:29:50 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml
Message-ID: <171322018699.201530.3043276928508489838.robh@kernel.org>
References: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
 <20240411-esai_arm_dts_warning-v1-2-5e1a7c7be9b9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-esai_arm_dts_warning-v1-2-5e1a7c7be9b9@nxp.com>


On Thu, 11 Apr 2024 13:07:46 -0400, Frank Li wrote:
> Add ref: dai-common.yaml to fix below warning.
> arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


