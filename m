Return-Path: <linux-kernel+bounces-109065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93D881436
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC615B20F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3476E4F217;
	Wed, 20 Mar 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy0nD9Hy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A24AEE0;
	Wed, 20 Mar 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947417; cv=none; b=E0gJopr/CnSr9pEZAQjkR78CEUD3VyNYpNDBcSK8mls7gIELvtCHnddIh0la6hN7SkIQfpqowHsTWq+LW7bRxEY+F91EIumJCAJQ7/3K4+/I4Yf0atc/3CTvAhDZ8Fgy6zsN8RpZo8wBfeBYpMm6tJT7HjWqZ9d4B7xDKgVU1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947417; c=relaxed/simple;
	bh=4//2Ztgp/9bNI3pOdqFM6t+BddbS0siyo86ffWZ/Cis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUZs85RvtRy0tUiEyY1+sN9fq6VMUMvvsrPNMX5YqCunhIMv/lrtuYDfcV1Nr9oc8ltvH/gdqWnsbdXjDpWkfmagti41gPQbLRyr9rhuVGBTzCVlDBxT2sH57627WJQOQo6NeJnS5tuorelm8JvKPkrlQA21BQXEM+o8eIWEU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy0nD9Hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84FBC433F1;
	Wed, 20 Mar 2024 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710947416;
	bh=4//2Ztgp/9bNI3pOdqFM6t+BddbS0siyo86ffWZ/Cis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy0nD9HyCZRmXwWFd3UlqqBhl2ZYER4gdgogPzhjSCx3G4XIkqsby7MNTLL8r77YB
	 01HqIdFbL/wLst4bp5hJPLRhbCYcbH2gxlPbfwB3Hh48Ye6oKE5EJ5DHEMWVL1I6fp
	 ggOv7O92qxJrZpwJUURgXxc0GAVMPpojWCr7Qbpk0yryJjZwZJTdsJbyAMy1icncEV
	 mdnQ5oCo6utiYEBoI6sDRK+9pn5ioyYYdO/96Gvadb01Weyrji5E282FFX/A7uZ+ZN
	 7gLUoYsOVbpDfYSTUQutk9FfhQL2PIxZMlxUd4mdGHqboa+gFbUqzhtgef5d0ASwLi
	 zc3aYo37Z31nQ==
Date: Wed, 20 Mar 2024 10:10:14 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <171094741235.1737484.4683319555697657710.robh@kernel.org>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
 <20240318-asrc_8qxp-v7-3-01ce5264a761@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-asrc_8qxp-v7-3-01ce5264a761@nxp.com>


On Mon, 18 Mar 2024 15:00:09 -0400, Frank Li wrote:
> Some sai only connect one direction dma (rx/tx) in SOC. For example:
> imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> for dma-names.
> 
> Remove description under dmas because no user use index to get dma channel.
> All user use 'dma-names' to get correct dma channel. dma-names already in
> 'required' list.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


