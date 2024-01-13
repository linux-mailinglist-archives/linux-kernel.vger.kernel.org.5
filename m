Return-Path: <linux-kernel+bounces-25279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED582CC92
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EC6285157
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DEA210E7;
	Sat, 13 Jan 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fVAgUE6A"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73011723;
	Sat, 13 Jan 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C96E22811E;
	Sat, 13 Jan 2024 13:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1705147653;
	bh=AWkbGvrri97ygiLDXcFsTUsvIJvm0ZdoZBcRZ/Dn6h8=;
	h=Received:From:To:Subject;
	b=fVAgUE6AnDUjj9sAQOzwLvObe7GCPEDKOBwFcv5mWJ4eZvC8rF5XgCJRTIEGuw1Qm
	 CmLmJBjTB3ewdkLUQmRJv+UiEMnXf7FbteJ262FdB+K0BmaFQdYDQWSJXA9XY/hMqi
	 TmoDGm0RpuypzdnUHpuc4XtoSWKyvmCpOrLzr9pUJscfX1l37bbwFFGvb02wk/QfSh
	 eMkBtVadtyL0hGHdQqkeWAC6Qy9jm2M/eBPeHm7P/7LIwYlPcWU3Z5DshzyVGimcn+
	 3K5vlt5p4fRTUEeuea0/CTj0ntsxk17RBYD7yN2xEYLYxnpT/JJ+QL4+YCHm0DmJm+
	 NALwXB7ZKZ8Wg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 6D2F97F824; Sat, 13 Jan 2024 13:07:33 +0100 (CET)
Date: Sat, 13 Jan 2024 13:07:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Lukas Wunner <lukas@wunner.de>
Cc: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: add verdin am62 mallow board
Message-ID: <ZaJ9BWD3K_iWWDkl@gaggiata.pivistrello.it>
References: <20231201145551.23337-1-francesco@dolcini.it>
 <20231201145551.23337-4-francesco@dolcini.it>
 <20231204181336.scm2fgfyyzpr2u7t@dimmer>
 <20240113092025.GA8517@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113092025.GA8517@wunner.de>

On Sat, Jan 13, 2024 at 10:20:25AM +0100, Lukas Wunner wrote:
> On Mon, Dec 04, 2023 at 12:13:36PM -0600, Nishanth Menon wrote:
> > On 15:55-20231201, Francesco Dolcini wrote:
> > > From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > > +
> > > +	tpm@1 {
> > > +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> > 
> > arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dtb: /bus@f0000/spi@20110000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670', 'tcg,tpm_tis-spi']
> > arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dtb: /bus@f0000/spi@20110000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670', 'tcg,tpm_tis-spi']
> > 
> > We should either drop this node OR introduce bindings and later
> > introduce this series.
> > 
> > Yes, I know there are other places where the compatible is already used
> > arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
> > arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> > etc.. But, unfortunately, I'd rather see the binding
> > Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
> > transition over to yaml prior to picking things up.
> 
> Thy will be done:
> 
> https://git.kernel.org/linus/26c9d152ebf3
> 
> The TPM bindings are now converted to YAML, so the change rejected above
> can be resubmitted.

Thanks Lukas, it's ready to be sent, just waiting for rc1 to be out.

Francesco


