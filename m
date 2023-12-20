Return-Path: <linux-kernel+bounces-6636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E82819B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7AE28A2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C71DA56;
	Wed, 20 Dec 2023 09:21:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA761D6BD;
	Wed, 20 Dec 2023 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 878DB28141E98;
	Wed, 20 Dec 2023 10:21:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7953219C8C; Wed, 20 Dec 2023 10:21:31 +0100 (CET)
Date: Wed, 20 Dec 2023 10:21:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yannic Moog <Y.Moog@phytec.de>, Alexander Bauer <a.bauer@phytec.de>
Cc: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"leoyang.li@nxp.com" <leoyang.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M
 Mini Support
Message-ID: <20231220092131.GA11402@wunner.de>
References: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
 <20230925-tauri_upstream_support-v2-2-62a6dfc48e31@phytec.de>
 <20231220074931.GA13382@wunner.de>
 <ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 20, 2023 at 07:56:11AM +0000, Yannic Moog wrote:
> On Wed, 2023-12-20 at 08:49 +0100, Lukas Wunner wrote:
> > On Mon, Sep 25, 2023 at 09:25:19AM +0200, Yannic Moog wrote:
> > > phyGATE-Tauri uses a phyCORE-i.MX8MM SoM. Add device tree for the board.
> > [...]
> > > +	tpm: tpm@1 {
> > > +		compatible = "tcg,tpm_tis-spi";
> > 
> > What's the chip used on this board?  Going forward, the DT schema for TPMs
> > requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".
> 
> TPM SLB 9670 is used on the board. Thank you for highlighting this.

Thanks Yannic, I've added this to my fixups to avoid TPM warnings with
"make dtbs_check", they will be submitted it in the near future.

One more question, I assume the TPM mentioned in

  arch/arm/boot/dts/imx6ull-phytec-tauri.dtsi

and introduced by

  commit 0b08af343ab0 ("ARM: dts: imx6ull: Add support for PHYTEC
  phyGATE-Tauri-S with i.MX 6ULL")

is likewise an Infineon SLB9670? (cc += Alexander)

Thanks,

Lukas

