Return-Path: <linux-kernel+bounces-128329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A920A895987
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB976B29AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656A14B066;
	Tue,  2 Apr 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqKJr+mr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F31474BD;
	Tue,  2 Apr 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074391; cv=none; b=k8WzIQuNU2LtuMHlp2OGQSn6cGvBy3nSu9OPogBWxnYg5DzHoAmk1cXlxJMIggQT/6sErMK/IaQq5Zt7wP2swaQjeX67yHeEWVrAvB3p7zei9xPR1o1o9krvjiZ167bQNFGfI4gqsFwBsG9Z7Z4K3M1fV3+VGrJuJN7UZHLdCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074391; c=relaxed/simple;
	bh=MkUFKIu8WVht39UogLsNZeMU2Bw6C8O2htGVjHcVQbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fphiPs23/mRX9np5mpPsitBaGlS8t51VeDv8rvCtUCS3h243tK3EBnelv41nBObCMC8gqsW+IMAJ2Hr7BtECUpNpOxXmIY4xOk0MvbnL4yq1SLbEXFxDQU/h74bEDSM3rtY0lQPe/Ecl6HPbrZBhkGPsNL7LlL+WX7ej1Pr+LU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqKJr+mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3805C43390;
	Tue,  2 Apr 2024 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074390;
	bh=MkUFKIu8WVht39UogLsNZeMU2Bw6C8O2htGVjHcVQbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqKJr+mrN8rfXlOXT29RrWmWoHh1PJw40TGMuRRDQr2stAKGJNp783fh5h4pwZZjN
	 89VcGltYe8PxJQAZ4mdCl1GkRShm/GX+FDBdoKhyEht16Iyb7GQwxQ8pup7TpqfZ3A
	 uRthKh/tbAgTWn7N4xBAt69fyAX64ROiIi70jDjsuEH8MwQ4bSqX0mepmBiQpyvd9A
	 kXKGrro3Ic6Pt7dGgSn+Nf2ZHFaOoGTrsLmrHE6MQDslmlZ4o5cgijUHzgKUhqieRu
	 fBfnvt4Lm65GbrFdnkI1hYH92wc3ay0zO7Y/ok9Zo5yahA6f9/yu1JpM8smx/6Ywo3
	 ICdrgi6itVxSg==
Date: Tue, 2 Apr 2024 11:13:08 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: clock: add i.MX95 clock header
Message-ID: <171207438612.238480.2390045528450671858.robh@kernel.org>
References: <20240401-imx95-blk-ctl-v6-0-84d4eca1e759@nxp.com>
 <20240401-imx95-blk-ctl-v6-1-84d4eca1e759@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-imx95-blk-ctl-v6-1-84d4eca1e759@nxp.com>


On Mon, 01 Apr 2024 21:28:15 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add clock header for i.MX95 BLK CTL modules
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/clock/nxp,imx95-clock.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


