Return-Path: <linux-kernel+bounces-6515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9FC8199D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BD4288263
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B89168B2;
	Wed, 20 Dec 2023 07:49:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE01B285;
	Wed, 20 Dec 2023 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AE1D610029CB7;
	Wed, 20 Dec 2023 08:49:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 80E251FD98; Wed, 20 Dec 2023 08:49:31 +0100 (CET)
Date: Wed, 20 Dec 2023 08:49:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M
 Mini Support
Message-ID: <20231220074931.GA13382@wunner.de>
References: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
 <20230925-tauri_upstream_support-v2-2-62a6dfc48e31@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-tauri_upstream_support-v2-2-62a6dfc48e31@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 25, 2023 at 09:25:19AM +0200, Yannic Moog wrote:
> phyGATE-Tauri uses a phyCORE-i.MX8MM SoM. Add device tree for the board.
[...]
> +	tpm: tpm@1 {
> +		compatible = "tcg,tpm_tis-spi";

What's the chip used on this board?  Going forward, the DT schema for TPMs
requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".


> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tpm>;
> +		reg = <1>;
> +		spi-max-frequency = <38000000>;
> +	};
> +};

