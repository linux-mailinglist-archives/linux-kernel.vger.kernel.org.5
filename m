Return-Path: <linux-kernel+bounces-33831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6EB836F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89081F2D57C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637A55C1C;
	Mon, 22 Jan 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ovw9h5AC"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5DC58119;
	Mon, 22 Jan 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944931; cv=none; b=YejaTd/8De+QRim2k43J1jt7bdIrMS4ptymMvPeuZSu1CY7H0I0d5at+yBWXTwBRZ7SK+58EubRmNWyyfACeOAQzhslvU0x70/bclnVp6p+HbAUgvgqaTCZfdSBDOK6ZT/LkCSATGf1Xlz/1mQfyAPETpPnX/7Lw8pAhHqscxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944931; c=relaxed/simple;
	bh=U0VMj6mx08CLyOci8ZYFzeqCoBasIPEMjUZ6q/bTr8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0FZjvuLdIEPtmUuzHBSup/8w1+LbFKQIN8cXL5IG1ykiGP5KoxFoEPAQVSjLzYYdD5kpQc7uuAnKX925jsY7NM76MsHXGA44+dLTat4tPo25tI8EFiufx0AFxAvj+VHVUbre1tRy4IM6dVTPm8kAvuYaB67fKYk6dCYY0znENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ovw9h5AC; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id C6AC522DCD;
	Mon, 22 Jan 2024 18:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1705944918;
	bh=JZ9TX5NOgqL4MXL/9WyEXmX3gOnlcshdJ3hnptH5oGc=; h=From:To:Subject;
	b=ovw9h5ACq/pp5BSH7zuUuwr+NBAQAWs6o81fr7YUUXJrxhPq0BCG8R4xq7KsXNEhT
	 wBy7IPcvLEDKwqmJ2TUc59BBGJd1pqNRlpItrDeqXF/uvsKTtnewF3CnjfzaHAdPxL
	 qLnXM3Y51ag0F3gJZ8faEs8ORenivATep20PSCvgzGimQC2Y3yYLR21bWoVtk6YiP4
	 Q/2CWVSJsywwl6NQXG8cRuufGCVlPJJRZUEWw5779DQtGx7AYYE2UWOR+WxfTJfK8q
	 8i7dY4DZg7fwCqITcQZpyHW8obJyAgIwkvTz7ATJDiIXsj7GZea8FvvhLicKBOVu4W
	 paqp9PdBR7YoA==
Date: Mon, 22 Jan 2024 18:35:13 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v1 2/2] arm: dts: nxp: imx: Add support for Apalis
 Evaluation Board v1.2
Message-ID: <20240122173513.GA32711@francesco-nb>
References: <20240122123526.43400-1-hiagofranco@gmail.com>
 <20240122123526.43400-3-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122123526.43400-3-hiagofranco@gmail.com>

On Mon, Jan 22, 2024 at 09:35:00AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> Add support for the new Apalis Evaluation Board v1.2. Because
> only the imx6q-apalis-eval.dts was available, the imx6q-apalis-eval.dtsi
> has been created which has common hardware configurations for v1.0, v1.1
> and v1.2. Both imx6q-apalis-eval.dts and imx6q-apalis-eval-v1.2.dts
> files include imx6q-apalis-eval.dtsi.
> 
> Versions 1.0 and 1.1 are compatible with each other and should
> use imx6q-apalis-eval.dts file. Now for v1.2, the new device-tree file
> should be used.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


