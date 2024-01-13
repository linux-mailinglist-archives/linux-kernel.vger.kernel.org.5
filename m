Return-Path: <linux-kernel+bounces-25232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D544582CAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BF01C22197
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999FEC5;
	Sat, 13 Jan 2024 09:20:37 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B17E8;
	Sat, 13 Jan 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C7B6D300002A1;
	Sat, 13 Jan 2024 10:20:25 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B0DA52F03E3; Sat, 13 Jan 2024 10:20:25 +0100 (CET)
Date: Sat, 13 Jan 2024 10:20:25 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: add verdin am62 mallow board
Message-ID: <20240113092025.GA8517@wunner.de>
References: <20231201145551.23337-1-francesco@dolcini.it>
 <20231201145551.23337-4-francesco@dolcini.it>
 <20231204181336.scm2fgfyyzpr2u7t@dimmer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204181336.scm2fgfyyzpr2u7t@dimmer>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Dec 04, 2023 at 12:13:36PM -0600, Nishanth Menon wrote:
> On 15:55-20231201, Francesco Dolcini wrote:
> > From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > +
> > +	tpm@1 {
> > +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> 
> arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dtb: /bus@f0000/spi@20110000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670', 'tcg,tpm_tis-spi']
> arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dtb: /bus@f0000/spi@20110000/tpm@1: failed to match any schema with compatible: ['infineon,slb9670', 'tcg,tpm_tis-spi']
> 
> We should either drop this node OR introduce bindings and later
> introduce this series.
> 
> Yes, I know there are other places where the compatible is already used
> arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
> arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> etc.. But, unfortunately, I'd rather see the binding
> Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
> transition over to yaml prior to picking things up.

Thy will be done:

https://git.kernel.org/linus/26c9d152ebf3

The TPM bindings are now converted to YAML, so the change rejected above
can be resubmitted.

Thanks,

Lukas

