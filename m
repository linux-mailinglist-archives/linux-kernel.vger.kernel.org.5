Return-Path: <linux-kernel+bounces-6568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBFB819A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17AA1C21127
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4811B290;
	Wed, 20 Dec 2023 08:27:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73BC1F5E4;
	Wed, 20 Dec 2023 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E12EE100FC279;
	Wed, 20 Dec 2023 09:27:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ACA1426F31; Wed, 20 Dec 2023 09:27:14 +0100 (CET)
Date: Wed, 20 Dec 2023 09:27:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	taoren@fb.com
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Wedge400 BMC
Message-ID: <20231220082714.GA17989@wunner.de>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-6-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824211948.12852-6-rentao.bupt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 24, 2020 at 02:19:48PM -0700, rentao.bupt@gmail.com wrote:
> Add initial version of device tree for Facebook Wedge400 (AST2500) BMC.
[...]
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
[...]
> +		tpmdev@0 {
> +			compatible = "tcg,tpm_tis-spi";

What's the chip used on this board?  Going forward, the DT schema for TPMs
requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".


> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};

